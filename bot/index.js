const { Client, GatewayIntentBits, EmbedBuilder, ActionRowBuilder, ButtonBuilder, ButtonStyle, ModalBuilder, TextInputBuilder, TextInputStyle, PermissionFlagsBits } = require('discord.js');

const client = new Client({ intents: [GatewayIntentBits.Guilds] });

const API_URL    = process.env.API_URL;
const BOT_SECRET = process.env.BOT_SECRET;
const SCRIPT_URL = process.env.SCRIPT_URL;        // raw URL to the loader script
const KEY_ROLE   = process.env.KEY_ROLE_ID;       // Discord role ID given on redeem
const HUB_NAME   = process.env.HUB_NAME || 'kamidere';
const HUB_ID     = process.env.HUB_ID   || '000000000000000000';

const COLORS = { gold: 0xd2aa37, dark: 0x121110, err: 0xb85040 };

async function apiCall(method, path, body) {
  const res = await fetch(`${API_URL}${path}`, {
    method,
    headers: { 'Content-Type': 'application/json', 'x-bot-secret': BOT_SECRET },
    body: body ? JSON.stringify(body) : undefined,
  });
  return res.json();
}

function buildPanel(guildId) {
  const embed = new EmbedBuilder()
    .setColor(COLORS.gold)
    .setTitle(`${HUB_NAME} Panel`)
    .setDescription(`**Hub:** ${HUB_NAME}\n**Hub ID:** ${HUB_ID}\nUse the buttons below to manage your access for this hub.`)
    .setFooter({ text: `${HUB_NAME} — #1 Whitelist Service` })
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
  // Slash command: /panel
  if (interaction.isChatInputCommand() && interaction.commandName === 'panel') {
    if (!interaction.member.permissions.has(PermissionFlagsBits.ManageGuild))
      return interaction.reply({ content: 'No permission.', ephemeral: true });
    await interaction.channel.send(buildPanel(interaction.guildId));
    return interaction.reply({ content: 'Panel posted.', ephemeral: true });
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
    const loader = `loadstring(game:HttpGet("${SCRIPT_URL}"))()`;
    return interaction.reply({
      embeds: [
        new EmbedBuilder()
          .setColor(COLORS.gold)
          .setTitle('Your Script')
          .setDescription(`Set your key at the top of the loader then execute.\n\`\`\`lua\n${loader}\n\`\`\``)
          .addFields({ name: 'Your Key', value: `||${data.key}||`, inline: false })
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

    // assign role if configured
    if (KEY_ROLE) {
      try { await interaction.member.roles.add(KEY_ROLE); } catch {}
    }

    return interaction.editReply({
      embeds: [
        new EmbedBuilder()
          .setColor(COLORS.gold)
          .setTitle('Key Redeemed')
          .setDescription(`Your key has been activated. Use **Get Script** to get your loader.`)
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
      ephemeral: true,
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

    if (KEY_ROLE) {
      try {
        await interaction.member.roles.add(KEY_ROLE);
        return interaction.editReply({
          embeds: [new EmbedBuilder().setColor(COLORS.gold).setDescription('Role assigned.')],
        });
      } catch {
        return interaction.editReply({
          embeds: [new EmbedBuilder().setColor(COLORS.err).setDescription('Could not assign role. Check bot permissions.')],
        });
      }
    }

    return interaction.editReply({
      embeds: [new EmbedBuilder().setColor(COLORS.err).setDescription('No role configured.')],
    });
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
          .setDescription(data.ok ? 'HWID reset. Your key will bind to your next device on execute.' : data.message)
      ],
    });
  }
});

client.login(process.env.BOT_TOKEN);
