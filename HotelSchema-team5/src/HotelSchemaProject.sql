create database hotel;
use hotel;

-- SET SQL_SAFE_UPDATES=0;

create table Room(
room_id int primary key,
room_type varchar(25) not null,
ada_accessible boolean not null,
std_occupancy int not null,
max_occupancy int not null,
base_price decimal(65,2) not null);


create table Guest (
guest_id int auto_increment,
guest_name varchar(25) not null,
address varchar(25) not null,
city varchar(25) not null,
state varchar(25) not null,
zip int not null,
phone varchar(15) not null,
constraint PK_Guests primary key (guest_id));

create table Reservation (
reservation_id int auto_increment primary key,
adults int not null,
children int,
start_date date not null,
end_date date not null,
total_cost decimal(65,2) not null,
room_id int not null,
guest_id int not null,
constraint FK_Room foreign key(room_id) references Room(room_id),
constraint FK_Guest foreign key(guest_id) references Guest(guest_id)
);

create table Amenities (
amenities_id int auto_increment primary key,
type varchar(20));

create table Room_amenities (
serial_number int auto_increment primary key,
room_id int not null,
amenities_id int not null,
constraint FK_Room_id foreign key (room_id) references Room(room_id),
constraint FK_Amenities foreign key (amenities_id) references Amenities(amenities_id));

drop table Reservation;
drop table Room;
drop table Guest;
drop table Amenities;
drop table Room_amenities;

select * from Room;
select * from Guest;
select * from Amenities;
select * from Room_amenities;
select * from Reservation;
