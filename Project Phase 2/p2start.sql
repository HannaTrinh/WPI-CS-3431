drop table PhoneExtensions;
drop table CSStaffTitles;
drop table CSStaff;
drop table Titles;

drop table PathEdges;
drop table Paths;
drop table Edges;
drop table Offices;
drop table Locations;

-- Create all of the tables with constraints
create table Locations (
	locationID varchar2(10),
	locationName varchar2(25),
	locationType varchar2(15),
	xcoord number(4),
	ycoord number(4),
	mapFloor char(1),
	Constraint Locations_PK Primary Key (locationID),
	Constraint Locations_locationTypeVal check (locationType in 
	   ('Office', 'Conference Room', 'Lecture Hall', 'Lab', 'Elevator', 'Staircase', 'Hallway', 'Entrance')),
	Constraint Locations_xcoordVal check (xcoord >= 0 and xcoord <= 1100),
	Constraint Locations_ycoordVal check (ycoord >= 0 and ycoord <= 1100),
	Constraint Locations_mapFloorVal check (mapFloor in
		('1', '2', '3', 'A', 'B'))
);

create table Offices (
	officeID varchar2(10),
	Constraint Offices_PK Primary Key (officeID),
	Constraint Offices_FK Foreign Key (officeID)
		References Locations (locationID)
);

create table Edges (
	edgeID varchar2(15),
	startingLocationID varchar2(10),
	endingLocationID varchar2(10),
	Constraint Edges_PK Primary Key (edgeID),
	Constraint Edges_FK1 Foreign Key (startingLocationID)
		References Locations (locationID),
	Constraint Edges_FK2 Foreign Key (endingLocationID)
		References Locations (locationID)
);

create table Paths (
	pathID varchar2(15),
	beginID varchar2(10),
	finishID varchar2(10),
	Constraint Paths_PK Primary Key (pathID),
	Constraint Paths_FK1 Foreign Key (beginID)
		References Locations (locationID),
	Constraint Paths_FK2 Foreign Key (finishID)
		References Locations (locationID)
);

create table PathEdges (
	pathID varchar2(15),
	edgeID varchar2(20),
	sequenceNumber number(3),
	Constraint PathEdges_PK Primary Key (pathID, edgeID, sequenceNumber),
	Constraint PathEdges_FK1 Foreign Key (pathID)
		References Paths (pathID),
	Constraint PathEdges_FK2 Foreign Key (edgeID)
		References Edges (edgeID)
);

create table CSStaff (
	accountName varchar2(15),
	firstName varchar2(15),
	lastName varchar2(20),
	officeID varchar2(10),
	Constraint CSStaff_PK Primary Key (accountName),
	Constraint CSStaff_FK Foreign Key (officeID)
		References Offices (officeID),
	Constraint CSStaff_firstNameVal check (firstName is not null),
	Constraint CSStaff_lastNameVal check (lastName is not null)
);

create table PhoneExtensions (
	accountName varchar2(15),
	phoneExt number(4),
	Constraint PhoneExtensions_PK Primary Key (accountName, phoneExt),
	Constraint PhoneExtensions_FK Foreign Key (accountName)
		References CSStaff (accountName)
);

create table Titles (
	acronym varchar2(20),
	titleName varchar2(50),
	Constraint Titles_PK Primary Key (acronym),
	Constraint Titles_UQ Unique (titleName)
);

create table CSStaffTitles (
	accountName varchar2(15),
	acronym varchar2(20),
	Constraint CSStaffTitles_PK Primary Key (accountName, acronym),
	Constraint CSStaffTitles_FK1 Foreign Key (accountName)
		References CSStaff (accountName),
	Constraint CSStaffTitles_FK2 Foreign Key (acronym)
		References Titles (acronym)
);


-- This file populates all of the tables

