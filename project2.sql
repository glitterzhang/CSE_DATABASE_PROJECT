CREATE TABLE Department(
	Dept_No INT PRIMARY KEY,
	Dept_Name VARCHAR(100) NOT NULL,
	Dept_PhoneNo CHAR(10),
	Dept_Address VARCHAR(200),
	Total_Students INT,
	Total_Employee INT,
	CHECK (Dept_No > 0 AND Dept_No <= 999),
	CHECK (Total_Students >= 0),
	CHECK (Total_Employee >= 0)
);
CREATE TABLE Employee(
	E_FirstName VARCHAR(50) NOT NULL,
	E_LastName VARCHAR(50) NOT NULL,
	E_OSUid VARCHAR(50) PRIMARY KEY,
	E_Sex CHAR(1),
	E_Title VARCHAR(50),
	E_Nationality VARCHAR(100),
	E_Race VARCHAR(20),
	E_Office VARCHAR(100),
	CHECK (E_Sex = 'M' OR E_Sex = 'F')
);

CREATE TABLE Student(
	S_FirstName VARCHAR(50) NOT NULL,
	S_LastName VARCHAR(50) NOT NULL,
	S_OSUid VARCHAR(50) PRIMARY KEY,
	S_Sex CHAR(1),
	S_Nationality VARCHAR(100),
	S_Race VARCHAR(20),
	S_Year INT,
	S_GPA DECIMAL(3,2),
	CHECK (S_Sex = 'M' OR S_Sex = 'F'),
	CHECK (S_Year >= 1 AND S_Year <= 10),
	CHECK (S_GPA >= 0.0 AND S_GPA <= 4.0)
);

CREATE TABLE UnderGrad(
	OSUid VARCHAR(50) PRIMARY KEY,
	FOREIGN KEY (OSUid) REFERENCES Student(S_OSUid)
);

CREATE TABLE Grad(
	OSUid VARCHAR(50) PRIMARY KEY,
	FOREIGN KEY (OSUid) REFERENCES Student(S_OSUid)
);

CREATE TABLE Masters(
	OSUid VARCHAR(50) PRIMARY KEY,
	FOREIGN KEY (OSUid) REFERENCES Student(S_OSUid)
);

CREATE TABLE ResearchArea(
	AreaName VARCHAR(50) NOT NULL,
	AreaNo INT PRIMARY KEY
);

CREATE TABLE PhD(
	OSUid VARCHAR(50) PRIMARY KEY,
	FOREIGN KEY (OSUid) REFERENCES Student(S_OSUid),
	Major_AreaNo INT,
	FOREIGN KEY (Major_AreaNo) REFERENCES ResearchArea(AreaNo)
);

CREATE TABLE RA(
	OSUid VARCHAR(50) PRIMARY KEY,
	FOREIGN KEY (OSUid) REFERENCES Student(S_OSUid)
);

CREATE TABLE Faculty(
	F_OSUid VARCHAR(50) PRIMARY KEY,
	FOREIGN KEY (F_OSUid) REFERENCES Employee(E_OSUid),
	IsResearcher BIT
);


CREATE TABLE Course(
	ClassNo CHAR(5),
	SectionNo CHAR(4),
	CourseNo CHAR(4) NOT NULL,
	CourseName VARCHAR(50) NOT NULL,
	Courseweekday VARCHAR(10),
	CourseStartTime TIME,
	CourseEndTime TIME,
	CourseClassRoom VARCHAR(50),
	InstructorID VARCHAR(50),
	Dept_No INT,
	Course_credit INT,
	PRIMARY KEY (ClassNo, SectionNo),
	FOREIGN KEY (InstructorID) REFERENCES Faculty(F_OSUid) 
);

CREATE TABLE TA(
	OSUid VARCHAR(50) PRIMARY KEY,
	FOREIGN KEY (OSUid) REFERENCES Student(S_OSUid),
	ClassNo CHAR(5),
	FOREIGN KEY (ClassNo,SectionNo) REFERENCES Course(ClassNo,SectionNo),
	SectionNo CHAR(4),
);


