-- Delete in reverse order of dependencies (child tables first)
BEGIN;

-- Delete all tickets
DELETE FROM public.ticket;

-- Delete all registrations
DELETE FROM public.registration;

-- Delete all events
DELETE FROM public.event;

-- Delete all customers
DELETE FROM public.customer;

-- Delete all organisers
DELETE FROM public.organiser;

-- Delete all site users
DELETE FROM public.site_user;

-- Commit the transaction if all deletions are successful
COMMIT;
