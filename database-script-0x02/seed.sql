-- Insert sample data
-- User
INSERT INTO User (
    user_id,
    first_name,
    last_name,
    email,
    password_hash,
    role
) VALUES (
    "d7ece863-6e57-4db1-99bd-552ff0c10bd5",
    "Eric",
    "John",
    "ericjohn@gmail.com",
    "$2b$7fxvDqcVKp71S4gOwHnaza1Tu",
    "admin"
), (
    "2d5273e8-515b-49f7-b113-f50dd9846175",
    "Peter",
    "Joe",
    "peter@hotmail.com",
    "$2b$12$x9clf2oboD2z.wHnaza1Tw",
    "host"
), (
    "0ea52fff-b9c8-491b-9323-d087d4715873",
    "Jane",
    "Robbinson",
    "janerob@gmail.com",
    "$2b$12$oboD2zb.0.J10WW..7fxvD",
    "host"
), (
    "d5851c9b-ba95-4c53-ad84-d13e175c9c0e",
    "Michael",
    "Jordan",
    "michaeljordan@gmail.com",
    "$2b$12$x8clf7fxvDqcVKp71S4gOw",
    "guest"
), (
    "7dd6788e-73f9-47fe-aa93-569f7f25b650",
    "Matthew",
    "George",
    "matthewgeorge@outlook.mail",
    "$2b$12$i34lf2pkpD2zYwO2Kl1Pl",
    "guest"
)

-- Property
INSER INTO Property (
    property_id
    host_id,
    name,
    description,
    location,
    price_per_night
) VALUES (
    "e071f579-d15c-492d-9ae5-c12830f05563",
    "2d5273e8-515b-49f7-b113-f50dd9846175", -- Peter Joe's
    "Beach House",
    "2 rooms, 1 kitchen, and 1 bathroom. Enjoy the cool luxury of the coastal view of Baru Island...",
    "Baru Island, South Colombia",
    250
), (
    "2d73cc4b-c13e-4a62-b131-a122092ca931",
    "0ea52fff-b9c8-491b-9323-d087d4715873", -- Jane Robbinson's
    "Down town Malibu",
    "A peaceful and serene reserve meticulously designed for luxury and relaxation, located in the heart of Malibu with exclusive access to CURE Wellness and Gym.",
    "Malibu, California",
    350
)

-- Booking
INSERT INTO Booking (
    booking_id,
    property_id,
    user_id,
    start_date,
    end_date,
    total_price,
    status
) VALUES (
    "4ec843ed-ac19-4943-8169-87ed1027fd36",
    "2d73cc4b-c13e-4a62-b131-a122092ca931", -- Prop: Down Town Malibu
    "d5851c9b-ba95-4c53-ad84-d13e175c9c0e", -- User: Michael Jordan
    "2025-05-12",
    "2025-05-19",
    2450,
    "pending"
), (
    "2228f336-f993-40b9-a422-161438b7da52",
    "e071f579-d15c-492d-9ae5-c12830f05563", --Prop: Beach House
    "7dd6788e-73f9-47fe-aa93-569f7f25b650", --User: Matthew George
    "2025-05-15",
    "2025-05-18",
    750,
    "confirmed"
)

-- Payment
INSERT INTO Payment (
    payment_id,
    booking_id,
    amount,
    payment_date,
    payment_method
) VALUES (
    "b5ea46db-2303-43b4-8b5e-998a5e9606bd",
    "2228f336-f993-40b9-a422-161438b7da52", --Booking: Matthew > Beach House
    750,
    "2025-05-14 08:00:00",
    "credit_card"
), (
    "4f8d6c9d-352e-49d5-8f9e-eab5dff17577",
    "4ec843ed-ac19-4943-8169-87ed1027fd36", --Booking: Michael > Malibu
    2450,
    "2025-05-10 09:45:55",
    "paypal"
)

-- Message
INSERT INTO Message (
    message_id,
    sender_id,
    recipient_id,
    message_body,
    sent_at
) VALUES (
    "cd93dc2f-2c3f-4441-8872-1fb63407b02a",
    "d5851c9b-ba95-4c53-ad84-d13e175c9c0e", --Sender: Michael
    "0ea52fff-b9c8-491b-9323-d087d4715873", --Reciever: Jane
    "Hi Jane, hope you're doing okay? I really appreciate your kind offer, and can't wait to be there",
    "2025-05-10 10:15:05"
), (
    "05981046-6db3-439a-b37e-30f93517b937",
    "0ea52fff-b9c8-491b-9323-d087d4715873", --Sender: Jane
    "d5851c9b-ba95-4c53-ad84-d13e175c9c0e", --Reciever: Michael
    "Hi Michael, you're absolutely welcome, it's been pleasure doing business with you!",
    "2025-05-10 10:16:36"
);

-- Review
INSERT INTO Review (
    review_id,
    property_id,
    user_id,
    rating,
    comment,
    created_at
) VALUES (
    "20a31c11-5b4e-4ca3-9ef9-c5277ba9e078",
    "e071f579-d15c-492d-9ae5-c12830f05563", --Prop: Beach House
    "7dd6788e-73f9-47fe-aa93-569f7f25b650", --User: Matthew
    5,
    "What an amazing place!",
    "2025-04-01 07:50:00"
)
