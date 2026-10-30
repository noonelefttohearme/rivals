-- Run this once in your Supabase SQL editor
-- If you already ran the old schema, run this to rename the table:
-- alter table keys rename to licenses;
-- Otherwise run the full create below:

create table if not exists licenses (
  id            uuid primary key default gen_random_uuid(),
  key           text unique not null,
  discord_id    text unique,
  hwid          text,
  script_type   text,
  redeemed_at   timestamptz,
  expires_at    timestamptz,
  last_used     timestamptz,
  reset_hwid_at timestamptz,
  created_at    timestamptz default now()
);

alter table licenses disable row level security;

-- Run these if the table already exists:
-- alter table licenses add column if not exists blacklisted boolean default false;
-- alter table licenses add column if not exists frozen boolean default false;