-- Populate Locations table
INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('129', 'FL129', 'Office', null, null, '1');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('130', 'FL130', 'Office', null, null, '1');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('132', 'FL132', 'Office', null, null, '1');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('133', 'FL133', 'Office', null, null, '1');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('135', 'FL135', 'Office', null, null, '1');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('137', 'FL137', 'Office', null, null, '1');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('138', 'FL138', 'Office', null, null, '1');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('139', 'FL139', 'Office', null, null, '1');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('144', 'FL144', 'Office', null, null, '1');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('222', 'IMGD Lab', 'Lab', 935.0, 930.0, '2');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('231', 'FL231', 'Office', 700.0, 170.0, '2');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('232', 'FL232', 'Office', 675.0, 170.0, '2');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('233', 'FL233', 'Office', 520.0, 170.0, '2');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('234', 'FL234', 'Office', 330.0, 170.0, '2');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('235', 'FL235', 'Office', 275.0, 235.0, '2');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('236', 'FL236', 'Office', 275.0, 295.0, '2');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('237', 'FL237', 'Office', 275.0, 355.0, '2');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('243', 'FL243', 'Office', 540.0, 230.0, '2');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('244', 'FL244', 'Office', 620.0, 230.0, '2');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('245', 'FL245', 'Office', 700.0, 230.0, '2');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('2E1', 'FL2E1', 'Elevator', 870.0, 420.0, '2');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('2H1', 'FL2H1', 'Hallway', 835.0, 200.0, '2');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('2H2', 'FL2H2', 'Hallway', 835.0, 355.0, '2');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('2H3', 'FL2H3', 'Hallway', 835.0, 420.0, '2');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('2H4', 'FL2H4', 'Hallway', 835.0, 930.0, '2');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('2H5', 'FL2H5', 'Hallway', 865.0, 930.0, '2');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('2H6', 'FL2H6', 'Hallway', 700.0, 200.0, '2');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('2H7', 'FL2H7', 'Hallway', 675.0, 200.0, '2');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('2H8', 'FL2H8', 'Hallway', 620.0, 200.0, '2');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('2H9', 'FL2H9', 'Hallway', 540.0, 200.0, '2');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('2H10', 'FL2H10', 'Hallway', 520.0, 200.0, '2');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('2H11', 'FL2H11', 'Hallway', 330.0, 200.0, '2');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('2H12', 'FL2H12', 'Hallway', 310.0, 235.0, '2');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('2H13', 'FL2H13', 'Hallway', 310.0, 295.0, '2');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('2H14', 'FL2H14', 'Hallway', 310.0, 355.0, '2');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('2H15', 'FL2H15', 'Hallway', 310.0, 200.0, '2');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('2N1', 'FL2N1', 'Entrance', 835.0, 1075.0, '2');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('2S1', 'FL2S1', 'Staircase', 865.0, 355.0, '2');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('2S2', 'FL2S2', 'Staircase', 865.0, 960.0, '2');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('300', 'Beckett', 'Conference Room', null, null, '3');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('307', 'FL307', 'Office', 900.0, 440.0, '3');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('308', 'FL308', 'Office', 900.0, 335.0, '3');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('311', 'FL311', 'Conference Room', 900.0, 375.0, '3');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('312', 'FL312', 'Office', 945.0, 510.0, '3');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('314', 'FL314', 'Office', 845.0, 660.0, '3');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('316', 'FL316', 'Office', 845.0, 760.0, '3');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('317', 'FL317', 'Office', 925.0, 670.0, '3');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('318', 'FL318', 'Office', 950.0, 700.0, '3');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('319', 'FL319', 'Office', 925.0, 735.0, '3');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('320', 'FL320', 'Lecture Hall', 900.0, 920.0, '3');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('3E1', '3rd Floor Elevator', 'Elevator', 820.0, 415.0, '3');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('3H1', 'FL3H1', 'Hallway', 790.0, 150.0, '3');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('3H2', 'FL3H2', 'Hallway', 790.0, 340.0, '3');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('3H3', 'FL3H3', 'Hallway', 790.0, 375.0, '3');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('3H4', 'FL3H4', 'Hallway', 790.0, 420.0, '3');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('3H5', 'FL3H5', 'Hallway', 790.0, 465.0, '3');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('3H6', 'FL3H6', 'Hallway', 900.0, 465.0, '3');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('3H7', 'FL3H7', 'Hallway', 900.0, 510.0, '3');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('3H8', 'FL3H8', 'Hallway', 790.0, 660.0, '3');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('3H9', 'FL3H9', 'Hallway', 790.0, 700.0, '3');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('3H10', 'FL3H10', 'Hallway', 925.0, 700.0, '3');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('3H11', 'FL3H11', 'Hallway', 790.0, 755.0, '3');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('3H12', 'FL3H12', 'Hallway', 790.0, 925.0, '3');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('3H13', 'FL3H13', 'Hallway', 840.0, 920.0, '3');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('3S1', '3rd Floor Staircase 1', 'Staircase', 835.0, 340.0, '3');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('3S2', '3rd Floor Staircase 2', 'Staircase', 840.0, 965.0, '3');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('A21', 'Zoo Lab', 'Lab', null, null, 'A');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('B19', 'FLB19', 'Office', null, null, 'B');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('B20', 'FLB20', 'Office', null, null, 'B');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('B24', 'FLB24', 'Office', null, null, 'B');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('B25a', 'FLB25a', 'Office', null, null, 'B');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('B25b', 'FLB25b', 'Office', null, null, 'B');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('PHUPR', 'Upper Perrault Hall', 'Lecture Hall', null, null, '2');

