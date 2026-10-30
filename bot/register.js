// Run once: node register.js
require('dotenv').config();
const { REST, Routes, SlashCommandBuilder } = require('discord.js');

const userOrKey = (cmd) => cmd
  .addUserOption(opt => opt.setName('user').setDescription('Discord user').setRequired(false))
  .addStringOption(opt => opt.setName('key').setDescription('Key string').setRequired(false));

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
  userOrKey(new SlashCommandBuilder()
    .setName('blacklist')
    .setDescription('Blacklist a user by Discord mention or key'))
    .toJSON(),
  userOrKey(new SlashCommandBuilder()
    .setName('unblacklist')
    .setDescription('Remove a blacklist by Discord mention or key'))
    .toJSON(),
  userOrKey(new SlashCommandBuilder()
    .setName('removekey')
    .setDescription('Delete a key by Discord mention or key'))
    .toJSON(),
];

const rest = new REST({ version: '10' }).setToken(process.env.BOT_TOKEN);

(async () => {
  await rest.put(
    Routes.applicationGuildCommands(process.env.CLIENT_ID, process.env.GUILD_ID),
    { body: commands }
  );
  console.log('Commands registered.');
})();
