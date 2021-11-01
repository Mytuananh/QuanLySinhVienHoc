create database quanlysinhvienhoc;
use quanlysinhvienhoc;

create table Class(
                      ClassID int auto_increment primary key,
                      ClassName varchar(10),
                      StartDate date,
                      Status boolean
);
create table Student(
                        StudentID int auto_increment primary key,
                        StudentName varchar(30),
                        Address varchar(50),
                        Phone varchar(12),
                        Status boolean,
                        ClassID int,
                        foreign key (ClassID) references Class (ClassID)
);
create table Subject(
                        SubID int auto_increment primary key,
                        SubName varchar(20),
                        Credit int,
                        Status boolean
);
create table Mark(
                     MarkID int auto_increment primary key,
                     SubID int,
                     StudentID int,
                     Mark int,
                     ExamTimes time,
                     foreign key (SubID) references Subject (SubID),
                     foreign key (StudentID) references  Student (StudentID)
);
insert into Class (ClassName, StartDate, Status) value ('A1', '2021-10-23', true);
insert into Class (ClassName, StartDate, Status) value ('A2', '2020-10-23', true);
insert into Class (ClassName, StartDate, Status) value ('A3', '2019-10-23', false);

insert into Student (StudentName, Address, Phone, Status, ClassID) VALUE ('Tuan','Hai Phong', '012345567', true,1);
insert into Student (StudentName, Address, Phone, Status, ClassID) VALUE ('Thao','Phu Tho', '0123455678', true,1);
insert into Student (StudentName, Address, Phone, Status, ClassID) VALUE ('Duy','Ha Noi', '01234556789', true,2);

insert into Subject (SubName, Credit, Status) VALUE ('Tieng Anh', 5, true);
insert into Subject (SubName, Credit, Status) VALUE ('My Thuat', 6, true);
insert into Subject (SubName, Credit, Status) VALUE ('Am Nhac', 5, true);
insert into Subject (SubName, Credit, Status) VALUE ('Ngu Van', 10, true);

insert into Mark (SubID, StudentID, Mark, ExamTimes) VALUE (1, 1, 8, '01:00');
insert into Mark (SubID, StudentID, Mark, ExamTimes) VALUE (1, 2, 10, '02:00');
insert into Mark (SubID, StudentID, Mark, ExamTimes) VALUE (2, 1, 12, '01:00');

use quanlysinhvienhoc;
select Address, count(StudentID) as 'Số lượng học viên' from Student group by Address;
select s.StudentID, s.StudentName, avg(Mark) from Student s join Mark M on s.StudentID = M.StudentID group by  s.StudentID, s.StudentName having avg(Mark) > 11;
select s.StudentID, s.StudentName, avg(Mark) from Student s join Mark M on s.StudentID = M.StudentID group by  s.StudentID, s.StudentName having avg(Mark) <= all(select avg(Mark) from Mark group by StudentID);
select *, max(Credit) from Subject s group by SubID, SubName having max(Credit) >= all(select max(Credit) from Subject);
select *, max(m.Mark) from Subject join Mark M on Subject.SubID = M.SubID group by Subject.SubID, Subject.SubName having max(Mark) >= all(select max(Mark) from Mark group by m.SubID);
select s.StudentID, s.StudentName, avg(Mark) from student s join Mark M on s.StudentID = M.StudentID group by s.StudentID, s.StudentName order by avg(Mark) desc;

