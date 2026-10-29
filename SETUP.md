# kamidere — setup (Windows 10)

---

## 1. Supabase (database)

1. Go to **supabase.com** → Sign up → **New Project**
2. Pick a name and password, hit Create
3. Once it loads, click **SQL Editor** in the left sidebar
4. Paste everything from `api/schema.sql` into the editor and click **Run**
5. Go to **Settings → API** and copy:
   - **Project URL** → save this as `SUPABASE_URL`
   - **service_role** key (under "Project API Keys") → save this as `SUPABASE_SERVICE_KEY`

---

## 2. API on Fly.io

**Step 1 — Install Fly CLI**

Open PowerShell as Administrator and paste this:
```
powershell -Command "iwr https://fly.io/install.ps1 -useb | iex"
```
Close and reopen PowerShell after it finishes.

**Step 2 — Sign up**

```
flyctl auth signup
```
It will open a browser. Create a free account (no card needed for free tier).

**Step 3 — Deploy**

First, download the repo if you haven't:
```
git clone https://github.com/iwishpeoplelovedmeforme/kami.git
cd kami\api
```
Then run:
```
flyctl launch --name kamidere-api --region lax --no-deploy
```
When it asks questions just press Enter to accept defaults.

**Step 4 — Add your secrets**

Run these one by one, replacing the values:
```
flyctl secrets set SUPABASE_URL=https://xxxx.supabase.co
flyctl secrets set SUPABASE_SERVICE_KEY=your_service_role_key_here
flyctl secrets set BOT_SECRET=makeuparandomlongstring123
```

**Step 5 — Deploy**

```
flyctl deploy
```
When it finishes it will print a URL like `https://kamidere-api.fly.dev` — **save this**, it is your `API_URL`.

---

## 3. Discord Bot

**Step 1 — Create the bot**

1. Go to **discord.com/developers/applications** → **New Application** → name it `kamidere`
2. Click **Bot** on the left → **Reset Token** → copy the token → save as `BOT_TOKEN`
3. Scroll down, turn on **Server Members Intent**
4. Click **OAuth2 → URL Generator** → tick `bot` + `applications.commands`
5. Under Bot Permissions tick: **Manage Roles**, **Send Messages**, **Use Slash Commands**
6. Copy the URL at the bottom and open it to invite the bot to your server

**Step 2 — Install Node.js**

Download and install from **nodejs.org** (LTS version). Just click Next through the installer.

**Step 3 — Set up the bot**

Open PowerShell, go into the bot folder (from wherever you cloned the repo):
```
cd kami\bot
```
Install dependencies:
```
npm install
```

Create a file called `.env` in the `bot/` folder with Notepad and paste this (fill in your values):
```
BOT_TOKEN=your_bot_token
CLIENT_ID=your_application_id
GUILD_ID=your_discord_server_id
API_URL=https://kamidere-api.fly.dev
BOT_SECRET=makeuparandomlongstring123
SCRIPT_URL=https://raw.githubusercontent.com/iwishpeoplelovedmeforme/kami/main/loader.lua
HUB_NAME=kamidere
KAMIDERE_EMOJI_ID=your_kamidere_emoji_id
```

> **Where to find CLIENT_ID:** discord.com/developers → your app → **General Information** → Application ID  
> **Where to find GUILD_ID:** Right-click your Discord server icon → **Copy Server ID** (enable Developer Mode in Discord settings first)  
> **KAMIDERE_EMOJI_ID:** Type `\:kamidere:` in any channel, it shows the full ID

Install dotenv so the bot reads the `.env` file:
```
npm install dotenv
```

Add this line to the very top of `bot/index.js`:
```
require('dotenv').config();
```

**Step 4 — Register the slash command (once only)**

```
node register.js
```

**Step 5 — Run the bot**

```
node index.js
```

Go to your Discord server and type `/panel` — the panel will appear.

---

## 4. Add keys

In Supabase → SQL Editor, run:
```sql
insert into keys (key, script_type) values
  ('KAMI-ABCD-EFGH-IJKL', 'rivals'),
  ('KAMI-WXYZ-1234-5678', 'rivals');
```
Make up any key format you want. Give these keys to your users.

---

## 5. Update loader.lua

Open `loader.lua` and replace:
- `YOUR_KEY_HERE` → leave as is (users fill this in themselves)
- `https://YOUR_API_URL/verify` → `https://kamidere-api.fly.dev/verify`

Commit and push after editing:
```
git add loader.lua
git commit -m "update api url"
git push
```

---

## Done

Users execute `loader.lua`, put their key at the top.  
First run binds their HWID. Wrong HWID = blocked.  
They reset HWID via the Discord panel (once per 24 hours).
