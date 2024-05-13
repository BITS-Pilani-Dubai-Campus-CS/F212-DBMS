USE 20220276db;

create table employee2(id int primary key, name varchar(100), superid int, salary int, bdate date, dno int);
insert into employee2 values (1, "John", 3, 100000, "1960-01-01", 1);
insert into employee2 values (2, "Mary", 3, 50000, "1964-12-01", 3);
insert into employee2 values (3, "Bob", NULL, 80000, "1974-02-07", 3);
insert into employee2 values (4, "Tom", 1, 50000, "1970-01-17", 2);
insert into employee2 values (5, "Bill", NULL, NULL, "1985-01-20", 1);


create table deptsal(dnumber int primary key, totalsalary int);
insert into deptsal values(1, 1000000);
insert into deptsal values(2, 800000);
insert into deptsal values(3, 1300000);

delimiter |
create trigger update_salary
after insert on employee2 
for each row 
begin
if new.dno is not null then
update deptsal
set totalsalary = totalsalary + new.salary
where dnumber=new.dno;
end if;
end |


delimiter ;

select * from deptsal;
insert into employee2 values (6, "Lucy", null, 90000, "1981-01-01", 1);
select * from deptsal;
insert into employee2 values (7, "George", null, 45000, "1971-11-11", null);

drop trigger update_salary;

delimiter |
create trigger update_salary2
after update on employee 
for each row 
begin
if old.dno is not null then
update deptsal
set totalsalary = totalsalary - old.salary
where dnumber=new.dno;
end if;
end |

delimiter ;

select * from employee;

select * from deptsal;

update employee2 set salary = 100000 where id=6;

select * from deptsal;

drop trigger update_salary2;



delimiter |
create trigger update_salary3
before delete on employee 
for each row 
begin
if (old.dno is not null) then
update deptsal
set totalsalary = totalsalary - old.salary
where dnumber=old.dno;
end if;
end |

delimiter ;

select * from employee;

delete from employee where id=6;
delete from employee where id=7;

drop trigger update_salary3;

select * from deptsal;

show triggers;
