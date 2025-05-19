                                       -- 'Remote Patient Monitoring' --


-- What is RPM : Remote Patient Monitoring (RPM) refers to the use of digital technologies to collect health 
-- data from individuals in one location (often their home) and electronically transmit that information securely to healthcare providers 
-- in a different location for assessment and recommendations.

-- How It Works:
-- 1) Patients use devices like blood pressure monitors, glucose meters, pulse oximeters, and wearables 
-- (like smartwatches) that automatically collect health metrics.
-- 2) Data is transmitted in real-time or at scheduled intervals to healthcare providers via mobile apps, cloud platforms, 
-- or integrated health systems.

-- Apprised by client : 

-- The client does not receive payment if the patient fails to monitor for more than 7 days. 
-- Therefore, it is important to send timely reminders to patients to ensure consistent monitoring.
-- The client is responsible for a $100 charge for each device that is either lost or not used by the patient for monitoring.
-- The acceptable range for Heart Rate (HR) is between 45 and 90 beats per minute.
-- The threshold for SPO2 (oxygen saturation) is below 90%.
-- The client would like to identify which disease has the highest number of patient visits.
-- The client is interested in determining the specific age group of patients experiencing the most issues with both SPO2 and HR.
-- The client wants to analyze which gender is more affected and understand the percentage difference between the two.

show variables like 'secure_file_priv';

-- Create database using name 'rpm'.
create database rpm;

-- Use database.
use rpm;

-- Create table using name 'pdf'.
create table pdf (
    patient_id int,
    name varchar(50),
    email varchar(50),
    mobile_phone varchar(15),
    gender varchar(10),
    birth_date varchar (15),
    heart_rate varchar (15),
    spo2 varchar (15),
    rpm_minutes varchar (15),
    rpm_last_monitoring_day varchar (15),
    rpm_monitoring_days varchar (15),
    rpm_live_date varchar (15),
    rpm_consent varchar(15),
    drx_information varchar(60)
);

show variables like 'local_infile';
set global local_infile = 1;

load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\RPM Patient CSV Final File.csv'
into table pdf
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

-- Show all columns and rows.
Select * from pdf;

-- Find youngest and oldest Date of birth range of patients from the dataset pdf.

Select max(birth_date) as youngest_patient from pdf;
Select min(birth_date) as Oldest_patient from pdf;

-- Convert Date of birth in age format. 

Set SQL_SAFE_UPDATES = 0;

Update pdf
Set age = timestampdiff(YEAR, STR_TO_DATE(birth_date, '%d-%m-%Y'), CURDATE());

-- Find youngest and oldest age of patient from the dataset pdf.

Select max(age) from pdf;
Select min(age) from pdf;

-- Find patients who's age is below 40.

Select * from pdf
Where age < 40;

-- Find patients who's age between 40 and 50.

Select * from pdf
Where age between 40 and 50;

-- Find patients who's age between 50 and 60.

Select * from pdf
Where age between 50 and 60;

-- Find patients who's age between 60 and 70.

Select * from pdf
Where age between 60 and 70;

-- Find patients who's age between 70 and 80.

Select * from pdf
Where age between 70 and 80;

-- Find total number of patients who's SPO2 is unstable.
-- As per WHO guidline Unstable SPO2 is below 90%

Select * From pdf
Where SPO2 regexp '^[0-9]+$'  -- ensures SPO2 is only digits
and CAST(SPO2 as unsigned) < 90;

-- Find patients who's age below 40 and who's SPO2 is unstable 

Select age, SPO2 from pdf
Where SPO2 regexp '^[0-9]+$'
and age < 40 and SPO2 < 90;

-- Find patients who's age is between 40 to 50 and who's SPO2 is unstable.

Select age, SPO2 from pdf
Where SPO2 regexp '^[0-9]+$'
and age between 40 and 50 and SPO2 < 90;

-- Find patients who's age is between 50 to 60 and who's SPO2 is unstable.

