###########ddl(definition)-数据库操作##########
SHOW DATABASES;#查询所有数据库
create database if not exists itysx;#创建
drop database if exists itysx;#删除
use sys;#使用
select DATABASE();#查询当前
###########ddl-表操作#############
show tables;#查询所有表
use itysx;#创建表
create table tb_user(
id int comment '编号',
name varchar(50) comment '姓名',
age int comment '年龄',
gender varchar(1) comment '性别'
) comment '用户表';
show tables;
desc tb_user # 查询表结构
show create table tb_user#查询创建表时的语句
###########ddl-数据类型###########
create table emp(
id int,#纯数字用int
working varchar(10),#char和varchar区别，char为定值性能较好，varchar相反
name varchar(10),
gender char(1),#所以定值用char
age tinyint unsigned,#正常人年龄，不为负数可存储小范围，unsigned表示非负无单位
idcard char(18),
time date#年月日
)comment '用户表';
desc emp;
############ddl-修改删除###########
alter table emp add nickname varchar(20) comment '昵称';#增加行
desc emp;
alter table emp change nickname username varchar(25) comment '用户名';#修改字段名和其类型
alter table emp modify username varchar(30);#进修改类型
desc emp;
alter table emp drop username;#删除字段
desc emp;
alter table emp rename to employee;#修改表名
show tables;
drop table if exists tb_user;#删除表
truncate table employee;#删除并重新创建表
show tables;