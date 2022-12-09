-- Returns first 100 rows from tutorial.yammer_emails
  SELECT * FROM tutorial.yammer_emails LIMIT 100;

-- Returns first 100 rows from tutorial.yammer_users
  SELECT * FROM tutorial.yammer_users LIMIT 100;

/*
yammer_users - gives user level data
yammer_event - event level data
yammer_email - gives email data
*/
--Question -1 measure weekly user engagement
select extract(week from b.occurred_At)as weeknum,
COUNT(distinct user_id) from tutorial.yammer_events b 
group by weeknum

--question 2 - user growth(no of active users per week) for a product calculate the growth 
select weeknum,num_users,sum(num_users) over(order by weeknum rows between unbounded preceding and current row)from
(select extract(year from a.activated_at)||'-'||extract(week from a.activated_at)as weeknum,COUNT(distinct user_id) as num_users 
from tutorial.yammer_users a
where state='active' 
GROUP by weeknum)a

select extract (year from occurred_at),extract (week from occurred_at), device,count(distinct user_id)
from tutorial.yammer_events
where event_type='engagement'
group by 1,2,3 order by 1,2,3


SELECT
100.0 *SUM(CASE WHEN email_cate = 'email_open' THEN 1 ELSE 0 END)/SUM(CASE WHEN email_cate = 'email_sent' THEN 1 ELSE 0 END) AS email_open_rate, 
100.0 *SUM(CASE WHEN email_cate = 'email_clicked' THEN 1 ELSE 0 END)/SUM(CASE WHEN email_cate = 'email_sent' THEN 1 ELSE 0 END) AS email_clicked_rate
FROM ( SELECT *, 
CASE WHEN action IN ('sent_weekly_digest', 'sent_reengagement_email') 
THEN 'email_sent' WHEN action IN ('email_open')
THEN 'email_open' WHEN action in ('email_clickthrough') THEN 'email_clicked' 
END AS email_cate FROM tutorial.yammer_emails ) a