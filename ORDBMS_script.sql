--Create object types for Spaceformance business entities
--Customer 
CREATE TYPE Customer_objtyp AS OBJECT(
CustomerId NUMBER,
FirstName  VARCHAR2(100),
LastName VARCHAR2(100),
DOB DATE
);
/

CREATE TABLE Customer_objtab OF Customer_objtyp (CustomerId PRIMARY KEY) 
   OBJECT IDENTIFIER IS PRIMARY KEY;

--Venue 
CREATE TYPE Venue_objtyp AS OBJECT(
VenueId NUMBER,
VenueName  VARCHAR2(100),
Address VARCHAR2(100),
TelephoneNo VARCHAR2(10)
);
/

CREATE TABLE Venue_objtab OF Venue_objtyp (VenueId PRIMARY KEY) 
   OBJECT IDENTIFIER IS PRIMARY KEY;
   
   
--Event Type 
CREATE TYPE EventType_objtyp AS OBJECT(
TypeId NUMBER,
TypeName  VARCHAR2(100)
);
/

CREATE TABLE EventType_objtab OF EventType_objtyp (TypeId PRIMARY KEY) 
   OBJECT IDENTIFIER IS PRIMARY KEY;

--Create event as incomplete
CREATE TYPE Event_objtyp;

--Performer Type
CREATE TYPE PerformerType_objtyp AS OBJECT (
PerformerTypeId NUMBER,
TypeName VARCHAR2(50)
);
/

CREATE TABLE PerformerType_objtab OF PerformerType_objtyp (PerformerTypeId PRIMARY KEY) 
   OBJECT IDENTIFIER IS PRIMARY KEY;
   
--   drop table "SYS"."PERFORMERTYPE_OBJTAB";

--Performer
CREATE TYPE Performer_objtyp AS OBJECT (
PerformerId NUMBER,
Name VARCHAR2(100),
PerformerType_ref REF PerformerType_objtyp,
RegisteredDate DATE,
Address VARCHAR2(200)
);
/

CREATE TABLE Performer_objtab OF Performer_objtyp (
PRIMARY KEY(PerformerId),
FOREIGN KEY (PerformerType_ref) REFERENCES PerformerType_objtab
)OBJECT IDENTIFIER IS PRIMARY KEY;

--Event Performer
CREATE TYPE EventPerformer_objtyp AS OBJECT (
EventPerformerId NUMBER,
Event_ref REF Event_objtyp,
Performer_ref REF Performer_objtyp
);
/

--Event performers nested table 
CREATE TYPE EventPerformerList_ntabtyp AS TABLE OF EventPerformer_objtyp

--Event 
CREATE OR REPLACE TYPE Event_objtyp AS OBJECT(
EventId NUMBER,
EventName  VARCHAR2(100),
Venue_ref REF Venue_objtyp,
EventType_ref REF EventType_objtyp,
EventPerformerList_ntab EventPerformerList_ntabtyp,
StartTime DATE,
EndTime DATE,
AgeLimit VARCHAR(15),
Price DECIMAL
);
/

CREATE TABLE Event_objtab OF Event_objtyp (EventId PRIMARY KEY,
FOREIGN KEY (Venue_ref) REFERENCES Venue_objtab,
FOREIGN KEY (EventType_ref) REFERENCES EventType_objtab) 
   OBJECT IDENTIFIER IS PRIMARY KEY
   NESTED TABLE EventPerformerList_ntab STORE AS EventPerformer_ntab ( 
     (PRIMARY KEY(NESTED_TABLE_ID, EventPerformerId))           
     ORGANIZATION INDEX COMPRESS)           
   RETURN AS LOCATOR     
   
   
--Table of event performer
CREATE TABLE EventPerformer_objtab OF EventPerformer_objtyp (
PRIMARY KEY(EventPerformerId),
FOREIGN KEY (Event_ref) REFERENCES Event_objtab,
FOREIGN KEY (Performer_ref) REFERENCES Performer_objtab
)OBJECT IDENTIFIER IS PRIMARY KEY;


-- Booking as incomplete object
CREATE TYPE  Booking_objtyp;


--Booking Event
CREATE TYPE BookingEvent_objtyp AS OBJECT(
BookingEventId NUMBER,
Booking_ref REF Booking_objtyp,
Event_ref REF Event_objtyp,
NoOfTickets NUMBER
);
/

--currently here
--Booking event nested table
CREATE TYPE  BookingEventList_ntabtyp AS TABLE OF BookingEvent_objtyp;
/


--REPLACE Booking with fields
CREATE OR REPLACE TYPE  Booking_objtyp AS OBJECT (
BookingId NUMBER,
Customer_ref REF Customer_objtyp,
BookingDate DATE,
BookingEvent_ntab BookingEventList_ntabtyp,
CreatedDate DATE,

MEMBER FUNCTION GetTotalBookingCost RETURN NUMBER
);
/


--Replace booking with memeber function to get total cost of the booking
CREATE OR REPLACE TYPE BODY Booking_objtyp AS
MEMBER FUNCTION GetTotalBookingCost RETURN NUMBER is  
      i             INTEGER;  
      Event      Event_objtyp;  
      Total         NUMBER := 0;  
   
   BEGIN  
      FOR i in 1..SELF.BookingEvent_ntab.COUNT LOOP  
         UTL_REF.SELECT_OBJECT(BookingEvent_ntab(i).Event_ref,Event);  
         Total := Total + SELF.BookingEvent_ntab(i).NoOfTickets * Event.Price;  
      END LOOP;  
      RETURN Total;
   END;
