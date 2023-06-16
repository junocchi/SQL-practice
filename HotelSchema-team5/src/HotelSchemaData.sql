
delete from Reservation where guest_id in
(select guest_id from Guest
where guest_name ="Jeremiah Pendergrass ");

delete from Guest
where guest_name = 'Jeremiah Pendergrass';

