require('dotenv').config();
const { Client, GatewayIntentBits, EmbedBuilder, ActionRowBuilder, ButtonBuilder, ButtonStyle, ModalBuilder, TextInputBuilder, TextInputStyle, PermissionFlagsBits } = require('discord.js');

const client = new Client({ intents: [GatewayIntentBits.Guilds] });

const API_URL    = process.env.API_URL;
const BOT_SECRET = process.env.BOT_SECRET;
const SCRIPT_URL = process.env.SCRIPT_URL;
const HUB_NAME   = process.env.HUB_NAME || 'kamidere';
const EMOJI_ID   = process.env.KAMIDERE_EMOJI_ID;

const SCRIPT_ROLES = {
  rivals: '1562921775992541284',
};

const GENERATE_ROLE = '1565484945034576013';

const COLORS = { gold: 0xd2aa37, dark: 0x121110, err: 0xb85040, green: 0x2ecc71 };

function footer() {
  return {
    text: HUB_NAME,
    iconURL: EMOJI_ID ? `https://cdn.discordapp.com/emojis/${EMOJI_ID}.png` : undefined,
  };
}

function errEmbed(msg) {
  return new EmbedBuilder()
    .setColor(COLORS.err)
    .setDescription(`> ❌  ${msg}`)
    .setFooter(footer());
}

async function apiCall(method, path, body) {
  const controller = new AbortController();
  const timer = setTimeout(() => controller.abort(), 20000);
  try {
    const res = await fetch(`${API_URL}${path}`, {
      method,
      headers: { 'Content-Type': 'application/json', 'x-bot-secret': BOT_SECRET },
      body: body ? JSON.stringify(body) : undefined,
      signal: controller.signal,
    });
    return res.json();
  } catch {
    return { ok: false, message: 'API timed out. Try again in a few seconds.' };
  } finally {
    clearTimeout(timer);
  }
}

function buildPanel() {
  const embed = new EmbedBuilder()
    .setColor(COLORS.gold)
    .setTitle(`${HUB_NAME}`)
    .setDescription('> Manage your access using the buttons below.')
    .setFooter(footer())
    .setTimestamp();

  const row1 = new ActionRowBuilder().addComponents(
    new ButtonBuilder().setCustomId('get_script').setLabel('Get Script').setStyle(ButtonStyle.Secondary).setEmoji('📄'),
    new ButtonBuilder().setCustomId('redeem_key').setLabel('Redeem Key').setStyle(ButtonStyle.Success).setEmoji('🔑'),
    new ButtonBuilder().setCustomId('get_stats').setLabel('Get Stats').setStyle(ButtonStyle.Secondary).setEmoji('📊'),
  );

  const row2 = new ActionRowBuilder().addComponents(
    new ButtonBuilder().setCustomId('get_role').setLabel('Get Role').setStyle(ButtonStyle.Secondary).setEmoji('🪪'),
    new ButtonBuilder().setCustomId('reset_hwid').setLabel('Reset HWID').setStyle(ButtonStyle.Danger).setEmoji('🔄'),
  );

  return { embeds: [embed], components: [row1, row2] };
}

client.on('ready', () => {
  console.log(`Logged in as ${client.user.tag}`);
  setInterval(() => fetch(`${API_URL}/ping`).catch(() => {}), 4 * 60 * 1000);
});

