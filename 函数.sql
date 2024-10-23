#字符串函数
################################################################################
#concat(s1,s2,...,sn)       将s1,s2,...,sn拼接为一个字符串
#lower(str)                 将字符串str全部转为小写
#upper(str)                 将字符串str全部转为大写
#lpad(str,n,pad)            左填充，用字符串pda对str的左边进行填充，达到n个字符串长度
#rpad(str,n,pad)            右填充，用字符串pda对str的右边进行填充，达到n个字符串长度
#trim(str)                  去掉字符串头部和尾部的空格
#substring(str,start,len)   返回字符串string从start位置起的len个长度的字符串
#select 函数(参数)
################################################################################

select concat('hello','mysql');

select lower('Hello');

select upper('hello');

select lpad('01',5,'-');

select rpad('01',5,'-');

select trim(' Hello MySQL ');

select substring('Hello MySQL',1,5);

#将workno变为五位数，不足的左边补0
update emp set workno=lpad(workno,5,'0');

#字符串函数
################################################################################
#ceil(x)                            向上取整
#floor(x)                           向下取整
#mod(x,y)                           返回x/y的模
#rand()                             返回0~1内的随机数
#round(x,y)                         求参数x的四舍五入的值，保留y位小数
################################################################################
select ceil(1.1);

select floor(1.9);

select mod(3,4);

select rand();

select round(2.345,2);

#########生成六位验证码#########
select lpad(round(rand()*1000000,0),6,'0');

#日期函数
################################################################################
#curdate()                           返回当前日期
#curtime()                           返回当前时间
#now()                               返回当前日期和时间
#year(date)                          获取指定date的年份
#month(date)                         获取指定date的月份
#day(date)                           获取指定date的日期
#date_add(date,intercal expr type)   从date往后加exper（数字） type（单位）（例如70天即exper为70type为day）
#datediff(date1,date2)               获取两个时间之间的天数
################################################################################
select curdate();
select curtime();
select now();

select year(now());
select month(now());
select day(now());

##date add
select date_add(now(), interval 70 DAY);
select date_add(now(), interval 70 month);
select date_add(now(), interval 70 year);

select datediff('2045-09-05','2024-05-08');

#查询员工入职天数，并根据入职天数倒序排序
use itysx;
select name , datediff(curdate(),entrydate) as '入职天数' from emp order by 入职天数 desc;

#流程函数
################################################################################
#if(value,t,f)                                                如果value为true，则返回t，否则返回f
#ifnull(value1,value2)                                        如果value1不为空，返回value1，否则返回value2
#case when [val1] then [res1] ... else [default] end          如果val1为true，返回res1，...否则返回default默认值（多用于数字）
#case [expr] when [val1] then [res1]... else [default] end    如果expr的值等于val1，返回res1，...否则返回default默认值（用于字符串）
################################################################################
select if(false,'OK','Error');
select if(True,'OK','Error');

select ifnull('OK','Default');
select ifnull(null,'Default');
#查询emp表的员工姓名和工作地址(如果员工的地址是上海和北京则展示一线城市，其他为二线城市)
select
    name as '姓名',
    (case workaddress when '北京' then '一线城市' when '上海' then '一线城市'else '二线城市' end) as '工作地址'
from emp;
#######分数表#########
create table score(
    id int comment 'ID',
    name VARCHAR(20) comment '姓名',
    math int comment '数学',
    english int comment '英语',
    chinese int comment '语文'
) comment '学员成绩表';

insert into score VALUES
(1,'tom',67,88,95),
(2,'rose',23,66,98),
(3,'jack',56,98,76);
#展示学员成绩
#>=85优秀
#>=60及格
#其他为不及格
select
    id,
    name as '姓名',
    (case
        when math>=85 then '优秀'
        when 85>math>=60 then '及格'
        else '不及格' end)
    as '数学',
    (case
        when english>=85 then '优秀'
        when 85>english>=60 then '及格'
        else '不及格' end)
    as '英语',
    (case
        when chinese>=85 then '优秀'
        when 85>chinese>=60 then '及格'
        else '不及格' end)
    as '语文'
from score;