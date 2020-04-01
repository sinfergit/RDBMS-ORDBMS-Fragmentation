-- Create Relational tables with Spaceformance business entities
--Customer
CREATE TABLE Customer(
CustomerId NUMBER NOT NULL PRIMARY KEY ,
FirstName VARCHAR2(100) NOT NULL,
LastName VARCHAR2(100) NOT NULL,
DOB DATE
);
--Venue 
CREATE TABLE Venue(
VenueId NUMBER NOT NULL PRIMARY KEY,
VenueName  VARCHAR2(100) NOT NULL,
Address VARCHAR2(100) NULL,
TelephoneNo VARCHAR2(15) NOT NULL
);
--Event Type 
CREATE TABLE EventType(
TypeId NUMBER NOT NULL PRIMARY KEY,
TypeName  VARCHAR2(100) NOT NULL
);
--Event
CREATE TABLE Event(
EventId NUMBER NOT NULL PRIMARY KEY,
EventName  VARCHAR2(100),
VenueId NUMBER NOT NULL,
EventTypeId NUMBER,
StartTime DATETIME,
EndTime DATE,
AgeLimit VARCHAR(15),
Price DECIMAL,
AvailableSeats NUMBER,
FOREIGN KEY(VenueId) REFERENCES Venue(VenueId),
FOREIGN KEY(EventTypeId) REFERENCES EventType(TypeId)
);
--Booking
CREATE TABLE  Booking(
BookingId NUMBER NOT NULL PRIMARY KEY,
CustomerId NUMBER NOT NULL ,
BookingDate DATE NOT NULL,
CreatedDate DATE NOT NULL,
FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId)
);
--Booking Event
CREATE TABLE BookingEvent(
BookingEventId NUMBER NOT NULL PRIMARY KEY,
BookingId NUMBER NOT NULL,
EventId NUMBER NOT NULL,
NoOfTickets NUMBER,
FOREIGN KEY(BookingId) REFERENCES Booking(BookingId),
FOREIGN KEY(EventId) REFERENCES Event(EventId)
);
--Employee
CREATE TABLE Employee(
EmployeeId NUMBER NOT NULL PRIMARY KEY,
FirstName VARCHAR2(100),
LastName VARCHAR2(100),
VenueId NUMBER NOT NULL,
DOB DATE NULL,
FOREIGN KEY(VenueId) REFERENCES Venue(VenueId)
);
--Performer Type
CREATE TABLE PerformerType (
PerformerTypeId NUMBER NOT NULL PRIMARY KEY,
TypeName VARCHAR2(50) NOT NULL
);
--Performer
CREATE TABLE Performer (
PerformerId NUMBER NOT NULL PRIMARY KEY,
Name VARCHAR2(100),
PerformerTypeId NUMBER NOT NULL,
RegisteredDate DATE,
Address VARCHAR2(200),
FOREIGN KEY(PerformerTypeId) REFERENCES PerformerType(PerformerTypeId)
);
--Event Performer
CREATE TABLE EventPerformer (
EventPerformerId NUMBER NOT NULL PRIMARY KEY,
EventId NUMBER NOT NULL,
PerformerId NUMBER NOT NULL,
FOREIGN KEY(EventId) REFERENCES Event(EventId),
FOREIGN KEY(PerformerId) REFERENCES Performer(PerformerId)
);
--Performer Payment
CREATE TABLE PerformerPayment (
PerformerPaymentId NUMBER NOT NULL PRIMARY KEY,
EventPerformerId NUMBER NOT NULL,
Amount DECIMAL NOT NULL,
PaymentDate DATE NOT NULL,
FOREIGN KEY(EventPerformerId) REFERENCES EventPerformer(EventPerformerId)
);
--Satff Assignment
CREATE TABLE StaffAssignment (
AssignementId NUMBER NOT NULL PRIMARY KEY,
EmployeeId NUMBER NOT NULL,
BookingEventId NUMBER NULL,
EventPerformerId NUMBER NULL,
FOREIGN KEY(EmployeeId) REFERENCES Employee(EmployeeId),
FOREIGN KEY(BookingEventId) REFERENCES BookingEvent(BookingEventId),
FOREIGN KEY(EventPerformerId) REFERENCES EventPerformer(EventPerformerId)
);
--Membership payment status
CREATE TABLE MembershipPaymentStatus (
StatusId NUMBER NOT NULL PRIMARY KEY,
StatusName VARCHAR2(20) NOT NULL
);
--Membership type
CREATE TABLE MembershipType (
MembershipTypeId NUMBER NOT NULL PRIMARY KEY,
TypeName VARCHAR2(20) NOT NULL,
DurationType VARCHAR2(20) NULL,
Active SMALLINT
);
--Membership
CREATE TABLE Membership (
MemberShipId NUMBER NOT NULL PRIMARY KEY,
MemberShipTypeId NUMBER NOT NULL,
StartDate DATE NOT NULL,
Fee DECIMAL NOT NULL,
Active SMALLINT,
FOREIGN KEY(MemberShipTypeId) REFERENCES MembershipType(MembershipTypeId)
);
--CustomerMembership
CREATE TABLE CustomerMembership (
Id NUMBER NOT NULL PRIMARY KEY ,
CustomerId NUMBER NOT NULL,
MemberShipId NUMBER NOT NULL,
PaymentStatusId NUMBER NOT NULL,
StartDate DATE  NOT NULL,
EndDate DATE NOT NULL,
Active SMALLINT,
FOREIGN KEY(CustomerId) REFERENCES Customer(CustomerId),
FOREIGN KEY(MemberShipId) REFERENCES MemberShip(MemberShipId),
FOREIGN KEY(PaymentStatusId) REFERENCES MembershipPaymentStatus(StatusId)
);













