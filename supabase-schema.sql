-- ===================================================================
-- PONTO A — Estrutura de banco de dados para o Supabase
-- Rode este script inteiro em: Supabase > SQL Editor > New query > Run
-- ===================================================================

-- Tabela do "Ponto de partida" (saldo, cartões, caixinhas)
create table if not exists ponto_a (
  user_id uuid references auth.users not null primary key,
  saldo_conta numeric not null default 0,
  cartoes jsonb not null default '[]',
  caixinhas jsonb not null default '[]',
  updated_at timestamptz not null default now()
);

-- Tabela de lançamentos (entradas e saídas)
create table if not exists entries (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users not null,
  tipo text not null check (tipo in ('entrada','saida')),
  data date not null,
  categoria text not null,
  valor numeric not null,
  descricao text,
  created_at timestamptz not null default now()
);

-- Tabela de objetivos financeiros
create table if not exists goals (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users not null,
  tipo text not null,
  nome text not null,
  valor_alvo numeric not null,
  valor_atual numeric not null default 0,
  created_at timestamptz not null default now()
);

-- Tabela de limites semanais por categoria
create table if not exists limits_config (
  user_id uuid references auth.users not null,
  categoria text not null,
  valor numeric not null,
  primary key (user_id, categoria)
);

-- ===================================================================
-- Segurança: cada pessoa só acessa os próprios dados (Row Level Security)
-- ===================================================================
alter table ponto_a enable row level security;
alter table entries enable row level security;
alter table goals enable row level security;
alter table limits_config enable row level security;

drop policy if exists "own data" on ponto_a;
create policy "own data" on ponto_a
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

drop policy if exists "own data" on entries;
create policy "own data" on entries
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

drop policy if exists "own data" on goals;
create policy "own data" on goals
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);

drop policy if exists "own data" on limits_config;
create policy "own data" on limits_config
  for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
