create database DB_PROJECT;
use DB_PROJECT;
create TABLE PERSON (
    PersonID INT PRIMARY KEY,
    FirstName VARCHAR(30) ,
    LastName VARCHAR(30),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    DateOfBirth DATE,
    Street VARCHAR(100),
    City VARCHAR(30)
);
create TABLE TRAINER (
    TrainerID INT PRIMARY KEY,
    PersonID INT UNIQUE,
    Specialty VARCHAR(50),
    HireDate DATE,
    Salary DECIMAL(10,2),
    FOREIGN KEY (PersonID)
    REFERENCES PERSON(PersonID)
);
create TABLE MEMBER (
    MemberID INT PRIMARY KEY,
    PersonID INT UNIQUE,
    TrainerID INT,
    JoinDate DATE,
    Status VARCHAR(20),
    FOREIGN KEY (PersonID)
    REFERENCES PERSON(PersonID),
    FOREIGN KEY (TrainerID)
    REFERENCES TRAINER(TrainerID)
);
create TABLE MEMBERSHIP_PLAN (
    PlanID INT PRIMARY KEY,
    PlanName VARCHAR(30),
    DurationMonths INT,
    Fee DECIMAL(10,2)
);
create TABLE SUBSCRIPTION (
    SubscriptionID INT PRIMARY KEY,
    MemberID INT,
    PlanID INT,
    StartDate DATE,
    EndDate DATE,
    PaymentAmount DECIMAL(10,2),
    PaymentDate DATE,
    PaymentMethod VARCHAR(30),
    Status VARCHAR(20),
    FOREIGN KEY (MemberID)
    REFERENCES MEMBER(MemberID),
    FOREIGN KEY (PlanID)
    REFERENCES MEMBERSHIP_PLAN(PlanID)
);
create TABLE ATTENDANCE (
    AttendanceID INT PRIMARY KEY,
    MemberID INT,
    CheckIn DATETIME,
    CheckOut DATETIME,
    FOREIGN KEY (MemberID)
    REFERENCES MEMBER(MemberID)
);
create TABLE FITNESS_CLASS (
    ClassID INT PRIMARY KEY,
    TrainerID INT,
    ClassName VARCHAR(50),
    ClassDate DATE,
    StartTime TIME,
    EndTime TIME,
    Capacity INT,
    FOREIGN KEY (TrainerID)
    REFERENCES TRAINER(TrainerID)
);
create TABLE CLASS_ENROLLMENT (
    EnrollmentID INT PRIMARY KEY,
    MemberID INT,
    ClassID INT,
    EnrollmentDate DATE,
    FOREIGN KEY (MemberID)
    REFERENCES MEMBER(MemberID),
    FOREIGN KEY (ClassID)
    REFERENCES FITNESS_CLASS(ClassID)
);
create TABLE WORKOUT_PLAN (
    WorkoutPlanID INT PRIMARY KEY,
    MemberID INT,
    TrainerID INT,
    PlanName VARCHAR(50),
    Goal VARCHAR(100),
    CreatedDate DATE,
    FOREIGN KEY (MemberID)
    REFERENCES MEMBER(MemberID),
    FOREIGN KEY (TrainerID)
    REFERENCES TRAINER(TrainerID)
);
create TABLE EXERCISE (
    ExerciseID INT PRIMARY KEY,
    ExerciseName VARCHAR(50),
    TargetMuscle VARCHAR(50),
    Instructions VARCHAR(200)
);
create TABLE WORKOUT_PLAN_EXERCISE (
    WorkoutPlanID INT,
    ExerciseID INT,
    Sets INT,
    Repetitions INT,
    PRIMARY KEY (WorkoutPlanID, ExerciseID),
    FOREIGN KEY (WorkoutPlanID)
    REFERENCES WORKOUT_PLAN(WorkoutPlanID),
    FOREIGN KEY (ExerciseID)
    REFERENCES EXERCISE(ExerciseID)
);
create TABLE EQUIPMENT (
    EquipmentID INT PRIMARY KEY,
    EquipmentName VARCHAR(50),
    PurchaseDate DATE,
    EquipmentCondition VARCHAR(30),
    Location VARCHAR(50),
    LastMaintenanceDate DATE,
    MaintenanceNotes VARCHAR(200)
);

-- DML IMPLEMENTATION --

INSERT INTO PERSON VALUES
(1, 'Ali', 'Ahmed', 'ali@gmail.com',
 '03001234567', '2003-05-10',
 'Johar Town', 'Lahore'),
(2, 'Ahmed', 'Khan', 'ahmed@gmail.com',
 '03001234568', '1998-08-15',
 'Model Town', 'Lahore'),
(3, 'Usman', 'Malik', 'usman@gmail.com',
 '03001234569', '2001-03-20',
 'Wapda Town', 'Lahore');
 
