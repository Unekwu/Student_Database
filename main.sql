-- Implementation of School Database 
.header on
.mode column

-- Database to for storing the data
.open LincolnUniversity.db 

PRAGMA foreign_keys = 0;

DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Instructor;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Enrols_In;
DROP TABLE IF EXISTS Is_Pre_Req;
DROP TABLE IF EXISTS Is_Head;
DROP TABLE IF EXISTS Instructor_Phone;

-- Enable Foreign key constraint
PRAGMA foreign_keys = 1; 

CREATE TABLE Department
(
  Dnumber INT NOT NULL,
  Dname VARCHAR(25) NOT NULL,
  Dlocation INT NOT NULL,
  PRIMARY KEY (Dnumber)
);

CREATE TABLE Instructor
(
  Fname VARCHAR(25) NOT NULL,
  Lname VARCHAR(25) NOT NULL,
  Email VARCHAR(25) NOT NULL,
  Instructor_ID INT NOT NULL,
  Street_Add VARCHAR(25) NOT NULL,
  City VARCHAR(25) NOT NULL,
  Zip VARCHAR(25) NOT NULL,
  Dno INT NOT NULL,
  PRIMARY KEY (Instructor_ID),
  FOREIGN KEY (Dno) REFERENCES Department(Dnumber)
);

CREATE TABLE Course
(
  Ctitle VARCHAR(25) NOT NULL,
  Cnumber INT NOT NULL,
  Credit_Hour INT NOT NULL,
  Dno INT NOT NULL,
  Teacher_ID INT NOT NULL,
  PRIMARY KEY (Cnumber),
  FOREIGN KEY (Dno) REFERENCES Department(Dnumber),
  FOREIGN KEY (Teacher_ID) REFERENCES Instructor(Instructor_ID)
);

CREATE TABLE Student
(
  Student_ID INT NOT NULL,
  Fname VARCHAR(25) NOT NULL,
  Lname VARCHAR(25) NOT NULL,
  Email VARCHAR(25) NOT NULL,
  Phone_Number INT NOT NULL,
  Dno INT NOT NULL,
  PRIMARY KEY (Student_ID),
  FOREIGN KEY (Dno) REFERENCES Department(Dno)
);


CREATE TABLE Enrols_In
(
  Grade VARCHAR(1),
  Cno INT NOT NULL,
  Std_ID INT NOT NULL,
  PRIMARY KEY (Cno, Std_ID),
  FOREIGN KEY (Cno) REFERENCES Course(Cnumber),
  FOREIGN KEY (Std_ID) REFERENCES Student_(Student_ID)
);

CREATE TABLE Is_Pre_Req
(
  Cno_1 INT NOT NULL,
  Is_PreReqCno_2 INT NOT NULL,
  PRIMARY KEY (Cno_1, Is_PreReqCno_2),
  FOREIGN KEY (Cno_1) REFERENCES Course(Cnumber),
  FOREIGN KEY (Is_PreReqCno_2) REFERENCES Course(Cnumber)
);

CREATE TABLE Is_Head
(
  Dno INT NOT NULL,
  Teacher_ID INT NOT NULL,
  Dept_Head_Start INT NOT NULL,
  Dept_Head_End INT,
  PRIMARY KEY (Dno, Teacher_ID),
  FOREIGN KEY (Dno) REFERENCES Department(Dno),
  FOREIGN KEY (Teacher_ID) REFERENCES Instructor(Instructor_ID)
);

CREATE TABLE Instructor_Phone
(
  Phone INT NOT NULL,
  Teacher_ID INT NOT NULL,
  PRIMARY KEY (Phone, Teacher_ID),
  FOREIGN KEY (Teacher_ID) REFERENCES Instructor(Instructor_ID)
);

