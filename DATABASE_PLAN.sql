-- RR EVOLUTION — esquema inicial recomendado para Supabase/PostgreSQL
-- No ejecutar en una base productiva sin revisión y pruebas de seguridad.

create extension if not exists pgcrypto;

create type public.app_role as enum ('admin', 'student');
create type public.plan_status as enum ('draft', 'published', 'archived');

create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  role public.app_role not null default 'student',
  full_name text not null,
  email text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.students (
  id uuid primary key default gen_random_uuid(),
  user_id uuid unique references public.profiles(id) on delete set null,
  full_name text not null,
  email text,
  goal text,
  status text not null default 'active' check (status in ('active','pending','inactive')),
  coach_notes text,
  created_by uuid not null references public.profiles(id),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.training_plans (
  id uuid primary key default gen_random_uuid(),
  student_id uuid not null references public.students(id) on delete cascade,
  title text not null,
  version integer not null default 1,
  status public.plan_status not null default 'draft',
  instructions text,
  created_by uuid not null references public.profiles(id),
  published_at timestamptz,
  created_at timestamptz not null default now(),
  unique(student_id, version)
);

create table public.training_sessions (
  id uuid primary key default gen_random_uuid(),
  plan_id uuid not null references public.training_plans(id) on delete cascade,
  day_label text not null,
  sort_order integer not null default 0
);

create table public.exercises (
  id uuid primary key default gen_random_uuid(),
  session_id uuid not null references public.training_sessions(id) on delete cascade,
  name text not null,
  sets text,
  reps text,
  rest_seconds integer,
  notes text,
  sort_order integer not null default 0
);

create table public.nutrition_plans (
  id uuid primary key default gen_random_uuid(),
  student_id uuid not null references public.students(id) on delete cascade,
  title text not null,
  version integer not null default 1,
  status public.plan_status not null default 'draft',
  professional_name text,
  instructions text,
  created_by uuid not null references public.profiles(id),
  published_at timestamptz,
  created_at timestamptz not null default now(),
  unique(student_id, version)
);

create table public.meals (
  id uuid primary key default gen_random_uuid(),
  plan_id uuid not null references public.nutrition_plans(id) on delete cascade,
  meal_name text not null,
  meal_time text,
  ingredients jsonb not null default '[]'::jsonb,
  alternatives jsonb not null default '[]'::jsonb,
  sort_order integer not null default 0
);

create table public.check_ins (
  id uuid primary key default gen_random_uuid(),
  student_id uuid not null references public.students(id) on delete cascade,
  submitted_by uuid not null references public.profiles(id),
  recorded_at timestamptz not null default now(),
  weight_kg numeric(5,2),
  waist_cm numeric(5,2),
  adherence_percent integer check (adherence_percent between 0 and 100),
  notes text,
  created_at timestamptz not null default now()
);

create table public.training_completions (
  id uuid primary key default gen_random_uuid(),
  student_id uuid not null references public.students(id) on delete cascade,
  session_id uuid not null references public.training_sessions(id) on delete cascade,
  completed_at timestamptz not null default now(),
  notes text
);

create table public.messages (
  id uuid primary key default gen_random_uuid(),
  student_id uuid not null references public.students(id) on delete cascade,
  sender_id uuid not null references public.profiles(id),
  body text not null,
  created_at timestamptz not null default now(),
  read_at timestamptz
);

create table public.audit_log (
  id uuid primary key default gen_random_uuid(),
  actor_id uuid not null references public.profiles(id),
  student_id uuid references public.students(id) on delete set null,
  action text not null,
  entity_type text not null,
  entity_id uuid,
  created_at timestamptz not null default now()
);

-- Security design notes:
-- 1) Enable RLS on every table before real data is inserted.
-- 2) Admin policies must be based on a trusted role claim or profiles.role,
--    never on client-provided form fields.
-- 3) Students must only read/update the row linked to their own auth.uid().
-- 4) Only admins may create/publish plans; students may submit their own
--    check-ins and read published plans assigned to them.
-- 5) Use private Storage buckets and expiring signed URLs for photos/documents.
-- 6) Add tests proving one student cannot read another student's rows.
-- Policy SQL intentionally omitted until the final identity/authorization
-- model is selected and reviewed; permissive placeholder policies are unsafe.
