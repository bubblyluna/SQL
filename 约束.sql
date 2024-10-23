#约束，一般在表结构的创建中#
#非空约束                        notnull
#唯一约束                        unique
#主键约束                        primary key
#默认约束 没有值时采用默认值         default
#检查约束 保证字段满足某一个条件      check
#外键约束 连长表之间建立连接         foreign key
##############################
create database ityang;
use ityang;
create table user(
    id int primary key auto_increment comment '主键', #主键且自动增长
    name varchar(10) not null unique comment '姓名'  ,#不为空且唯一
    age int check(age>0 && age<=120) comment '年龄',  #大于0并且小于等于120
    statue char(1) default 1  comment '状态',           #没有指定值则为1
    gender char(1) comment '性别'
) comment '用户表';

##########################################################
insert into user( name, age, statue, gender)
    values('Tom1',19,'1','男'),
          ('Tom2',25,'0','男');
insert into user( name, age, statue, gender)
    values('Tom3',19,'1','男');
#######################会违反非空和唯一约束######################
insert into user( name, age, statue, gender)
    values(null,19,'1','男');
insert into user( name, age, statue, gender)
    values('Tom3',19,'1','男');
###################id为4因为之前报错时已经申请了一次id##############
insert into user( name, age, statue, gender)
    values('Tom4',80,'1','男');
#########负值和超过120为无效########
insert into user( name, age, statue, gender)
    values('Tom5',-1,'1','男');
#############statue没有传递，但是有默认值#########
insert into user( name, age, gender)
    values('Tom5',120,'男');
##外键约束#
CREATE TABLE dept(
		id int auto_increment COMMENT 'ID' PRIMARY KEY,
		name VARCHAR(50) not null COMMENT '部门名称'
)COMMENT '部门表';

insert into dept ( name) values ('研发部'),('市场部'),('财务部'),('销售部'),('总经办');

CREATE TABLE eml (
  id INT AUTO_INCREMENT COMMENT 'ID' PRIMARY KEY,
  NAME VARCHAR(50) NOT NULL COMMENT '姓名',
  age INT COMMENT '年龄',
  job VARCHAR(20) COMMENT '职位',
  salary INT COMMENT '薪资',
  entrydate date COMMENT '入职时间',
  managerid INT COMMENT '直属领导ID',
  dept_id INT COMMENT '部门ID'
) COMMENT '员工表';

INSERT INTO emp (id, name, age, job, salary, entrydate, managerid, dept_id)
VALUES
(1, '柳岩', 66, '总裁', 20000, '2000-01-01', NULL, 5),
(2, '张无忌', 20, '项目经理', 125000, '2005-09-01', 1, 1),
(3, '韦一笑', 33, '开发', 8400, '2005-08-01', 2, 1),
(4, '赵敏', 48, '开发', 11000, '2009-12-01', 2, 1),
(5, '小昭', 43, '开发', 6600, '2007-07-01', 3, 1),
(6, '奥特玛', 43, '程序员鼓励师', 6600, '2007-07-01', 2, 1);

#####外键约束####
#alter table 表名 add constraint 外键名称 foreign key(外键字段名) references 主表(主表列名)
#将dept和emp连接emp表中创建外键后蓝色小钥匙就为外键
#此时不能删除外键相关联的数据，一旦删除会报错
alter table emp add constraint fk_emp_dept_id foreign key(dept_id) references dept(id);
#删除外键
alter table emp drop foreign key fk_emp_dept_id;
#删除更新规则
#cascade    父表数据（删除\更新）时同存在的子表的外键数据一起（删除\更新）
#set null   父表数据删除时同存在的子表的外键值设置为null
#在添加外键约束的代码后加入 on update 规则 on delete 规则
alter table emp add constraint fk_emp_dept_id foreign key(dept_id) references dept(id) on update cascade on delete cascade;