INSERT INTO TRAINER VALUES
(201, 2, 'Weight Training', '2024-01-10', 50000),
(202, 3, 'Cardio Training', '2025-02-15', 45000);


INSERT INTO MEMBER VALUES
(101, 1, 201, '2026-01-01', 'Active'),
(102, 3, 202, '2026-02-01', 'Active');

INSERT INTO MEMBERSHIP_PLAN VALUES
(1, 'Monthly', 1, 5000),
(2, 'Quarterly', 3, 12000),
(3, 'Yearly', 12, 40000);

INSERT INTO SUBSCRIPTION VALUES
(301, 101, 1, '2026-11-01',
 '2026-11-30', 5000, '2026-11-01',
 'Cash', 'Active'),
(302, 102, 2, '2026-11-01',
 '2027-01-31', 12000, '2026-11-01',
 'Online', 'Active');
 
INSERT INTO ATTENDANCE VALUES
(401, 101, '2026-11-14 08:00:00',
 '2026-11-14 10:00:00'),
(402, 102, '2026-11-14 09:00:00',
 '2026-11-14 11:00:00');
 
INSERT INTO FITNESS_CLASS VALUES
(501, 201, 'Weight Training',
 '2026-11-15', '09:00:00',
 '10:00:00', 20),
(502, 202, 'Cardio',
 '2026-11-15', '11:00:00',
 '12:00:00', 15);

INSERT INTO CLASS_ENROLLMENT VALUES
(601, 101, 501, '2026-11-14'),
(602, 102, 502, '2026-11-14');

INSERT INTO WORKOUT_PLAN VALUES
(701, 101, 201, 'Strength Plan',
 'Build Muscle', '2026-11-01'),
(702, 102, 202, 'Cardio Plan',
 'Improve Stamina', '2026-11-02');

INSERT INTO EXERCISE VALUES
(801, 'Bench Press', 'Chest',
 'Keep your back stable'),
(802, 'Squats', 'Legs',
 'Maintain proper posture'),
(803, 'Running', 'Cardio',
 'Maintain steady pace');

INSERT INTO WORKOUT_PLAN_EXERCISE VALUES
(701, 801, 3, 10),
(701, 802, 3, 12),
(702, 803, 4, 15);

INSERT INTO EQUIPMENT VALUES
(901, 'Treadmill', '2024-01-01',
 'Good', 'Cardio Room',
 '2026-10-01', 'Routine servicing'),
(902, 'Dumbbells', '2024-02-01',
 'Good', 'Weight Room',
 '2026-09-15', 'Regular inspection');
 
 -- UPDATING MEMBER STATUS -- 
UPDATE MEMBER
SET Status = 'Inactive'
WHERE MemberID = 102;

-- UPDATING MEMBERSHIP FEES --
UPDATE MEMBERSHIP_PLAN
SET Fee = 5500
WHERE PlanID = 1;

-- UPDATING EQUIPMENT CONDITION --
UPDATE EQUIPMENT
SET EquipmentCondition = 'Needs Repair'
WHERE EquipmentID = 901;

-- DELETING CLASS ENROLLMENT BY ID -- 
DELETE FROM CLASS_ENROLLMENT
WHERE EnrollmentID = 602;  -- DELETES USMAN ENROLLMENT--

-- DISPLAYING ALL MEMBERS --
SELECT * FROM MEMBER;

-- DISPLAYING ALL TRAINERS -- 
SELECT * FROM TRAINER;

-- DISPLAYING ALL SUBSCRIPTIONS --
SELECT * FROM SUBSCRIPTION;

-- DISPLAYING ALL EQUIPMENT -- 
SELECT * FROM EQUIPMENT;

-- DISPLAYING ACTIVE MEMBERS --
SELECT *FROM MEMBER WHERE Status = 'Active';

-- Display membership plans costing more than 5000 --
SELECT * FROM MEMBERSHIP_PLAN WHERE Fee > 5000;

-- Display members in ascending order --
SELECT * FROM MEMBER ORDER BY MemberID ASC;

-- ADDING A COLUMN --
ALTER TABLE MEMBER ADD Gender VARCHAR(10);

-- MODIFYING A COLUMN --
ALTER TABLE MEMBER MODIFY Gender VARCHAR(20);

-- DROP A COLUMN -- 
ALTER TABLE MEMBER DROP COLUMN Gender;

-- SQL JOIN QUERIES --

-- INNER JOIN — Members with personal information --
SELECT MEMBER.MemberID,PERSON.FirstName,PERSON.LastName,MEMBER.JoinDate
FROM MEMBER
INNER JOIN PERSON
ON MEMBER.PersonID = PERSON.PersonID;

-- INNER JOIN — Members with their trainers --
SELECT PERSON.FirstName AS MemberName,TRAINER.TrainerID,TRAINER.Specialty
FROM MEMBER
INNER JOIN PERSON
ON MEMBER.PersonID = PERSON.PersonID
INNER JOIN TRAINER
ON MEMBER.TrainerID = TRAINER.TrainerID;