CREATE TABLE Staff(
	Staff_OSUid VARCHAR(50) PRIMARY KEY,
	FOREIGN KEY (Staff_OSUid) REFERENCES Employee(E_OSUid)
);

CREATE TABLE AdministrativeContacts(
	OSUid VARCHAR(50) PRIMARY KEY,
	FOREIGN KEY (OSUid) REFERENCES Employee(E_OSUid),
	AdministrativeGroup VARCHAR(50),
	AdministrativeTitle VARCHAR(50)
);

CREATE TABLE Lab(
	RoomNo VARCHAR(10) PRIMARY KEY,
	LabResearchArea INT,
	FOREIGN KEY (LabResearchArea) REFERENCES ResearchArea(AreaNo)
);



CREATE TABLE Alumni(
	A_FirstName VARCHAR(50) NOT NULL,
	A_LastName VARCHAR(50) NOT NULL,
	A_Sex CHAR(1),
	GradYear INT,
	A_OSUid VARCHAR(50) PRIMARY KEY,
	CHECK (A_Sex = 'M' OR A_Sex = 'F'),
	CHECK (GradYear >= 1800 AND GradYear <= 2100)
);



CREATE TABLE WorkIn(
	OSUid VARCHAR(50),
	FOREIGN KEY (OSUid) REFERENCES Employee(E_OSUid),
	Dept_No INT ,
	PRIMARY KEY( OSUid,Dept_No),
	FOREIGN KEY (Dept_No) REFERENCES Department(Dept_No)
);

CREATE TABLE StudyIn(
	OSUid VARCHAR(50) ,
	FOREIGN KEY (OSUid) REFERENCES Student(S_OSUid),
	Dept_No INT,
	PRIMARY KEY(OSUid,Dept_No),
	FOREIGN KEY (Dept_No) REFERENCES Department(Dept_No)
);

CREATE TABLE EnrollIn(
	OSUid VARCHAR(50) ,
	FOREIGN KEY (OSUid) REFERENCES Student(S_OSUid),
	ClassNo CHAR(5) ,
	PRIMARY KEY(OSUid,ClassNo,SectionNo),
	SectionNo CHAR(4),	
	FOREIGN KEY (ClassNo,SectionNo) REFERENCES Course(ClassNo,SectionNo),
	Grade VARCHAR(2)
);

CREATE TABLE Supervise(
	Faculty_OSUid VARCHAR(50) ,
	FOREIGN KEY (Faculty_OSUid) REFERENCES Faculty(F_OSUid),
	Student_OSUid VARCHAR(50),
	PRIMARY KEY(Faculty_OSUid,Student_OSUid),
	FOREIGN KEY (Student_OSUid) REFERENCES Student(S_OSUid)
);

CREATE TABLE InChargeOf(
	Faculty_OSUid VARCHAR(50),
	FOREIGN KEY (Faculty_OSUid) REFERENCES Faculty(F_OSUid),
	LabAddress VARCHAR(10),
	PRIMARY KEY(Faculty_OSUid,LabAddress),
	FOREIGN KEY (LabAddress) REFERENCES Lab(RoomNO)
);

CREATE TABLE GraduateFrom(
	Alumni_OSUid VARCHAR(50),
	FOREIGN KEY (Alumni_OSUid) REFERENCES Alumni(A_OSUid),
	Dept_No INT,
	PRIMARY KEY(Alumni_OSUid,Dept_No),
	FOREIGN KEY (Dept_No) REFERENCES Department(Dept_No)
);

CREATE TABLE FocusIn(
	Faculty_OSUid VARCHAR(50),
	FOREIGN KEY (Faculty_OSUid) REFERENCES Faculty(F_OSUid),
	ResearchAreaNo INT,
	PRIMARY KEY(Faculty_OSUid, ResearchAreaNo),
	FOREIGN KEY (ResearchAreaNo) REFERENCES ResearchArea(AreaNo)
);

