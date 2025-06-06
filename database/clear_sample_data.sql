-- Delete in reverse order of dependencies (child tables first)
-- Start transaction
BEGIN;

-- Clear all tables in proper order
DELETE FROM public.ticket;
DELETE FROM public.registration;
DELETE FROM public.event;
DELETE FROM public.customer;
DELETE FROM public.organiser;
DELETE FROM public.site_user;

-- Reset all sequences to 1
ALTER SEQUENCE public.site_user_site_user_id_seq RESTART WITH 1;
ALTER SEQUENCE public.organiser_organiser_id_seq RESTART WITH 1;
ALTER SEQUENCE public.customer_user_id_seq RESTART WITH 1;
ALTER SEQUENCE public.event_event_id_seq RESTART WITH 1;
ALTER SEQUENCE public.registration_registration_id_seq RESTART WITH 1;
ALTER SEQUENCE public.ticket_ticket_id_seq RESTART WITH 1;

-- Commit the transaction if all deletions are successful
COMMIT;
