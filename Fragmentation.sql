--Create original DB Table for Employee(All Employees)
--original table
CREATE TABLE Spaceformance_Staff(
EmployeeId NUMBER NOT NULL PRIMARY KEY,
FirstName VARCHAR2(100) NOT NULL,
LastName VARCHAR2(100) NOT NULL,
Venue VARCHAR2(100) NOT NULL,
DOB DATE NULL
);

INSERT INTO Spaceformance_Staff VALUES (1,'Gillian','Hasselhof','Bristol',TO_DATE('1984-02-09','yyyy/MM/dd'));
INSERT INTO Spaceformance_Staff VALUES (2,'Chris','Prat','Bristol',TO_DATE('1991-02-03','yyyy/MM/dd'));
INSERT INTO Spaceformance_Staff VALUES (3,'Jacob','Marin','Bristol',TO_DATE('1980-02-23','yyyy/MM/dd'));
INSERT INTO Spaceformance_Staff VALUES (4,'Jack','Martin','London',TO_DATE('1986-02-14','yyyy/MM/dd'));
INSERT INTO Spaceformance_Staff VALUES (5,'Daniel','Peterson','London',TO_DATE('1993-10-09','yyyy/MM/dd'));
INSERT INTO Spaceformance_Staff VALUES (6,'Anna','Hank','London',TO_DATE('1987-11-09','yyyy/MM/dd'));

--DB Links to connect from local to remote
--creating a link to remote London db
create database link "London_remote" connect to "ADMIN" identified by "sin123jkit123"
using 'spaceformance-remote-rds.cfxsf7ku6b3t.ap-southeast-1.rds.amazonaws.com/myRds';

--creating a link to remote Bristol db
create database link "Bristol_remote" connect to "ADMIN" identified by "sin123jkit123"
using 'spaceformance-remote-rds1.cfxsf7ku6b3t.ap-southeast-1.rds.amazonaws.com/myRds1';

---------------------------------------------------------------------------------------------------------------------------------------------------------------
--Should be executed in remote databases
--Horizontal Fragmentation
CREATE TABLE London_Staff (
EmployeeId NUMBER NOT NULL PRIMARY KEY,
FirstName VARCHAR2(100) NOT NULL,
LastName VARCHAR2(100) NOT NULL,
Venue VARCHAR2(100) NOT NULL,
DOB DATE NULL
);

INSERT INTO London_Staff VALUES (4,'Jack','Martin','London',TO_DATE('1986-02-14','yyyy/MM/dd'));
INSERT INTO London_Staff VALUES (5,'Daniel','Peterson','London',TO_DATE('1993-10-09','yyyy/MM/dd'));
INSERT INTO London_Staff VALUES (6,'Anna','Hank','London',TO_DATE('1987-11-09','yyyy/MM/dd'));
--Create Synonym 
CREATE SYNONYM Spaceformance_Staff FOR London_Staff;


CREATE TABLE Bristol_Staff (
EmployeeId NUMBER NOT NULL PRIMARY KEY,
FirstName VARCHAR2(100) NOT NULL,
LastName VARCHAR2(100) NOT NULL,
Venue VARCHAR2(100) NOT NULL,
DOB DATE NULL
);

INSERT INTO Bristol_Staff VALUES (1,'Gillian','Hasselhof','Bristol',TO_DATE('1984-02-09','yyyy/MM/dd'));
INSERT INTO Bristol_Staff VALUES (2,'Chris','Prat','Bristol',TO_DATE('1991-02-03','yyyy/MM/dd'));
INSERT INTO Bristol_Staff VALUES (3,'Jacob','Marin','Bristol',TO_DATE('1980-02-23','yyyy/MM/dd'));
--Create Synonym 
CREATE SYNONYM Spaceformance_Staff FOR Bristol_Staff;

--grant permission on both tables
grant SELECT ON Bristol_Staff to PUBLIC;
grant SELECT ON London_Staff to PUBLIC;

--create view to reconstruct horizontal fragmented data
CREATE VIEW GetSpaceformanceGlobalStaff AS 
--Union two tables Horizontal reconstruction
(select * from "ADMIN".Spaceformance_Staff@"Bristol_remote")
UNION
(select * from "ADMIN".Spaceformance_Staff@"London_remote");

--View created for horizontal fragment reconstruction
select * from GetSpaceformanceGlobalStaff;

DROP TABLE London_Staff;
DROP TABLE Bristol_Staff;


