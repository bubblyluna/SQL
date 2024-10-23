#########################################################################################################################
#题目：现在运营想查看每个学校用户的平均发贴和回帖情况，寻找低活跃度学校进行重点运营，请取出平均发贴数低于5的学校或平均回帖数小于20的学校。
##########################################################################################################################
drop table if exists user_profile;
CREATE TABLE `user_profile` (
`id` int NOT NULL,
`device_id` int NOT NULL,
`gender` varchar(14) NOT NULL,
`age` int ,
`university` varchar(32) NOT NULL,
`gpa` float,
`active_days_within_30` int ,
`question_cnt` float,
`answer_cnt` float
);
INSERT INTO user_profile VALUES(1,2138,'male',21,'北京大学',3.4,7,2,12);
INSERT INTO user_profile VALUES(2,3214,'male',null,'复旦大学',4.0,15,5,25);
INSERT INTO user_profile VALUES(3,6543,'female',20,'北京大学',3.2,12,3,30);
INSERT INTO user_profile VALUES(4,2315,'female',23,'浙江大学',3.6,5,1,2);
INSERT INTO user_profile VALUES(5,5432,'male',25,'山东大学',3.8,20,15,70);
INSERT INTO user_profile VALUES(6,2131,'male',28,'山东大学',3.3,15,7,13);
INSERT INTO user_profile VALUES(7,4321,'male',28,'复旦大学',3.6,9,6,52);
select university,avg(question_cnt) as 'avg_question_cnt',avg(answer_cnt) as 'avg_answer_cnt'
from user_profile group by university
having  avg(question_cnt)<5 or avg(answer_cnt)<20;
#having和where的区别，having后可加聚合函数
#having为过滤声明而where为约束声明，且having可以加聚合函数一般配合groupby一起使用





############################################################################################################################
#题目：现在运营想要查看用户在某天刷题后第二天还会再来刷题的平均概率。请你取出相应数据。
############################建表##############################################################################################
drop table if exists `user_profile`;
drop table if  exists `question_practice_detail`;
drop table if  exists `question_detail`;
CREATE TABLE `user_profile` (
`id` int NOT NULL,
`device_id` int NOT NULL,
`gender` varchar(14) NOT NULL,
`age` int ,
`university` varchar(32) NOT NULL,
`gpa` float,
`active_days_within_30` int ,
`question_cnt` int ,
`answer_cnt` int
);
CREATE TABLE `question_practice_detail` (
`id` int NOT NULL,
`device_id` int NOT NULL,
`question_id`int NOT NULL,
`result` varchar(32) NOT NULL,
`date` date NOT NULL
);
CREATE TABLE `question_detail` (
`id` int NOT NULL,
`question_id`int NOT NULL,
`difficult_level` varchar(32) NOT NULL
);

INSERT INTO user_profile VALUES(1,2138,'male',21,'北京大学',3.4,7,2,12);
INSERT INTO user_profile VALUES(2,3214,'male',null,'复旦大学',4.0,15,5,25);
INSERT INTO user_profile VALUES(3,6543,'female',20,'北京大学',3.2,12,3,30);
INSERT INTO user_profile VALUES(4,2315,'female',23,'浙江大学',3.6,5,1,2);
INSERT INTO user_profile VALUES(5,5432,'male',25,'山东大学',3.8,20,15,70);
INSERT INTO user_profile VALUES(6,2131,'male',28,'山东大学',3.3,15,7,13);
INSERT INTO user_profile VALUES(7,4321,'male',28,'复旦大学',3.6,9,6,52);
INSERT INTO question_practice_detail VALUES(1,2138,111,'wrong','2021-05-03');
INSERT INTO question_practice_detail VALUES(2,3214,112,'wrong','2021-05-09');
INSERT INTO question_practice_detail VALUES(3,3214,113,'wrong','2021-06-15');
INSERT INTO question_practice_detail VALUES(4,6543,111,'right','2021-08-13');
INSERT INTO question_practice_detail VALUES(5,2315,115,'right','2021-08-13');
INSERT INTO question_practice_detail VALUES(6,2315,116,'right','2021-08-14');
INSERT INTO question_practice_detail VALUES(7,2315,117,'wrong','2021-08-15');
INSERT INTO question_practice_detail VALUES(8,3214,112,'wrong','2021-05-09');
INSERT INTO question_practice_detail VALUES(9,3214,113,'wrong','2021-08-15');
INSERT INTO question_practice_detail VALUES(10,6543,111,'right','2021-08-13');
INSERT INTO question_practice_detail VALUES(11,2315,115,'right','2021-08-13');
INSERT INTO question_practice_detail VALUES(12,2315,116,'right','2021-08-14');
INSERT INTO question_practice_detail VALUES(13,2315,117,'wrong','2021-08-15');
INSERT INTO question_practice_detail VALUES(14,3214,112,'wrong','2021-08-16');
INSERT INTO question_practice_detail VALUES(15,3214,113,'wrong','2021-08-18');
INSERT INTO question_practice_detail VALUES(16,6543,111,'right','2021-08-13');
INSERT INTO question_detail VALUES(1,111,'hard');
INSERT INTO question_detail VALUES(2,112,'medium');
INSERT INTO question_detail VALUES(3,113,'easy');
INSERT INTO question_detail VALUES(4,115,'easy');
INSERT INTO question_detail VALUES(5,116,'medium');
INSERT INTO question_detail VALUES(6,117,'easy');

with user as (
    select distinct
    device_id,
    date as 'current'
    from question_practice_detail
    ),
user_que as(
select
    distinct
    a.device_id,
    a.current as'current_day',
    b.date as'next_day'
    from user a
left join question_practice_detail b
on a.device_id=b.device_id and datediff(b.date,a.current)=1)
select AVG(
    CASE
        WHEN DATEDIFF(next_day, current_day) = 1
        THEN 1
        ELSE 0
    END
) AS avg_ret
FROM user_que;

SELECT COUNT(distinct q2.device_id,q2.date)/count(DISTINCT q1.device_id,q1.date) as avg_ret
from question_practice_detail as q1 left outer join question_practice_detail as q2
on q1.device_id=q2.device_id and DATEDIFF(q2.date,q1.date)=1;






############################################################################################################################
#题目：现在运营举办了一场比赛，收到了一些参赛申请，表数据记录形式如下所示，现在运营想要统计每个性别的用户分别有多少参赛者，请取出相应结果
############################建表##############################################################################################
drop table if exists user_submit;
CREATE TABLE `user_submit` (
`id` int NOT NULL,
`device_id` int NOT NULL,
`profile` varchar(100) NOT NULL,
`blog_url` varchar(100) NOT NULL
);
INSERT INTO user_submit VALUES(1,2138,'180cm,75kg,27,male','http:/url/bisdgboy777');
INSERT INTO user_submit VALUES(1,3214,'165cm,45kg,26,female','http:/url/dkittycc');
INSERT INTO user_submit VALUES(1,6543,'178cm,65kg,25,male','http:/url/tigaer');
INSERT INTO user_submit VALUES(1,4321,'171cm,55kg,23,female','http:/url/uhsksd');
INSERT INTO user_submit VALUES(1,2131,'168cm,45kg,22,female','http:/url/sysdney');
################################
SELECT
    CASE
        WHEN profile LIKE '%,male%' THEN 'male'
        WHEN profile LIKE '%,female%' THEN 'female'
    END AS gender,
    COUNT(*) AS number
FROM user_submit
GROUP BY gender;

select substring_index(profile,',',-1) as gender,count(device_id)
from user_submit
group by gender;
#1、LOCATE(substr , str )：返回子串 substr 在字符串 str 中第一次出现的位置，如果字符substr在字符串str中不存在，则返回0；
#2、POSITION(substr  IN str )：返回子串 substr 在字符串 str 中第一次出现的位置，如果字符substr在字符串str中不存在，与LOCATE函数作用相同；
#3、LEFT(str, length)：从左边开始截取str，length是截取的长度；
#4、RIGHT(str, length)：从右边开始截取str，length是截取的长度；
#5、SUBSTRING_INDEX(str  ,substr  ,n)：返回字符substr在str中第n次出现位置之前的字符串;
#6、SUBSTRING(str  ,n ,m)：返回字符串str从第n个字符截取到第m个字符；
#7、REPLACE(str, n, m)：将字符串str中的n字符替换成m字符；
#8、LENGTH(str)：计算字符串str的长度。
#介绍SUBSTRING_INDEX(str  ,substr  ,n)
#要用到substring_index()这个函数的用法
#substring_index(str,delim,count)
#str:要处理的字符串
# delim:分隔符
#count:计数
#如果count是正数，那么就是从左往右数，第N个分隔符的左边的所有内容
#如果count是负数，那么就是从右往左数，第N个分隔符的右边的所有内容
#一个例子，结果显示wikibt
#str=www.wikibt.com
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX('www.wikibt.com', '.', -2), '.', 1);





