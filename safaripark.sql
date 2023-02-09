DROP TABLE IF EXISTS assignments;
DROP TABLE IF EXISTS animals;
DROP TABLE IF EXISTS enclosures;
DROP TABLE IF EXISTS staff;

CREATE TABLE staff(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    employeeNumber INT
);

CREATE TABLE enclosures (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  capacity INT,
  closedformaintenance BIT
);

CREATE TABLE assignments(
    id SERIAL PRIMARY KEY,
    employeeId INT REFERENCES staff(id),
    enclosureId INT REFERENCES enclosures(id),
    day VARCHAR(10)
);

CREATE TABLE animals (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  type VARCHAR(50),
  age INT,
  enclosures_id INT REFERENCES enclosures(id)
);

INSERT INTO enclosures (name,capacity,closedformaintenance) VALUES ('Monkey House',30,'0');
INSERT INTO enclosures (name,capacity,closedformaintenance) VALUES ('Snake Cage',30,'0');
INSERT INTO enclosures (name,capacity,closedformaintenance) VALUES ('Gorilla Island',30,'1');
INSERT INTO enclosures (name,capacity,closedformaintenance) VALUES ('Flamingo Pond',30,'0');
INSERT INTO enclosures (name,capacity,closedformaintenance) VALUES ('Fox Hole',30,'0');
INSERT INTO enclosures (name,capacity,closedformaintenance) VALUES ('Safari',30,'0');

INSERT INTO animals (name, type, age, enclosures_id) VALUES ('James Emery', 'Mountain Goat', 7,4);
INSERT INTO animals (name, type, age, enclosures_id) VALUES ('Max Verstappen', 'Giraffe', 24,4);
INSERT INTO animals (name, type, age, enclosures_id) VALUES ('Lewis Hamilton', 'Fox', 3,5);
INSERT INTO animals (name, type, age, enclosures_id) VALUES ('Donald Trump', 'Fat Rat', 1,2);
INSERT INTO animals (name, type, age, enclosures_id) VALUES ('Stephen Hawking', 'Elephant', 89,3);
INSERT INTO animals (name, type, age, enclosures_id) VALUES ('Michael Jackson', 'Snake', 3,5);

INSERT INTO staff (name, employeeNumber) VALUES ('Greg',0001);
INSERT INTO staff (name, employeeNumber) VALUES ('Colin',0002);
INSERT INTO staff (name, employeeNumber) VALUES ('Richard',0003);
INSERT INTO staff (name, employeeNumber) VALUES ('Ed',0004);
INSERT INTO staff (name, employeeNumber) VALUES ('James',0005);

INSERT INTO assignments (employeeId,enclosureId,day) VALUES (1,3,'Monday');
INSERT INTO assignments (employeeId,enclosureId,day) VALUES (1,1,'Tuesday');
INSERT INTO assignments (employeeId,enclosureId,day) VALUES (1,5,'Wednesday');
INSERT INTO assignments (employeeId,enclosureId,day) VALUES (2,3,'Monday');
INSERT INTO assignments (employeeId,enclosureId,day) VALUES (2,4,'Tuesday');
INSERT INTO assignments (employeeId,enclosureId,day) VALUES (4,3,'Monday');
INSERT INTO assignments (employeeId,enclosureId,day) VALUES (4,6,'Tuesday');


SELECT enclosures.name, animals.name FROM enclosures
    JOIN animals
    ON enclosures.id = animals.enclosures_id;


SELECT staff.name, enclosures.name
FROM staff
INNER JOIN assignments ON staff.id = assignments.employeeId
INNER JOIN enclosures ON assignments.enclosureId = enclosures.id;

-- SELECT staff.name
-- FROM staff
-- JOIN assignments ON staff.id = assignments.employeeId
-- WHERE assingments.enclosureId IN (SELECT id FROM enclosures WHERE closedformaintenance = '1');

SELECT staff.name
    FROM staff
    JOIN assignments ON staff.id = assignments.employeeId
    JOIN enclosures ON assignments.enclosureId = enclosures.id
    WHERE enclosures.closedformaintenance = '1';


SELECT animals.name
FROM enclosures
JOIN animals ON enclosures.id = enclosures_id
ORDER BY animals.age DESC, animals.name
LIMIT 1;

SELECT staff.name, COUNT(DISTINCT animals.type) AS numberOfTypes
    FROM staff
    JOIN assignments ON staff.id = assignments.employeeId
    JOIN enclosures ON assignments.enclosureId = enclosures.id
    JOIN animals on enclosures.id = animals.enclosures_id
    GROUP BY staff.name;


SELECT enclosures.name, COUNT(DISTINCT staff.id) AS numberOfKeepers
FROM enclosures
JOIN assignments ON enclosures.id = assignments.enclosureId
JOIN staff on assignments.employeeId = staff.id
GROUP BY enclosures.name;

SELECT name
    FROM animals
    WHERE enclosures_id = (SELECT enclosures_id 
                                    FROM animals 
                                    WHERE name = 'James Emery');