Select age, SPO2 from pdf
Where SPO2 regexp '^[0-9]+$'
and age between 50 and 60 and SPO2 < 90;

-- Find patients who's age is between 60 to 70 and who's SPO2 is unstable.

Select age, SPO2 from pdf
Where SPO2 regexp '^[0-9]+$'
and age between 60 and 70 and SPO2 < 90;

-- Find patients who's age is between 70 to 80 and who's SPO2 is unstable.

Select age, SPO2 from pdf
Where SPO2 regexp '^[0-9]+$'
and age between 70 and 80 and SPO2 < 90;

-- Find total number of patient who's heart rate is unstable

Select heart_rate from pdf
Where SPO2 regexp '^[0-9]+$'
and heart_rate < 45 or heart_rate > 90;

-- Find patients who's age is below 40 and whose HR is unstable

Select heart_rate, age
from pdf
Where age < 40
and SPO2 regexp '^[0-9]+$'
and (heart_rate < 45 OR heart_rate > 90);

-- Find patients who's age is between 40 to 50 and who's SPO2 is unstable.

Select heart_rate, age
from pdf
Where age between 40 and 50
and SPO2 regexp '^[0-9]+$'
and (heart_rate < 45 OR heart_rate > 90);

-- Find patients who's age is between 50 to 60 and who's SPO2 is unstable.

Select heart_rate, age
from pdf
Where age between 50 and 60
and SPO2 regexp '^[0-9]+$'
and (heart_rate < 45 OR heart_rate > 90);

-- Find patients who's age is between 60 to 70 and who's SPO2 is unstable.

Select heart_rate, age
from pdf
Where age between 60 and 70
and SPO2 regexp '^[0-9]+$'
and (heart_rate < 45 OR heart_rate > 90);

-- Find patients who's age is between 70 to 80 and who's SPO2 is unstable.

Select heart_rate, age
from pdf
Where age between 70 and 80
and SPO2 regexp '^[0-9]+$'
and (heart_rate < 45 OR heart_rate > 90);

-- Find patients who's SPO2 & HR both are fluctuating.

Select heart_rate, age, SPO2
from pdf
Where SPO2 < 90
and SPO2 regexp '^[0-9]+$'
and (heart_rate < 45 OR heart_rate > 90);

-- Find patients who's age is below 40 and who's SPO2 & HR both are fluctuating.

Select heart_rate, age, SPO2
from pdf
Where age < 40 and SPO2 < 90
and SPO2 regexp '^[0-9]+$'
and (heart_rate < 45 OR heart_rate > 90);

-- Find patients who's age is between 40 to 50 & who's SPO2 & HR both are fluctuating.

Select heart_rate, age, SPO2
from pdf
Where age between 40 and 50 and SPO2 < 90
and SPO2 regexp '^[0-9]+$'
and (heart_rate < 45 OR heart_rate > 90);

-- Find patients who's age is between 50 to 60 & who's SPO2 & HR both are fluctuating.

Select heart_rate, age, SPO2
from pdf
Where age between 50 and 60 and SPO2 < 90
and SPO2 regexp '^[0-9]+$'
and (heart_rate < 45 OR heart_rate > 90);

-- Find patients who's age is between 60 to 70 & who's SPO2 & HR both are fluctuating.

Select heart_rate, age, SPO2
from pdf
Where age between 60 and 70 and SPO2 < 90
and SPO2 regexp '^[0-9]+$'
and (heart_rate < 45 OR heart_rate > 90);

-- Find patients who's age is between 70 to 80 & who's SPO2 & HR both are fluctuating.

Select heart_rate, age, SPO2
from pdf
Where age between 70 and 80 and SPO2 < 90
and SPO2 regexp '^[0-9]+$'
and (heart_rate < 45 OR heart_rate > 90);

-- Check the female gender who's HR and SPO2 both are unstable.

Select heart_rate, age, SPO2, gender
from pdf
Where SPO2 < 90 and gender = 'Female'
and SPO2 regexp '^[0-9]+$'
and (heart_rate < 45 OR heart_rate > 90);

