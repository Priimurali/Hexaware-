create database Hotel_Management;
use Hotel_Management;
create table hotels (
    hotelid int primary key identity(1,1),
    name varchar(100) not null,
    location varchar(255) not null,
    rating decimal(2,1) check (rating between 1 and 5)
);


insert into hotels (name, location, rating) values
('Taj Coromandel', 'Chennai', 4.8),
('The Leela Palace', 'Bangalore', 4.7),
('ITC Grand Chola', 'Chennai', 4.6),
('Vivanta by Taj', 'Coimbatore', 4.5),
('The Gateway Hotel', 'Madurai', 4.3);


create table rooms (
    roomid int primary key identity(1,1),
    hotelid int foreign key references hotels(hotelid) on delete cascade,
    roomnumber varchar(10) not null,
    roomtype varchar(50) not null,
    pricepernight decimal(10,2) not null check (pricepernight >= 0),
    available bit not null default 1
);



insert into rooms (hotelid, roomnumber, roomtype, pricepernight, available) values
(1, '101', 'Deluxe', 4500, 1),
(1, '102', 'Suite', 8000, 1),
(2, '201', 'Standard', 3000, 1),
(2, '202', 'Suite', 7500, 1),
(3, '301', 'Deluxe', 5000, 1),
(3, '302', 'Presidential', 12000, 1),
(4, '401', 'Standard', 3500, 1),
(4, '402', 'Executive', 5500, 1),
(5, '501', 'Suite', 7000, 1),
(5, '502', 'Deluxe', 4800, 1);


create table guests (
    guestid int primary key identity(1,1),
    fullname varchar(100) not null,
    email varchar(100) unique not null,
    phonenumber varchar(15) unique not null,
    checkindate datetime,
    checkoutdate datetime
);


insert into guests (fullname, email, phonenumber, checkindate, checkoutdate) values
('Arun Kumar', 'arun.kumar@example.com', '9876543210', '2024-03-20', '2024-03-22'),
('Meena Ramesh', 'meena.ramesh@example.com', '9876543211', '2024-03-21', '2024-03-23'),
('Suresh Babu', 'suresh.babu@example.com', '9876543212', '2024-03-22', '2024-03-24'),
('Revathi Raj', 'revathi.raj@example.com', '9876543213', '2024-03-23', '2024-03-25'),
('Vikram Krishnan', 'vikram.krishnan@example.com', '9876543214', '2024-03-24', '2024-03-26');


create table bookings (
    bookingid int primary key identity(1,1),
    guestid int foreign key references guests(guestid) on delete cascade,
    roomid int foreign key references rooms(roomid) on delete cascade,
    bookingdate datetime not null default getdate(),
    totalamount decimal(10,2) check (totalamount >= 0),
    status varchar(20) check (status in ('confirmed', 'cancelled', 'checked out'))
);


insert into bookings (guestid, roomid, bookingdate, totalamount, status) values
(1, 1, '2024-03-19', 9000, 'confirmed'),
(2, 2, '2024-03-20', 8000, 'confirmed'),
(3, 3, '2024-03-21', 6000, 'cancelled'),
(4, 4, '2024-03-22', 7500, 'confirmed'),
(5, 5, '2024-03-23', 5000, 'checked out');


create table payments (
    paymentid int primary key identity(1,1),
    bookingid int foreign key references bookings(bookingid) on delete cascade,
    amountpaid decimal(10,2) not null check (amountpaid >= 0),
    paymentdate datetime not null default getdate(),
    paymentmethod varchar(50) not null
);

insert into payments (bookingid, amountpaid, paymentdate, paymentmethod) values
(1, 9000, '2024-03-19', 'Credit Card'),
(2, 8000, '2024-03-20', 'UPI'),
(4, 7500, '2024-03-22', 'Debit Card'),
(5, 5000, '2024-03-23', 'Net Banking');