##############################################################
#题目：现在运营想要找到每个学校gpa最低的同学来做调研，请你取出每个学校的最低gpa。
##############################################################
drop table if exists user_profile;
CREATE TABLE `user_profile` (
`id` int NOT NULL,
`device_id` int NOT NULL,
`gender` varchar(14) NOT NULL,
`age` int ,
`university` varchar(32) NOT NULL,
`gpa` float,
`active_days_within_30` int ,
`question_cnt` int ,
`answer_cnt` int
);
INSERT INTO user_profile VALUES(1,2138,'male',21,'北京大学',3.4,7,2,12);
INSERT INTO user_profile VALUES(2,3214,'male',null,'复旦大学',4.0,15,5,25);
INSERT INTO user_profile VALUES(3,6543,'female',20,'北京大学',3.2,12,3,30);
INSERT INTO user_profile VALUES(4,2315,'female',23,'浙江大学',3.6,5,1,2);
INSERT INTO user_profile VALUES(5,5432,'male',25,'山东大学',3.8,20,15,70);
INSERT INTO user_profile VALUES(6,2131,'male',28,'山东大学',3.3,15,7,13);
INSERT INTO user_profile VALUES(7,4321,'male',28,'复旦大学',3.6,9,6,52);
select device_id,university,gpa
from user_profile
where (university,gpa) in (
    select university,min(gpa)
    from user_profile
    group by university
    )
order by university;
#这道题的关键在于需要嵌套两个，因为如果像下面的代码
select device_id ,university,min(gpa)
from user_profile
group by university,device_id
order by university;
#就会同时对大学和id进行分组，而不是先后，所以出现两个大学一样的，所以此时就需要使用where语句进行嵌套



##############################################################
#题目： 现在运营想要了解复旦大学的每个用户在8月份练习的总题目数和回答正确的题目数情况，请取出相应明细数据，对于在8月份没有练习过的用户，答题数结果返回0.
##############################################################
drop table if exists `user_profile`;
drop table if  exists `question_practice_detail`;
drop table if  exists `question_detail`;
CREATE TABLE `user_profile` (
`id` int NOT NULL,
`device_id` int NOT NULL,
`gender` varchar(14) NOT NULL,
`age` int ,
`university` varchar(32) NOT NULL,
`gpa` float,
`active_days_within_30` int ,
`question_cnt` int ,
`answer_cnt` int
);
CREATE TABLE `question_practice_detail` (
`id` int NOT NULL,
`device_id` int NOT NULL,
`question_id`int NOT NULL,
`result` varchar(32) NOT NULL,
`date` date NOT NULL
);
CREATE TABLE `question_detail` (
`id` int NOT NULL,
`question_id`int NOT NULL,
`difficult_level` varchar(32) NOT NULL
);

INSERT INTO user_profile VALUES(1,2138,'male',21,'北京大学',3.4,7,2,12);
INSERT INTO user_profile VALUES(2,3214,'male',null,'复旦大学',4.0,15,5,25);
INSERT INTO user_profile VALUES(3,6543,'female',20,'北京大学',3.2,12,3,30);
INSERT INTO user_profile VALUES(4,2315,'female',23,'浙江大学',3.6,5,1,2);
INSERT INTO user_profile VALUES(5,5432,'male',25,'山东大学',3.8,20,15,70);
INSERT INTO user_profile VALUES(6,2131,'male',28,'山东大学',3.3,15,7,13);
INSERT INTO user_profile VALUES(7,4321,'male',28,'复旦大学',3.6,9,6,52);
INSERT INTO question_practice_detail VALUES(1,2138,111,'wrong','2021-05-03');
INSERT INTO question_practice_detail VALUES(2,3214,112,'wrong','2021-05-09');
INSERT INTO question_practice_detail VALUES(3,3214,113,'wrong','2021-06-15');
INSERT INTO question_practice_detail VALUES(4,6543,111,'right','2021-08-13');
INSERT INTO question_practice_detail VALUES(5,2315,115,'right','2021-08-13');
INSERT INTO question_practice_detail VALUES(6,2315,116,'right','2021-08-14');
INSERT INTO question_practice_detail VALUES(7,2315,117,'wrong','2021-08-15');
INSERT INTO question_practice_detail VALUES(8,3214,112,'wrong','2021-05-09');
INSERT INTO question_practice_detail VALUES(9,3214,113,'wrong','2021-08-15');
INSERT INTO question_practice_detail VALUES(10,6543,111,'right','2021-08-13');
INSERT INTO question_practice_detail VALUES(11,2315,115,'right','2021-08-13');
INSERT INTO question_practice_detail VALUES(12,2315,116,'right','2021-08-14');
INSERT INTO question_practice_detail VALUES(13,2315,117,'wrong','2021-08-15');
INSERT INTO question_practice_detail VALUES(14,3214,112,'wrong','2021-08-16');
INSERT INTO question_practice_detail VALUES(15,3214,113,'wrong','2021-08-18');
INSERT INTO question_practice_detail VALUES(16,6543,111,'right','2021-08-13');
INSERT INTO question_detail VALUES(1,111,'hard');
INSERT INTO question_detail VALUES(2,112,'medium');
INSERT INTO question_detail VALUES(3,113,'easy');
INSERT INTO question_detail VALUES(4,115,'easy');
INSERT INTO question_detail VALUES(5,116,'medium');
INSERT INTO question_detail VALUES(6,117,'easy');

with que as (select
    u.device_id,
    count(q.device_id) as 'question_cnt',
    sum(case
        when q.result='right'
        then 1
        else 0
        end)as 'right_question_cnt'
    from user_profile u
    left join question_practice_detail q
    on month(q.date)=8 and u.device_id=q.device_id
    group by u.device_id)
select u.device_id,
       u.university,
       q.question_cnt,
       q.right_question_cnt
from user_profile u
left join que q
on u.device_id=q.device_id
where u.university='复旦大学';

select
    u.device_id,
    u.university,
    count(q.device_id) as 'question_cnt',
    sum(case
        when q.result='right'
        then 1
        else 0
        end)as 'right_question_cnt'
    from user_profile u
    left join question_practice_detail q
    on month(q.date)=8 and u.device_id=q.device_id
    where u.university='复旦大学'
    group by u.device_id;
#这道题告诉我们 where 和 on其实可以一起用的




##############################################################
#题目：现在运营想要了解浙江大学的用户在不同难度题目下答题的正确率情况，请取出相应数据，并按照准确率升序输出。
##############################################################
drop table if exists `user_profile`;
drop table if  exists `question_practice_detail`;
drop table if  exists `question_detail`;
CREATE TABLE `user_profile` (
`id` int NOT NULL,
`device_id` int NOT NULL,
`gender` varchar(14) NOT NULL,
`age` int ,
`university` varchar(32) NOT NULL,
`gpa` float,
`active_days_within_30` int ,
`question_cnt` int ,
`answer_cnt` int
);
CREATE TABLE `question_practice_detail` (
`id` int NOT NULL,
`device_id` int NOT NULL,
`question_id`int NOT NULL,
`result` varchar(32) NOT NULL,
`date` date NOT NULL
);
CREATE TABLE `question_detail` (
`id` int NOT NULL,
`question_id`int NOT NULL,
`difficult_level` varchar(32) NOT NULL
);

