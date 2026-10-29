# kamidere — setup

## 1. Supabase (database, free)
1. Create project at supabase.com
2. Go to SQL Editor → paste and run `api/schema.sql`
3. Settings → API → copy **Project URL** and **service_role** key

## 2. API (Fly.io, free)
1. Install the Fly CLI:
   ```
   curl -L https://fly.io/install.sh | sh
   ```
2. Sign up and log in:
   ```
   fly auth signup
   fly auth login
   ```
3. From the `api/` folder, launch the app:
   ```
   cd api
   fly launch
   ```
   - Pick a name (e.g. `kamidere-api`)
   - Region: pick closest to you
   - Say **no** to adding a database (using Supabase)
   - Say **no** to deploying now
4. Set your secrets:
   ```
   fly secrets set SUPABASE_URL=https://xxxx.supabase.co
   fly secrets set SUPABASE_SERVICE_KEY=your_service_role_key
   fly secrets set BOT_SECRET=any_long_random_string
   ```
5. Deploy:
   ```
   fly deploy
   ```
6. Copy the URL it gives you (e.g. `https://kamidere-api.fly.dev`) — this is your `API_URL`

## 3. Discord bot
1. discord.com/developers → New Application → Bot → copy token
2. Enable **Server Members Intent** under Bot → Privileged Gateway Intents
3. Set env vars wherever you run the bot:
   ```
   BOT_TOKEN=your_discord_bot_token
   CLIENT_ID=your_bot_application_id
   GUILD_ID=your_discord_server_id
   API_URL=https://kamidere-api.fly.dev
   BOT_SECRET=same_string_as_above
   SCRIPT_URL=https://raw.githubusercontent.com/iwishpeoplelovedmeforme/kami/main/loader.lua
   HUB_NAME=kamidere
   KAMIDERE_EMOJI_ID=numeric_id_of_your_kamidere_emoji
   ```
4. Register the slash command (run once):
   ```
   cd bot && node register.js
   ```
5. Run the bot:
   ```
   node index.js
   ```
6. In Discord, run `/panel` in your channel

## 4. Add keys
In Supabase SQL Editor:
```sql
insert into keys (key, script_type) values
  ('KAMI-ABCD-EFGH-IJKL', 'rivals'),
  ('KAMI-WXYZ-1234-5678', 'rivals');
```

## 5. Loader
Users put their key in `loader.lua` at the top, replace `YOUR_API_URL` with your Fly URL, then execute.
- First execute → key binds to their HWID
- Wrong HWID → blocked, tells them to reset via Discord
- Reset HWID → click **Reset HWID** in Discord panel (1 day cooldown)

## 6. Getting your :kamidere: emoji ID
Type `\:kamidere:` in any Discord channel — it will show the full string like `<:kamidere:123456789012345678>`. The number is the ID to put in `KAMIDERE_EMOJI_ID`.
