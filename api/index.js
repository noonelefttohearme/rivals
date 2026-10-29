const express = require('express');
const { createClient } = require('@supabase/supabase-js');

const app = express();
app.use(express.json());

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_KEY
);

const BOT_SECRET = process.env.BOT_SECRET;
const HWID_RESET_COOLDOWN_MS = 24 * 60 * 60 * 1000; // 24 hours

// POST /verify  { key, hwid }
app.post('/verify', async (req, res) => {
  const { key, hwid } = req.body;
  if (!key || !hwid) return res.json({ valid: false, message: 'Missing key or hwid.' });

  const { data, error } = await supabase
    .from('keys')
    .select('*')
    .eq('key', key)
    .single();

  if (error || !data) return res.json({ valid: false, message: 'Invalid key.' });

  if (data.expires_at && new Date(data.expires_at) < new Date()) {
    return res.json({ valid: false, message: 'Key expired.' });
  }

  if (!data.hwid) {
    await supabase.from('keys').update({ hwid, last_used: new Date().toISOString() }).eq('key', key);
    return res.json({ valid: true, message: 'Key bound.' });
  }

  if (data.hwid !== hwid) {
    return res.json({ valid: false, message: 'HWID mismatch. Reset your HWID via the Discord panel.' });
  }

  await supabase.from('keys').update({ last_used: new Date().toISOString() }).eq('key', key);
  return res.json({ valid: true, message: 'OK' });
});

// POST /reset-hwid  { key }  — called by Discord bot, enforces 24h cooldown
app.post('/reset-hwid', async (req, res) => {
  if (req.headers['x-bot-secret'] !== BOT_SECRET)
    return res.status(401).json({ ok: false, message: 'Unauthorized.' });

  const { key } = req.body;
  if (!key) return res.json({ ok: false, message: 'No key provided.' });

  const { data, error } = await supabase
    .from('keys')
    .select('reset_hwid_at')
    .eq('key', key)
    .single();

  if (error || !data) return res.json({ ok: false, message: 'Key not found.' });

  if (data.reset_hwid_at) {
    const elapsed = Date.now() - new Date(data.reset_hwid_at).getTime();
    if (elapsed < HWID_RESET_COOLDOWN_MS) {
      const remaining = HWID_RESET_COOLDOWN_MS - elapsed;
      const hrs  = Math.floor(remaining / 3600000);
      const mins = Math.floor((remaining % 3600000) / 60000);
      return res.json({
        ok: false,
        message: `HWID reset is on cooldown. Try again in **${hrs}h ${mins}m**.`,
      });
    }
  }

  await supabase.from('keys')
    .update({ hwid: null, reset_hwid_at: new Date().toISOString() })
    .eq('key', key);

  return res.json({ ok: true, message: 'HWID reset. Binds to your next device on execute.' });
});

// POST /redeem  { key, discord_id }
app.post('/redeem', async (req, res) => {
  if (req.headers['x-bot-secret'] !== BOT_SECRET)
    return res.status(401).json({ ok: false, message: 'Unauthorized.' });

  const { key, discord_id } = req.body;
  if (!key || !discord_id) return res.json({ ok: false, message: 'Missing key or discord_id.' });

  const { data: existing } = await supabase
    .from('keys')
    .select('*')
    .eq('discord_id', discord_id)
    .single();

  if (existing) return res.json({ ok: false, message: 'You already have a key.' });

  const { data, error } = await supabase
    .from('keys')
    .update({ discord_id, redeemed_at: new Date().toISOString() })
    .eq('key', key)
    .is('discord_id', null)
    .select()
    .single();

  if (error || !data) return res.json({ ok: false, message: 'Invalid or already redeemed key.' });
  return res.json({ ok: true, key: data.key, script_type: data.script_type });
});

// GET /stats
app.get('/stats', async (req, res) => {
  if (req.headers['x-bot-secret'] !== BOT_SECRET)
    return res.status(401).json({ ok: false });

  const { count: total }  = await supabase.from('keys').select('*', { count: 'exact', head: true });
  const { count: active } = await supabase.from('keys').select('*', { count: 'exact', head: true }).not('discord_id', 'is', null);
  const { count: bound }  = await supabase.from('keys').select('*', { count: 'exact', head: true }).not('hwid', 'is', null);

  res.json({ total, active, bound });
});

// POST /generate  { script_type }
app.post('/generate', async (req, res) => {
  if (req.headers['x-bot-secret'] !== BOT_SECRET)
    return res.status(401).json({ ok: false, message: 'Unauthorized.' });

  const { script_type = 'rivals' } = req.body;

  const seg = () => Math.random().toString(36).toUpperCase().slice(2, 6).padEnd(4, '0');
  const key = `KAMI-${seg()}-${seg()}-${seg()}`;

  const { error } = await supabase.from('keys').insert({ key, script_type });
  if (error) return res.json({ ok: false, message: 'Failed to generate key.' });

  return res.json({ ok: true, key, script_type });
});

// GET /key/:discord_id
app.get('/key/:discord_id', async (req, res) => {
  if (req.headers['x-bot-secret'] !== BOT_SECRET)
    return res.status(401).json({ ok: false });

  const { data, error } = await supabase
    .from('keys')
    .select('key, hwid, redeemed_at, expires_at, last_used, script_type, reset_hwid_at')
    .eq('discord_id', req.params.discord_id)
    .single();

  if (error || !data) return res.json({ ok: false, message: 'No key found.' });
  return res.json({ ok: true, ...data });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`API running on :${PORT}`));