CREATE TABLE Minor(
	PhD_OSUid VARCHAR(50),
	FOREIGN KEY (PhD_OSUid) REFERENCES Student(S_OSUid),
	ResearchAreaNo INT,
	PRIMARY KEY(PhD_OSUid, ResearchAreaNo),
	FOREIGN KEY (ResearchAreaNo) REFERENCES ResearchArea(AreaNo)
);

INSERT  INTO Department
VALUES( 1, 'Accounting', '6140010001','189 Neil Ave', 0,43),
      ( 2, 'Agriculture', '6140010003','163 Wooddruff', 70,28),
      ( 3, 'Computer Science', '6140010005','395 Dreese Laboratories
2015 Neil Avenue', 400,56),
      ( 4, 'Business', '6140010006','2100 Neil Avenue Columbus, Ohio 43210',180,36);
INSERT INTO Employee
VALUES('Alex','Smith','smith.71' ,'F','Residence Hall Director','American','White','Hall Director Office Park-Stradley Hall'),
      ('Banerjee','Tanvi','tanvi.71' ,'F','Instructor','Indian','Asian','Bloz Hall'),
	   ('Mac','Posner','posner.3' ,'F','Professor','American','White','Baker Hall');
	  
 
INSERT INTO Student
VALUES( 'John' ,'Smith' ,'smith.1', 'M' ,'American' ,'White', 2, 3.30),
      ( 'Yejing',  'Lee', 'lee.2', 'F', 'Korea', 'Asian', 6 ,3.50),
	  ( 'Alie',  'Forest', 'forest.52', 'F', 'American', 'White', 1 ,3.00),
	  ( 'Mike', 'Chapman','chapman.36', 'M', 'American', 'White', 5 ,3.80),
	  ( 'Yun', 'Yu','yu.37', 'F', 'Chinese', 'Asian', 5 ,3.75);

INSERT INTO StudyIn
VALUES('smith.1',1),
      ('forest.52', 1),
	  ('chapman.36',3),
	  ( 'lee.2',4),
	  ('yu.37',4);

INSERT INTO UnderGrad
VALUES('smith.1'),
      ('forest.52');
       
INSERT INTO Grad
VALUES('chapman.36'),
      ('lee.2'),
	  ('yu.37');

INSERT INTO Masters
VALUES('yu.37');

INSERT ResearchArea
VALUES('Goverment Accounting',1),
('Financial Economics',4),
('Economics',7),
('Supply Chain',9),
('Computer Architecture',10);



INSERT INTO PhD
VALUES('chapman.36',10),
      ('lee.2',9);
INSERT INTO RA
VALUES( 'smith.1'),
       ( 'yu.37');
INSERT INTO Faculty
VALUES( 'tanvi.71',0),
      ( 'posner.3',1);
INSERT INTO Course
VALUES('02431', '0080', '5243', 'Data Mining','MW','08:50:00', '10:50:00', 'Baker 180','posner.3',1,3),
  ('02433', '0090', '5241', 'Data base','MWf','14:50:00', '15:50:00', 'Baker 180','posner.3',1,3);
;
    
INSERT INTO TA
VALUES('chapman.36','02431','0080'),
      ('yu.37','02433', '0090');
INSERT INTO Staff
VALUES('smith.71');

INSERT INTO AdministrativeContacts
VALUES( 'smith.71','Academic Program', 'UG Advising'),
      ( 'posner.3','Administrative Contacts','Fiscal officer');

INSERT INTO Lab
VALUES('MH172',10);

INSERT INTO Alumni
VALUES('Joshua','Louk','F', '2013','louk.35');

INSERT INTO WorkIn
VALUES('posner.3',3),
      ('tanvi.71',4);

INSERT INTO EnrollIn
VALUES('chapman.36','02431', '0080','89'),
  ('lee.2','02433', '0090','95');

INSERT INTO Supervise
VALUES('posner.3','chapman.36'),
      ('tanvi.71','lee.2');

INSERT INTO InChargeOf
VALUES('tanvi.71','MH172');
  

INSERT INTO GraduateFrom 
VALUES('louk.35',3)

INSERT INTO FocusIn
VALUES('posner.3',1),
      ('posner.3',4),
	  ('posner.3',7),
	   ('posner.3',9),
	   ('posner.3',10),
      ('tanvi.71',10);

INSERT INTO Minor
VALUES('chapman.36',1),
      ('lee.2',1);

SELECT * FROM Student;


/* Trigger is tested by inserting more students into the database and observing if 
the Total_Students field in the Department table change correctly */
GO
CREATE TRIGGER DEPARTMENT_INC ON StudyIn
AFTER INSERT
AS 
IF (SELECT Dept_No FROM inserted) IS NOT NULL
UPDATE Department
SET Total_Students=Total_Students+1
WHERE Dept_No=(SELECT Dept_No FROM inserted)


/* Trigger is tested by deleting students from the database and observing if 
the Total_Students field in the Department table change correctly */
GO
CREATE TRIGGER DEPARTMENT_DEC ON StudyIn
AFTER DELETE
AS 
IF (SELECT Dept_No FROM deleted) IS NOT NULL
UPDATE Department
SET Total_Students=Total_Students-1
WHERE Dept_No=(SELECT Dept_No FROM deleted)

/*Test trigger*/
SELECT * FROM Department;

INSERT INTO Student
VALUES( 'Amy' ,'Smith' ,'smith.2', 'F' ,'American' ,'White', 2, 3.30);

INSERT INTO StudyIn
VALUES('smith.2',1);
 
SELECT * FROM Department;

/* test trigger 2*/
DELETE FROM StudyIn
WHERE OSUid='smith.2';
SELECT * FROM Department

 
/* Some queries will search students based on their firstname and lastname */
CREATE INDEX Student_index
On Student (S_FirstName,S_LastName);

/* some queries will search employees based on their firstname and lastname */
CREATE INDEX Employee_index
On Employee (E_FirstName,E_LastName);
/* some queries will search departments based on their department name */
CREATE INDEX Department_index
On Department(Dept_Name);
/* some queries will search courses based on their instructorID, course start time and end time */
CREATE INDEX Course_index
On Course(InstructorID,CourseStartTime,CourseEndTime);

/* some queries will search alumni based on their first name and lastname */
CREATE Index Alumni_index1
ON Alumni(A_FirstName,A_LastName);

/* some queries will search alumni based on the year of graduation and their lastname */
CREATE Index Alumni_index2
ON Alumni(GradYear,A_LastName);

/*retrieve information about student who are RA or TA*/

SELECT *
From Student  
WHERE S_OSUid in( SELECT OSUid from RA UNION SELECT OSUid from TA);

/*retrieve information about students who are RA and TA*/
SELECT *
FROM Student
WHERE S_OSUid in ( SELECT OSUid from RA INTERSECT SELECT OSUid from TA);

/*retrieve information about students  who are RA and TA but not in major in Computer Architecture*/
SELECT *
FROM Student where S_OSUid in ( SELECT OSUid FROM RA INTERSECT SELECT OSUid from TA EXCEPT SELECT OSUid FROM PhD WHERE Major_AreaNo=10)

/*retrieve information about faculty who focus in all research areas.*/
SELECT Faculty_OSUid FROM FocusIn , ResearchArea 
WHERE FocusIn.ResearchAreaNo =ResearchArea.AreaNo
GROUP BY Faculty_OSUid 
HAVING COUNT(FocusIn.ResearchAreaNo)=(SELECT COUNT(ResearchArea.AreaNo) FROM ResearchArea)

/*retrieve information about the number of female and male students*/
SELECT COUNT(S_OSUid) FROM Student
GROUP BY S_Sex;

/*retrieve information about information about students taught by professor Mac posner*/
SELECT * FROM Course 
JOIN  EnrollIn ON Course.ClassNo=EnrollIn.ClassNo 
JOIN  Student ON Student.S_OSUid=EnrollIn.OSUid
WHERE Course.InstructorID='posner.3'

SELECT* FROM Employee;
SELECT* FROM Department;
SELECT Dept_Name FROM Department ORDER by Total_Employee;
SELECT count(*) , AVG(Total_Employee) FROM Department Group by Dept_Name,Dept_No Having avg(Total_Employee)<=50;
 


