-- Check the male gender who's HR and SPO2 both are unstable.

Select heart_rate, age, SPO2, gender
from pdf
Where SPO2 < 90 and gender = 'Male'
and SPO2 regexp '^[0-9]+$'
and (heart_rate < 45 OR heart_rate > 90);

-- Find the unique Drx code from pdf dataset.

Select distinct(drx_information) from pdf;

-- Fine the unique Drx code from pdf dataset with number of patients fall under each specific Drx code. 

Select drx_information, count(*) as patient_count
from pdf
group by drx_information
order by patient_count;

-- Find the patients number who's HR and SPO2 both are unstable with there specific Drx.

Select drx_information, avg(heart_rate) as avg_heart_rate, avg(age) as avg_age, avg(SPO2) as avg_SPO2, count(*) as patient_count
from pdf
Where SPO2 < 90 and SPO2 regexp '^[0-9]+$' and (heart_rate < 45 or heart_rate > 90)
group by drx_information;

-- Find patients who monitored last time before 2 months.

Select * from pdf
Where rpm_last_monitoring_day regexp '^[0-9]{2}-[0-9]{2}-[0-9]{4}$'
and STR_TO_DATE(rpm_last_monitoring_day, '%d-%m-%Y') < STR_TO_DATE('18-03-2025', '%d-%m-%Y');

-- Find patients who monitored last time before a year.

Select * from pdf
Where rpm_last_monitoring_day regexp '^[0-9]{2}-[0-9]{2}-[0-9]{4}$'
and STR_TO_DATE(rpm_last_monitoring_day, '%d-%m-%Y') < STR_TO_DATE('18-05-2024', '%d-%m-%Y');

-- Find live date for those patients who enrolled in last 15 days.

Select * from pdf
Where rpm_live_date regexp '^[0-9]{2}-[0-9]{2}-[0-9]{4}$'
and STR_TO_DATE(rpm_live_date, '%d-%m-%Y') between STR_TO_DATE('01-01-2025', '%d-%m-%Y') and STR_TO_DATE('18-03-2025', '%d-%m-%Y');


-- Check RPM consent date for patients from pdf dataset who fall under 'False'. 

Select rpm_consent from pdf
Where rpm_consent = 'False'; 

-- Find patients who monitored less then 7 times who's consent is True and who's Last monitoring day between 30-04-2025 and 18-05-2025.

Select *
from pdf
where rpm_consent = 'True'
  and rpm_monitoring_days regexp '^[0-9]+$'
  and CAST(rpm_monitoring_days as unsigned) < 7
  and rpm_last_monitoring_day regexp '^[0-9]{2}-[0-9]{2}-[0-9]{4}$'
  and STR_TO_DATE(rpm_last_monitoring_day, '%d-%m-%Y') 
      between STR_TO_DATE('30-04-2025', '%d-%m-%Y') 
          and STR_TO_DATE('18-05-2025', '%d-%m-%Y');

-- Key Insights : 
-- 1) The max patients fall under age 40 to 70 and in specific in between age 50 to 60 from the dataset pdf.
-- 2) The max patients fall under age 50 to 70 and in specific in between age 50 to 60 for low SPO2. 
-- 3) The max patients fall under age 40 to 70 and in specific in between age 60 to 70 for out of limit HR.
-- 4) The max patients fall under age 40 to 70 and in specific in between age 50 to 60 for low SPO2 and out of limit HR.
-- 5) The low SPO2 and out of limit HR for female is 25% more then male.
-- 6) The Interstitial Lung Disease having least number of patient and Pulmonary Fibrosis having major number of patients.
-- 7) The disease like Asthma, Central Sleep Apnea, Obstructive Sleep Apnea, Pulmonary Fibrosis, Cystic Fibrosis having high number of patients 
-- who's SPO2 and HR is unstable but highest number of patients are follow under Pulmonary Fibrosis.
-- 13) There are total 168 patients who doesn't monitored since last two months and they required reminders or return of the device. 
-- 14) There are total 12 patients who doesn't monitored since a year and they required return of the device.
-- 15) There are total 239 patients who enrolled in last 15 days and these patients need introduction call of the program so, 
-- that they will be consistent. 
-- 16) There are 350 patients who's RPM consent is false and these patients needs to get archive from the program 
-- becasue they are already opted out.
-- 17) There are 206 patients who monitored less then 7 days between 30-04-2025 and 18-05-2025 and there patient needs 
-- consistent reminders for monitoring.


