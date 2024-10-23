##用户管理(添加删除用户)
#创建用户itcast,在当前主机localhost访问，密码123456
create user 'itcast'@'localhost' identified by '123456';
#创建用户ysx，可以在任意主机访问该数据库，密码123456
create user 'ysx'@'%' identified by '123456';
#修改密码
alter user 'ysx'@'%' identified with mysql_native_password by '1234';
#删除用户
drop user 'itcast'@'localhost';

##权限控制(访问用户)
#查询用户权限
show grants for 'ysx'@'%';#usage表示没有权限,all privileges表示所有权限

#授予权限
grant  all on itysx.* to 'ysx'@'%';

#撤销权限
revoke all on itysx.* from 'ysx'@'%';