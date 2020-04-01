-----------------------RDBMS---------------------------------------------------------------------
INSERT INTO Customer VALUES(1,'Jake','Gillenhal',TO_DATE('1984-02-09','yyyy/MM/dd'));
INSERT INTO Customer VALUES(2,'Simon','Hoff',TO_DATE('1964-12-09','yyyy/MM/dd'));
INSERT INTO Customer VALUES(3,'Brian','Lara',TO_DATE('1992-06-09','yyyy/MM/dd'));
INSERT INTO Customer VALUES(4,'Natasha','Gabriel',TO_DATE('1988-03-09','yyyy/MM/dd'));

INSERT INTO Venue VALUES (1,'Bristol','1st Street,Bristol,UK','06596565655');
INSERT INTO Venue VALUES (2,'London','2nd Street,London,UK','06412386565');

INSERT INTO EventType VALUES (1,'Theatre Play');
INSERT INTO EventType VALUES (2,'Concert');
INSERT INTO EventType VALUES (3,'Meal');

INSERT INTO Event VALUES 
(1,'Kids concert',1,2,TO_DATE('2015/05/10 08:30:00', 'yyyy/mm/dd hh24:mi:ss'),TO_DATE('2015/05/10 12:30:00', 'yyyy/mm/dd hh24:mi:ss'),'15<',1500.00,200);

INSERT INTO Event VALUES 
(2,'Beethoven concert',1,2,TO_DATE('2015/05/12 08:30:00', 'yyyy/mm/dd hh24:mi:ss'),TO_DATE('2015/05/12 12:30:00', 'yyyy/mm/dd hh24:mi:ss'),'18<',5000.00,200);

INSERT INTO Event VALUES 
(3,'Meal With Beethoven',1,3,TO_DATE('2015/05/12 13:00:00', 'yyyy/mm/dd hh24:mi:ss'),TO_DATE('2015/05/12 15:30:00', 'yyyy/mm/dd hh24:mi:ss'),'12<',1500.00,200);

INSERT INTO Event VALUES 
(4,'A Night With Stars',2,2,TO_DATE('2015/05/11 17:30:00', 'yyyy/mm/dd hh24:mi:ss'),TO_DATE('2015/05/11 20:30:00', 'yyyy/mm/dd hh24:mi:ss'),'18<',3000.00,200);

INSERT INTO Event VALUES 
(5,'A Meal With Stars',2,3,TO_DATE('2015/05/11 21:00:00', 'yyyy/mm/dd hh24:mi:ss'),TO_DATE('2015/05/11 23:30:00', 'yyyy/mm/dd hh24:mi:ss'),'18<',2000.00,200);

INSERT INTO Event VALUES 
(6,'A Hamilton Sttory',2,1,TO_DATE('2015/05/15 08:00:00', 'yyyy/mm/dd hh24:mi:ss'),TO_DATE('2015/05/15 12:30:00', 'yyyy/mm/dd hh24:mi:ss'),'18<',1500.00,200);


INSERT INTO Booking VALUES (1,1,TO_DATE('2015-05-11','yyyy/MM/dd'),TO_DATE('2015-05-01','yyyy/MM/dd'));
INSERT INTO Booking VALUES (2,2,TO_DATE('2015-05-12','yyyy/MM/dd'),TO_DATE('2015-05-01','yyyy/MM/dd'));


INSERT INTO BookingEvent VALUES (1,1,4,5);
INSERT INTO BookingEvent VALUES (2,1,5,5);

INSERT INTO BookingEvent VALUES (3,2,2,6);
INSERT INTO BookingEvent VALUES (4,2,3,6);

INSERT INTO Employee VALUES ( 1,'Sineth','Fernando',1,TO_DATE('1991-05-11','yyyy/MM/dd'));
INSERT INTO Employee VALUES ( 2,'Saman','Perera',1,TO_DATE('1964-05-11','yyyy/MM/dd'));
INSERT INTO Employee VALUES ( 3,'Sameera','Kulathunge',2,TO_DATE('1995-05-11','yyyy/MM/dd'));
INSERT INTO Employee VALUES ( 4,'Hasitha','Jayasinghe',2,TO_DATE('1975-05-11','yyyy/MM/dd'));

INSERT INTO PerformerType VALUES (1,'Cast Member');
INSERT INTO PerformerType VALUES (2,'Band');

INSERT INTO Performer VALUES(1,'Calvin',1,TO_DATE('2010-05-11','yyyy/MM/dd'),'1st street London');
INSERT INTO Performer VALUES(2,'Rock On',2,TO_DATE('2012-05-11','yyyy/MM/dd'),'2nd street Bristol');
INSERT INTO Performer VALUES(3,'Gillian',1,TO_DATE('2011-05-11','yyyy/MM/dd'),'23B street London');
INSERT INTO Performer VALUES(4,'Stars',2,TO_DATE('2018-05-11','yyyy/MM/dd'),'B43 street Bristol');

INSERT INTO EventPerformer VALUES (1,1,2);
INSERT INTO EventPerformer VALUES (2,2,2);
INSERT INTO EventPerformer VALUES (3,4,3);
INSERT INTO EventPerformer VALUES (4,5,3);
INSERT INTO EventPerformer VALUES (5,6,1);
INSERT INTO EventPerformer VALUES (6,6,2);

