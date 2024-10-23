############dql-查询数据##############
drop table emp;
##########数据准备#########
create table emp(
    id          int              comment '编号',
    workno     varchar(10)      comment '工号',
    name        varchar(10)      comment '姓名',
    gender      char(1)          comment '性别',
    age         tinyint unsigned comment '年龄',
    idcard      char(18)         comment '身份证号',
    workaddress varchar(20)      comment '工作地址',
    entrydate   date             comment '入职时间'
) comment '员工表';


insert into emp values
(1,'1','柳岩','女','20','123456789112345678','北京','2000-01-01'),
(2,'2','张无忌','男','18','123456891012345678','北京','2005-09-01'),
(3,'3','韦一笑','男','38','123456781012345678','上海','2005-08-01'),
(4,'4','赵敏','女','18','123456789102345678','北京','2009-12-01'),
(5,'5','小昭','女','16','123456789101345678','上海','2007-07-01'),
(6,'6','杨逍','男','28','12345678910123467X','北京','2006-01-01'),
(7,'7','范瑶','男','40','123456789101245678','北京','2005-05-01'),
(8,'8','黛绮丝','女','38','123456789101345678','天津','2015-05-01'),
(9,'9','范凉凉','女','45','123456789101345678','北京','2010-04-01'),
(10,'10','陈友凉','男','53','123456789102345678','上海','2011-01-01'),
(11,'11','张士诚','男','55','123456789112345678','江苏','2015-05-01'),
(12,'12','常遇春','男','32','123456789101245678','北京','2004-02-01'),
(13,'13','张三丰','男','88','123456789102345678','江苏','2020-11-01'),
(14,'14','灭绝','女','65','123456789101235678','西安','2019-05-01'),
(15,'15','胡青牛','男','70','123456789102345678','西安','2018-04-01'),
(16,'16','周芷若','女','18',null,'北京','2012-06-01');

####基本查询

###查询字段
select name,workno,age from emp;
select * from emp;
select workaddress as '工作地址' from emp;#字段名会变为工作地址而不是workadress
select distinct workaddress as '工作地址' from emp;#去处重复记录
##条件查询（where+条件）
select * from emp where age=88;
select * from emp where age<20;
select * from emp where age<=20;
select * from emp where idcard  is null;
select * from emp where age!=88;
select * from emp where age between 15 and 28;
select * from emp where gender='女' and age<25;
select * from emp where age in(18,20,40);
#查询名字为两个字的人
select * from emp where name like '__';
#查询身份证号最后一位为x的人（%为通配符匹配1个或者n个任意值）
select * from emp where idcard like '%X';
##聚合函数
#查询员工总数
select count(id) from emp;#count函数不计算null，所以要统计总数一般用*
#平均年龄
select avg(age) from emp;
#最大最小年龄
select max(age) from emp;
select min(age) from emp;
#西安年龄和
select sum(age) from emp where workaddress='西安';
##分组查询
select gender,count(*) from emp group by gender;
select gender,avg(age) from emp group by gender;
#年龄小于45的员工，根据工作地址进行分组，获取员工数量大于等于3的工作地址
select workaddress '工作地址',count(*) '工作地址人数' from emp where age<45 group by workaddress having count(workaddress)>=3;
##排序
select * from emp order by age asc;#年龄升序
select * from emp order by entrydate desc;#入职时间降序
select * from emp order by age asc , entrydate desc;
##分页查询
select * from emp limit 0,10;#查询第一页的10条记录，起始索引等于(需要的查询的页数-1)*要显示的记录
select * from emp limit 10,10;#查询第二页的10条记录