INSERT INTO user_profile VALUES(1,2138,'male',21,'北京大学',3.4,7,2,12);
INSERT INTO user_profile VALUES(2,3214,'male',null,'复旦大学',4.0,15,5,25);
INSERT INTO user_profile VALUES(3,6543,'female',20,'北京大学',3.2,12,3,30);
INSERT INTO user_profile VALUES(4,2315,'female',23,'浙江大学',3.6,5,1,2);
INSERT INTO user_profile VALUES(5,5432,'male',25,'山东大学',3.8,20,15,70);
INSERT INTO user_profile VALUES(6,2131,'male',28,'山东大学',3.3,15,7,13);
INSERT INTO user_profile VALUES(7,4321,'male',28,'复旦大学',3.6,9,6,52);
INSERT INTO question_practice_detail VALUES(1,2138,111,'wrong','2021-05-03');
INSERT INTO question_practice_detail VALUES(2,3214,112,'wrong','2021-05-09');
INSERT INTO question_practice_detail VALUES(3,3214,113,'wrong','2021-06-15');
INSERT INTO question_practice_detail VALUES(4,6543,111,'right','2021-08-13');
INSERT INTO question_practice_detail VALUES(5,2315,115,'right','2021-08-13');
INSERT INTO question_practice_detail VALUES(6,2315,116,'right','2021-08-14');
INSERT INTO question_practice_detail VALUES(7,2315,117,'wrong','2021-08-15');
INSERT INTO question_practice_detail VALUES(8,3214,112,'wrong','2021-05-09');
INSERT INTO question_practice_detail VALUES(9,3214,113,'wrong','2021-08-15');
INSERT INTO question_practice_detail VALUES(10,6543,111,'right','2021-08-13');
INSERT INTO question_practice_detail VALUES(11,2315,115,'right','2021-08-13');
INSERT INTO question_practice_detail VALUES(12,2315,116,'right','2021-08-14');
INSERT INTO question_practice_detail VALUES(13,2315,117,'wrong','2021-08-15');
INSERT INTO question_practice_detail VALUES(14,3214,112,'wrong','2021-08-16');
INSERT INTO question_practice_detail VALUES(15,3214,113,'wrong','2021-08-18');
INSERT INTO question_practice_detail VALUES(16,6543,111,'right','2021-08-13');
INSERT INTO question_detail VALUES(1,111,'hard');
INSERT INTO question_detail VALUES(2,112,'medium');
INSERT INTO question_detail VALUES(3,113,'easy');
INSERT INTO question_detail VALUES(4,115,'easy');
INSERT INTO question_detail VALUES(5,116,'medium');
INSERT INTO question_detail VALUES(6,117,'easy');
#count(q.difficult_level)/sum(case when qd.result='right' then 1 else 0 end)
select
    q.difficult_level,
    sum(case when qd.result='right' then 1 else 0 end) / count(q.difficult_level) as 'correct_rate'
from question_practice_detail qd
join  user_profile u on u.device_id=qd.device_id
join question_detail q on qd.question_id=q.question_id
where u.university='浙江大学'
group by q.difficult_level;





##############################################################
#描述从听歌流水中找到18-25岁用户在2022年每个月播放次数top 3的周杰伦的歌曲
##############################################################
drop table if exists play_log;
create table `play_log` (
    `fdate` date,
    `user_id` int,
    `song_id` int
);
insert into play_log(fdate, user_id, song_id)
values
('2022-01-08', 10000, 0),
('2022-01-16', 10000, 0),
('2022-01-20', 10000, 0),
('2022-01-25', 10000, 0),
('2022-01-02', 10000, 1),
('2022-01-12', 10000, 1),
('2022-01-13', 10000, 1),
('2022-01-14', 10000, 1),
('2022-01-10', 10000, 2),
('2022-01-11', 10000, 3),
('2022-01-16', 10000, 3),
('2022-01-11', 10000, 4),
('2022-01-27', 10000, 4),
('2022-02-05', 10000, 0),
('2022-02-19', 10000, 0),
('2022-02-07', 10000, 1),
('2022-02-27', 10000, 2),
('2022-02-25', 10000, 3),
('2022-02-03', 10000, 4),
('2022-02-16', 10000, 4);

drop table if exists song_info;
create table `song_info` (
    `song_id` int,
    `song_name` varchar(255),
    `singer_name` varchar(255)
);
insert into song_info(song_id, song_name, singer_name)
values
(0, '明明就', '周杰伦'),
(1, '说好的幸福呢', '周杰伦'),
(2, '江南', '林俊杰'),
(3, '大笨钟', '周杰伦'),
(4, '黑键', '林俊杰');

drop table if exists user_info;
create table `user_info` (
    `user_id`   int,
    `age`       int
);
insert into user_info(user_id, age)
values
(10000, 18);

select *
from
(select month(p.fdate) as 'month',
       row_number()over(partition by month(p.fdate) order by count(p.song_id) desc,s.song_id) as 'ranking',
       s.song_name as 'song_name',
       count(p.song_id) as 'play_pv'
from play_log p
left join song_info s
on p.song_id=s.song_id
left join user_info u
on p.user_id=u.user_id
where u.age>=18 and u.age<=25 and year(p.fdate)=2022 and s.singer_name='周杰伦'
group by s.song_id,s.song_name , month
order by month,play_pv desc,ranking) as t1
where ranking<=3;
#
#因为row_number()这种窗口函数是在select阶段执行的，而在select阶段以及之后的只有order by，所以ranking可以在子查询的order by中执行而不能在where中执行
#执行顺序：
#FROM，JOIN
#WHERE 字符串函数（UPPER()、LOWER()）和日期函数（DATE()、NOW()）
#GROUP BY 聚合函数，如 SUM()、AVG()
#HAVING 窗口函数的执行阶段，如 ROW_NUMBER()、RANK()
#SELECT
#ORDER BY
#LIMIT
#常见的窗口函数
#row_number 连续但不重复 1234
#rank 不连续但重复 1224
#dense_rank 连续且重复



##############################################################
#连续登陆天数
##############################################################
drop table if exists tb_dau;
create table `tb_dau` (
    `fdate` date,
    `user_id` int
);
insert into tb_dau(fdate, user_id)
values
('2023-01-01', 10000),
('2023-01-02', 10000),
('2023-01-04', 10000);

select user_id,
       fdate,
       row_number() over(partition by user_id order by fdate) as 'rank'
from tb_dau;

select *,
       date_sub(fdate, interval ranking day) as 'aff_date'
from(select user_id,
       fdate,
       row_number()over(partition by user_id order by fdate) as 'ranking'
    from tb_dau) as t1;

select user_id,
       aff_date,
       count(aff_date) as 'con_date'
from (select *,
       date_sub(fdate, interval ranking day) as 'aff_date'
    from(select user_id,
       fdate,
       row_number()over(partition by user_id order by fdate) as 'ranking'
    from tb_dau) as t1)as t2
group by user_id,aff_date;

select user_id,
       max(con_date)
from(select user_id,
       aff_date,
       count(aff_date) as 'con_date'
from (select *,
       date_sub(fdate, interval ranking day) as 'aff_date'
    from(select user_id,
       fdate,
       row_number()over(partition by user_id order by fdate) as 'ranking'
    from tb_dau) as t1)as t2
group by user_id,aff_date) as t3
group by user_id;

#这道题不错的
#sql其实就是子查询的嵌套，将任务进行分解的过程
#rank是一个函数，不要使用在列名中！


##############################################################
#请根据以上数据分析各还款能力级别的客户逾期情况，按照还款能力级别统计有逾期行为客户占比？
#要求输出还款能力级别、逾期客户占比；
#注：逾期客户占比要求按照百分数形式输出并四舍五入保留 1 位小数，最终结果按照占比降序排序；
##############################################################
drop table if exists  `loan_tb` ;
CREATE TABLE `loan_tb` (
`agreement_id` int(11) NOT NULL,
`customer_id` int(11) NOT NULL,
`loan_amount` int(11) NOT NULL,
`pay_amount` int(11) NOT NULL,
`overdue_days` int(11),
PRIMARY KEY (`agreement_id`));
INSERT INTO loan_tb VALUES(10111,1111,20000,18000,null);
INSERT INTO loan_tb VALUES(10112,1112,10000,10000,null);
INSERT INTO loan_tb VALUES(10113,1113,15000,10000,38);
INSERT INTO loan_tb VALUES(10114,1114,50000,30000,null);
INSERT INTO loan_tb VALUES(10115,1115,60000,50000,null);
INSERT INTO loan_tb VALUES(10116,1116,10000,8000,null);
INSERT INTO loan_tb VALUES(10117,1117,50000,50000,null);
INSERT INTO loan_tb VALUES(10118,1118,25000,10000,5);
INSERT INTO loan_tb VALUES(10119,1119,20000,1000,106);

drop table if exists  `customer_tb` ;
CREATE TABLE `customer_tb` (
`customer_id` int(11) NOT NULL,
`customer_age` int(11) NOT NULL,
`pay_ability` varchar(2) NOT NULL,
PRIMARY KEY (`customer_id`));
INSERT INTO customer_tb VALUES(1111,28,'B');
INSERT INTO customer_tb VALUES(1112,38,'A');
INSERT INTO customer_tb VALUES(1113,20,'C');
INSERT INTO customer_tb VALUES(1114,30,'A');
INSERT INTO customer_tb VALUES(1115,29,'B');
INSERT INTO customer_tb VALUES(1116,21,'C');
INSERT INTO customer_tb VALUES(1117,35,'B');
INSERT INTO customer_tb VALUES(1118,36,'B');
INSERT INTO customer_tb VALUES(1119,25,'C');

select c.pay_ability,
       concat(round(count(l.overdue_days)/count(l.customer_id)*100,1),'%') as 'overdue_ratio'
from loan_tb l
join customer_tb c
on c.customer_id=l.customer_id
group by c.pay_ability
order by overdue_ratio desc;

