use ityang;
create table account(
    id int auto_increment primary key comment '主键ID',
    name varchar(10) comment '姓名',
    money int comment '余额'
)comment '账户表';
insert into account (id, name, money) values (null,'张三',2000),(null,'李四',2000);

update account set money=2000 where name='张三' or name='李四';


select @@autocommit;
set @@autocommit=1;
#转张操作
#查询张三账户余额
select * from account where name='张三';
#将张三账户余额-1000
update account set money=money-1000 where name='张三';
#将李四账户余额+1000
update account set money=money+1000 where name='李四';
##提交事务
commit;
#回滚事务
rollback;

start transaction;
#查询张三账户余额
select * from account where name='张三';
#将张三账户余额-1000
update account set money=money-1000 where name='张三';
#将李四账户余额+1000
update account set money=money+1000 where name='李四';
##提交事务
commit;
#回滚事务
rollback;