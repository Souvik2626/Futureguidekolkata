-- ==============================================================================
-- FUTURE GUIDE - Supabase Backend Database Schema
-- Project Ref: sxntsaivqdhovbzzoqci
-- Project URL: https://sxntsaivqdhovbzzoqci.supabase.co
-- Table: public.inquiries
-- Status: ACTIVE & VERIFIED
-- ==============================================================================

-- 1. Create Inquiries Table
create table if not exists public.inquiries (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  phone text not null,
  email text,
  course text not null,
  location_preference text,
  message text,
  source text default 'Website Admission Form',
  status text default 'New',
  created_at timestamp with time zone default timezone('utc'::text, now()) not null
);

-- 2. Enable Row Level Security (RLS)
alter table public.inquiries enable row level security;

-- 3. Policy: Allow anonymous website visitors to submit admission inquiries
create policy "Allow anonymous website inquiries"
  on public.inquiries
  for insert
  to anon, authenticated
  with check (true);

-- 4. Policy: Allow authenticated staff / counselors to view all inquiries
create policy "Allow authenticated users to read inquiries"
  on public.inquiries
  for select
  to authenticated
  using (true);

-- 5. Policy: Allow authenticated staff / counselors to update inquiry status (e.g., New -> Contacted -> Admitted)
create policy "Allow authenticated users to update inquiries"
  on public.inquiries
  for update
  to authenticated
  using (true);

-- 6. Performance Indexes for Fast Searching & Filtering
create index if not exists idx_inquiries_created_at on public.inquiries (created_at desc);
create index if not exists idx_inquiries_phone on public.inquiries (phone);
create index if not exists idx_inquiries_course on public.inquiries (course);
