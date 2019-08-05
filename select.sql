# 1.查询同时存在1课程和2课程的情况
select studentId from student_course where courseId=1 and studentId in 
(select studentId from student_course where courseId=2);

# 2.查询同时存在1课程和2课程的情况
select studentId from student_course where courseId=1 and studentId in 
(select studentId from student_course where courseId=2);

# 3.查询平均成绩大于等于60分的同学的学生编号和学生姓名和平均成绩
select
    b.id,
    b.name,
    round(avg(a.score), 2) as avg_score
from
    student b
join student_course a on
    b.id = a.studentId
group by
    b.id,
    b.name
having
    round(avg(a.score), 2)>= 60;

# 4.查询在student_course表中不存在成绩的学生信息的SQL语句
select a.ID , a.name
from student a left join student_course b
on a.ID = b.studentId
group by a.id , a.name
having isnull(cast(avg(b.score) as decimal(18,2)))
order by a.ID;

# 5.查询所有有成绩的SQL
select a.ID , a.name, cast(avg(b.score) as decimal(18,2)) avg
from student a left join student_course b
on a.ID = b.studentId
group by a.id , a.name
having cast(avg(b.score) as decimal(18,2))
order by a.ID;

# 6.查询学过编号为1并且也学过编号为2的课程的同学的信息
select student.* from student,student_course where courseId=1 and student.id = student_course.studentId and student_course.studentId in 
(select studentId from student_course where courseId=2);

# 7.检索1课程分数小于60，按分数降序排列的学生信息
select s.*, c.score from student s, student_course c where s.id = c.studentId and c.courseId=1 and c.score<60 order by c.score desc;

# 8.查询每门课程的平均成绩，结果按平均成绩降序排列，平均成绩相同时，按课程编号升序排列
select  cast(avg(sc.score) as decimal(18,2)) avg, c.name, c.id  from course c, student s, student_course sc
where c.id = sc.courseId and s.id = sc.studentId
group by c.id, c.name
order by avg(sc.score) desc,c.id desc;
# 9.查询课程名称为"数学"，且分数低于60的学生姓名和分数
select s.name, sc.score from student s, student_course sc, course c
where c.name='数学' and c.id=sc.courseId and s.id=sc.studentId and sc.score<60;