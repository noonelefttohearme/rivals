# kamidere — setup

## 1. Supabase (database, free)
1. Create project at supabase.com
2. Go to SQL Editor → paste and run `api/schema.sql`
3. Settings → API → copy **Project URL** and **service_role** key

## 2. API (Railway, free)
1. railway.app → New Project → Deploy from GitHub repo → select `/api` folder
2. Add env vars from `.env.example` (SUPABASE_URL, SUPABASE_SERVICE_KEY, BOT_SECRET)
3. Copy the deployed URL (e.g. `https://kamidere-api.railway.app`)

## 3. Discord bot
1. discord.com/developers → New Application → Bot → copy token
2. Enable **Server Members Intent** under Bot → Privileged Gateway Intents
3. Add env vars to bot process: BOT_TOKEN, CLIENT_ID, GUILD_ID, API_URL, BOT_SECRET, SCRIPT_URL, KEY_ROLE_ID, HUB_NAME, HUB_ID
4. Register slash command (run once):
   ```
   node bot/register.js
   ```
5. Run bot:
   ```
   node bot/index.js
   ```
6. In Discord, run `/panel` in your channel

## 4. Add keys
In Supabase SQL Editor:
```sql
insert into keys (key) values
  ('KAMI-ABCD-EFGH-IJKL'),
  ('KAMI-WXYZ-1234-5678');
```

## 5. Loader
Users put their key in `loader.lua` at the top and execute it.  
On first execute → key binds to their HWID.  
Wrong HWID → error, tells them to reset via Discord bot.  
Reset HWID → click **Reset HWID** button in Discord panel.
