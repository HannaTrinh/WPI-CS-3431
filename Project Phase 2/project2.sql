SET serveroutput on;




CREATE OR REPLACE VIEW OfficeLocations AS
SELECT locationID,locationName
FROM Locations
WHERE locationType='Office';

CREATE OR REPLACE VIEW LabTitles AS
SELECT acronym
FROM Titles
WHERE titleName 
LIKE '%Lab Manager%';

CREATE OR REPLACE VIEW LabStaffIDs AS
SELECT accountName
FROM CSStaffTitles 
NATURAL JOIN LabTitles;

CREATE OR REPLACE VIEW NonLabStaffIDs AS
SELECT accountName 
FROM CSStaff 
MINUS 
SELECT * 
FROM LabStaffIDs;

CREATE OR REPLACE VIEW NonLabStaffLocationCounts AS
SELECT officeID,count(*) AS CNT
FROM NonLabStaffIDs 
NATURAL JOIN CSStaff
GROUP BY officeID;

CREATE OR REPLACE VIEW NoLabMgr AS
SELECT locationName, locationID, CNT
FROM NonLabStaffLocationCounts S
JOIN OfficeLocations L ON S.officeID=L.locationID
ORDER BY CNT DESC;

SELECT * FROM NoLabMgr;




CREATE OR REPLACE PROCEDURE NumberOfStaff (office_ID varchar2) IS 
total number;
BEGIN
    SELECT Count(*) INTO total
    FROM CSStaff
    WHERE officeID = NumberOfStaff.office_ID;
    dbms_output.put_line('Total CSStaff members at location '||office_ID||': ' || total);
END;
/

REM Should be 3 Staff 
EXEC NumberOfStaff('233'); 




CREATE OR REPLACE TRIGGER NoSameLocations
BEFORE INSERT ON Edges
FOR EACH ROW
WHEN (new.startingLocationID=new.endingLocationID)
BEGIN
RAISE_APPLICATION_ERROR(-20001,'edge start and end is same');
END;
/

REM Should Error
INSERT INTO Edges VALUES ('error1', '2H1', '2H1');




CREATE OR REPLACE TRIGGER CrossFloorEdge
BEFORE INSERT ON Edges
FOR EACH ROW
DECLARE
startFloor char(1);
endFloor char(1);
startType varchar2(15);
endType varchar2(15);
BEGIN

SELECT mapFloor,locationType INTO startFloor,startType
FROM locations
WHERE locationID=:new.startingLocationID;

SELECT mapFloor,locationType INTO endFloor,endType
FROM locations
WHERE locationID=:new.endingLocationID;

IF startFloor<>endFloor AND NOT (startType IN ('Elevator','Staircase') AND startType=endType) THEN
    RAISE_APPLICATION_ERROR(-20002,'floors doesn''t match');
END IF;
END;
/

REM Should Error
INSERT INTO Edges VALUES ('error2', '2H1', '3H1');

REM Should Error
INSERT INTO Edges VALUES ('error3', '2E1', '3S1');

REM Should Error
INSERT INTO Edges VALUES ('error4', '2S1', '3E1');




CREATE OR REPLACE TRIGGER MustBeOffice
AFTER INSERT ON Offices
DECLARE
    CURSOR c1 IS
    SELECT locationType
    FROM Offices O JOIN Locations L ON O.officeID=L.locationID ;
BEGIN
    FOR loc IN c1 LOOP
        IF loc.locationType <> 'Office' THEN
            RAISE_APPLICATION_ERROR(-20002,'office is in bad location');
        END IF;
    END LOOP;
END;
/

REM Should Error
INSERT INTO Offices VALUES ('3E1');



CREATE OR REPLACE VIEW ProfTitles AS
SELECT acronym
FROM Titles
WHERE titleName
LIKE '%Professor%';

CREATE OR REPLACE VIEW ProfStaffIDs AS
SELECT accountName
FROM CSStaffTitles 
NATURAL JOIN ProfTitles;

CREATE OR REPLACE VIEW ProfStaffTitleCounts AS
SELECT accountName,count(*) as CNT
FROM CSStaffTitles S NATURAL JOIN ProfStaffIDs
GROUP BY accountName;

CREATE OR REPLACE VIEW ProfStaffTitleCountsOverThree AS
SELECT *
FROM ProfStaffTitleCounts
WHERE CNT>3;

CREATE OR REPLACE TRIGGER TitleLimit
AFTER INSERT OR UPDATE ON CSStaffTitles
DECLARE 
is_bad number;
BEGIN
    SELECT count(*) INTO is_bad
    FROM ProfStaffTitleCountsOverThree;

    IF is_bad != 0 THEN
        RAISE_APPLICATION_ERROR(-20004, 'Professor cannot have more than 3 titles');
    END IF;
END;
/

REM will work
INSERT INTO CSStaffTitles VALUES ('wwong2', 'Admin 5');
INSERT INTO CSStaffTitles VALUES ('wwong2', 'Admin 6');

REM will error
INSERT INTO CSStaffTitles VALUES ('wwong2', 'DeptHead');

REM remove the bad data
DELETE FROM CSStaffTitles
WHERE accountName='wwong2' AND acronym LIKE '%Admin%';