INSERT INTO Locations (LOCATIONID, LOCATIONNAME, LOCATIONTYPE, XCOORD, YCOORD, MAPFLOOR) 
VALUES ('PHLWR', 'Lower Perrault Hall', 'Lecture Hall', null, null, 'B');

select * from Locations; 

-- Populate Offices table
INSERT INTO Offices (OFFICEID) 
VALUES ('129');

INSERT INTO Offices (OFFICEID) 
VALUES ('130');

INSERT INTO Offices (OFFICEID) 
VALUES ('132');

INSERT INTO Offices (OFFICEID) 
VALUES ('133');

INSERT INTO Offices (OFFICEID) 
VALUES ('135');

INSERT INTO Offices (OFFICEID) 
VALUES ('137');

INSERT INTO Offices (OFFICEID) 
VALUES ('138');

INSERT INTO Offices (OFFICEID) 
VALUES ('139');

INSERT INTO Offices (OFFICEID) 
VALUES ('144');

INSERT INTO Offices (OFFICEID) 
VALUES ('231');

INSERT INTO Offices (OFFICEID) 
VALUES ('232');

INSERT INTO Offices (OFFICEID) 
VALUES ('233');

INSERT INTO Offices (OFFICEID) 
VALUES ('234');

INSERT INTO Offices (OFFICEID) 
VALUES ('235');

INSERT INTO Offices (OFFICEID) 
VALUES ('236');

INSERT INTO Offices (OFFICEID) 
VALUES ('237');

INSERT INTO Offices (OFFICEID) 
VALUES ('243');

INSERT INTO Offices (OFFICEID) 
VALUES ('244');

INSERT INTO Offices (OFFICEID) 
VALUES ('245');

INSERT INTO Offices (OFFICEID) 
VALUES ('307');

INSERT INTO Offices (OFFICEID) 
VALUES ('308');

INSERT INTO Offices (OFFICEID) 
VALUES ('312');

INSERT INTO Offices (OFFICEID) 
VALUES ('314');

INSERT INTO Offices (OFFICEID) 
VALUES ('316');

INSERT INTO Offices (OFFICEID) 
VALUES ('317');

INSERT INTO Offices (OFFICEID) 
VALUES ('318');

INSERT INTO Offices (OFFICEID) 
VALUES ('319');

INSERT INTO Offices (OFFICEID) 
VALUES ('B19');

INSERT INTO Offices (OFFICEID) 
VALUES ('B20');

INSERT INTO Offices (OFFICEID) 
VALUES ('B24');

INSERT INTO Offices (OFFICEID) 
VALUES ('B25a');

INSERT INTO Offices (OFFICEID) 
VALUES ('B25b');

select * from Offices;

