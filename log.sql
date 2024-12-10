-- Keep a log of any SQL queries you execute as you solve the mystery.

-- To determine what tables are within the database
.tables

-- To determine what collumns are within the different tables
.schema

-- Find description of the crime scene on the day it happened

SELECT description FROM crime_scene_reports
WHERE month = 7 AND day = 28
AND street = 'Humphrey Street';
        -- Theft of the duck took place at 10:15am at the Humphrey Street Bakery, all three witnesses interviewed mentioned the baker. Littering took place at 4:36 pm with no witnesses

-- List all crimes reported on humphrey street

SELECT * FROM crime_scene_reports WHERE street = 'Humphrey Street';

-- find all the activity from the 28th of july at the bakery
SELECT license_plate, activity, hour, minute FROM bakery_security_logs WHERE day = 28 AND month = 7;

-- analyze witness interviews

SELECT transcript
FROM interviews
WHERE day = 28 AND month = 7;
    -- Sometime within ten minutes of the theft, I saw the thief get into a car in the bakery parking lot and drive away. If you have security footage from the bakery parking lot, you might want to look for cars that left the parking lot in that time frame.
    -- I don't know the thief's name, but it was someone I recognized. Earlier this morning, before I arrived at Emma's bakery, I was walking by the ATM on Leggett Street and saw the thief there withdrawing some money.
    --As the thief was leaving the bakery, they called someone who talked to them for less than a minute. In the call, I heard the thief say that they were planning to take the earliest flight out of Fiftyville tomorrow. The thief then asked the person on the other end of the phone to purchase the flight ticket.

-- To get the license plates that have an activity of "exit" within the time frame of 10:15 and 10:25 on the 28th of July, you can use the following SQL query:

SELECT license_plate
FROM bakery_security_logs
WHERE activity = 'exit'
AND hour = 10
AND minute BETWEEN 15 AND 25
AND day = 28
AND month = 7;

+---------------+
| license_plate |
+---------------+
| 5P2BI95       |
| 94KL13X       |
| 6P58WS2       |
| 4328GD8       |
| G412CB7       |
| L93JTIZ       |
| 322W7JE       |
| 0NTHK55       |
+---------------+

-- find all the flights that left the 29th of july, their times, origin airport id, id, and destination airport id, year, month, day, hour, and minute

SELECT id, origin_airport_id
FROM flights
WHERE day = 29 AND month = 7;

+----+-------------------+------------------------+------+-------+-----+------+--------+
| id | origin_airport_id | destination_airport_id | year | month | day | hour | minute |
+----+-------------------+------------------------+------+-------+-----+------+--------+
| 36 | 8                 | 4                      | 2023 | 7     | 29  | 8    | 20     |
| 43 | 8                 | 1                      | 2023 | 7     | 29  | 9    | 30     |
| 23 | 8                 | 11                     | 2023 | 7     | 29  | 12   | 15     |
| 53 | 8                 | 9                      | 2023 | 7     | 29  | 15   | 20     |
| 18 | 8                 | 6                      | 2023 | 7     | 29  | 16   | 0      |
+----+-------------------+------------------------+------+-------+-----+------+--------+

-- Find all the passport numbers from flight ID 36

SELECT passport_number
FROM passengers
WHERE flight_id = 36;

+-----------------+
| passport_number |
+-----------------+
| 7214083635      |
| 1695452385      |
| 5773159633      |
| 1540955065      |
| 8294398571      |
| 1988161715      |
| 9878712108      |
| 8496433585      |
+-----------------+

-- find all the transactions on the 28th that occurred on leggett street with transaction type 'withdraw'

SELECT * FROM atm_transactions WHERE month = 7 AND day = 28
   ...> AND transaction_type = 'withdraw'
   ...> AND atm_location = 'Leggett Street';

   +-----+----------------+------+-------+-----+----------------+------------------+--------+
| id  | account_number | year | month | day |  atm_location  | transaction_type | amount |
+-----+----------------+------+-------+-----+----------------+------------------+--------+
| 246 | 28500762       | 2023 | 7     | 28  | Leggett Street | withdraw         | 48     |
| 264 | 28296815       | 2023 | 7     | 28  | Leggett Street | withdraw         | 20     |
| 266 | 76054385       | 2023 | 7     | 28  | Leggett Street | withdraw         | 60     |
| 267 | 49610011       | 2023 | 7     | 28  | Leggett Street | withdraw         | 50     |
| 269 | 16153065       | 2023 | 7     | 28  | Leggett Street | withdraw         | 80     |
| 288 | 25506511       | 2023 | 7     | 28  | Leggett Street | withdraw         | 20     |
| 313 | 81061156       | 2023 | 7     | 28  | Leggett Street | withdraw         | 30     |
| 336 | 26013199       | 2023 | 7     | 28  | Leggett Street | withdraw         | 35     |
+-----+----------------+------+-------+-----+----------------+------------------+--------+

