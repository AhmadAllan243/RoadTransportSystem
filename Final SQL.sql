DROP TABLE IF EXISTS Bus_Assignment;
DROP TABLE IF EXISTS All_Stops;
DROP TABLE IF EXISTS Route_Stop;
DROP TABLE IF EXISTS Bus_Stop;
DROP TABLE IF EXISTS Bus;
DROP TABLE IF EXISTS Route;

-- Creating Bus table
CREATE TABLE Bus (
    License_Plate_Number varchar(50) PRIMARY KEY,
    Seat_Capacity int,
    Make varchar(50),
    Model varchar(50),
    Model_Year int,
    Fuel_Type varchar(10),
    Route_ID int
);

-- Creating Route table
CREATE TABLE Route (
    Route_ID int PRIMARY KEY,
    Route_Name varchar(50),
    Start_Terminal varchar(50),
    End_Terminal varchar(50)
);

-- Creating All Stops table
CREATE TABLE All_Stops (
    Route_ID int,
    Stop_ID int,
    PRIMARY KEY (Route_ID, Stop_ID),
    FOREIGN KEY (Route_ID) REFERENCES Route(Route_ID)
);

-- Creating Bus Stop table
CREATE TABLE Bus_Stop (
    Stop_Name varchar(50),
    Stop_Number int,
    Route_ID int,
    Stop_ID int PRIMARY KEY,
    FOREIGN KEY (Route_ID) REFERENCES Route(Route_ID)
);

-- Creating Route Stop table
CREATE TABLE Route_Stop (
    Route_ID int,
    Stop_Name varchar(50),
    Stop_Order int,
    Stop_Number int,
    Stop_ID int,
    PRIMARY KEY (Route_ID, Stop_ID),
    FOREIGN KEY (Route_ID) REFERENCES Route(Route_ID),
    FOREIGN KEY (Stop_ID) REFERENCES Bus_Stop(Stop_ID)
);

-- Creating Bus Assignment table
CREATE TABLE Bus_Assignment (
    License_Plate_Number varchar(50),
    Route_ID int,
    PRIMARY KEY (License_Plate_Number, Route_ID),
    FOREIGN KEY (License_Plate_Number) REFERENCES Bus(License_Plate_Number),
    FOREIGN KEY (Route_ID) REFERENCES Route(Route_ID)
);

-- Inserting data into Route table
INSERT INTO Route (Route_ID, Route_Name, Start_Terminal, End_Terminal)
VALUES
    (101, 'E11', 'Terminal A', 'Terminal B'),
    (102, 'E95 or Sheikh Khalifa bin Zayed Road', 'Terminal C', 'Terminal D'),
    (103, 'E311 or Sheikh Mohammed bin Zayed Road', 'Terminal E', 'Terminal F'),
    (104, 'E84 or Sheikh Khalifa Highway', 'Terminal G', 'Terminal H'),
    (105, 'E44 or Al Khail Road', 'Terminal I', 'Terminal J'),
    (106, 'E611 or Emirates Road', 'Terminal K', 'Terminal L'),
    (107, 'E66 or Dubai-Al Ain Road', 'Terminal M', 'Terminal N'),
    (108, 'E77 or Emirates Road', 'Terminal O', 'Terminal P'),
    (109, 'E621 or Emirates Road', 'Terminal Q', 'Terminal R'),
    (110, 'E46 or Al Khail Road', 'Terminal S', 'Terminal T');

-- Inserting data into Bus table
INSERT INTO Bus (License_Plate_Number, Seat_Capacity, Make, Model, Model_Year, Fuel_Type, Route_ID)
VALUES
    ('YZ001', 40, 'Yutong', 'Model A', 2020, 'Diesel', 101),
    ('YZ002', 50, 'Yutong', 'Model B', 2021, 'Electric', 102),
    ('MBG001', 35, 'Mercedes-Benz Group', 'Sprinter', 2019, 'Diesel', 103),
    ('MBG002', 45, 'Mercedes-Benz Group', 'Tourismo', 2020, 'Diesel', 104),
    ('VB001', 30, 'Volvo Buses', '9700', 2018, 'Hybrid', 105),
    ('VB002', 55, 'Volvo Buses', '9900', 2022, 'Electric', 106),
    ('SB001', 40, 'Scania', 'Citywide', 2019, 'Petrol', 107),
    ('SB002', 50, 'Scania', 'Interlink', 2020, 'Diesel', 108),
    ('BB001', 35, 'Blue Bird', 'Vision', 2018, 'Hybrid', 109),
    ('BB002', 45, 'Blue Bird', 'All American', 2021, 'Petrol', 110);

