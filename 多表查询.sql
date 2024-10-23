use ityang;
######多对多######
create table student(
    id int auto_increment primary key comment '主键ID',
    name varchar(10) comment '姓名',
    no varchar(10) comment '学号'
)comment '学生表';
insert into student values(null,'戴维斯','200100101'),(null,'谢逊','200100102'),(null,'殷天正','200100103'),(null,'韦一笑','200100104');

create table course(
            id int auto_increment primary key comment '主键ID',
            name varchar(10) comment '课程名称'
        )comment '课程表';
insert into course values(null,'Java'),(null,'PHP'),(null,'MySQL'),(null,'Hadoop');

create table student_course(
    id int auto_increment primary key comment '主键',
    studentid int not null comment '学生ID',
    courseid int not null comment '课程ID',
    constraint fk_courseid foreign key (courseid) references  course(id),
    constraint fk_studentid foreign key (studentid) references student(id)
)comment '学生课程中间表';
insert into student_course values(null,1,1),(null,1,2),(null,1,3),(null,2,2),(null,2,3),(null,3,4);

######一对一#######
create table tb_user(
  id int auto_increment  key COMMENT '主键ID',
  name varchar(10) COMMENT '姓名',
  age int COMMENT '年龄',
  gender char(1) COMMENT '1:男， 2：女',
  phone char(11) COMMENT '手机号'
)comment '用户基本信息表';
create table tb_user_edu(
  id int auto_increment primary key COMMENT '主键ID',
  degree varchar(20) COMMENT '学历',
  major varchar(50) COMMENT '专业',
  primaryschool varchar(50) COMMENT '小学',
  middleschool varchar(50) COMMENT '中学',
  university varchar(50) COMMENT '大学',
  userid int unique COMMENT '用户ID',#加入unique以保证是一对一关系
  constraint fk_userid foreign key (userid) references tb_user(id)
)comment '用户教育信息表';

insert into tb_user(id,name,age,gender,phone) values
(null,'黄渤',45,'1','18800001111'),
(null,'冰冰',35,'2','18800002222'),
(null,'码云',55,'1','18800008888' ),
(null,'李彦宏',50,'1','18800009999');
insert into tb_user_edu(id, degree, major, primaryschool, middleschool, university, userid) values
(null,'本科','舞蹈','静安区第一小学','静安区第一中学','北京舞蹈学院',1),
(null,'硕士','表演','朝阳区第一小学','朝阳区第一中学','北京电影学院',2),
(null,'本科','英语','杭州市第一小学','杭州市第一中学','杭州师范大学',3),
(null,'本科','应用数学','阳泉第一小学','阳泉区第一中学','清华大学',4);

alter table emp drop foreign key fk_emp_dept_id;
drop table dept;
drop table emp;




#多表查询
##建表
create table dept(
  id int primary key auto_increment,
  name varchar(10)
);
insert into dept values
   (null, '研发部'),
   (null, '市场部'),
   (null, '财务部'),
   (null, '销售部'),
   (null, '总经办'),
   (null, '人事部');

create table emp(
  id int primary key auto_increment,
  name varchar(10),
  age int,
  job varchar(10),
  salary int,
  entrydate date,
  managerid int,
  dept_id int,
  constraint fk_dept foreign key (dept_id) references dept(id)
);
insert into emp values
  (null, '金庸', 66, '总裁', 20000, '2000-01-01', null, 5),
  (null, '张无忌', 20, '项目经理', 12500, '2005-12-05', 1, 1),
  (null, '杨逍', 33, '开发', 8400, '2000-11-03', 2, 1),
  (null, '韦一笑', 48, '开发', 11000, '2002-02-05', 2, 1),
  (null, '常遇春', 43, '开发', 10500, '2004-09-07', 3, 1),
  (null, '小昭', 19, '程序员鼓励师', 6600, '2004-10-12', 2, 1),
  (null, '灭绝', 60, '财务总监', 8500, '2002-09-12', 1, 3),
  (null, '周芷若', 19, '会计', 4800, '2006-06-02', 7, 3),
  (null, '丁敏君', 23, '出纳', 5250, '2009-05-13', 7, 3),
  (null, '赵敏', 20, '市场部总监', 12500, '2004-10-12', 1, 2),
  (null, '鹿杖客', 56, '职员', 3750, '2006-10-03', 10, 2),
  (null, '鹤笔翁', 19, '职员', 3750, '2007-05-09', 10, 2),
  (null, '方东白', 19, '职员', 5500, '2009-02-12', 10, 2),
  (null, '张三丰', 88, '销售总监', 14000, '2004-10-12', 1, 4),
  (null, '俞莲舟', 38, '销售', 4600, '2004-10-12', 14, 4),
  (null, '宋远桥', 40, '销售', 4600, '2004-10-12', 14, 4),
  (null, '陈友谅', 42, null, 2000, '2011-10-12', 1, null);
