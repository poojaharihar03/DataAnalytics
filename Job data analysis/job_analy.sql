-- Calculate the number of jobs reviewed per hour per day for November 2020
SELECT ds,count(DISTINCT job_id)*3600/sum(time_spent) as reviewed
from job_data
where ds between '2020-11-01' and '2020-11-30' group by ds;


select ds,count(job_id) as jobs, (time_spent) as total_time 
from job_data
where ds between '2020-11-01' and '2020-11-30' 
group by language;

-- 
select language, count(language) * 100.0 / (select count(*) from job_data)
from job_data
group by language;

--  How will you display duplicates from the table?
SELECT *FROM
(
select *, ROW_NUMBER() over (partition by job_id) as rowcount
from job_data)d
where rowcount>1;


-- Your task: Let’s say the above  metric is called throughput.
-- Calculate 7 day rolling average of throughput? For throughput, do you prefer daily metric or 7-day rolling and why?
select ds,jobs_rev, avg(jobs_rev) over(order by ds rows between 6 preceding and current row) as throughput
from
(SELECT ds,count(DISTINCT job_id) as jobs_rev from job_data
where ds between '2020-11-01' and '2020-11-30' GROUP BY ds order by ds)a;