-- Populate Edges table

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H1_2H2', '2H1', '2H2');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H2_2H1', '2H2', '2H1');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H2_2S1', '2H2', '2S1');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2S1_2H2', '2S1', '2H2');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H2_2H3', '2H2', '2H3');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H3_2H2', '2H3', '2H2');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H3_2E1', '2H3', '2E1');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2E1_2H3', '2E1', '2H3');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H3_2H4', '2H3', '2H4');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H4_2H3', '2H4', '2H3');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H4_2H5', '2H4', '2H5');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H5_2H4', '2H5', '2H4');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H4_2N1', '2H4', '2N1');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2N1_2H4', '2N1', '2H4');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H5_2S2', '2H5', '2S2');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2S2_2H5', '2S2', '2H5');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H5_222', '2H5', '222');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('222_2H5', '222', '2H5');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H1_2H6', '2H1', '2H6');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H6_2H1', '2H6', '2H1');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H6_231', '2H6', '231');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('231_2H6', '231', '2H6');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H6_245', '2H6', '245');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('245_2H6', '245', '2H6');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H6_2H7', '2H6', '2H7');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H7_2H6', '2H7', '2H6');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H7_232', '2H7', '232');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('232_2H7', '232', '2H7');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H7_2H8', '2H7', '2H8');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H8_2H7', '2H8', '2H7');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H8_244', '2H8', '244');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('244_2H8', '244', '2H8');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H8_2H9', '2H8', '2H9');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H9_2H8', '2H9', '2H8');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H9_243', '2H9', '243');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('243_2H9', '243', '2H9');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H9_2H10', '2H9', '2H10');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H10_2H9', '2H10', '2H9');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H10_233', '2H10', '233');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('233_2H10', '233', '2H10');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H10_2H11', '2H10', '2H11');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H11_2H10', '2H11', '2H10');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H11_234', '2H11', '234');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('234_2H11', '234', '2H11');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H11_2H15', '2H11', '2H15');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H15_2H11', '2H15', '2H11');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H15_2H12', '2H15', '2H12');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H12_2H15', '2H12', '2H15');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H12_235', '2H12', '235');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('235_2H12', '235', '2H12');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H12_2H13', '2H12', '2H13');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H13_2H12', '2H13', '2H12');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H13_236', '2H13', '236');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('236_2H13', '236', '2H13');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H13_2H14', '2H13', '2H14');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H14_2H13', '2H14', '2H13');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2H14_237', '2H14', '237');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('237_2H14', '237', '2H14');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2E1_3E1', '2E1', '3E1');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3E1_2E1', '3E1', '2E1');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2S1_3S1', '2S1', '3S1');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3S1_2S1', '3S1', '2S1');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('2S2_3S2', '2S2', '3S2');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3S2_2S2', '3S2', '2S2');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3H1_3H2', '3H1', '3H2');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3H2_3H1', '3H2', '3H1');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3H2_3S1', '3H2', '3S1');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3S1_3H2', '3S1', '3H2');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3H2_3H3', '3H2', '3H3');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3H3_3H2', '3H3', '3H2');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3H3_3H4', '3H3', '3H4');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3H4_3H3', '3H4', '3H3');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3H3_311', '3H3', '311');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('311_3H3', '311', '3H3');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('311_308', '311', '308');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('308_311', '308', '311');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3H4_3E1', '3H4', '3E1');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3E1_3H4', '3E1', '3H4');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3H4_3H5', '3H4', '3H5');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3H5_3H4', '3H5', '3H4');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3H5_3H6', '3H5', '3H6');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3H6_3H5', '3H6', '3H5');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3H5_3H8', '3H5', '3H8');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3H8_3H5', '3H8', '3H5');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3H6_307', '3H6', '307');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('307_3H6', '307', '3H6');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3H6_3H7', '3H6', '3H7');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3H7_3H6', '3H7', '3H6');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3H7_312', '3H7', '312');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('312_3H7', '312', '3H7');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3H8_314', '3H8', '314');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('314_3H8', '314', '3H8');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3H8_3H9', '3H8', '3H9');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3H9_3H8', '3H9', '3H8');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3H9_3H11', '3H9', '3H11');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3H11_3H9', '3H11', '3H9');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3H9_3H10', '3H9', '3H10');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3H10_3H9', '3H10', '3H9');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3H10_317', '3H10', '317');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('317_3H10', '317', '3H10');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3H10_318', '3H10', '318');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('318_3H10', '318', '3H10');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3H10_319', '3H10', '319');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('319_3H10', '319', '3H10');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3H11_316', '3H11', '316');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('316_3H11', '316', '3H11');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3H11_3H12', '3H11', '3H12');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3H12_3H11', '3H12', '3H11');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3H12_3H13', '3H12', '3H13');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3H13_3H12', '3H13', '3H12');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3H13_320', '3H13', '320');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('320_3H13', '320', '3H13');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3H13_3S2', '3H13', '3S2');

INSERT INTO Edges (EDGEID, STARTINGLOCATIONID, ENDINGLOCATIONID) 
VALUES ('3S2_3H13', '3S2', '3H13');

select * from Edges;

-- Populate Paths
INSERT INTO Paths (PATHID, BEGINID, FINISHID) 
VALUES ('3S2_316_1', '3S2', '316');

INSERT INTO Paths (PATHID, BEGINID, FINISHID) 
VALUES ('311_319_1', '311', '319');

INSERT INTO Paths (PATHID, BEGINID, FINISHID) 
VALUES ('308_3E1_1', '308', '3E1');

select * from Paths;

-- Populate PathEdges
INSERT INTO PathEdges (PATHID, EDGEID, SEQUENCENUMBER) 
VALUES ('3S2_316_1', '3S2_3H13', 1.0);

