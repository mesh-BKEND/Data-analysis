-- Overall class performance
SELECT
    COUNT(*) AS total_students,
    ROUND(AVG(attendance_rate), 2) AS avg_attendance_rate,
    ROUND(AVG(study_hours_per_week), 2) AS avg_study_hours,
    ROUND(AVG(final_exam_score), 2) AS avg_final_exam_score
FROM student_learning;

-- Average scores by final grade
SELECT
    final_grade,
    COUNT(*) AS student_count,
    ROUND(AVG(assignment_score), 2) AS avg_assignment_score,
    ROUND(AVG(midterm_score), 2) AS avg_midterm_score,
    ROUND(AVG(final_exam_score), 2) AS avg_final_exam_score
FROM student_learning
GROUP BY final_grade
ORDER BY final_grade;

-- Students with low attendance
SELECT
    student_id,
    student_name,
    attendance_rate,
    final_grade
FROM student_learning
WHERE attendance_rate < 75
ORDER BY attendance_rate ASC;

-- Relationship between study hours and exam performance
SELECT
    student_id,
    student_name,
    study_hours_per_week,
    final_exam_score
FROM student_learning
ORDER BY study_hours_per_week DESC;