PRAGMA foreign_keys = 0; --- Disable foreign key integrity for manager and Supervisor
insert into Department values (1, "Mathematics","Pennsylvania"),
(2, "English","Pennsylvania"),
(3, "Biology","Pennsylvania"),
(4, "Music","Pennsylvania"),
(5, "Chemistry","Pennsylvania");


insert into Instructor values ("Wong", "Smith", "wsmith@lincol.edu",0215468,"445 Naf klaus","New Mexico", 45678,1);
insert into Instructor values ("Borg", "English","benglish@lincol.edu", 0123876,"863 Hampton Inn","Georgia", 19354,2);
insert into Instructor values ("Manni", "Pacquioa", "mpacquioa@lincol.edu",0214567,"10034 Victoria Island","Las Vegas", 45789,3);
insert into Instructor values ("Mayweather", "Floyd", "mfloyd@lincol.edu",0456789,"456 Victoria Garden City","Arizona", 56789,4);
insert into Instructor values ("John", "Wick","jwick@lincol.edu",0324567,"124 Crown Estate","Los Angeles", 43290,5);


insert into Student values (1234567,"James", "Mario","jmario@lincol.edu",445678902,1);
insert into Student values (0987654,"Shaniah", "Holland", "sholland@lincol.edu",565678902,2);
insert into Student values (8947563,"Joshua", "Lar","jlar@lincol.edu",675678902,3);
insert into Student values (5623894,"Mary", "Joseph","mjoseph@lincol.edu",778905437,4);
insert into Student values ( 3546278,"Amanda", "Cook","acook@lincol.edu",900678920,5);


insert into Course values ("Finite Math", 145,3,1,0215468);
insert into Course values ("Literature", 270,3,2,0123876);
insert into Course values ("Genetics", 302,3,3,0214567);
insert into Course values ("Contemporary Music", 432,3,4,0456789);
insert into Course values ("Organic Chemistry", 547,3,5,0324567);
insert into Course values ("General Education", 100,2,1,0324567);

insert into Enrols_In values ("A", 302,"8947563");
insert into Enrols_In values ("B", 270,"1234567");
insert into Enrols_In values ("C", 145,"0987654");
insert into Enrols_In values ("B", 547,"5623894");
insert into Enrols_In values ("D", 432,"3546278");

insert into Is_Pre_Req values (302,145);
insert into Is_Pre_Req values (270,100);
insert into Is_Pre_Req values (547,302 );
insert into Is_Pre_Req values (145,100);
insert into Is_Pre_Req values (432,270);

insert into Is_Head values (1,0215468,"2003-07-31", "2019-27-31");
insert into Is_Head values (2,0123876,"2002-04-3", NULL);
insert into Is_Head values (3,0214567,"2005-04-1", "2020-02-31");
insert into Is_Head values (4,0456789,"2004-02-5", NULL);
insert into Is_Head values (5,0324567,"2010-07-31", "2019-10-29");

insert into Instructor_Phone values (4556789023,0215468);
insert into Instructor_Phone values (4556365362,0123876);
insert into Instructor_Phone values (5645656532,0214567);
insert into Instructor_Phone values (7245654532,0456789);
insert into Instructor_Phone values (8698645398,0324567);

.print "Department"
select * from Department;
.print "Course"
select * from Course;
.print "Student"
select * from Student;

.print "22:"
select  Student_ID, count (Cno) as no_of_students from Student, Enrols_In where Student_ID =std_ID group by Student_ID ;
.print
--select * from Is_Head;
select Ctitle, Dname, count (*) as no_of_students from Course, Department, Enrols_In, Student where Course.Dno = Department.Dnumber and Enrols_In.Cno = Course.Cnumber and Enrols_In.Std_ID = Student.Student_ID group by Ctitle;
.print

select Lname, Fname, Ctitle, Grade from Student, Course, Enrols_In where Course.Cnumber = Enrols_In.Cno and Enrols_In.Std_ID = Student.Student_ID
order by Lname;
.print

-- Enable Foreign key constraint
PRAGMA foreign_keys = 1; 