INSERT INTO PathEdges (PATHID, EDGEID, SEQUENCENUMBER) 
VALUES ('3S2_316_1', '3H13_3H12', 2.0);

INSERT INTO PathEdges (PATHID, EDGEID, SEQUENCENUMBER) 
VALUES ('3S2_316_1', '3H12_3H11', 3.0);

INSERT INTO PathEdges (PATHID, EDGEID, SEQUENCENUMBER) 
VALUES ('3S2_316_1', '3H11_316', 4.0);

INSERT INTO PathEdges (PATHID, EDGEID, SEQUENCENUMBER) 
VALUES ('311_319_1', '311_3H3', 1.0);

INSERT INTO PathEdges (PATHID, EDGEID, SEQUENCENUMBER) 
VALUES ('311_319_1', '3H3_3H4', 2.0);

INSERT INTO PathEdges (PATHID, EDGEID, SEQUENCENUMBER) 
VALUES ('311_319_1', '3H4_3H5', 3.0);

INSERT INTO PathEdges (PATHID, EDGEID, SEQUENCENUMBER) 
VALUES ('311_319_1', '3H5_3H8', 4.0);

INSERT INTO PathEdges (PATHID, EDGEID, SEQUENCENUMBER) 
VALUES ('311_319_1', '3H8_3H9', 5.0);

INSERT INTO PathEdges (PATHID, EDGEID, SEQUENCENUMBER) 
VALUES ('311_319_1', '3H9_3H10', 6.0);

INSERT INTO PathEdges (PATHID, EDGEID, SEQUENCENUMBER) 
VALUES ('311_319_1', '3H10_319', 7.0);

INSERT INTO PathEdges (PATHID, EDGEID, SEQUENCENUMBER) 
VALUES ('308_3E1_1', '308_311', 1.0);

INSERT INTO PathEdges (PATHID, EDGEID, SEQUENCENUMBER) 
VALUES ('308_3E1_1', '311_3H3', 2.0);

INSERT INTO PathEdges (PATHID, EDGEID, SEQUENCENUMBER) 
VALUES ('308_3E1_1', '3H3_3H4', 3.0);

INSERT INTO PathEdges (PATHID, EDGEID, SEQUENCENUMBER) 
VALUES ('308_3E1_1', '3H4_3E1', 4.0);

select * from PathEdges;

-- Populate CSStaff
INSERT INTO CSStaff (ACCOUNTNAME, FIRSTNAME, LASTNAME, OFFICEID) 
VALUES ('ruiz', 'Carolina', 'Ruiz', '232');

INSERT INTO CSStaff (ACCOUNTNAME, FIRSTNAME, LASTNAME, OFFICEID) 
VALUES ('rich', 'Charles', 'Rich', 'B25b');

INSERT INTO CSStaff (ACCOUNTNAME, FIRSTNAME, LASTNAME, OFFICEID) 
VALUES ('ccaron', 'Christine', 'Caron', '233');

INSERT INTO CSStaff (ACCOUNTNAME, FIRSTNAME, LASTNAME, OFFICEID) 
VALUES ('cshue', 'Craig', 'Shue', '236');

INSERT INTO CSStaff (ACCOUNTNAME, FIRSTNAME, LASTNAME, OFFICEID) 
VALUES ('cew', 'Craig', 'Wills', '234');

INSERT INTO CSStaff (ACCOUNTNAME, FIRSTNAME, LASTNAME, OFFICEID) 
VALUES ('dd', 'Daniel', 'Dougherty', '231');

INSERT INTO CSStaff (ACCOUNTNAME, FIRSTNAME, LASTNAME, OFFICEID) 
VALUES ('deselent', 'Douglas', 'Selent', '144');

INSERT INTO CSStaff (ACCOUNTNAME, FIRSTNAME, LASTNAME, OFFICEID) 
VALUES ('rundenst', 'Elke', 'Rundensteiner', '135');

INSERT INTO CSStaff (ACCOUNTNAME, FIRSTNAME, LASTNAME, OFFICEID) 
VALUES ('emmanuel', 'Emmanuel', 'Agu', '139');

INSERT INTO CSStaff (ACCOUNTNAME, FIRSTNAME, LASTNAME, OFFICEID) 
VALUES ('heineman', 'George', 'Heineman', 'B20');

INSERT INTO CSStaff (ACCOUNTNAME, FIRSTNAME, LASTNAME, OFFICEID) 
VALUES ('ghamel', 'Glynis', 'Hamel', '132');