-- Inserting data into All Stops table
INSERT INTO All_Stops (Route_ID, Stop_ID)
VALUES
    (101, 1),
    (102, 2),
    (103, 3),
    (104, 4),
    (105, 5),
    (106, 6),
    (107, 7),
    (108, 8),
    (109, 9),
    (110, 10);

-- Inserting data into Bus_Stop table
INSERT INTO Bus_Stop (Stop_Name, Stop_Number, Route_ID, Stop_ID)
VALUES
    ('Burj Khalifa', 1, 101, 1),
	('Burj Khalifa', 1, 102, 2),
    ('Burj Al Arab', 2, 102, 3),
    ('Global Village', 1, 103, 4),
    ('Dubai Mall', 2, 104, 5),
	('Dubai Mall', 2, 103, 6),
    ('Dubai Mall', 2, 107, 7),
    ('Ski Dubai', 1, 105, 8),
    ('Desert Safari', 2, 106, 9),
    ('Dubai Garden Glow', 1, 107, 10),
    ('Palm Jumeirah', 2, 108, 11),
	('Palm Jumeirah', 2, 105, 12),
    ('Dubai Miracle Garden', 1, 109, 13),
    ('Mall of the Emirates', 2, 110, 14),
    ('Mall of the Emirates', 2, 106, 15);

-- Inserting data into Route_Stop table
INSERT INTO Route_Stop (Route_ID, Stop_Name, Stop_Order, Stop_Number, Stop_ID)
VALUES
    (101, 'Burj Khalifa', 1, 1, 1),
    (102, 'Burj Al Arab', 2, 2, 2),
    (103, 'Global Village', 1, 1, 3),
    (104, 'Dubai Mall', 2, 2, 4),
    (105, 'Ski Dubai', 3, 3, 5),
    (106, 'Desert Safari', 4, 4, 6),
    (107, 'Dubai Garden Glow', 5, 5, 7),
    (108, 'Palm Jumeirah', 6, 6, 8),
    (109, 'Dubai Miracle Garden', 7, 7, 9),
    (110, 'Mall of the Emirates', 8, 8, 10);

-- Inserting data into Bus_Assignment table
INSERT INTO Bus_Assignment (License_Plate_Number, Route_ID)
VALUES
    ('YZ001', 101),
    ('YZ002', 102),
    ('MBG001', 103),
    ('MBG002', 104),
    ('VB001', 105),
    ('VB002', 106),
    ('SB001', 107),
    ('SB002', 108),
    ('BB001', 109),
    ('BB002', 110);

-- selecting the route names that have the greatest number of stops. 
SELECT Route_Name 
FROM Route, Route_Stop
WHERE Stop_Number = (SELECT MAX(Stop_Number) FROM Route);

-- First we need to create a view table:
DROP VIEW IF EXISTS ElectricBuses;
CREATE VIEW ElectricBuses AS
SELECT License_Plate_Number, Seat_Capacity, Make, Model, Model_Year, Fuel_Type, Route_ID
FROM Bus
WHERE Fuel_Type = 'Electric';

-- Then we will extract the names of routes that electric buses run on:
SELECT r.Route_Name
FROM Route r
JOIN ElectricBuses eb ON r.Route_ID = eb.Route_ID;

-- the names of bus stops that are shared by at least two distinct routes
SELECT Stop_Name
FROM Bus_Stop
GROUP BY Stop_Name
HAVING COUNT(DISTINCT Route_ID) >= 2;

-- the total number of seat capacity of buses grouped by fuel type.
SELECT Fuel_Type, SUM(Seat_Capacity) AS Total_Seat_Capacity
FROM Bus
GROUP BY Fuel_Type;

-- the stop names that is not used by any route.
SELECT Stop_Name
FROM Bus_Stop
WHERE Stop_ID NOT IN (
    SELECT DISTINCT Stop_ID
    FROM Route_Stop
);

SELECT DISTINCT r.Route_ID, r.Route_Name, r.Start_Terminal AS startTerminal, r.End_Terminal AS endTerminal
FROM ROUTE r 
JOIN ROUTE_STOP rs1 ON r.Route_ID = rs1.Route_ID 
JOIN ALL_STOPS s1 ON rs1.Stop_ID = s1.Stop_ID
JOIN ROUTE_STOP rs2 ON r.Route_ID = rs2.Route_ID
JOIN ALL_STOPS s2 ON rs2.Stop_ID = s2.Stop_ID 
WHERE (rs1.stop_Name LIKE '%Global Village%' OR rs2.stop_Name LIKE '%Global Village%') 
ORDER BY r.Route_ID;