-- Insert sample site users
INSERT INTO public.site_user (account_name, account_type, username, password)
VALUES 
('John Smith', 'Customer', 'john_smith', 'securepass1'),
('Event Masters', 'Organiser', 'event_masters', 'securepass2'),
('Sarah Jones', 'Customer', 'sarah_j', 'securepass3'),
('Conference Pro', 'Organiser', 'conf_pro', 'securepass4');

-- Insert sample organisers
INSERT INTO public.organiser (site_user_id, name, email, organiser_id)
VALUES 
(2, 'Event Masters Inc.', 'contact@eventmasters.com', 1),
(4, 'Conference Professionals', 'info@confpro.com', 2);

-- Insert sample customers
INSERT INTO public.customer (site_user_id, name, email)
VALUES 
(1, 'John Smith', 'john.smith@email.com'),
(3, 'Sarah Jones', 'sarah.jones@email.com');

-- Insert sample events
INSERT INTO public.event (organiser_id, name, location, event_date, description, ticket_total, tickets_available)
VALUES 
(1, 'Tech Conference 2025', 'Wollongong Convention Center', '2025-06-15 09:00:00', 'Annual technology conference featuring the latest innovations', 200, 200),
(1, 'Yours & Owls', 'North Dalton Park, Wollongong', '2025-07-20 12:00:00', 'Outdoor music festival with local and international artists', 500, 500),
(2, 'Business Leadership Summit', 'Wollongong Convention Centre', '2025-05-30 08:30:00', 'Network with industry leaders and learn key leadership skills', 150, 150);