END;
/


-- Create table of booking
CREATE TABLE Booking_objtab OF Booking_objtyp (
PRIMARY KEY(BookingId),
FOREIGN KEY (Customer_ref) REFERENCES Customer_objtab)
OBJECT IDENTIFIER IS PRIMARY KEY
NESTED TABLE BookingEvent_ntab STORE AS BookingItems_ntab ( 
         (PRIMARY KEY(NESTED_TABLE_ID, BookingEventId))           
         ORGANIZATION INDEX COMPRESS)           
       RETURN AS LOCATOR


--Create table of booking event
CREATE TABLE BookingEvent_objtab OF BookingEvent_objtyp (
PRIMARY KEY(BookingEventId),
FOREIGN KEY (Booking_ref) REFERENCES Booking_objtab,
FOREIGN KEY (Event_ref) REFERENCES Event_objtab)
    OBJECT IDENTIFIER IS PRIMARY KEY;
    

--Employee
CREATE TYPE Employee_objtyp AS OBJECT(
EmployeeId NUMBER,
FirstName VARCHAR2(100),
LastName VARCHAR2(100),
Venue_ref REF Venue_objtyp,
DOB DATE
);
/

CREATE TABLE Employee_objtab OF Employee_objtyp(
PRIMARY KEY(EmployeeId),
FOREIGN KEY (Venue_ref) REFERENCES Venue_objtab
)
OBJECT IDENTIFIER IS PRIMARY KEY;

--Performer Payment
CREATE TYPE PerformerPayment_objtyp AS OBJECT (
PerformerPaymentId NUMBER,
EventPerformer_ref REF EventPerformer_objtyp,
Amount DECIMAL,
PaymentDate DATE
);
/



CREATE TABLE PerformerPayment_objtab OF PerformerPayment_objtyp(
PRIMARY KEY(PerformerPaymentId),
FOREIGN KEY (EventPerformer_ref) REFERENCES EventPerformer_objtab
)
OBJECT IDENTIFIER IS PRIMARY KEY;



--Satff Assignment
CREATE TYPE StaffAssignment_objtyp AS OBJECT (
AssignementId NUMBER,
Employee_ref REF Employee_objtyp,
BookingEvent_ref REF BookingEvent_objtyp,
EventPerformer_ref REF EventPerformer_objtyp
);
/


CREATE TABLE StaffAssignment_objtab OF StaffAssignment_objtyp(
PRIMARY KEY(AssignementId),
FOREIGN KEY (Employee_ref) REFERENCES Employee_objtab,
FOREIGN KEY (BookingEvent_ref) REFERENCES BookingEvent_objtab,
FOREIGN KEY (EventPerformer_ref) REFERENCES EventPerformer_objtab
)
OBJECT IDENTIFIER IS PRIMARY KEY;



--Membership payment status
CREATE TYPE MembershipPaymentStatus_objtyp AS OBJECT (
StatusId NUMBER,
StatusName VARCHAR2(20)
);
/

CREATE TABLE MembershipPaymentStatus_objtab OF MembershipPaymentStatus_objtyp(
PRIMARY KEY(StatusId)
)
OBJECT IDENTIFIER IS PRIMARY KEY;

--Membership type
CREATE TYPE MembershipType_objtyp AS OBJECT (
MembershipTypeId NUMBER,
TypeName VARCHAR2(20),
DurationType VARCHAR2(20),
Active SMALLINT
);
/

CREATE TABLE MembershipType_objtab OF MembershipType_objtyp(
PRIMARY KEY(MembershipTypeId)
)
OBJECT IDENTIFIER IS PRIMARY KEY;



--Membership
CREATE TYPE Membership_objtyp AS OBJECT (
MemberShipId NUMBER,
MemberShipType_ref REF MembershipType_objtyp,
StartDate DATE,
Fee DECIMAL,
Discount DECIMAL,
Active SMALLINT
);
/

CREATE TABLE Membership_objtab OF Membership_objtyp(
PRIMARY KEY(MemberShipId),
FOREIGN KEY (MemberShipType_ref) REFERENCES MembershipType_objtab
)
OBJECT IDENTIFIER IS PRIMARY KEY;




--CustomerMembership
CREATE TYPE CustomerMembership_objtyp AS OBJECT (
Id NUMBER,
Customer_ref REF Customer_objtyp,
MemberShip_ref REF Membership_objtyp,
PaymentStatus_ref REF MembershipPaymentStatus_objtyp,
StartDate DATE,
EndDate DATE,
Active SMALLINT
);
/

CREATE TABLE CustomerMembership_objtab OF CustomerMembership_objtyp(
PRIMARY KEY(Id),
FOREIGN KEY (Customer_ref) REFERENCES Customer_objtab,
FOREIGN KEY (MemberShip_ref) REFERENCES Membership_objtab,
FOREIGN KEY (PaymentStatus_ref) REFERENCES MembershipPaymentStatus_objtab
)
OBJECT IDENTIFIER IS PRIMARY KEY;
