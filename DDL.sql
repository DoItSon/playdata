# DDL
-- 데이터베이스와 테이블을 정의하는 언어
-- CREATE: 데이터베이스와 테이블을 생성하는 명령어
-- ALTER: 테이블을 수정하는 명령어
-- DROP: 데이터베이스와 테이블을 삭제하는 명령어
-- 데이터베이스 생성

create database test;
-- 데이터베이스 삭제
drop database test;
-- 데이터베이스 삭제시 조건 주기
drop database if exists test;

create database shop;

-- 데이터베이스 리스트 출력하기
show databases;
-- 데이터베이스를 선택하려면 아래의 USE를 사용해야한다.
use shop;
-- 현재 어떤 데이터베이스를 선택했는지 확인한다.
select database();

-- 테이블 생성하기
create table tb_user(
		user_id int
);

-- 테이블 리스트 보기
show tables;

-- 테이블 삭제하기
drop table tb_user;
drop table if exists tb_user;

create table tb_user(
	user_id int,
    user_name varchar(10), # 가변길이, 입력한 크기만큼 공간이 잡힌다.
    phone char(13) # 고정길이, 가변길이보다 속도가 빠르다.
);
-- 테이블 구조 확인하기
desc tb_user;

-- 제약조건: 어떠한 제약조건이 만족할 시 데이터 삽입!
-- 기본키(Primary key): 중복값 X, Null X
-- auto_increment: 새 데이터 저장 시 고유번호가 자동생성되서 들어간다.
create table tb_product(
	product_id int primary key auto_increment,
    product_name varchar(20) unique not null, # 중복 불가
	product_price int
);
desc tb_product;

select * from tb_product;

# 테이블 수정하기
-- 컬럼 추가하기
alter table tb_user add user_addr varchar(255);
desc tb_user;

-- 컬럼명 수정하기
alter table tb_user change phone user_phone varchar(50);
desc tb_user;

-- 컬럼 타입 수정하기
alter table tb_user modify column user_phone varchar(13);
desc tb_user;

-- 컬럼에 대하여 제약조건 및 속성 추가하기
alter table tb_user modify column user_id int primary key auto_increment;
desc tb_user;


alter table tb_user add user_age int;
-- 컬럼 삭제하기
alter table tb_user drop user_age;
desc tb_user;

-- not null로 변경
alter table tb_user modify column user_name varchar(10) not null;
alter table tb_user modify column user_phone varchar(13) not null;
alter table tb_user modify column user_addr varchar(255) not null;
desc tb_user;

-- foreign key(외래키, 외부키, 참조키...)
-- pk를 보유하는 테이블이 부모, 참조하는 테이블을 자식
create table tb_order(
	order_id int primary key auto_increment,
    user_id int, # 부모의 기본키의 테이터 타입으로.. 
    product_id int,	# 부모의 기본키의 테이터 타입으로.. 
    order_dt datetime default current_timestamp, # 값이 null이면 현재 시간이 들어간다.
    foreign key(user_id) references tb_user(user_id),
    foreign key(product_id) references tb_product(product_id)
);
desc tb_order;