#查询
select * from emp , dept where emp.dept_id=dept.id;
##内连接 A和B的交集
##隐式内连接
select e.name,d.name from emp e,dept d where e.dept_id=d.id;
##显示内连接
select e.name,d.name from emp e inner join dept d on e.dept_id=d.id;
##左外连接 查询左表所有数据，加交集(左右完全取决于 join左右是哪一张表)
##右外连接 查询右表所有数据，加交集
##查询emp所有数据还有对应部门信息
select e.*,d.name from emp e left join dept d on e.dept_id=d.id;
##查询dept所有数据还有对应部门信息
select d.*,e.* from emp e right join dept d on e.dept_id=d.id;
##自连接
###查询员工及其领导的名字
select a.name,b.name from emp a , emp b where a.managerid = b.id;
###查询员工及其领导的名字，没有领导也要显示（左连接，将左表作为主表，右表上有的就显示，没有就显示为null）
select a.name,b.name from emp a left join emp b on a.managerid = b.id;



#联合查询
##工资小于5000显示一次，年龄大于50的显示一次
select * from emp where salary<5000 union all select * from emp where age>50;
##联合查询后去除重复的，只会显示一次
select * from emp where salary<5000 union select * from emp where age>50;




#子查询
##查询销售部的所有员工信息(标量子查询)
###a.首先查询‘销售部’ID
select ID from dept where name='销售部';
###b.根据ID查询员工信息
select * from emp where dept_id=(select ID from dept where name='销售部');
##查询在‘方东白’入职之后的员工信息
#a.查询方东白入职日期
select entrydate from emp where name='方东白';
#b.查询员工信息限制条件为方东白之后
select * from emp where entrydate>(select entrydate from emp where name='方东白');
##列子查询
## in     在指定集合范围内
## not in 不在指定集合范围内
## any    子查询返回列表中，有任意一个满足即可
## some   同any
## all    子查询的所有值必须满足
###查询‘销售部’和‘市场部’的员工信息
#a.查询‘销售部’和‘市场部’的id
select id from dept where name='销售部' or name='市场部';
#b.查询相关员工信息
select * from emp where dept_id in (select id from dept where name='销售部' or name='市场部');
###查询比财务部所有人工资都高的员工信息
select id from dept where name='财务部';
select salary from emp where dept_id in (select id from dept where name='财务部');
select salary from emp where salary >all (select salary from emp where dept_id in (select id from dept where name='财务部'));
###查询比研发部任意一人工资高的员工的信息
select id from dept where name='研发部';
select salary from emp where dept_id in (select id from dept where name='研发部');
select * from emp where salary>any(select salary from emp where dept_id in (select id from dept where name='研发部'));
#行子查询
#常用 = <> in not in
#查询与张无忌的薪资即直属领导相同的员工信息
select managerid,salary from emp where name='张无忌';
select * from emp where managerid = (select managerid from emp where name='张无忌' ) and salary=(select salary from emp where name='张无忌' );
select * from emp where (managerid,salary)=(select managerid,salary from emp where name='张无忌');
#表子查询
#常用 in
select salary,job from emp where name='鹿杖客' or name='宋远桥';
select * from emp where (salary,job) in (select salary,job from emp where name='鹿杖客' or name='宋远桥');
#查询入职日期是2006-01-01之前的员工信息，及其部门信息
select * from (select * from emp where entrydate>'2006-01-01') e left join dept d on e.dept_id=d.id;