INSERT INTO CSStaff (ACCOUNTNAME, FIRSTNAME, LASTNAME, OFFICEID) 
VALUES ('lauer', 'Hugh', 'Lauer', '144');

INSERT INTO CSStaff (ACCOUNTNAME, FIRSTNAME, LASTNAME, OFFICEID) 
VALUES ('jleveillee', 'John', 'Leveillee', '244');

INSERT INTO CSStaff (ACCOUNTNAME, FIRSTNAME, LASTNAME, OFFICEID) 
VALUES ('josephbeck', 'Joseph', 'Beck', '138');

INSERT INTO CSStaff (ACCOUNTNAME, FIRSTNAME, LASTNAME, OFFICEID) 
VALUES ('kfisler', 'Kathryn', 'Fisler', '130');

INSERT INTO CSStaff (ACCOUNTNAME, FIRSTNAME, LASTNAME, OFFICEID) 
VALUES ('kven', 'Krishna', 'Venkatasubramanian', '137');

INSERT INTO CSStaff (ACCOUNTNAME, FIRSTNAME, LASTNAME, OFFICEID) 
VALUES ('claypool', 'Mark', 'Claypool', 'B24');

INSERT INTO CSStaff (ACCOUNTNAME, FIRSTNAME, LASTNAME, OFFICEID) 
VALUES ('hofri', 'Micha', 'Hofri', '133');

INSERT INTO CSStaff (ACCOUNTNAME, FIRSTNAME, LASTNAME, OFFICEID) 
VALUES ('ciaraldi', 'Michael', 'Ciaraldi', '129');

INSERT INTO CSStaff (ACCOUNTNAME, FIRSTNAME, LASTNAME, OFFICEID) 
VALUES ('mvoorhis', 'Michael', 'Voorhis', '245');

INSERT INTO CSStaff (ACCOUNTNAME, FIRSTNAME, LASTNAME, OFFICEID) 
VALUES ('meltabakh', 'Mohamed', 'Eltabakh', '235');

INSERT INTO CSStaff (ACCOUNTNAME, FIRSTNAME, LASTNAME, OFFICEID) 
VALUES ('nth', 'Neil', 'Heffernan', '237');

INSERT INTO CSStaff (ACCOUNTNAME, FIRSTNAME, LASTNAME, OFFICEID) 
VALUES ('nkcaligiuri', 'Nicole', 'Caligiuri', '233');

INSERT INTO CSStaff (ACCOUNTNAME, FIRSTNAME, LASTNAME, OFFICEID) 
VALUES ('rcane', 'Refie', 'Cane', '233');

INSERT INTO CSStaff (ACCOUNTNAME, FIRSTNAME, LASTNAME, OFFICEID) 
VALUES ('tgannon', 'Thomas', 'Gannon', '243');

INSERT INTO CSStaff (ACCOUNTNAME, FIRSTNAME, LASTNAME, OFFICEID) 
VALUES ('wwong2', 'Wilson', 'Wong', 'B19');

select * from CSStaff;

--Populate Phone Extensions
INSERT INTO PhoneExtensions (ACCOUNTNAME, PHONEEXT) 
VALUES ('ruiz', 5640.0);

INSERT INTO PhoneExtensions (ACCOUNTNAME, PHONEEXT) 
VALUES ('rich', 5945.0);

INSERT INTO PhoneExtensions (ACCOUNTNAME, PHONEEXT) 
VALUES ('ccaron', 5678.0);

INSERT INTO PhoneExtensions (ACCOUNTNAME, PHONEEXT) 
VALUES ('cshue', 4933.0);

INSERT INTO PhoneExtensions (ACCOUNTNAME, PHONEEXT) 
VALUES ('cew', 5357.0);

INSERT INTO PhoneExtensions (ACCOUNTNAME, PHONEEXT) 
VALUES ('cew', 5622.0);

INSERT INTO PhoneExtensions (ACCOUNTNAME, PHONEEXT) 
VALUES ('dd', 5621.0);

INSERT INTO PhoneExtensions (ACCOUNTNAME, PHONEEXT) 
VALUES ('deselent', 5493.0);

INSERT INTO PhoneExtensions (ACCOUNTNAME, PHONEEXT) 
VALUES ('rundenst', 5815.0);

INSERT INTO PhoneExtensions (ACCOUNTNAME, PHONEEXT) 
VALUES ('emmanuel', 5568.0);