-- . INNER JOIN — Members with membership plans --
SELECT MEMBER.MemberID,MEMBERSHIP_PLAN.PlanName,SUBSCRIPTION.PaymentAmount
FROM MEMBER
INNER JOIN SUBSCRIPTION
ON MEMBER.MemberID = SUBSCRIPTION.MemberID
INNER JOIN MEMBERSHIP_PLAN
ON SUBSCRIPTION.PlanID = MEMBERSHIP_PLAN.PlanID;

-- INNER JOIN — Members with attendance --
SELECT MEMBER.MemberID,ATTENDANCE.CheckIn,ATTENDANCE.CheckOut
FROM MEMBER
INNER JOIN ATTENDANCE
ON MEMBER.MemberID = ATTENDANCE.MemberID;

-- LEFT JOIN — All members and their subscriptions --
SELECT MEMBER.MemberID,SUBSCRIPTION.SubscriptionID,SUBSCRIPTION.Status
FROM MEMBER
LEFT JOIN SUBSCRIPTION
ON MEMBER.MemberID = SUBSCRIPTION.MemberID;

-- JOIN with WHERE — Active subscriptions --
SELECT MEMBER.MemberID,SUBSCRIPTION.SubscriptionID,SUBSCRIPTION.Status
FROM MEMBER
INNER JOIN SUBSCRIPTION
ON MEMBER.MemberID = SUBSCRIPTION.MemberID
WHERE SUBSCRIPTION.Status = 'Active';

-- JOIN with GROUP BY — Total payments per member --
SELECT MEMBER.MemberID,SUM(SUBSCRIPTION.PaymentAmount) AS TotalPaid
FROM MEMBER
INNER JOIN SUBSCRIPTION
ON MEMBER.MemberID = SUBSCRIPTION.MemberID
GROUP BY MEMBER.MemberID;

-- SQL SUBQUERIES --

-- Members whose ID is greater than the average member ID --
SELECT *FROM MEMBER WHERE MemberID >
(
    SELECT AVG(MemberID)
    FROM MEMBER
);

-- Membership plans with fees greater than the average fee --
SELECT *FROM MEMBERSHIP_PLAN WHERE Fee >
(
    SELECT AVG(Fee)
    FROM MEMBERSHIP_PLAN
);

-- Members who have subscriptions --
SELECT *FROM MEMBER WHERE MemberID IN
(
    SELECT MemberID
    FROM SUBSCRIPTION
);

-- Members who have attendance records --
SELECT *FROM MEMBER WHERE MemberID IN
(
    SELECT MemberID
    FROM ATTENDANCE
);

-- Trainers who supervise fitness classes --
SELECT *FROM TRAINER WHERE TrainerID IN
(
    SELECT TrainerID
    FROM FITNESS_CLASS
);

-- Members who have workout plans --
SELECT *FROM MEMBER WHERE MemberID IN
(
    SELECT MemberID
    FROM WORKOUT_PLAN
);

-- Membership plans with the highest fee --
SELECT *FROM MEMBERSHIP_PLAN WHERE Fee =
(
    SELECT MAX(Fee)
    FROM MEMBERSHIP_PLAN
);

-- Members who have not enrolled in any class --
SELECT *FROM MEMBER WHERE MemberID NOT IN
(
    SELECT MemberID
    FROM CLASS_ENROLLMENT
);

-- Members whose subscription payment is greater than 5000 --
SELECT *FROM MEMBER WHERE MemberID IN
(
    SELECT MemberID
    FROM SUBSCRIPTION
    WHERE PaymentAmount > 5000
);

-- Members who have at least one attendance record using EXISTS --
SELECT *FROM MEMBER WHERE EXISTS
(
    SELECT *
    FROM ATTENDANCE
    WHERE ATTENDANCE.MemberID =
          MEMBER.MemberID
);

-- Count total members --
SELECT COUNT(*) AS TotalMembers FROM MEMBER;

-- Calculate average membership fee --
SELECT AVG(Fee) AS AverageFee FROM MEMBERSHIP_PLAN;

-- Find maximum membership fee --
SELECT MAX(Fee) AS HighestFee FROM MEMBERSHIP_PLAN;

-- Find minimum membership fee --
SELECT MIN(Fee) AS LowestFee FROM MEMBERSHIP_PLAN;

-- Calculate total subscription payments --
SELECT SUM(PaymentAmount) AS TotalPayments FROM SUBSCRIPTION;

-- GROUP BY membership status --
SELECT Status,COUNT(*) AS TotalMembers FROM MEMBER GROUP BY Status;

-- GROUP BY with HAVING --
SELECT MemberID,SUM(PaymentAmount) AS TotalPaid
FROM SUBSCRIPTION
GROUP BY MemberID
HAVING SUM(PaymentAmount) > 5000;




















