create table events (
    eventid int primary key identity(1,1),
    hotelid int foreign key references hotels(hotelid) on delete cascade,
    eventname varchar(100) not null,
    eventdate datetime not null,
    venue varchar(100) not null
);


insert into events (hotelid, eventname, eventdate, venue) values
(1, 'South Indian Food Festival', '2024-04-15', 'Banquet Hall A'),
(2, 'Corporate Leadership Summit', '2024-04-18', 'Conference Room B'),
(3, 'Wedding Reception of Priya & Arjun', '2024-04-20', 'Grand Ballroom'),
(4, 'Traditional Bharatanatyam Performance', '2024-04-25', 'Cultural Hall'),
(5, 'Yoga & Wellness Retreat', '2024-04-30', 'Open Lawn Area');


create table eventparticipants (
    participantid int primary key identity(1,1),
    participantname varchar(100) not null,
    participanttype varchar(50) check (participanttype in ('guest', 'organization')),
    eventid int foreign key references events(eventid) on delete cascade
);

drop table eventparticipants;

insert into eventparticipants (participantname, participanttype, eventid) values
('Manoj', 'guest', 1),
('Aishwarya Venkat', 'guest', 2),
('Prakash Rangan', 'organization', 2),
('Deepa Sreenivasan', 'guest', 3),
('Karthik Subramaniam', 'organization', 4),
('Lakshmi Narayanan', 'guest', 5);


select * from rooms where available = 1;

declare @eventid int =1
select participantname from eventparticipants where eventid = @eventid;

create procedure update_hotel_info
    @hotelid int,
    @newname varchar(100),
    @newlocation varchar(255)
as
begin
    update hotels
    set name = @newname, location = @newlocation
    where hotelid = @hotelid;
end;


select h.hotelid, h.name, sum(b.totalamount) as total_revenue
from hotels h
join rooms r on h.hotelid = r.hotelid
join bookings b on r.roomid = b.roomid
where b.status = 'confirmed'
group by h.hotelid, h.name;

select * from rooms
where roomid not in (select distinct roomid from bookings);

select year(paymentdate) as year, month(paymentdate) as month, sum(amountpaid) as total_payments
from payments
group by year(paymentdate), month(paymentdate)
order by year(paymentdate), month(paymentdate);

select distinct roomtype from rooms
where pricepernight between 50 and 150 or pricepernight > 300;

select r.roomnumber, g.fullname, g.checkindate, g.checkoutdate
from rooms r
join bookings b on r.roomid = b.roomid
join guests g on b.guestid = g.guestid
where g.checkoutdate is null;

declare @cityname varchar(255) = 'chennai';
select e.hotelid, count(ep.participantid) as total_participants
from events e
join hotels h on e.hotelid = h.hotelid
join eventparticipants ep on e.eventid = ep.eventid
where h.location = @cityname
group by e.hotelid;

declare @hotelid int = 1;
select distinct roomtype from rooms where hotelid = @hotelid;

select * from guests
where guestid not in (select distinct guestid from bookings);

select r.roomnumber, g.fullname
from bookings b
join rooms r on b.roomid = r.roomid
join guests g on b.guestid = g.guestid;


select h.hotelid, h.name, count(r.roomid) as available_rooms
from hotels h
left join rooms r on h.hotelid = r.hotelid and r.available = 1
group by h.hotelid, h.name;

select r1.roomid as room1, r2.roomid as room2, r1.hotelid, r1.roomtype
from rooms r1
join rooms r2 on r1.hotelid = r2.hotelid and r1.roomtype = r2.roomtype and r1.roomid < r2.roomid;


select h.name as hotel_name, e.eventname as event_name
from hotels h
cross join events e;


select top 1 h.hotelid, h.name, count(b.bookingid) as total_bookings
from hotels h
join rooms r on h.hotelid = r.hotelid
join bookings b on r.roomid = b.roomid
group by h.hotelid, h.name
order by total_bookings desc;