client.on('interactionCreate', async interaction => {
  if (interaction.isChatInputCommand() && interaction.commandName === 'panel') {
    if (!interaction.member.permissions.has(PermissionFlagsBits.ManageGuild))
      return interaction.reply({ content: 'No permission.', ephemeral: true });
    try {
      await interaction.channel.send(buildPanel());
      return interaction.reply({ content: 'Panel posted.', ephemeral: true });
    } catch (e) {
      return interaction.reply({ content: `Failed to post panel: ${e.message}`, ephemeral: true });
    }
  }

  // ── GENERATE KEY ─────────────────────────────────────────────────────────────
  if (interaction.isChatInputCommand() && interaction.commandName === 'generate') {
    if (!interaction.member.roles.cache.has(GENERATE_ROLE))
      return interaction.reply({ content: 'You do not have permission to generate keys.', ephemeral: true });

    await interaction.deferReply({ ephemeral: true });
    const script_type = interaction.options.getString('script_type') || 'rivals';
    const data = await apiCall('POST', '/generate', { script_type });

    if (!data.ok) {
      return interaction.editReply({ embeds: [errEmbed(data.message)] });
    }

    return interaction.editReply({
      embeds: [
        new EmbedBuilder()
          .setColor(COLORS.gold)
          .setTitle('🔐  Key Generated')
          .setDescription(`> Your key has been created. Send it directly to the user — do not share publicly.`)
          .addFields(
            { name: '🔑  Key', value: `\`\`\`${data.key}\`\`\`` },
            { name: '🎮  Script', value: `\`${data.script_type}\``, inline: true },
          )
          .setFooter(footer())
          .setTimestamp()
      ],
    });
  }

  if (!interaction.isButton() && !interaction.isModalSubmit()) return;

  const userId = interaction.user.id;

  // ── GET SCRIPT ──────────────────────────────────────────────────────────────
  if (interaction.customId === 'get_script') {
    await interaction.deferReply({ ephemeral: true });
    const data = await apiCall('GET', `/key/${userId}`);
    if (!data.ok) {
      return interaction.editReply({ embeds: [errEmbed('No key found. Redeem one first.')] });
    }
    const key = data.key;
    const snippet = `_G.KAMI_KEY = "${key}"\nloadstring(game:HttpGet("https://raw.githubusercontent.com/noonelefttohearme/rivals/main/loader.lua"))()`;
    return interaction.editReply({
      embeds: [
        new EmbedBuilder()
          .setColor(COLORS.gold)
          .setTitle('📄  Your Script')
          .setDescription(`\`\`\`lua\n${snippet}\n\`\`\``)
          .setFooter({ ...footer(), text: `${HUB_NAME} · paste into your executor` })
      ],
    });
  }

  // ── REDEEM KEY ───────────────────────────────────────────────────────────────
  if (interaction.customId === 'redeem_key') {
    const modal = new ModalBuilder()
      .setCustomId('redeem_modal')
      .setTitle('Redeem Key')
      .addComponents(
        new ActionRowBuilder().addComponents(
          new TextInputBuilder()
            .setCustomId('key_input')
            .setLabel('Enter your key')
            .setPlaceholder('KAMI-XXXX-XXXX-XXXX')
            .setStyle(TextInputStyle.Short)
            .setRequired(true)
        )
      );
    return interaction.showModal(modal);
  }

  if (interaction.customId === 'redeem_modal') {
    await interaction.deferReply({ ephemeral: true });
    const key = interaction.fields.getTextInputValue('key_input').trim();
    const data = await apiCall('POST', '/redeem', { key, discord_id: userId });

    if (!data.ok) {
      return interaction.editReply({ embeds: [errEmbed(data.message)] });
    }

    const roleId = SCRIPT_ROLES[data.script_type];
    if (roleId) {
      try { await interaction.member.roles.add(roleId); } catch {}
    }

    return interaction.editReply({
      embeds: [
        new EmbedBuilder()
          .setColor(COLORS.green)
          .setTitle('✅  Key Redeemed')
          .setDescription('> Your key is now active. Click **Get Script** to grab your loader.')
          .setFooter(footer())
          .setTimestamp()
      ],
    });
  }

  // ── GET STATS ────────────────────────────────────────────────────────────────
  if (interaction.customId === 'get_stats') {
    await interaction.deferReply({ ephemeral: true });
    const data = await apiCall('GET', '/stats');
    return interaction.editReply({
      embeds: [
        new EmbedBuilder()
          .setColor(COLORS.gold)
          .setTitle(`📊  ${HUB_NAME} Stats`)
          .addFields(
            { name: '🗝️  Total Keys',   value: `\`${data.total}\``,  inline: true },
            { name: '👥  Active Users', value: `\`${data.active}\``, inline: true },
            { name: '🔒  HWID Bound',   value: `\`${data.bound}\``,  inline: true },
          )
          .setFooter(footer())
          .setTimestamp()
      ],
    });
  }

  // ── GET ROLE ─────────────────────────────────────────────────────────────────
  if (interaction.customId === 'get_role') {
    await interaction.deferReply({ ephemeral: true });
    const data = await apiCall('GET', `/key/${userId}`);

    if (!data.ok) {
      return interaction.editReply({ embeds: [errEmbed('No key found. Redeem one first.')] });
    }

    const roleId = SCRIPT_ROLES[data.script_type];
    if (!roleId) {
      return interaction.editReply({ embeds: [errEmbed('No role configured for your key type.')] });
    }

    try {
      await interaction.member.roles.add(roleId);
      return interaction.editReply({
        embeds: [
          new EmbedBuilder()
            .setColor(COLORS.green)
            .setTitle('🪪  Role Assigned')
            .setDescription(`> You've been given the **${data.script_type}** role.`)
            .setFooter(footer())
        ],
      });
    } catch {
      return interaction.editReply({ embeds: [errEmbed('Could not assign role. Check bot permissions.')] });
    }
  }

  // ── RESET HWID ───────────────────────────────────────────────────────────────
  if (interaction.customId === 'reset_hwid') {
    await interaction.deferReply({ ephemeral: true });
    const keyData = await apiCall('GET', `/key/${userId}`);

    if (!keyData.ok) {
      return interaction.editReply({ embeds: [errEmbed('No key found.')] });
    }

    const data = await apiCall('POST', '/reset-hwid', { key: keyData.key });

    return interaction.editReply({
      embeds: [
        new EmbedBuilder()
          .setColor(data.ok ? COLORS.green : COLORS.err)
          .setTitle(data.ok ? '🔄  HWID Reset' : '⏳  On Cooldown')
          .setDescription(`> ${data.message}`)
          .setFooter(footer())
          .setTimestamp()
      ],
    });
  }
});

client.login(process.env.BOT_TOKEN);