-- Detailed insights 
-- 1) 01/01/1945 is the minimum DOB of the patients in the dataset.
-- 2) 31/12/1994 is the maximum DOB of the patients in the dataset. 
-- 3) 18 is the minimum age of the patients in the dataset.
-- 4) 80 is the maximum age of the patients in the dataset.
-- 5) Patients are qually distributed in the complete age group : 
-- Below 40 = 337 patients
-- Between 40 to 50 = 531 patients
-- Between 50 to 60 = 534 patients
-- Between 60 to 70 = 527 patients
-- Between 70 to 80 = 336 patients
-- 6) There are total 62 patients in the dataset who's SPO2 is low :
-- Below 40 = 10 patients
-- Between 40 to 50 = 13 patients
-- Between 50 to 60 = 19 patients
-- Between 60 to 70 = 18 patients
-- Between 70 to 80 = 7 patients 
-- 7) There are total 357 patients in the dataset who's HR is not in limit :
-- Below 40 = 57 patients
-- Between 40 to 50 = 94 patients
-- Between 50 to 60 = 87 patients
-- Between 60 to 70 = 100 patients
-- Between 70 to 80 = 47 rows
-- 8) There are total 27 patients in the dataset who's HR & SPO2 both are not in limit :
-- Below 40 = 2 patients
-- Between 40 to 50 = 7 patients
-- Between 50 to 60 = 9 patients
-- Between 60 to 70 = 8 patients
-- Between 70 to 80 = 3 patients
-- 9) There are total 15 Females are there who's hHR & SPO2 both are not in limit. 
-- 10) There are total 12 Males are there who's HR & SPO2 both are not in limit. 
-- 11) There are total 20 unique disease present in the dataset and below are the number of patients in perticular list :  
-- Pulmonary Fibrosis = 134
-- Hypersomnia = 94
-- Pleural Effusion = 98
-- Upper Airway Resistance Syndrome = 101
-- Sleepwalking = 113
-- Asthma = 93
-- Pneumonia = 105
-- Bronchitis = 97
-- Restless Legs Syndrome = 95
-- Central Sleep Apnea = 107
-- Obstructive Sleep Apnea	= 119
-- Insomnia = 107
-- Emphysema = 94
-- Interstitial Lung Disease = 83
-- Cystic Fibrosis	= 122
-- Nocturnal Asthma = 110
-- Respiratory Failure = 111
-- Narcolepsy = 113
-- Sleep Apnea = 90
-- Chronic Obstructive Pulmonary Disease = 114
-- 12) Total number of patients in the dataset who's HR is not in limit as per the dignosis code : 
-- Asthma -- 4 patients
-- Central Sleep Apnea -- 4 patients
-- Obstructive Sleep Apnea -- 4 patients
-- Sleepwalking -- 2 patients
-- Restless Legs Syndrome -- 2 patients
-- Pulmonary Fibrosis -- 5 patients
-- Cystic Fibrosis -- 4 patients
-- Chronic Obstructive Pulmonary Disease -- 1 patients
-- Hypersomnia -- 1 patients
-- 13) There are total 168 patients who doesn't monitored since last two months. 
-- 14) There are total 12 patients who doesn't monitored since a year.
-- 15) There are total 239 patients who enrolled in last 15 days. 
-- 16) There are 350 patients who's RPM consent is false.
-- 17) There are 206 patients who monitored less then 7 days between 30-04-2025 and 18-05-2025.