#非常好的一道题
#concat()字符串粘贴
#round()保留小数函数



##############################################################
#现需要查询 Tom 这个客户在 2023 年每月的消费金额（按月份正序显示）
##############################################################
drop table if exists  `trade` ;
CREATE TABLE `trade` (
`t_id` int(11) NOT NULL,
`t_time` TIMESTAMP NOT NULL,
`t_cus` int(16) NOT NULL,
`t_type` int(2) NOT NULL,
`t_amount` double NOT NULL,
PRIMARY KEY (`t_id`));
INSERT INTO trade VALUES(1,'2022-01-19 03:14:08',101,1,45);
INSERT INTO trade VALUES(2,'2023-02-15 11:22:11',101,1,23.6);
INSERT INTO trade VALUES(3,'2023-03-19 05:33:22',102,0,350);
INSERT INTO trade VALUES(4,'2023-03-21 06:44:09',103,1,16.9);
INSERT INTO trade VALUES(5,'2023-02-21 08:44:09',101,1,26.9);
INSERT INTO trade VALUES(6,'2023-07-07 07:11:45',101,1,1200);
INSERT INTO trade VALUES(7,'2023-07-19 06:04:32',102,1,132.5);
INSERT INTO trade VALUES(8,'2023-09-19 11:23:11',101,1,130.6);
INSERT INTO trade VALUES(9,'2023-10-19 04:32:30',103,1,110);
drop table if exists  `customer` ;
CREATE TABLE `customer` (
`c_id` int(11) NOT NULL,
`c_name` varchar(20) NOT NULL,
PRIMARY KEY (`c_id`));
INSERT INTO customer VALUES(101,'Tom');
INSERT INTO customer VALUES(102,'Ross');
INSERT INTO customer VALUES(103,'Juile');
INSERT INTO customer VALUES(104,'Niki');

select
    concat(year(t.t_time),'-',lpad(month(t.t_time),2,'0')) as 'time',
    sum(t.t_amount) as 'total'
from trade t
left join customer c
on t.t_cus=c.c_id
where c.c_name='Tom' and year(t.t_time)=2023 and t.t_type=1
group by time
order by time;

##############################################################
##############################################################
drop table if exists  `guestroom_tb` ;
CREATE TABLE `guestroom_tb` (
`room_id` int(11) NOT NULL,
`room_type` varchar(16) NOT NULL,
`room_price` int(11) NOT NULL,
PRIMARY KEY (`room_id`));
INSERT INTO guestroom_tb VALUES(1001,'商务标准房',165);
INSERT INTO guestroom_tb VALUES(1002,'家庭套房',376);
INSERT INTO guestroom_tb VALUES(1003,'商务单人房',100);
INSERT INTO guestroom_tb VALUES(1004,'商务单人房',100);
INSERT INTO guestroom_tb VALUES(1005,'商务标准房',165);
INSERT INTO guestroom_tb VALUES(1006,'商务单人房',100);
INSERT INTO guestroom_tb VALUES(1007,'商务标准房',165);
INSERT INTO guestroom_tb VALUES(1008,'家庭套房',365);
INSERT INTO guestroom_tb VALUES(1009,'商务标准房',165);

drop table if exists  `checkin_tb` ;
CREATE TABLE `checkin_tb` (
`info_id` int(11) NOT NULL,
`room_id` int(11) NOT NULL,
`user_id` int(11) NOT NULL,
`checkin_time` datetime NOT NULL,
`checkout_time` datetime NOT NULL,
PRIMARY KEY (`info_id`));
INSERT INTO checkin_tb VALUES(1,1001,201,'2022-06-12 15:00:00','2022-06-13 09:00:00');
INSERT INTO checkin_tb VALUES(2,1001,202,'2022-06-12 15:00:00','2022-06-13 09:00:00');
INSERT INTO checkin_tb VALUES(3,1003,203,'2022-06-12 14:00:00','2022-06-14 08:00:00');
INSERT INTO checkin_tb VALUES(4,1004,204,'2022-06-12 15:00:00','2022-06-13 11:00:00');
INSERT INTO checkin_tb VALUES(5,1007,205,'2022-06-12 16:00:00','2022-06-15 12:00:00');
INSERT INTO checkin_tb VALUES(6,1008,206,'2022-06-12 19:00:00','2022-06-13 12:00:00');
INSERT INTO checkin_tb VALUES(7,1008,207,'2022-06-12 19:00:00','2022-06-13 12:00:00');
INSERT INTO checkin_tb VALUES(8,1009,208,'2022-06-12 20:00:00','2022-06-16 09:00:00');

select
    c.user_id,
    c.room_id,
    g.room_type,
    datediff(c.checkout_time,c.checkin_time) as 'days'
from checkin_tb c
join guestroom_tb g
on g.room_id=c.room_id
order by days;

select * from(
    select
    c.user_id,
    c.room_id,
    g.room_type,
    datediff(c.checkout_time,c.checkin_time) as 'days'
from checkin_tb c
join guestroom_tb g
on g.room_id=c.room_id
order by days,c.room_id,c.user_id desc
             )as t1
where days>1;



##############################################################
##############################################################
drop table if exists  `staff_tb` ;
CREATE TABLE `staff_tb` (
`staff_id` int(11) NOT NULL,
`staff_name` varchar(16) NOT NULL,
`staff_gender` char(8) NOT NULL,
`post` varchar(11) NOT NULL,
`department` varchar(16) NOT NULL,
PRIMARY KEY (`staff_id`));
INSERT INTO staff_tb VALUES(1,'Angus','male','Financial','dep1');
INSERT INTO staff_tb VALUES(2,'Cathy','female','Director','dep1');
INSERT INTO staff_tb VALUES(3,'Aldis','female','Director','dep2');
INSERT INTO staff_tb VALUES(4,'Lawson','male','Engineer','dep1');
INSERT INTO staff_tb VALUES(5,'Carl','male','Engineer','dep2');
INSERT INTO staff_tb VALUES(6,'Ben','male','Engineer','dep1');
INSERT INTO staff_tb VALUES(7,'Rose','female','Financial','dep2');

drop table if exists  `cultivate_tb` ;
CREATE TABLE `cultivate_tb` (
`info_id` int(11) NOT NULL,
`staff_id` int(11) NOT NULL,
`course` varchar(32) NULL,
PRIMARY KEY (`info_id`));
INSERT INTO cultivate_tb VALUES(101,1,'course1,course2');
INSERT INTO cultivate_tb VALUES(102,2,'course2');
INSERT INTO cultivate_tb VALUES(103,3,'course1,course3');
INSERT INTO cultivate_tb VALUES(104,4,'course1,course2,course3');
INSERT INTO cultivate_tb VALUES(105,5,'course3');
INSERT INTO cultivate_tb VALUES(106,6,NULL);
INSERT INTO cultivate_tb VALUES(107,7,'course1,course2');

SELECT sum(COALESCE(LENGTH(c.course) - LENGTH(REPLACE(c.course, ',', '')) + 1, 0)) AS 'course_pv'
FROM staff_tb s
LEFT JOIN cultivate_tb c ON s.staff_id = c.staff_id;

##############################################################
##############################################################
drop table if exists  `staff_tb` ;
CREATE TABLE `staff_tb` (
`staff_id` int(11) NOT NULL,
`staff_name` varchar(16) NOT NULL,
`staff_gender` char(8) NOT NULL,
`post` varchar(11) NOT NULL,
`department` varchar(16) NOT NULL,
PRIMARY KEY (`staff_id`));
INSERT INTO staff_tb VALUES(1,'Angus','male','Financial','dep1');
INSERT INTO staff_tb VALUES(2,'Cathy','female','Director','dep1');
INSERT INTO staff_tb VALUES(3,'Aldis','female','Director','dep2');
INSERT INTO staff_tb VALUES(4,'Lawson','male','Engineer','dep1');
INSERT INTO staff_tb VALUES(5,'Carl','male','Engineer','dep2');
INSERT INTO staff_tb VALUES(6,'Ben','male','Engineer','dep1');
INSERT INTO staff_tb VALUES(7,'Rose','female','Financial','dep2');

