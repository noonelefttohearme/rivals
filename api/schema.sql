-- Run this once in your Supabase SQL editor

create table if not exists keys (
  id           uuid primary key default gen_random_uuid(),
  key          text unique not null,
  discord_id   text unique,
  hwid         text,
  redeemed_at  timestamptz,
  expires_at   timestamptz,
  last_used    timestamptz,
  created_at   timestamptz default now()
);

-- Disable row-level security for service-key access (API uses service key)
alter table keys disable row level security;

-- Example: insert a key manually
-- insert into keys (key) values ('KAMI-TEST-AAAA-BBBB');
