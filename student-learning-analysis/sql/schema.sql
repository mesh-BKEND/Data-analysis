CREATE TABLE student_learning (
    student_id INTEGER PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    gender CHAR(1),
    age INTEGER,
    attendance_rate DECIMAL(5,2),
    study_hours_per_week DECIMAL(5,2),
    assignment_score DECIMAL(5,2),
    midterm_score DECIMAL(5,2),
    final_exam_score DECIMAL(5,2),
    final_grade CHAR(1)
);

-- Example import command syntax varies by database.
-- PostgreSQL example:
-- COPY student_learning
-- FROM '/path/to/stat1_sample.csv'
-- DELIMITER ','
-- CSV HEADER;