drop table if exists  `attendent_tb` ;
CREATE TABLE `attendent_tb` (
`info_id` int(11) NOT NULL,
`staff_id` int(11) NOT NULL,
`first_clockin` datetime NULL,
`last_clockin` datetime NULL,
PRIMARY KEY (`info_id`));
INSERT INTO attendent_tb VALUES(101,1,'2022-03-22 08:00:00','2022-03-22 17:00:00');
INSERT INTO attendent_tb VALUES(102,2,'2022-03-22 08:30:00','2022-03-22 18:00:00');
INSERT INTO attendent_tb VALUES(103,3,'2022-03-22 08:45:00','2022-03-22 17:00:00');
INSERT INTO attendent_tb VALUES(104,4,'2022-03-22 09:00:00','2022-03-22 18:30:00');
INSERT INTO attendent_tb VALUES(105,5,'2022-03-22 09:00:00','2022-03-22 18:10:00');
INSERT INTO attendent_tb VALUES(106,6,'2022-03-22 09:15:00','2022-03-22 19:30:00');
INSERT INTO attendent_tb VALUES(107,7,'2022-03-22 09:30:00','2022-03-22 18:29:00');


SELECT s.post,
       round(avg(timestampdiff(second, a.first_clockin, a.last_clockin)/3600),3) AS 'work_hours'
FROM staff_tb s
JOIN attendent_tb a ON s.staff_id = a.staff_id
WHERE a.first_clockin IS NOT NULL AND a.last_clockin IS NOT NULL
GROUP BY s.post
ORDER BY work_hours desc;


#timestampdiff()函数计算分钟，秒，小时之间的差异,但如果是分钟或者小时，就只会在分钟小时，小时的差异进行计算，而不会在更下一级进行计算


##############################################################
#请你查找employees里最晚入职员工的所有信息
##############################################################
drop table if exists  `employees` ;
CREATE TABLE `employees` (
`emp_no` int(11) NOT NULL,
`birth_date` date NOT NULL,
`first_name` varchar(14) NOT NULL,
`last_name` varchar(16) NOT NULL,
`gender` char(1) NOT NULL,
`hire_date` date NOT NULL,
PRIMARY KEY (`emp_no`));
INSERT INTO employees VALUES(10001,'1953-09-02','Georgi','Facello','M','1986-06-26');
INSERT INTO employees VALUES(10002,'1964-06-02','Bezalel','Simmel','F','1985-11-21');
INSERT INTO employees VALUES(10003,'1959-12-03','Parto','Bamford','M','1986-08-28');
INSERT INTO employees VALUES(10004,'1954-05-01','Chirstian','Koblick','M','1986-12-01');
INSERT INTO employees VALUES(10005,'1955-01-21','Kyoichi','Maliniak','M','1989-09-12');
INSERT INTO employees VALUES(10006,'1953-04-20','Anneke','Preusig','F','1989-06-02');
INSERT INTO employees VALUES(10007,'1957-05-23','Tzvetan','Zielinski','F','1989-02-10');
INSERT INTO employees VALUES(10008,'1958-02-19','Saniya','Kalloufi','M','1994-09-15');
INSERT INTO employees VALUES(10009,'1952-04-19','Sumant','Peac','F','1985-02-18');
INSERT INTO employees VALUES(10010,'1963-06-01','Duangkaew','Piveteau','F','1989-08-24');
INSERT INTO employees VALUES(10011,'1953-11-07','Mary','Sluis','F','1990-01-22');

select * from employees where hire_date=(select max(hire_date) from employees);
#查找最大值

##############################################################
#请你查找employees里入职员工时间排名倒数第三的员工所有信息
##############################################################
drop table if exists  `employees` ;
CREATE TABLE `employees` (
`emp_no` int(11) NOT NULL,
`birth_date` date NOT NULL,
`first_name` varchar(14) NOT NULL,
`last_name` varchar(16) NOT NULL,
`gender` char(1) NOT NULL,
`hire_date` date NOT NULL,
PRIMARY KEY (`emp_no`));
INSERT INTO employees VALUES(10001,'1953-09-02','Georgi','Facello','M','1986-06-26');
INSERT INTO employees VALUES(10002,'1964-06-02','Bezalel','Simmel','F','1985-11-21');
INSERT INTO employees VALUES(10003,'1959-12-03','Parto','Bamford','M','1986-08-28');
INSERT INTO employees VALUES(10004,'1954-05-01','Chirstian','Koblick','M','1986-12-01');
INSERT INTO employees VALUES(10005,'1955-01-21','Kyoichi','Maliniak','M','1989-09-12');
INSERT INTO employees VALUES(10006,'1953-04-20','Anneke','Preusig','F','1989-06-02');
INSERT INTO employees VALUES(10007,'1957-05-23','Tzvetan','Zielinski','F','1989-02-10');
INSERT INTO employees VALUES(10008,'1958-02-19','Saniya','Kalloufi','M','1994-09-15');
INSERT INTO employees VALUES(10009,'1952-04-19','Sumant','Peac','F','1985-02-18');
INSERT INTO employees VALUES(10010,'1963-06-01','Duangkaew','Piveteau','F','1989-08-24');
INSERT INTO employees VALUES(10011,'1953-11-07','Mary','Sluis','F','1990-01-22');

select *,
       dense_rank() over(order by hire_date desc) as'ranking'
from employees;


select emp_no,
birth_date,
first_name,
last_name,
gender,
hire_date
from(select *,
       dense_rank() over(order by hire_date desc) as'ranking'
from employees) as t1
where ranking=3;

##############################################################
#获取每个部门中当前员工薪水最高的相关信息，给出dept_no, emp_no以及其对应的salary，按照部门编号dept_no升序排列
##############################################################
drop table if exists  `dept_emp` ;
drop table if exists  `salaries` ;
CREATE TABLE `dept_emp` (
`emp_no` int(11) NOT NULL,
`dept_no` char(4) NOT NULL,
`from_date` date NOT NULL,
`to_date` date NOT NULL,
PRIMARY KEY (`emp_no`,`dept_no`));
CREATE TABLE `salaries` (
`emp_no` int(11) NOT NULL,
`salary` int(11) NOT NULL,
`from_date` date NOT NULL,
`to_date` date NOT NULL,
PRIMARY KEY (`emp_no`,`from_date`));
INSERT INTO dept_emp VALUES(10001,'d001','1986-06-26','9999-01-01');
INSERT INTO dept_emp VALUES(10002,'d001','1996-08-03','9999-01-01');
INSERT INTO dept_emp VALUES(10003,'d002','1996-08-03','9999-01-01');

INSERT INTO salaries VALUES(10001,88958,'2002-06-22','9999-01-01');
INSERT INTO salaries VALUES(10002,72527,'2001-08-02','9999-01-01');
INSERT INTO salaries VALUES(10003,92527,'2001-08-02','9999-01-01');


select d.dept_no,
    d.emp_no,
    s.salary as 'maxSalary'
from dept_emp d
join salaries s
on d.emp_no=s.emp_no
where (d.dept_no,salary) in (select d.dept_no, max(salary)
from dept_emp d
join salaries s
on d.emp_no=s.emp_no
where d.to_date='9999-01-01' and s.to_date='9999-01-01'
group by d.dept_no)
order by d.dept_no;
#我也不知道为啥是困难，可能要用in和子查询吧
# 查询没有离职的人：where d.to_date="9999-01-01" and s.to_date="9999-01-01"


##############################################################
#SQL212
##############################################################
drop table if exists  `employees` ;
drop table if exists  `salaries` ;
CREATE TABLE `employees` (
`emp_no` int(11) NOT NULL,
`birth_date` date NOT NULL,
`first_name` varchar(14) NOT NULL,
`last_name` varchar(16) NOT NULL,
`gender` char(1) NOT NULL,
`hire_date` date NOT NULL,
PRIMARY KEY (`emp_no`));
CREATE TABLE `salaries` (
`emp_no` int(11) NOT NULL,
`salary` int(11) NOT NULL,
`from_date` date NOT NULL,
`to_date` date NOT NULL,
PRIMARY KEY (`emp_no`,`from_date`));
INSERT INTO employees VALUES(10001,'1953-09-02','Georgi','Facello','M','1986-06-26');
INSERT INTO employees VALUES(10002,'1964-06-02','Bezalel','Simmel','F','1985-11-21');
INSERT INTO employees VALUES(10003,'1959-12-03','Parto','Bamford','M','1986-08-28');
INSERT INTO employees VALUES(10004,'1954-05-01','Chirstian','Koblick','M','1986-12-01');
INSERT INTO salaries VALUES(10001,88958,'2002-06-22','9999-01-01');
INSERT INTO salaries VALUES(10002,72527,'2001-08-02','9999-01-01');
INSERT INTO salaries VALUES(10003,43311,'2001-12-01','9999-01-01');
INSERT INTO salaries VALUES(10004,74057,'2001-11-27','9999-01-01');