INSERT INTO PerformerPayment VALUES (1,1,20000,TO_DATE('2010-05-11','yyyy/MM/dd'));
INSERT INTO PerformerPayment VALUES (2,2,1500,TO_DATE('2010-05-11','yyyy/MM/dd'));
INSERT INTO PerformerPayment VALUES (3,3,24000,TO_DATE('2010-05-11','yyyy/MM/dd'));
INSERT INTO PerformerPayment VALUES (4,4,2400,TO_DATE('2010-05-11','yyyy/MM/dd'));
INSERT INTO PerformerPayment VALUES (5,5,1200,TO_DATE('2010-05-11','yyyy/MM/dd'));
INSERT INTO PerformerPayment VALUES (6,6,1500,TO_DATE('2010-05-11','yyyy/MM/dd'));

INSERT INTO StaffAssignment VALUES (1,1,NULL,1);
INSERT INTO StaffAssignment VALUES (2,2,1,NULL);
INSERT INTO StaffAssignment VALUES (3,2,2,NULL);

INSERT INTO MembershipPaymentStatus VALUES (1,'Paid');
INSERT INTO MembershipPaymentStatus VALUES (2,'Pending');
INSERT INTO MembershipPaymentStatus VALUES (3,'Suspended');

INSERT INTO MembershipType VALUES(1,'VIP','Annual',1);
INSERT INTO MembershipType VALUES(2,'Premium','Annual',1);
INSERT INTO MembershipType VALUES(3,'Silver','Monthly',1);


INSERT INTO Membership VALUES(1,1,TO_DATE('2018-01-01','yyyy/MM/dd'),5000,1);
INSERT INTO Membership VALUES(2,2,TO_DATE('2018-01-01','yyyy/MM/dd'),2000,1);
INSERT INTO Membership VALUES(3,3,TO_DATE('2018-01-01','yyyy/MM/dd'),1500,1);

INSERT INTO CustomerMembership VALUES (1,1,1,2,TO_DATE('2018-01-05','yyyy/MM/dd'),TO_DATE('2019-01-05','yyyy/MM/dd'),1);
INSERT INTO CustomerMembership VALUES (2,2,2,1,TO_DATE('2018-02-05','yyyy/MM/dd'),TO_DATE('2019-02-05','yyyy/MM/dd'),1);
INSERT INTO CustomerMembership VALUES (3,3,3,1,TO_DATE('2018-04-05','yyyy/MM/dd'),TO_DATE('2019-05-05','yyyy/MM/dd'),1);




------------------------ORDBMS-------------------------------------------------------------------
INSERT INTO Customer_objtab VALUES(1,'Jake','Gillenhal',TO_DATE('1984-02-09','yyyy/MM/dd'));
INSERT INTO Customer_objtab VALUES(2,'Simon','Hoff',TO_DATE('1964-12-09','yyyy/MM/dd'));
INSERT INTO Customer_objtab VALUES(3,'Brian','Lara',TO_DATE('1992-06-09','yyyy/MM/dd'));
INSERT INTO Customer_objtab VALUES(4,'Natasha','Gabriel',TO_DATE('1988-03-09','yyyy/MM/dd'));

INSERT INTO Venue_objtab VALUES (1,'Bristol','1st Street,Bristol,UK','06595655');
INSERT INTO Venue_objtab VALUES (2,'London','2nd Street,London,UK','0641265');

INSERT INTO EventType_objtab VALUES (1,'Theatre Play');
INSERT INTO EventType_objtab VALUES (2,'Concert');
INSERT INTO EventType_objtab VALUES (3,'Meal');

INSERT INTO PerformerType_objtab VALUES (1,'Cast Member');
INSERT INTO PerformerType_objtab VALUES (2,'Band');


INSERT INTO Event_objtab VALUES 
(1,'Kids concert',1,2,TO_DATE('2015/05/10 08:30:00', 'yyyy/mm/dd hh24:mi:ss'),TO_DATE('2015/05/10 12:30:00', 'yyyy/mm/dd hh24:mi:ss'),'15<',1500.00,200);

INSERT INTO Event_objtab VALUES 
(2,'Beethoven concert',1,2,TO_DATE('2015/05/12 08:30:00', 'yyyy/mm/dd hh24:mi:ss'),TO_DATE('2015/05/12 12:30:00', 'yyyy/mm/dd hh24:mi:ss'),'18<',5000.00,200);

INSERT INTO Event_objtab VALUES 
(3,'Meal With Beethoven',1,3,TO_DATE('2015/05/12 13:00:00', 'yyyy/mm/dd hh24:mi:ss'),TO_DATE('2015/05/12 15:30:00', 'yyyy/mm/dd hh24:mi:ss'),'12<',1500.00,200);

INSERT INTO Event_objtab VALUES 
(4,'A Night With Stars',2,2,TO_DATE('2015/05/11 17:30:00', 'yyyy/mm/dd hh24:mi:ss'),TO_DATE('2015/05/11 20:30:00', 'yyyy/mm/dd hh24:mi:ss'),'18<',3000.00,200);

INSERT INTO Event_objtab VALUES 
(5,'A Meal With Stars',2,3,TO_DATE('2015/05/11 21:00:00', 'yyyy/mm/dd hh24:mi:ss'),TO_DATE('2015/05/11 23:30:00', 'yyyy/mm/dd hh24:mi:ss'),'18<',2000.00,200);

INSERT INTO Event_objtab VALUES 
(6,'A Hamilton Sttory',2,1,TO_DATE('2015/05/15 08:00:00', 'yyyy/mm/dd hh24:mi:ss'),TO_DATE('2015/05/15 12:30:00', 'yyyy/mm/dd hh24:mi:ss'),'18<',1500.00,200);

