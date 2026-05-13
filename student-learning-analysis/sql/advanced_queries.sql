-- Rank students by final exam score
SELECT
    student_id,
    student_name,
    final_exam_score,
    RANK() OVER (ORDER BY final_exam_score DESC) AS exam_rank
FROM student_learning;

-- Segment students by attendance level
SELECT
    CASE
        WHEN attendance_rate >= 90 THEN 'High attendance'
        WHEN attendance_rate >= 75 THEN 'Moderate attendance'
        ELSE 'Low attendance'
    END AS attendance_segment,
    COUNT(*) AS student_count,
    ROUND(AVG(final_exam_score), 2) AS avg_final_exam_score
FROM student_learning
GROUP BY attendance_segment
ORDER BY avg_final_exam_score DESC;

-- Compare performance by gender
SELECT
    gender,
    COUNT(*) AS student_count,
    ROUND(AVG(study_hours_per_week), 2) AS avg_study_hours,
    ROUND(AVG(final_exam_score), 2) AS avg_final_exam_score
FROM student_learning
GROUP BY gender;

-- Identify students who may need academic support
SELECT
    student_id,
    student_name,
    attendance_rate,
    study_hours_per_week,
    final_exam_score,
    final_grade
FROM student_learning
WHERE attendance_rate < 75
   OR study_hours_per_week < 8
   OR final_exam_score < 70
ORDER BY final_exam_score ASC;