##############################################################
#SQL215
##############################################################
drop table if exists  `employees` ;
drop table if exists  `salaries` ;
CREATE TABLE `employees` (
`emp_no` int(11) NOT NULL,
`birth_date` date NOT NULL,
`first_name` varchar(14) NOT NULL,
`last_name` varchar(16) NOT NULL,
`gender` char(1) NOT NULL,
`hire_date` date NOT NULL,
PRIMARY KEY (`emp_no`));
CREATE TABLE `salaries` (
`emp_no` int(11) NOT NULL,
`salary` int(11) NOT NULL,
`from_date` date NOT NULL,
`to_date` date NOT NULL,
PRIMARY KEY (`emp_no`,`from_date`));
INSERT INTO employees VALUES(10001,'1953-09-02','Georgi','Facello','M','2001-06-22');
INSERT INTO employees VALUES(10002,'1964-06-02','Bezalel','Simmel','F','1999-08-03');
INSERT INTO salaries VALUES(10001,85097,'2001-06-22','2002-06-22');
INSERT INTO salaries VALUES(10001,88958,'2002-06-22','9999-01-01');
INSERT INTO salaries VALUES(10002,72527,'1999-08-03','2000-08-02');
INSERT INTO salaries VALUES(10002,72527,'2000-08-02','2001-08-02');

select e.emp_no, j.salary - s.salary as growth
from employees e
join salaries s on e.emp_no = s.emp_no and e.hire_date = s.from_date
join salaries j on e.emp_no = j.emp_no and j.to_date = '9999-01-01'
order by growth;



##############################################################
#SQL229
#SQL230
#SQL231
#SQL232
#索引：一般而言：使用where语句时dbms会直接搜索整张表，但是如果使用索引，那么就会直接搜索指定列
#唯一索引：某列所有的值都是不相同的
#强制索引：索引过多时使用强制索引来强制搜索某列
##############################################################

##############################################################
#SQL236 删除emp_no重复的记录，只保留最小的id对应的记录。
##############################################################
drop table if exists titles_test;
CREATE TABLE titles_test (
   id int(11) not null primary key,
   emp_no  int(11) NOT NULL,
   title  varchar(50) NOT NULL,
   from_date  date NOT NULL,
   to_date  date DEFAULT NULL);

insert into titles_test values
('1', '10001', 'Senior Engineer', '1986-06-26', '9999-01-01'),
('2', '10002', 'Staff', '1996-08-03', '9999-01-01'),
('3', '10003', 'Senior Engineer', '1995-12-03', '9999-01-01'),
('4', '10004', 'Senior Engineer', '1995-12-03', '9999-01-01'),
('5', '10001', 'Senior Engineer', '1986-06-26', '9999-01-01'),
('6', '10002', 'Staff', '1996-08-03', '9999-01-01'),
('7', '10003', 'Senior Engineer', '1995-12-03', '9999-01-01');

DELETE FROM titles_test WHERE id NOT IN
(SELECT min_id FROM (select min(id) as min_id from titles_test group by emp_no) as t1);

#这道题重要的是dml语句是不允许子查询中的from来自要进行操作的表的所以要在from再嵌套一层子查询，这样就是select from （select），是dql的子查询而不是dml的

##########################################################
#SQL237
#SQL238
##########################################################
#REPLACE INTO 会删除并重新插入数据，可能会触发删除和插入的触发器。
#UPDATE 仅修改现有数据，不会插入新行。
#REPLACE INTO 可能会影响到外键约束，而 UPDATE 不会。

##########################################################
#SQL242
##########################################################

##########################################################
#计算某个字符串出现次数例题为逗号
##########################################################
drop table if exists strings;
CREATE TABLE strings(
   id int(5)  NOT NULL PRIMARY KEY,
   string  varchar(45) NOT NULL
 );
insert into strings values
(1, '10,A,B'),
(2, 'A,B,C,D'),
(3, 'A,11,B,C,D,E');

SELECT id,
LENGTH(string)-LENGTH(replace(string,',',''))
FROM strings;

##########################################################
#请你将employees中的first_name，并按照first_name最后两个字母升序进行输出
##########################################################

drop table if exists  `employees` ;
CREATE TABLE `employees` (
  `emp_no` int(11) NOT NULL,
  `birth_date` date NOT NULL,
  `first_name` varchar(14) NOT NULL,
  `last_name` varchar(16) NOT NULL,
  `gender` char(1) NOT NULL,
  `hire_date` date NOT NULL,
  PRIMARY KEY (`emp_no`));
INSERT INTO employees VALUES(10001,'1953-09-02','Georgi','Facello','M','1986-06-26');
INSERT INTO employees VALUES(10002,'1964-06-02','Bezalel','Simmel','F','1985-11-21');
INSERT INTO employees VALUES(10003,'1959-12-03','Parto','Bamford','M','1986-08-28');
INSERT INTO employees VALUES(10004,'1954-05-01','Chirstian','Koblick','M','1986-12-01');
INSERT INTO employees VALUES(10005,'1955-01-21','Kyoichi','Maliniak','M','1989-09-12');
INSERT INTO employees VALUES(10006,'1953-04-20','Anneke','Preusig','F','1989-06-02');
INSERT INTO employees VALUES(10007,'1957-05-23','Tzvetan','Zielinski','F','1989-02-10');
INSERT INTO employees VALUES(10008,'1958-02-19','Saniya','Kalloufi','M','1994-09-15');
INSERT INTO employees VALUES(10009,'1952-04-19','Sumant','Peac','F','1985-02-18');
INSERT INTO employees VALUES(10010,'1963-06-01','Duangkaew','Piveteau','F','1989-08-24');
INSERT INTO employees VALUES(10011,'1953-11-07','Mary','Sluis','F','1990-01-22');

SELECT first_name
FROM employees
order by SUBSTRING(first_name,LENGTH(first_name)-1, 2);

#这道题的LENGTH(first_name)-1比较巧妙

##########################################################
#按照dept_no进行汇总，属于同一个部门的emp_no按照逗号进行连接，结果给出dept_no以及连接出的结果
##########################################################

drop table if exists  `dept_emp` ;
CREATE TABLE `dept_emp` (
`emp_no` int(11) NOT NULL,
`dept_no` char(4) NOT NULL,
`from_date` date NOT NULL,
`to_date` date NOT NULL,
PRIMARY KEY (`emp_no`,`dept_no`));
INSERT INTO dept_emp VALUES(10001,'d001','1986-06-26','9999-01-01');
INSERT INTO dept_emp VALUES(10002,'d001','1996-08-03','9999-01-01');
INSERT INTO dept_emp VALUES(10003,'d004','1995-12-03','9999-01-01');
INSERT INTO dept_emp VALUES(10004,'d004','1986-12-01','9999-01-01');
INSERT INTO dept_emp VALUES(10005,'d003','1989-09-12','9999-01-01');
INSERT INTO dept_emp VALUES(10006,'d002','1990-08-05','9999-01-01');
INSERT INTO dept_emp VALUES(10007,'d005','1989-02-10','9999-01-01');
INSERT INTO dept_emp VALUES(10008,'d005','1998-03-11','2000-07-31');
INSERT INTO dept_emp VALUES(10009,'d006','1985-02-18','9999-01-01');
INSERT INTO dept_emp VALUES(10010,'d005','1996-11-24','2000-06-26');
INSERT INTO dept_emp VALUES(10010,'d006','2000-06-26','9999-01-01');

SELECT dept_no,
GROUP_CONCAT(emp_no) employees
FROM dept_emp
GROUP BY dept_no;

#记录group_concat的用法

##########################################################
#查找排除在职(to_date = '9999-01-01' )员工的最大、最小salary之后，其他的在职员工的平均工资avg_salary
##########################################################

drop table if exists  `salaries` ;
CREATE TABLE `salaries` (
`emp_no` int(11) NOT NULL,
`salary` float(11,3) NOT NULL,
`from_date` date NOT NULL,
`to_date` date NOT NULL,
PRIMARY KEY (`emp_no`,`from_date`));
INSERT INTO salaries VALUES(10001,85097,'2001-06-22','2002-06-22');
INSERT INTO salaries VALUES(10001,88958,'2002-06-22','9999-01-01');
INSERT INTO salaries VALUES(10002,72527,'2001-08-02','9999-01-01');
INSERT INTO salaries VALUES(10003,43699,'2000-12-01','2001-12-01');
INSERT INTO salaries VALUES(10003,43311,'2001-12-01','9999-01-01');
INSERT INTO salaries VALUES(10004,70698,'2000-11-27','2001-11-27');
INSERT INTO salaries VALUES(10004,74057,'2001-11-27','9999-01-01');

SELECT AVG(salary)
FROM salaries
WHERE to_date= '9999-01-01' and
salary not in (SELECT max(salary) FROM salaries Where to_date= '9999-01-01') and
salary not in (SELECT min(salary) FROM salaries Where to_date= '9999-01-01');

