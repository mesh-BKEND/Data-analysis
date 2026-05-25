-- Overall class performance
SELECT
    COUNT(*) AS Total_Students,
    ROUND(AVG(Study_Hours)) AS av_study_hours,
    ROUND(AVG(Retention_Score)) AS avg_retention_score,
    ROUND(AVG(Focus_Level)) AS avg_focus_level,
    ROUND(AVG(Exam_Score)) AS avg_exam_score
    FROM stat1;

-- perfomance based on the type of learning mode

SELECT
   Learning_Mode,
   AVG(Study_Hours) AS average_hours,
   AVG(Retention_Score) AS avg_retention_score,
   AVG(Focus_Level)  AS avg_focus_level,
   AVG(Exam_Score) AS  avg_exam_score
 FROM stat1
 GROUP BY Learning_Mode
ORDER BY avg_exam_Score DESC;

--creating temporary table for only online students online
create temporary table online_students as(
    select * from stat1 where `Learning_Mode` = 'Online'
);

--create on Offline table for only offline students
create TEMPORARY TABLE offline_students as (
    SELECT * FROM stat1
    WHERE Learning_Mode = 'Offline'
);

SELECT 
   Subject,
   AVG(Study_Hours) AS Study_Hours,
   AVG(Retention_Score) AS avg_retention_score,
   AVG(Focus_Level) AS avg_focus_score,
   AVG(Exam_Score) AS avg_exam_score,
   (avg(Retention_Score) / avg(Exam_Score)) as retention_to_exam_ratio
FROM online_students
GROUP BY Subject
ORDER BY avg_exam_score DESC;

--finding the relationship between study hours and the retention level for all the students
with mean_x as (
    select avg(Study_Hours) as value from stat1
), mean_y as (
    select avg(Retention_Score) as value from stat1
), mean_xy as (
    select avg(Study_Hours * Retention_Score) as value from stat1
)
select
    @mean_x := mx.value as mean_x,
    @mean_y := my.value as mean_y,
    @mean_xy := mxy.value as mean_xy
from mean_x mx
cross join mean_y my
cross join mean_xy mxy;

select @mean_xy - @mean_x * @mean_y as covariance_xy;