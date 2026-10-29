require('dotenv').config();
const { Client, GatewayIntentBits, EmbedBuilder, ActionRowBuilder, ButtonBuilder, ButtonStyle, ModalBuilder, TextInputBuilder, TextInputStyle, PermissionFlagsBits } = require('discord.js');

const client = new Client({ intents: [GatewayIntentBits.Guilds] });

const API_URL    = process.env.API_URL;
const BOT_SECRET = process.env.BOT_SECRET;
const SCRIPT_URL = process.env.SCRIPT_URL;
const HUB_NAME   = process.env.HUB_NAME || 'kamidere';
const EMOJI_ID   = process.env.KAMIDERE_EMOJI_ID; // numeric ID of the :kamidere: emoji

// role IDs per script type — add more as needed
const SCRIPT_ROLES = {
  rivals: '1562921775992541284',
};

const GENERATE_ROLE = '1565484945034576013';

const COLORS = { gold: 0xd2aa37, dark: 0x121110, err: 0xb85040 };

function kamiEmoji() {
  return EMOJI_ID ? `<:kamidere:${EMOJI_ID}>` : '⭐';
}

async function apiCall(method, path, body) {
  const controller = new AbortController();
  const timer = setTimeout(() => controller.abort(), 10000);
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
    .setTitle(`${HUB_NAME} Panel`)
    .setDescription('Use the buttons below to manage your access for this hub.')
    .setFooter({
      text: HUB_NAME,
      iconURL: EMOJI_ID ? `https://cdn.discordapp.com/emojis/${EMOJI_ID}.png` : undefined,
    })
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

client.on('ready', () => console.log(`Logged in as ${client.user.tag}`));

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
      return interaction.editReply({
        embeds: [new EmbedBuilder().setColor(COLORS.err).setDescription(data.message)],
      });
    }

    return interaction.editReply({
      embeds: [
        new EmbedBuilder()
          .setColor(COLORS.gold)
          .setTitle('Key Generated')
          .addFields(
            { name: 'Key', value: `\`${data.key}\`` },
            { name: 'Type', value: data.script_type, inline: true },
          )
      ],
    });
  }

  if (!interaction.isButton() && !interaction.isModalSubmit()) return;

  const userId = interaction.user.id;

  // ── GET SCRIPT ──────────────────────────────────────────────────────────────
  if (interaction.customId === 'get_script') {
    const data = await apiCall('GET', `/key/${userId}`);
    if (!data.ok) {
      return interaction.reply({
        embeds: [new EmbedBuilder().setColor(COLORS.err).setDescription('No key found. Redeem one first.')],
        ephemeral: true,
      });
    }
    const snippet = `_G.KAMI_KEY = "${data.key}"\nloadstring(game:HttpGet("${SCRIPT_URL}"))()`;
    return interaction.reply({
      embeds: [
        new EmbedBuilder()
          .setColor(COLORS.gold)
          .setTitle('Your Script')
          .setDescription(`Copy and execute this in your executor:\n\`\`\`lua\n${snippet}\n\`\`\``)
      ],
      ephemeral: true,
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
      return interaction.editReply({
        embeds: [new EmbedBuilder().setColor(COLORS.err).setDescription(data.message)],
      });
    }

    // assign role based on script_type
    const roleId = SCRIPT_ROLES[data.script_type];
    if (roleId) {
      try { await interaction.member.roles.add(roleId); } catch {}
    }

    return interaction.editReply({
      embeds: [
        new EmbedBuilder()
          .setColor(COLORS.gold)
          .setTitle('Key Redeemed')
          .setDescription('Your key has been activated. Use **Get Script** to get your loader.')
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
          .setTitle(`${HUB_NAME} Stats`)
          .addFields(
            { name: 'Total Keys',   value: `${data.total}`,  inline: true },
            { name: 'Active Users', value: `${data.active}`, inline: true },
            { name: 'HWID Bound',   value: `${data.bound}`,  inline: true },
          )
      ],
    });
  }

  // ── GET ROLE ─────────────────────────────────────────────────────────────────
  if (interaction.customId === 'get_role') {
    await interaction.deferReply({ ephemeral: true });
    const data = await apiCall('GET', `/key/${userId}`);

    if (!data.ok) {
      return interaction.editReply({
        embeds: [new EmbedBuilder().setColor(COLORS.err).setDescription('No key found. Redeem one first.')],
      });
    }

    const roleId = SCRIPT_ROLES[data.script_type];
    if (!roleId) {
      return interaction.editReply({
        embeds: [new EmbedBuilder().setColor(COLORS.err).setDescription('No role configured for your key type.')],
      });
    }

    try {
      await interaction.member.roles.add(roleId);
      return interaction.editReply({
        embeds: [new EmbedBuilder().setColor(COLORS.gold).setDescription('Role assigned.')],
      });
    } catch {
      return interaction.editReply({
        embeds: [new EmbedBuilder().setColor(COLORS.err).setDescription('Could not assign role. Check bot permissions.')],
      });
    }
  }

  // ── RESET HWID ───────────────────────────────────────────────────────────────
  if (interaction.customId === 'reset_hwid') {
    await interaction.deferReply({ ephemeral: true });
    const keyData = await apiCall('GET', `/key/${userId}`);

    if (!keyData.ok) {
      return interaction.editReply({
        embeds: [new EmbedBuilder().setColor(COLORS.err).setDescription('No key found.')],
      });
    }

    const data = await apiCall('POST', '/reset-hwid', { key: keyData.key });

    return interaction.editReply({
      embeds: [
        new EmbedBuilder()
          .setColor(data.ok ? COLORS.gold : COLORS.err)
          .setDescription(data.message)
      ],
    });
  }
});

client.login(process.env.BOT_TOKEN);