###########################################################
drop table if exists employees;
drop table if exists dept_emp;
CREATE TABLE `employees` (
  `emp_no` int(11) NOT NULL,
  `birth_date` date NOT NULL,
  `first_name` varchar(14) NOT NULL,
  `last_name` varchar(16) NOT NULL,
  `gender` char(1) NOT NULL,
  `hire_date` date NOT NULL,
  PRIMARY KEY (`emp_no`));
CREATE TABLE `dept_emp` (
`emp_no` int(11) NOT NULL,
`dept_no` char(4) NOT NULL,
`from_date` date NOT NULL,
`to_date` date NOT NULL,
PRIMARY KEY (`emp_no`,`dept_no`));
INSERT INTO employees VALUES(10001,'1953-09-02','Georgi','Facello','M','1986-06-26');
INSERT INTO employees VALUES(10002,'1964-06-02','Bezalel','Simmel','F','1985-11-21');
INSERT INTO employees VALUES(10003,'1959-12-03','Parto','Bamford','M','1986-08-28');
INSERT INTO employees VALUES(10004,'1954-05-01','Chirstian','Koblick','M','1986-12-01');
INSERT INTO employees VALUES(10005,'1955-01-21','Kyoichi','Maliniak','M','1989-09-12');
INSERT INTO employees VALUES(10006,'1953-04-20','Anneke','Preusig','F','1989-06-02');
INSERT INTO employees VALUES(10007,'1957-05-23','Tzvetan','Zielinski','F','1989-02-10');
INSERT INTO employees VALUES(10008,'1958-02-19','Saniya','Kalloufi','M','1994-09-15');
INSERT INTO employees VALUES(10009,'1952-04-19','Sumant','Peac','F','1985-02-18');
INSERT INTO employees VALUES(10010,'1963-06-01','Duangkaew','Piveteau','F','1989-08-24');
INSERT INTO employees VALUES(10011,'1953-11-07','Mary','Sluis','F','1990-01-22');
INSERT INTO dept_emp VALUES(10001,'d001','1986-06-26','9999-01-01');
INSERT INTO dept_emp VALUES(10002,'d001','1996-08-03','9999-01-01');
INSERT INTO dept_emp VALUES(10003,'d004','1995-12-03','9999-01-01');
INSERT INTO dept_emp VALUES(10004,'d004','1986-12-01','9999-01-01');
INSERT INTO dept_emp VALUES(10005,'d003','1989-09-12','9999-01-01');
INSERT INTO dept_emp VALUES(10006,'d002','1990-08-05','9999-01-01');
INSERT INTO dept_emp VALUES(10007,'d005','1989-02-10','9999-01-01');
INSERT INTO dept_emp VALUES(10008,'d005','1998-03-11','2000-07-31');
INSERT INTO dept_emp VALUES(10009,'d006','1985-02-18','9999-01-01');
INSERT INTO dept_emp VALUES(10010,'d005','1996-11-24','2000-06-26');
INSERT INTO dept_emp VALUES(10010,'d006','2000-06-26','9999-01-01');

SELECT e.* from employees e
left join dept_emp d
on e.emp_no=d.emp_no
where d.dept_no is null;

###########################################################
#SQL251 使用含有关键字exists查找未分配具体部门的员工的所有信息。
###########################################################

###########################################################
#SQL262-264 留存率
###########################################################
drop table if exists login;
CREATE TABLE `login` (
`id` int(4) NOT NULL,
`user_id` int(4) NOT NULL,
`client_id` int(4) NOT NULL,
`date` date NOT NULL,
PRIMARY KEY (`id`));

INSERT INTO login VALUES
(1,2,1,'2020-10-12'),
(2,3,2,'2020-10-12'),
(3,1,2,'2020-10-12'),
(4,2,2,'2020-10-13'),
(5,4,1,'2020-10-13'),
(6,1,2,'2020-10-13'),
(7,1,2,'2020-10-14');

SELECT ROUND(COUNT(l2.date)/COUNT(l1.id),3) 'p'
FROM login l1
LEFT JOIN login l2
ON l1.user_id=l2.user_id AND DATEDIFF(l2.date,l1.date)=1
WHERE (l1.user_id,l1.date) IN (SELECT user_id,min(date) FROM login GROUP BY user_id);

###########################################################
#SQL263  统计一下牛客每个日期登录新用户个数
###########################################################
drop table if exists login;
CREATE TABLE `login` (
`id` int(4) NOT NULL,
`user_id` int(4) NOT NULL,
`client_id` int(4) NOT NULL,
`date` date NOT NULL,
PRIMARY KEY (`id`));

INSERT INTO login VALUES
(1,2,1,'2020-10-12'),
(2,3,2,'2020-10-12'),
(3,1,2,'2020-10-12'),
(4,2,2,'2020-10-13'),
(5,1,2,'2020-10-13'),
(6,3,1,'2020-10-14'),
(7,4,1,'2020-10-14'),
(8,4,1,'2020-10-15');

SELECT date,
       SUM(CASE WHEN ranking=1 THEN  1 ELSE 0 END) 'new'
FROM (SELECT *,
             ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY date) 'ranking'
      FROM login)AS t1
GROUP BY date;



drop table if exists login;
CREATE TABLE `login` (
`id` int(4) NOT NULL,
`user_id` int(4) NOT NULL,
`client_id` int(4) NOT NULL,
`date` date NOT NULL,
PRIMARY KEY (`id`));

INSERT INTO login VALUES
(1,2,1,'2020-10-12'),
(2,3,2,'2020-10-12'),
(3,1,2,'2020-10-12'),
(4,2,2,'2020-10-13'),
(5,1,2,'2020-10-13'),
(6,3,1,'2020-10-14'),
(7,4,1,'2020-10-14'),
(8,4,1,'2020-10-15');

SELECT ROUND(COUNT(l2.date)/COUNT(l1.id),3) 'p'
FROM login l1
LEFT JOIN login l2
ON l1.user_id=l2.user_id AND DATEDIFF(l2.date,l1.date)=1
WHERE (l1.user_id,l1.date) IN (SELECT user_id,min(date) FROM login GROUP BY user_id);

drop table if exists login;
CREATE TABLE `login` (
`id` int(4) NOT NULL,
`user_id` int(4) NOT NULL,
`client_id` int(4) NOT NULL,
`date` date NOT NULL,
PRIMARY KEY (`id`));

INSERT INTO login VALUES
(1,2,1,'2020-10-12'),
(2,3,2,'2020-10-12'),
(3,1,2,'2020-10-12'),
(4,2,2,'2020-10-13'),
(5,1,2,'2020-10-13'),
(6,3,1,'2020-10-14'),
(7,4,1,'2020-10-14'),
(8,4,1,'2020-10-15');

drop table if exists login;
CREATE TABLE `login` (
`id` int(4) NOT NULL,
`user_id` int(4) NOT NULL,
`client_id` int(4) NOT NULL,
`date` date NOT NULL,
PRIMARY KEY (`id`));

INSERT INTO login VALUES
(1,2,1,'2020-10-12'),
(2,3,2,'2020-10-12'),
(3,1,2,'2020-10-12'),
(4,2,2,'2020-10-13'),
(5,1,2,'2020-10-13'),
(6,3,1,'2020-10-14'),
(7,4,1,'2020-10-14'),
(8,4,1,'2020-10-15');

SELECT *
FROM login
WHERE (user_id,date) in (SELECT user_id,MIN(date) FROM login GROUP BY user_id);

SELECT l1.date,
       SUM(CASE WHEN l2.date IS NULL THEN 0 ELSE 1 END) as 'new'
FROM login l1
LEFT JOIN login l2
on l1.user_id=l2.user_id AND l1.date=l2.date
AND (l1.user_id,l1.date) IN (SELECT user_id,MIN(date) FROM login GROUP BY user_id)
GROUP BY date;


drop table if exists login;
CREATE TABLE `login` (
`id` int(4) NOT NULL,
`user_id` int(4) NOT NULL,
`client_id` int(4) NOT NULL,
`date` date NOT NULL,
PRIMARY KEY (`id`));