--check against license plates

SELECT p.name, bsl.activity, bsl.license_plate, bsl.year, bsl.month, bsl.day, bsl.hour, bsl.minute
FROM bakery_security_logs bsl
JOIN people p ON p.license_plate = bsl.license_plate
WHERE bsl.year = 2023 AND bsl.month = 7 AND bsl.day = 28 AND bsl.hour = 10 AND bsl.minute BETWEEN 15 AND 25;

+---------+----------+---------------+------+-------+-----+------+--------+
|  name   | activity | license_plate | year | month | day | hour | minute |
+---------+----------+---------------+------+-------+-----+------+--------+
| Vanessa | exit     | 5P2BI95       | 2023 | 7     | 28  | 10   | 16     |
| Bruce   | exit     | 94KL13X       | 2023 | 7     | 28  | 10   | 18     |
| Barry   | exit     | 6P58WS2       | 2023 | 7     | 28  | 10   | 18     |
| Luca    | exit     | 4328GD8       | 2023 | 7     | 28  | 10   | 19     |
| Sofia   | exit     | G412CB7       | 2023 | 7     | 28  | 10   | 20     |
| Iman    | exit     | L93JTIZ       | 2023 | 7     | 28  | 10   | 21     |
| Diana   | exit     | 322W7JE       | 2023 | 7     | 28  | 10   | 23     |
| Kelsey  | exit     | 0NTHK55       | 2023 | 7     | 28  | 10   | 23     |
+---------+----------+---------------+------+-------+-----+------+--------+

-- witness 3 phone call investigating

SELECT p.name, pc.caller, pc.receiver, pc.year, pc.month, pc.day, pc.duration
FROM phone_calls pc
JOIN people p ON pc.caller = p.phone_number
WHERE pc.year = 2023 AND pc.month = 7 AND pc.day = 28 AND pc.duration < 60;

+---------+----------------+----------------+------+-------+-----+----------+
|  name   |     caller     |    receiver    | year | month | day | duration |
+---------+----------------+----------------+------+-------+-----+----------+
| Sofia   | (130) 555-0289 | (996) 555-8899 | 2023 | 7     | 28  | 51       |
| Kelsey  | (499) 555-9472 | (892) 555-8872 | 2023 | 7     | 28  | 36       |
| Bruce   | (367) 555-5533 | (375) 555-8161 | 2023 | 7     | 28  | 45       |
| Kelsey  | (499) 555-9472 | (717) 555-1342 | 2023 | 7     | 28  | 50       |
| Taylor  | (286) 555-6063 | (676) 555-6554 | 2023 | 7     | 28  | 43       |
| Diana   | (770) 555-1861 | (725) 555-3243 | 2023 | 7     | 28  | 49       |
| Carina  | (031) 555-6622 | (910) 555-3251 | 2023 | 7     | 28  | 38       |
| Kenny   | (826) 555-1652 | (066) 555-9701 | 2023 | 7     | 28  | 55       |
| Benista | (338) 555-6650 | (704) 555-2131 | 2023 | 7     | 28  | 54       |
+---------+----------------+----------------+------+-------+-----+----------+

Find city, full name of airport id 8

--SELECT full_name, city FROM airports WHERE id = 8;

+-----------------------------+------------+
|          full_name          |    city    |
+-----------------------------+------------+
| Fiftyville Regional Airport | Fiftyville |
+-----------------------------+------------+

--Find city, full name of airport id 4

SELECT full_name, city FROM airports WHERE id = 4;

+-------------------+---------------+
|     full_name     |     city      |
+-------------------+---------------+
| LaGuardia Airport | New York City |
+-------------------+---------------+

-- narrow down whether bruce or diana on flight 36

SELECT p.name
   ...> FROM people p
   ...> JOIN passengers ps ON p.passport_number = ps.passport_number
   ...> WHERE ps.flight_id = 36
   ...> AND p.name IN ('Bruce', 'Diana');

+-------+
| name  |
+-------+
| Bruce |
+-------+

--who did bruce call

SELECT p2.name AS receiver
FROM phone_calls pc
JOIN people p1 ON pc.caller = p1.phone_number
JOIN people p2 ON pc.receiver = p2.phone_number
WHERE p1.name = 'Bruce' AND pc.year = 2023 AND pc.month = 7 AND pc.day = 28 AND pc.duration < 60;

+----------+
| receiver |
+----------+
| Robin    |
+----------+

