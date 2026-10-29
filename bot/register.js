// Run once: node register.js
// Registers the /panel slash command to your guild.
require('dotenv').config();
const { REST, Routes, SlashCommandBuilder } = require('discord.js');

const commands = [
  new SlashCommandBuilder()
    .setName('panel')
    .setDescription('Post the kamidere whitelist panel')
    .setDefaultMemberPermissions('32')
    .toJSON(),
  new SlashCommandBuilder()
    .setName('generate')
    .setDescription('Generate a new key')
    .addStringOption(opt =>
      opt.setName('script_type')
        .setDescription('Script type (default: rivals)')
        .setRequired(false)
        .addChoices({ name: 'rivals', value: 'rivals' })
    )
    .toJSON(),
];

const rest = new REST({ version: '10' }).setToken(process.env.BOT_TOKEN);

(async () => {
  await rest.put(
    Routes.applicationGuildCommands(process.env.CLIENT_ID, process.env.GUILD_ID),
    { body: commands }
  );
  console.log('Registered /panel command.');
})();