INSERT INTO `login` (`id`, `user_id`, `client_id`, `date`) VALUES (1, 2, 1, '2020-10-12');
INSERT INTO `login` (`id`, `user_id`, `client_id`, `date`) VALUES (2, 3, 2, '2020-10-12');
INSERT INTO `login` (`id`, `user_id`, `client_id`, `date`) VALUES (3, 1, 2, '2020-10-12');
INSERT INTO `login` (`id`, `user_id`, `client_id`, `date`) VALUES (4, 2, 2, '2020-10-13');
INSERT INTO `login` (`id`, `user_id`, `client_id`, `date`) VALUES (5, 1, 2, '2020-10-13');
INSERT INTO `login` (`id`, `user_id`, `client_id`, `date`) VALUES (6, 5, 2, '2020-10-13');
INSERT INTO `login` (`id`, `user_id`, `client_id`, `date`) VALUES (7, 3, 1, '2020-10-14');
INSERT INTO `login` (`id`, `user_id`, `client_id`, `date`) VALUES (8, 4, 1, '2020-10-14');
INSERT INTO `login` (`id`, `user_id`, `client_id`, `date`) VALUES (9, 5, 1, '2020-10-14');
INSERT INTO `login` (`id`, `user_id`, `client_id`, `date`) VALUES (10, 1, 1, '2020-10-14');
INSERT INTO `login` (`id`, `user_id`, `client_id`, `date`) VALUES (11, 4, 1, '2020-10-15');

SELECT l1.date 'date',
    ROUND(COUNT(l3.date)/COUNT(l2.date),3) 'p'
FROM login l1
LEFT JOIN login l2
on l1.user_id=l2.user_id AND l1.date=l2.date
LEFT JOIN login l3
on l1.user_id=l3.user_id AND DATEDIFF(l3.date,l1.date)=1
WHERE (l1.user_id,l1.date) IN (SELECT user_id,MIN(date) FROM login GROUP BY user_id)
GROUP BY date
UNION
SELECT date,
       0.000 'p'
FROM login
WHERE date not in (SELECT MIN(date) FROM login GROUP BY user_id)
GROUP BY date
ORDER BY date;

###########################################################
#SQL265 累积的计算方法
###########################################################

drop table if exists login;
drop table if exists passing_number;
drop table if exists user;
drop table if exists client;
CREATE TABLE `login` (
`id` int(4) NOT NULL,
`user_id` int(4) NOT NULL,
`client_id` int(4) NOT NULL,
`date` date NOT NULL,
PRIMARY KEY (`id`));

CREATE TABLE `passing_number` (
`id` int(4) NOT NULL,
`user_id` int(4) NOT NULL,
`number` int(4) NOT NULL,
`date` date NOT NULL,
PRIMARY KEY (`id`));

CREATE TABLE `user` (
`id` int(4) NOT NULL,
`name` varchar(32) NOT NULL,
PRIMARY KEY (`id`));


INSERT INTO login VALUES
(1,2,1,'2020-10-12'),
(2,3,2,'2020-10-12'),
(3,1,2,'2020-10-12'),
(4,1,3,'2020-10-13'),
(5,3,2,'2020-10-13');

INSERT INTO passing_number VALUES
(1,2,4,'2020-10-12'),
(2,3,1,'2020-10-12'),
(3,1,0,'2020-10-13'),
(4,3,2,'2020-10-13');

INSERT INTO user VALUES
(1,'tm'),
(2,'fh'),
(3,'wangchao');

SELECT u.name 'u_n',
    p.date ,
    (SELECT SUM(number) FROM passing_number p1
    WHERE p.user_id=p1.user_id AND p1.date<=p.date) as 'ps_num'
FROM passing_number p
JOIN user u
ON p.user_id=u.id
ORDER BY date, u_n;

###########################################################
#SQL269 中位数向上取整和向下取整
###########################################################
drop table if exists grade;
CREATE TABLE  grade(
`id` int(4) NOT NULL,
`job` varchar(32) NOT NULL,
`score` int(10) NOT NULL,
PRIMARY KEY (`id`));

INSERT INTO grade VALUES
(1,'C++',11001),
(2,'C++',10000),
(3,'C++',9000),
(4,'Java',12000),
(5,'Java',13000),
(6,'B',12000),
(7,'B',11000),
(8,'B',9999);
select job,floor((count(job)+1)/2) as sta,ceiling((count(job)+1)/2) as en
from grade
group by job;



drop table if exists order_info;
CREATE TABLE order_info (
id int(4) NOT NULL,
user_id int(11) NOT NULL,
product_name varchar(256) NOT NULL,
status varchar(32) NOT NULL,
client_id int(4) NOT NULL,
date date NOT NULL,
PRIMARY KEY (id));

INSERT INTO order_info VALUES
(1,557336,'C++','no_completed',1,'2025-10-10'),
(2,230173543,'Python','completed',2,'2025-10-12'),
(3,57,'JS','completed',3,'2025-10-23'),
(4,57,'C++','completed',3,'2025-10-23'),
(5,557336,'Java','completed',1,'2025-10-23'),
(6,57,'Java','completed',1,'2025-10-24'),
(7,557336,'C++','completed',1,'2025-10-25');

SELECT DISTINCT user_id
FROM order_info
WHERE date>'2025-10-15'
AND status='completed'
AND product_name in ('C++','Java','Python')
GROUP BY user_id
HAVING COUNT(*)>=2
ORDER BY user_id;

drop table if exists resume_info;
CREATE TABLE resume_info (
id int(4) NOT NULL,
job varchar(64) NOT NULL,
date date NOT NULL,
num int(11) NOT NULL,
PRIMARY KEY (id));

INSERT INTO resume_info VALUES
(1,'C++','2025-01-02',53),
(2,'Python','2025-01-02',23),
(3,'Java','2025-01-02',12),
(4,'C++','2025-01-03',54),
(5,'Python','2025-01-03',43),
(6,'Java','2025-01-03',41),
(7,'Java','2025-02-03',24),
(8,'C++','2025-02-03',23),
(9,'Python','2025-02-03',34),
(10,'Java','2025-02-04',42),
(11,'C++','2025-02-04',45),
(12,'Python','2025-02-04',59),
(13,'Python','2025-03-04',54),
(14,'C++','2025-03-04',65),
(15,'Java','2025-03-04',92),
(16,'Python','2025-03-05',34),
(17,'C++','2025-03-05',34),
(18,'Java','2025-03-05',34),
(19,'Python','2026-01-04',230),
(20,'C++','2026-02-06',231);

SELECT job,
date_format(date,'%Y-%m') 'mon',
sum(num) 'cnt'
FROM resume_info
WHERE YEAR(date)=2025
GROUP BY job,mon
ORDER BY mon desc, cnt desc;


###########################################################
#SQL282
###########################################################
drop table if exists class_grade;
CREATE TABLE class_grade (
grade varchar(32) NOT NULL,
number int(4) NOT NULL
);

INSERT INTO class_grade VALUES
('A',2),
('C',4),
('B',4),
('D',2);

select grade
            ,(select sum(number) from class_grade) as 'total'
            ,sum(number) over(order by grade) a
            ,sum(number) over(order by grade desc) b
     from class_grade;





drop table if exists resume_info;
CREATE TABLE resume_info (
id int(4) NOT NULL,
job varchar(64) NOT NULL,
date date NOT NULL,
num int(11) NOT NULL,
PRIMARY KEY (id));

INSERT INTO resume_info VALUES
(1,'C++','2025-01-02',53),
(2,'Python','2025-01-02',23),
(3,'Java','2025-01-02',12),
(4,'C++','2025-01-03',54),
(5,'Python','2025-01-03',43),
(6,'Java','2025-01-03',41),
(7,'Java','2025-02-03',24),
(8,'C++','2025-02-03',23),
(9,'Python','2025-02-03',34),
(10,'Java','2025-02-04',42),
(11,'C++','2025-02-04',45),
(12,'Python','2025-02-04',59),
(13,'C++','2026-01-04',230),
(14,'Java','2026-01-04',764),
(15,'Python','2026-01-04',644),
(16,'C++','2026-01-06',240),
(17,'Java','2026-01-06',714),
(18,'Python','2026-01-06',624),
(19,'C++','2026-02-14',260),
(20,'Java','2026-02-14',721),
(21,'Python','2026-02-14',321),
(22,'C++','2026-02-24',134),
(23,'Java','2026-02-24',928),
(24,'Python','2026-02-24',525),
(25,'C++','2027-02-06',231);

SELECT t1.job,
       first_year_mon,
       first_year_cnt,
       second_year_mon,
       second_year_cnt
FROM(
SELECT job,
       date_format(date,'%Y-%m') 'first_year_mon',
       SUM(num) 'first_year_cnt'
FROM resume_info
WHERE YEAR(date)=2025
GROUP BY  job , first_year_mon) t1
JOIN(
SELECT job,
       date_format(date,'%Y-%m') 'second_year_mon',
       SUM(num) 'second_year_cnt'
FROM resume_info
WHERE YEAR(date)=2026
GROUP BY  job , second_year_mon) t2
ON t1.job=t2.job AND timestampdiff(month,DATE_FORMAT(CONCAT(first_year_mon,'-01'),'%Y-%m-%d'),DATE_FORMAT(CONCAT(second_year_mon,'-01'),'%Y-%m-%d'))=12;

