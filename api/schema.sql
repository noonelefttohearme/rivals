-- Run this once in your Supabase SQL editor

create table if not exists keys (
  id            uuid primary key default gen_random_uuid(),
  key           text unique not null,
  discord_id    text unique,
  hwid          text,
  script_type   text,          -- e.g. 'rivals'
  redeemed_at   timestamptz,
  expires_at    timestamptz,
  last_used     timestamptz,
  reset_hwid_at timestamptz,   -- tracks 24h cooldown
  created_at    timestamptz default now()
);

alter table keys disable row level security;

-- Example: insert a rivals key
-- insert into keys (key, script_type) values ('KAMI-TEST-AAAA-BBBB', 'rivals');
