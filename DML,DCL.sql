# DML
-- 테이블의 데이터를 조작하는 명령어
-- insert: 테이블에 데이터를 삽입하는 명령어
-- update: 테이블에 데이터를 수정하는 명령어
-- delete: 테이블에 데이터를 삭제하는 명령어
-- select: 테이블에 데이터를 조회하는 명령어

use shop;
select database();

# 데이터 삽입하기
-- 하나씩 삽입하기
desc tb_user;
insert into tb_user(user_name, user_phone, user_addr)
values("손용석","010-1234-1324","서울시 금천구");
select * from tb_user;

-- user_name의 varchar 길이가 10으로 설정되어 있어서 에러 발생!
insert into tb_user(user_name,user_phone,user_addr)
values("111111111111","010-1544-1324","서울시 강남구"); # 조건인 11개 이상이라 에러 발생!

desc tb_user;
-- not null 조건을 갖고 있는 컬럼에 데이터를 안 넣을 경우 에러 발생
insert into tb_user(user_name)
values("손흥민");

-- 여러 데이터 삽입하기
insert into tb_user(user_name,user_phone,user_addr)
values("기석","010-9876-5432","서울시 관악구"),
	  ("철수","010-9517-5395","서울시 서초구"),
      ("만수","010-5617-5214","서울시 종로구"),
      ("훈수","010-7684-5455","서울시 중구");
select * from tb_user;

insert into tb_product(product_name,product_price)
values("에어컨","1200000"),
	  ("스마트tv","2000000"),
      ("컴퓨터","1000000"),
      ("모니터","200000");
select * from tb_product;

-- unique 제약이 있는 컬럼에 중복 데이터를 넣을 경우 에러발생
insert into tb_product(product_name,product_price)
values("에어컨","0000")
desc tb_order;

select * from tb_user;


-- 부모에 없는 값을  넣을 경우 외래키에 넣을 경우 안들어간다.
insert into tb_order(user_id,product_id)	
values(1,3);
select * from tb_order;

# 데이터 수정하기
select * from tb_product;
update tb_product
set product_name = "삼성에어컨"
where product_id = 1; # 조건을 안 걸면 전부 다 바뀜
select * from tb_product;

# 데이터 삭제하기
select * from tb_user;
delete from tb_user
where user_id = 5;
select * from tb_user;

-- 자식 테이블에서 참조하는 값이 있는 부모키의 값은 삭제가 안된다.
-- 자식 테이블에 참조하는 값을 먼저 삭제하고 해당 부모키를 삭제해야한다.
select * from tb_order;
delete from tb_order
where user_id = 1;
delete from tb_user
where user_id = 1;
select * from tb_user;

# DCL
-- grant: 사용자 계정에 대한 권한을 주는 명령어
-- revoke: 사용자 계정에 대한 권한을 회수하는 명령어
-- commit: insert,update,delete에 대한 데이터베이스에 실제 반영
-- rollback: insert,update,delete에 대한 데이터베이스에 대한 복구

use mysql;
select database();
-- mysql에 계정 생성하기
# 예시 => create user 'ID'@'IP' identified by '비밀번호';
create user 'son'@'%' identified by '153246son@';
select * from user;
-- 권한 부여하기
grant select,insert,delete,update on *.* to 'son'@'%'; # 모든 DB와 모든 table에 접근한다.
select * from user;

-- 권한 해제하기
revoke select,insert,delete,update on *.* from 'son'@'%';
select * from user;

-- 계정 삭제
drop user 'son'@'%';
select * from user;

select @@AUTOCOMMIT; # 오토 커밋모드라 삭제 후 자동으로 보정됨!
set AUTOCOMMIT = 0;
select @@AUTOCOMMIT;

use shop;
select * from tb_user;
delete from tb_user
where user_id = 2;	# 데이터 전체가 삭제되니 워크 벤치에서 경고함!
select * from tb_user;
rollback;
select * from tb_user;

delete from tb_user
where user_id = 2;
commit;
rollback;
select * from tb_user;	# 커밋을 하면 롤백이 안된다.