----------------------------------------------------------------------------------------------------------------------------------------------------------
--Should be executed in remote databases
--Vertical Fragmentation
CREATE TABLE London_Staff_Vertical (
EmployeeId NUMBER NOT NULL PRIMARY KEY,
FirstName VARCHAR2(100) NOT NULL,
DOB DATE NULL
);
INSERT INTO London_Staff_Vertical VALUES (1,'Gillian',TO_DATE('1984-02-09','yyyy/MM/dd'));
INSERT INTO London_Staff_Vertical VALUES (2,'Chris',TO_DATE('1991-02-03','yyyy/MM/dd'));
INSERT INTO London_Staff_Vertical VALUES (3,'Jacob',TO_DATE('1980-02-23','yyyy/MM/dd'));
INSERT INTO London_Staff_Vertical VALUES (4,'Jack',TO_DATE('1986-02-14','yyyy/MM/dd'));
INSERT INTO London_Staff_Vertical VALUES (5,'Daniel',TO_DATE('1993-10-09','yyyy/MM/dd'));
INSERT INTO London_Staff_Vertical VALUES (6,'Anna',TO_DATE('1987-11-09','yyyy/MM/dd'));

--Synonym for location transparency
CREATE SYNONYM Staff FOR London_Staff_Vertical;

CREATE TABLE Bristol_Staff_Vertical (
EmployeeId NUMBER NOT NULL PRIMARY KEY,
LastName VARCHAR2(100) NOT NULL,
Venue VARCHAR2(100) NOT NULL
); 
INSERT INTO Bristol_Staff_Vertical VALUES (1,'Hasselhof','Bristol');
INSERT INTO Bristol_Staff_Vertical VALUES (2,'Prat','Bristol');
INSERT INTO Bristol_Staff_Vertical VALUES (3,'Marin','Bristol');
INSERT INTO Bristol_Staff_Vertical VALUES (4,'Martin','London');
INSERT INTO Bristol_Staff_Vertical VALUES (5,'Peterson','London');
INSERT INTO Bristol_Staff_Vertical VALUES (6,'Hank','London');

--Synonym for location transparency
CREATE SYNONYM Staff FOR Bristol_Staff_Vertical;

grant SELECT ON Bristol_Staff_Vertical to PUBLIC;
grant SELECT ON London_Staff_Vertical to PUBLIC;


--create view to reconstruct vertical fragmented data
CREATE VIEW GetGlobalStaff_Vertical AS 
--join two tables Vertical reconstruction
select b.EmployeeId ,l.FirstName,b.LastName,b.Venue,l.DOB from "ADMIN".Staff@"Bristol_remote" b
FULL OUTER JOIN "ADMIN".Staff@"London_remote" l ON l.EmployeeId = b.EmployeeId;

--View created for vertical fragment reconstruction
select *from GetGlobalStaff_Vertical;

----------------------------------------------------------------------------------------------------------------------------------------------------------
--Mixed Fragmentation (vertical and horizontal)
--shoudl be executed in LondonRemote DB
--union a two horizontal fragmentations and select few specific columns to create mixed fragmentation
--creating a link to remote Bristol db from london
CREATE DATABASE LINK Bristol_remote_from_london
CONNECT TO "ADMIN" IDENTIFIED BY "sin123jkit123"
USING'(DESCRIPTION =(ADDRESS = (PROTOCOL = TCP)(HOST = spaceformance-remote-rds1.cfxsf7ku6b3t.ap-southeast-1.rds.amazonaws.com)(PORT = 1521))(CONNECT_DATA = (SERVICE_NAME = myRds1)))';

CREATE TABLE London_Staff_Mix AS
SELECT EmployeeId,LastName,DOB FROM (
(select * from "ADMIN".Spaceformance_Staff@"Bristol_remote_from_london")
UNION
(select * from Spaceformance_Staff));

CREATE SYNONYM Company_Staff FOR London_Staff_Mix;
grant SELECT ON London_Staff_Mix to PUBLIC;


--should be executed in Bristol DB
--creating a link to remote Bristol db from london
CREATE DATABASE LINK London_remote_from_bristol
CONNECT TO "ADMIN" IDENTIFIED BY "sin123jkit123"
USING'(DESCRIPTION =(ADDRESS = (PROTOCOL = TCP)(HOST = spaceformance-remote-rds.cfxsf7ku6b3t.ap-southeast-1.rds.amazonaws.com)(PORT = 1521))(CONNECT_DATA = (SERVICE_NAME = myRds)))';

CREATE TABLE Bristol_Staff_Mix AS
SELECT EmployeeId,FirstName,Venue FROM (
(select * from "ADMIN".Spaceformance_Staff@"London_remote_from_bristol")
UNION
(select * from Spaceformance_Staff));

CREATE SYNONYM Company_Staff FOR Bristol_Staff_Mix;
grant SELECT ON Bristol_Staff_Mix to PUBLIC;

CREATE VIEW GetGlobalStaff_Mix AS
select b.EmployeeId ,b.FirstName,l.LastName,b.Venue,l.DOB from "ADMIN".Company_Staff@"Bristol_remote" b
FULL OUTER JOIN "ADMIN".Company_Staff@"London_remote" l ON l.EmployeeId = b.EmployeeId;

-- execute created view to reconstruct from mix fragmentation
select * from GetGlobalStaff_Mix

--increase open db links - in case if got an error saying too many open db links
alter system set open_links=6 scope=spfile;
shutdown immediate;
startup