INSERT INTO PhoneExtensions (ACCOUNTNAME, PHONEEXT) 
VALUES ('heineman', 5502.0);

INSERT INTO PhoneExtensions (ACCOUNTNAME, PHONEEXT) 
VALUES ('ghamel', 5252.0);

INSERT INTO PhoneExtensions (ACCOUNTNAME, PHONEEXT) 
VALUES ('lauer', 5493.0);

INSERT INTO PhoneExtensions (ACCOUNTNAME, PHONEEXT) 
VALUES ('jleveillee', 5822.0);

INSERT INTO PhoneExtensions (ACCOUNTNAME, PHONEEXT) 
VALUES ('josephbeck', 6156.0);

INSERT INTO PhoneExtensions (ACCOUNTNAME, PHONEEXT) 
VALUES ('kfisler', 5118.0);

INSERT INTO PhoneExtensions (ACCOUNTNAME, PHONEEXT) 
VALUES ('kven', 6571.0);

INSERT INTO PhoneExtensions (ACCOUNTNAME, PHONEEXT) 
VALUES ('claypool', 5409.0);

INSERT INTO PhoneExtensions (ACCOUNTNAME, PHONEEXT) 
VALUES ('hofri', 6911.0);

INSERT INTO PhoneExtensions (ACCOUNTNAME, PHONEEXT) 
VALUES ('ciaraldi', 5117.0);

INSERT INTO PhoneExtensions (ACCOUNTNAME, PHONEEXT) 
VALUES ('mvoorhis', 5669.0);

INSERT INTO PhoneExtensions (ACCOUNTNAME, PHONEEXT) 
VALUES ('mvoorhis', 5674.0);

INSERT INTO PhoneExtensions (ACCOUNTNAME, PHONEEXT) 
VALUES ('meltabakh', 6421.0);

INSERT INTO PhoneExtensions (ACCOUNTNAME, PHONEEXT) 
VALUES ('nth', 5569.0);

INSERT INTO PhoneExtensions (ACCOUNTNAME, PHONEEXT) 
VALUES ('nkcaligiuri', 5357.0);

INSERT INTO PhoneExtensions (ACCOUNTNAME, PHONEEXT) 
VALUES ('rcane', 5357.0);

INSERT INTO PhoneExtensions (ACCOUNTNAME, PHONEEXT) 
VALUES ('tgannon', 5357.0);

INSERT INTO PhoneExtensions (ACCOUNTNAME, PHONEEXT) 
VALUES ('wwong2', 5706.0);

select * from PhoneExtensions;

-- Populate Titles
INSERT INTO Titles (ACRONYM, TITLENAME) 
VALUES ('Adj Assoc Prof', 'Adjunct Associate Professor');

INSERT INTO Titles (ACRONYM, TITLENAME) 
VALUES ('Admin 5', 'Administrative Assistant V');

INSERT INTO Titles (ACRONYM, TITLENAME) 
VALUES ('Admin 6', 'Administrative Assistant VI');

INSERT INTO Titles (ACRONYM, TITLENAME) 
VALUES ('Asst Prof', 'Assistant Professor');

INSERT INTO Titles (ACRONYM, TITLENAME) 
VALUES ('Asst TProf', 'Assistant Teaching Professor');

INSERT INTO Titles (ACRONYM, TITLENAME) 
VALUES ('Assoc Prof', 'Associate Professor');

INSERT INTO Titles (ACRONYM, TITLENAME) 
VALUES ('C-MGRG', 'Coordinator of Mobile Graphics Research Group');

INSERT INTO Titles (ACRONYM, TITLENAME) 
VALUES ('DeptHead', 'Department Head');

INSERT INTO Titles (ACRONYM, TITLENAME) 
VALUES ('Dir-DS', 'Director of Data Science');

INSERT INTO Titles (ACRONYM, TITLENAME) 
VALUES ('Dir-LST', 'Director of Learn Sciences and Technologies');

INSERT INTO Titles (ACRONYM, TITLENAME) 
VALUES ('GradAdmin', 'Graduate Admin Coordinator');

INSERT INTO Titles (ACRONYM, TITLENAME) 
VALUES ('Lab1', 'Lab Manager I');

INSERT INTO Titles (ACRONYM, TITLENAME) 
VALUES ('Lab2', 'Lab Manager II');

INSERT INTO Titles (ACRONYM, TITLENAME) 
VALUES ('Prof', 'Professor');

INSERT INTO Titles (ACRONYM, TITLENAME) 
VALUES ('SrInst', 'Senior Instructor');

