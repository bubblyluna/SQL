##################################dml-增删改数据#############################################
########################
##多个字段之间使用逗号分割###
########################
#插入数据，双击表即可查看数据
insert into employee (id, working, name, gender, age, idcard, entrydate) values
(1, '1', 'itysx', '男', '10', '123456789012345678', '2001-01-01');
select * from employee;#查找数据
#插入数据（包含全部字段名），不需要输入字段名，values按顺序跟所有字段的数据
insert into employee values
(2,'2','张无忌','男','18','123456789012345678','2005-01-01');
delete from employee where id=1;#删除数据
#添加多条数据
insert into employee values
(3,'3','韦一笑','男','38','123456789012345678','2005-01-01'),
(4,'4','赵敏','女','18','123456789012345678','2005-01-01');
#修改数据
update employee set name='ityang' where name='itysx';#或者where id=1
update employee set name='小昭',gender='女' where name='ityang';#修改多个字段
update employee set entrydate='2008-01-01';#修改所有数据的某几个字段
#删除数据
delete from employee where gender='女';
delete from employee;