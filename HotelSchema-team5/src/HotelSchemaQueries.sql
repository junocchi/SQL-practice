
-- 1
-- Write a query that returns a list of reservations that end in July 2023, 
-- including the name of the guest, the room number(s), and the reservation dates.

SELECT guest.guest_name, room.room_id, reservation.start_date, reservation.end_date 
FROM reservation 
JOIN guest ON guest.guest_id = reservation.guest_id 
JOIN room ON room.room_id = reservation.room_id 
WHERE MONTH(reservation.end_date) = 7 AND YEAR(reservation.end_date) = 2023;

/*
guest_name,room_id,start_date,end_date
'Your Name','205','2023-06-28','2023-07-02'
'Walter Holaway','204','2023-07-13','2023-07-14'
'Wilfred Vise','401','2023-07-18','2023-07-21'
'Bettyann Seery','303','2023-07-28','2023-07-29'
*/


-- 2 Ju
-- Write a query that returns a list of all reservations for rooms with a jacuzzi,
-- displaying the guest's name, the room number, and the dates of the reservation.

select Guest.guest_name, Room.room_id, Reservation.start_date, Reservation.end_date
from Guest
inner join Reservation on Guest.guest_id = Reservation.guest_id
inner join Room on Reservation.room_id = Room.room_id
inner join Room_amenities on Room.room_id = Room_amenities.room_id
inner join Amenities on Room_amenities.amenities_id = Amenities.amenities_id
where Amenities.type = 'jacuzzi';

/* 
guest_name,room_id,start_date,end_date
"Karie Yang",201,2023-03-06,2023-03-07
"Bettyann Seery",203,2023-02-05,2023-02-10
"Karie Yang",203,2023-09-13,2023-09-15
"Wilfred Vise",207,2023-04-23,2023-04-24
"Walter Holaway",301,2023-04-09,2023-04-13
"Mack Simmer",301,2023-11-22,2023-11-25
"Bettyann Seery",303,2023-07-28,2023-07-29
"Duane Cullison",305,2023-02-22,2023-02-24
"Bettyann Seery",305,2023-08-30,2023-09-01
*/

-- 3 Ju
-- Write a query that returns all the rooms reserved for a specific guest, 
-- including the guest's name, the room(s) reserved, the starting date of the reservation, 
-- and how many people were included in the reservation. (Choose a guest's name from the existing data.)

select Guest.guest_name, Room.room_id, Reservation.start_date, Reservation.adults + Reservation.children 
as total_guests
from Guest
inner join Reservation on Guest.guest_id = Reservation.guest_id
inner join Room on Reservation.room_id = Room.room_id
where Guest.guest_name = 'Bettyann Seery';

/* 
guest_name,room_id,start_date,total_guests
"Bettyann Seery",203,2023-02-05,3
"Bettyann Seery",303,2023-07-28,3
"Bettyann Seery",305,2023-08-30,1
*/

-- 4
-- Write a query that returns a list of rooms, reservation ID, and per-room cost for each reservation.
-- The results should include all rooms, whether or not there is a reservation associated with the room.


SELECT Room.room_id, Reservation.reservation_id, Reservation.total_cost
FROM Room
LEFT JOIN Reservation ON Room.room_id = Reservation.room_id;

/*
room_id,reservation_id,total_cost
'201','4','199.99'
'202','7','349.98'
'203','2','999.95'
'203','21','399.98'
'204','16','184.99'
'205','15','699.96'
'206','12','599.96'
'206','23','449.97'
'207','10','174.99'
'208','13','599.96'
'208','20','149.99'
'301','9','799.96'
'301','24','599.97'
'302','6','924.95'
'302','25','699.96'
'303','18','199.99'
'304','8','874.95'
'304','14','184.99'
'305','3','349.98'
'305','19','349.98'
'306',NULL,NULL
'307','5','524.97'
'308','1','299.98'
'401','11','199.97'
'401','17','259.97'
'401','22','199.97'
'402',NULL,NULL
*/







-- 5
-- Write a query that returns all rooms with a capacity of three or more 
-- and that are reserved on any date in April 2023.

select room_id from Room
where max_occupancy >= 3 and room_id in
(select room_id from Reservation 
where month(start_date) = 4 and year(start_date) = 2023
or month(end_date) = 4 and year(end_date) = 2023
or start_date <= '2023-04-30' and end_date >= '2023-04-01');

-- result: 301





-- 6
-- Write a query that returns a list of all guest names and the number of reservations per guest,
-- sorted starting with the guest with the most reservations 
-- and then by the guest's last name.

select g.guest_name, count(r.reservation_id) AS NumOfReservations
from Guest g
left join Reservation r
On g.guest_id = r.guest_id
group by g.guest_id
order by  NumOfReservations desc, SUBSTRING_INDEX(guest_name, ' ', -1) asc;


-- output
-- Mack	Simmer			4
-- Bettyann	Seery		3
-- Duane Cullison		2
-- Walter Holaway		2
-- Aurore Lipton		2
-- Your Name			2
-- Maritza Tilton		2
-- Joleen Tison			2
-- Wilfred Vise			2
-- Karie Yang			2
-- Zachery Luechtefeld	1



-- 7
-- Write a query that displays the name, address, 
-- and phone number of a guest based on their phone number. 
-- (Choose a phone number from the existing data.)

select guest_name , address, phone
from guest
where phone = '(291) 553-0508' ;

-- output
-- Mack Simmer	379 Old Shore Street	(291) 553-0508