INSERT INTO Titles (ACRONYM, TITLENAME) 
VALUES ('TProf', 'Teaching Professor');

select * from Titles;

-- Populate CSStaffTitles
INSERT INTO CSStaffTitles (ACCOUNTNAME, ACRONYM) 
VALUES ('ruiz', 'Assoc Prof');

INSERT INTO CSStaffTitles (ACCOUNTNAME, ACRONYM) 
VALUES ('rich', 'Prof');

INSERT INTO CSStaffTitles (ACCOUNTNAME, ACRONYM) 
VALUES ('ccaron', 'Admin 6');

INSERT INTO CSStaffTitles (ACCOUNTNAME, ACRONYM) 
VALUES ('cshue', 'Assoc Prof');

INSERT INTO CSStaffTitles (ACCOUNTNAME, ACRONYM) 
VALUES ('cew', 'Prof');

INSERT INTO CSStaffTitles (ACCOUNTNAME, ACRONYM) 
VALUES ('cew', 'DeptHead');

INSERT INTO CSStaffTitles (ACCOUNTNAME, ACRONYM) 
VALUES ('dd', 'Prof');

INSERT INTO CSStaffTitles (ACCOUNTNAME, ACRONYM) 
VALUES ('deselent', 'Asst TProf');

INSERT INTO CSStaffTitles (ACCOUNTNAME, ACRONYM) 
VALUES ('rundenst', 'Prof');

INSERT INTO CSStaffTitles (ACCOUNTNAME, ACRONYM) 
VALUES ('rundenst', 'Dir-DS');

INSERT INTO CSStaffTitles (ACCOUNTNAME, ACRONYM) 
VALUES ('emmanuel', 'Assoc Prof');

INSERT INTO CSStaffTitles (ACCOUNTNAME, ACRONYM) 
VALUES ('emmanuel', 'C-MGRG');

INSERT INTO CSStaffTitles (ACCOUNTNAME, ACRONYM) 
VALUES ('heineman', 'Assoc Prof');

INSERT INTO CSStaffTitles (ACCOUNTNAME, ACRONYM) 
VALUES ('ghamel', 'SrInst');

INSERT INTO CSStaffTitles (ACCOUNTNAME, ACRONYM) 
VALUES ('lauer', 'TProf');

INSERT INTO CSStaffTitles (ACCOUNTNAME, ACRONYM) 
VALUES ('jleveillee', 'Lab1');

INSERT INTO CSStaffTitles (ACCOUNTNAME, ACRONYM) 
VALUES ('josephbeck', 'Assoc Prof');

INSERT INTO CSStaffTitles (ACCOUNTNAME, ACRONYM) 
VALUES ('kfisler', 'Prof');

INSERT INTO CSStaffTitles (ACCOUNTNAME, ACRONYM) 
VALUES ('kven', 'Asst Prof');

INSERT INTO CSStaffTitles (ACCOUNTNAME, ACRONYM) 
VALUES ('claypool', 'Prof');

INSERT INTO CSStaffTitles (ACCOUNTNAME, ACRONYM) 
VALUES ('hofri', 'Prof');

INSERT INTO CSStaffTitles (ACCOUNTNAME, ACRONYM) 
VALUES ('ciaraldi', 'SrInst');

INSERT INTO CSStaffTitles (ACCOUNTNAME, ACRONYM) 
VALUES ('mvoorhis', 'Lab2');

INSERT INTO CSStaffTitles (ACCOUNTNAME, ACRONYM) 
VALUES ('meltabakh', 'Assoc Prof');

INSERT INTO CSStaffTitles (ACCOUNTNAME, ACRONYM) 
VALUES ('nth', 'Prof');

INSERT INTO CSStaffTitles (ACCOUNTNAME, ACRONYM) 
VALUES ('nth', 'Dir-LST');

INSERT INTO CSStaffTitles (ACCOUNTNAME, ACRONYM) 
VALUES ('nkcaligiuri', 'Admin 5');

INSERT INTO CSStaffTitles (ACCOUNTNAME, ACRONYM) 
VALUES ('rcane', 'GradAdmin');

INSERT INTO CSStaffTitles (ACCOUNTNAME, ACRONYM) 
VALUES ('tgannon', 'Adj Assoc Prof');

INSERT INTO CSStaffTitles (ACCOUNTNAME, ACRONYM) 
VALUES ('wwong2', 'Asst TProf');

select * from CSStaffTitles;
