use playdata;
select database();

show tables;

select * from titanic_raw;

/*
passengerid - 승객 id (PK)
survied - 생존 여부 (0:사망, 1:생존)
pclass - 객실 등급 (1, 2, 3)
name - 이름
gender - 성별 (male: 남성, female: 여성)
sibsp - 동반한 형제 또는 자매 또는 배우자 수
parch - 동반한 부모 또는 자식의 수
ticket - 티켓번호
fare - 요금
cabin - 객실번호
embarked - 탑승한 항구 (C: 프랑스 항국, Q: 아일랜드 항구, S: 영국 항구)
*/

-- 컬럼을 선택해서 조회할 수 있다.
select name,age from titanic_raw;

-- 컬럼명에 대하여 별칭도 줄 수 있다. (원본에 영향 X)
select gender as "성별", fare as "요금" from titanic_raw;

# where 이용하여 조건줘서 조회하기
select * 	-- 산 사람만 조회
from titanic_raw
where survived = 1;

select *	-- 죽은사람만 조회
from titanic_raw
where survived != 1;

select *
from titanic_raw
where age > 59;

select *
from titanic_raw
where age < 10 and survived = 1;

-- is null
select * 
from titanic_raw
where age is null;

-- is not null
select *
from titanic_raw
where age is not null;

-- 특정 문자열이 포함되어 있는지 조회
select *
from titanic_raw
where name like '%miss%'; # 양 옆에 어떤 글자가 와도 상관없다.

select *
from titanic_raw
where binary(name) not like '%miss%';	# 대소문자 구분 = binary

select *
from titanic_raw
where gender like 'male%';

-- and
select *
from titanic_raw
where survived = 1 and gender = "female";

select *
from titanic_raw
where survived = 1 and gender = "male";

-- or
select *
from titanic_raw
where name like "%mrs%" or name like "miss";

-- in, not in
select * from titanic_raw
where embarked in("C","S");

select * from titanic_raw
where embarked not in("Q");

-- 구간 조회
select *
from titanic_raw
where age between 20 and 40; # 20살 이상 ~ 40살 이하

select *
from titanic_raw
where pclass between 0 and 2 and ticket like "%1";

-- 정렬하기
select *
from titanic_raw
where survived = 1
order by fare desc; # 정렬이 되고자하는 컬럼명 넣기 (오름차순(asc)이 기본) 내림차순은 desc

-- 산술연산
select name, sibsp + parch as add_sibsp_parch
from titanic_raw;

select sibsp - parch as add_sibsp_parch
from titanic_raw;

select sibsp * parch as add_sibsp_parch
from titanic_raw;

select sibsp / parch as add_sibsp_parch
from titanic_raw;	# 나누기의 경우 나누는 수가 0일 경우 Null

select sibsp % parch as add_sibsp_parch
from titanic_raw;	# 나머지를 구할 때 나누는 수가 0일 경우 Null

# 함수 사용하기

-- 중복 제거하기
select distinct(cabin) from titanic_raw;

-- 총 개수 확인하기
	-- count 함수는 Null값 무시!
select count(passengerid) as cnt # Null 값이 없는 PK를 주로 넣는다.
from titanic_raw;

select count(passengerid) as cnt	# 객실 번호는 Null값이 많다.
from titanic_raw
where cabin is null;

-- sum 함수는 Null값 무시
select sum(fare) as sum_fare
from titanic_raw;

select avg(fare)/std(fare) as sum_fare
from titanic_raw;

-- 평균 운임료 확인해보기
	-- avg 함수는 null값 무시
select avg(fare) as sum_fare
from titanic_raw;    

-- 운임료에 대한 표준편차 확인해보기
	-- std 함수는 null값 무시
select std(fare) as sum_fare
from titanic_raw;

-- 분산 구하기
	-- variance 함수는 Null값 무시
select variance(fare) as var_fare
from titanic_raw;

-- 거듭제곱하기
	-- pow 함수
select pow(std(fare),2) as pow_std_fare
from titanic_raw;

-- pow 함수와 variance 함수를 이용해서 표준편차 구해보기
select pow(variance(fare),0.5) as pow_variance_fare
from titanic_raw;

 -- 최대값 구하기
 select max(fare) as max_fare
 from titanic_raw;
 
 -- 최소값 구하기
  select min(fare) as max_fare
 from titanic_raw;
 
 -- 생존자의 나이에 대한 평균과 표준편차를 구해보세요.	# where을 생각 못함;;
 select  avg(age) as avg_age, std(age) as std_age
 from titanic_raw
 where survived = 1;
 
 -- 사망자의 나이에 대한 평균과 표준편차를 구해보세요.
select avg(age) as avg_age, std(age) as std_age
 from titanic_raw
 where survived = 0;	# 생존자의 나이의 편차가 크다
 
 
 -- 3등급 객실에 대한 생존률을 구해보세요.
 -- 0과 1로 되어있는 데이터의 평균을 구하면 1에 대한 비율이 나온다.
 select avg(survived) as surived_rate
 from titanic_raw
 where pclass = 3;
 
 -- 1등급과, 2등급과, 전체 생존율과 여자 생존률을 구하시오.
 select avg(survived) as survived_1
 from titanic_raw
 where pclass = 1;
 
  select avg(survived) as survived_2
 from titanic_raw
 where pclass = 2;
 
  select avg(survived) as survived_3
 from titanic_raw
 where pclass = 3;
 
select avg(survived) as survived_all
from titanic_raw;

 select avg(survived) as survived_female
 from titanic_raw
 where gender = "female";
 
-- gender = "female" and pclass = 1 # 1,0 으로 분류하여 인공지능 모델이 학습을 잘하도록 추가 칼럼을 넣는다.

 select avg(survived) as survived_female # 여자이면서 1등급인 생존자
 from titanic_raw
 where gender = "female" and pclass = 1;
 
-- 나이대에 대한 생존률 확인해보기
select avg(survived) as survived_rate
from titanic_raw
where age < 10; # (60이상과 10대미만 중 10대미만이 더 편차에 대한 영향이 크다.)

-- 생존자에 대한 sibsp(형제자매배우자수)과 parch(부모자식수) 평균!
select avg(sibsp) as survived_sibsp, avg(parch) as survived_parch
from titanic_raw
where survived = 1;

-- 사망자에 대한 sibsp(형제자매배우자수)과 parch(부모자식수) 평균!
select avg(sibsp) as survived_sibsp, avg(parch) as survived_parch
from titanic_raw
where survived = 0;

# select 절에 조건주기
-- ifnull 첫번째 값이 null일 경우 두번쨰 값으로 채워넣습니다.
select ifnull(cabin,"알수없음") as result
from titanic_raw;

-- if 첫번째 값이 참일 경우 두번쨰 값이 들어가고, 거짓일 경우 세번째 값이 들어간다.
select if(cabin is not null,cabin,"알수없음") as result
from titanic_raw;

-- gender에 대하여 male일 경우 남자, female일 경우 여자로 변경하여 조회하시오.
select if(gender = "male", "남자","여자") as gender_name
from titanic_raw;

-- one hot encoding 해보기	# 문자를 숫자로 바꾸는 것
-- em C Q S (em: 탑승항구)
--  C 1 0 0
--  Q 0 1 0
--  S 0 0 1
select * from titanic_raw;
select if(embarked = "C","1",0) as C, if(embarked = "Q","1","0") as Q, if(embarked = "S","1","0") as S
from titanic_raw;

-- case 문
select case
		when embarked = "c" then "프랑스 항구" # if 와 동일하다.
        when embarked = "q" then "아일랜드 항구"	# else if 와 동일하다
        else "영국 항구"
    end as result
from titanic_raw;

select * from titanic_raw;

-- count encoding (성능이 좋게 나온다.) 개수를 세는 것!
set @embarked_c = (select count(embarked) from titanic_raw where embarked="c");
set @embarked_q = (select count(embarked) from titanic_raw where embarked="q");
set @embarked_s = (select count(embarked) from titanic_raw where embarked="s");
select @embarked_s;
-- 예시
select embarked,
		case
			when embarked = "c"  then @embarked_c
			when embarked = "q"  then @embarked_q
			else @embarked_s
		end as result
from titanic_raw;

-- sibsp가 없을 경우 "형제와 배우자없음", parch가 없을 경우 "부모와 자녀 없음"
-- sibsp 와 parch가 둘다 없을 경우 "외로워"
select case # 내 생각
		when sibsp = 0 then "형제와 배우자 없음"
        when parch = 0 then "부모와 자녀 없음"	# parch도 0이 될수 있음
        when sibsp = 0 and parch = 0 then "외로워"
	end as result
from titanic_raw;

select case
		when sibsp + parch = 0 then "외로워" 
		when sibsp = 0 then "형제와 배우자 없음"
		when parch = 0 then "부모와 자녀 없음"
	end as result
from titanic_raw;

# group by
-- 데이터를 그룹화, 특정 컬럼으로 데이터 묶는다.
-- 특정 컬럼을 기준으로 데이터를 묶고 집계함수를 이용해서 집계한다.
select * from titanic_raw;

-- pclass별로 평균 나이를 알고 싶다면?
select avg(age) from titanic_raw where pclass = 1;
select avg(age) from titanic_raw where pclass = 2;
select avg(age) from titanic_raw where pclass = 3;

-- pclass 별 평균 나이구하기
select pclass, avg(age)	# 1,2,3의 값들을 집계(avg,sum....)하여 묶음
from titanic_raw
group by pclass;

-- pcalss 별 생존률 구하기
select pclass, avg(survived)
from titanic_raw
group by pclass;

-- embarked별 생존률 구하기
select embarked, avg(survived)
from titanic_raw
group by embarked;

select * from titanic_raw where embarked is null; # 두 명 다 살아서 null값 생존율 100%

select embarked, avg(survived)
from titanic_raw
where embarked is not null
group by embarked order by embarked;

-- gender 별 생존률을 알아보시오.
select gender, avg(survived) as survived_rate
from titanic_raw
group by gender;

-- survived별 나이와 운임료에 대한 평균과 표준편차를 구하시오.
select age, avg(age) as age_avg, std(age) as age_std
from titanic_raw
group by survived;

select fare, avg(fare) as age_avg, std(fare) as age_std # 내생각
from titanic_raw
group by survived;

select survived,	# 강사님 답
		avg(age) as avg_age,
        std(age) as std_age,
        avg(fare) as avg_fare,
        std(fare) as std_fare
from titanic_raw
group by survived;

-- 각 pclass에 대하여 gender 별로 생존률로 알고 싶다면?
select pclass, gender, avg(survived) as result
from titanic_raw
group by pclass,gender;

-- 각 embarked에 대하여 pclass 별로 생존률을 구하시오.alter
select	embarked, pclass, avg(survived) as result
from titanic_raw
group by embarked,pclass order by embarked, pclass;
# c항구가 생존율이 높으므로 c항구가 더 잘산다!

-- Q항구에 대해서 pclass별로 여자의 비율과 나이의 평균을 구하세요.
select pclass, avg(gender = "female") as lady_rate, avg(age) as age_avg
from titanic_raw
where embarked = "Q"
group by pclass, embarked order by pclass;

-- 강사님 답
select pclass, 
		avg(if(gender = "female",1,0)) as lady_rate,
        avg(age) as age_avg
from titanic_raw
where embarked = "Q"
group by pclass, embarked order by pclass;

-- embarked별로 운임료의 평균을 구하세요.
select embarked, fare, avg(fare) as fare_avg
from titanic_raw
group by embarked;

# 분석한 내용을 정리해보면
-- 객실 등급별, 성별, 나이별 생존률이 다르다.
-- 가족수가 생존률에 영향을 준다.
-- 등급이 낮아질수록 나이가 어려지고, 생존률도 낮아진다.
-- 생존자의 평균나이가 어린편이고, 편차가 심하다.
-- 1등급 남자의 생존률이 25%나 된다.

select * from titanic_raw;

-- 이름을 통해 결혼여부 분석
select *
from titanic_raw
where binary(name) like '%Mr.%'; # 결혼 여부와 관계없는 남성

select *
from titanic_raw
where binary(name) like '%Mrs.%';	# 기혼여성

select *
from titanic_raw
where binary(name) like '%Miss%';	# 미혼여성

select *
from titanic_raw
where binary(name) like '%Ms.%';	 # 결혼 여부와 관계없는 남성

-- 기혼여성이면서 sibsp(형제 자매 또는 배우자 수) 0명인 사람
select *
from titanic_raw
where binary(name) like '%Mrs.%' and sibsp = 0;

-- Mr. , Mrs. ,Miss. , Ms. 모두 아닌 경우 조회하기
select * from titanic_raw
where
binary(name) not like '%Mr.%' and binary(name) not like '%Mrs.%' and binary(name) not like '%Miss.%' and binary(name) not like '%Ms.%';

-- Mr. , Mrs. ,Miss. , Ms. 모두 아닌 경우 조회하기 (정규표현식 사용) 다시보기!
select *
from titanic_raw
where name not regexp "M[rsi]{1,3}[.]";

-- 승객의 총 개수
-- 이름의 Mr. 총개수, 이름의 Mrs. 총개수, 이름의 Miss. 총개수, 이름의 Ms. 총개수,
-- Mr. , Mrs. , Miss. , MS. 모두 아닌 경우의 총개수
select 
count(passengerid) as total_cnt,
count(if(binary(name) like '%Mr.%',1,Null)) as mr_cnt,
count(if(binary(name) like '%Mrs.%',1,Null)) as mrs_cnt,
count(if(binary(name) like '%Miss.%',1,Null)) as miss_cnt,
count(if(binary(name) like '%Ms.%',1,Null)) as ms_cnt,
count(if(name not regexp "M[rsi]{1,3}[.]",1,null)) as m_cnt
from titanic_raw;

-- 전체 승객의 생존률
-- 이름의 Mr. 생존률, 이름의 Mrs. 생존률, 이름의 Miss. 생존률, 이름의 Ms. 생존률,
-- Mr. , Mrs. , Miss. , MS. 모두 아닌 경우의 생존률
select
avg(survived) as survived_rate,
avg(if(binary(name) like '%Mr.%',survived,Null)) as mr_rate, # 0 을 넣으면 전체에 대한 생존률
avg(if(binary(name) like '%Mrs.%',survived,Null)) as mrs_rate,
avg(if(binary(name) like '%Miss.%',survived,Null)) as miss_rate,
avg(if(binary(name) like '%Ms.%',survived,Null)) as ms_rate,
avg(if(name not regexp "M[rsi]{1,3}[.]",survived,Null)) as m_rate
from titanic_raw;

-- 항구별 특징을 알아보자
-- 항구별로 생존률과
-- 운임료와 나이, 가족수(sibsp+parch)에 대한 평균,
-- 여성의 비율, 각 객실 등급의 비율을 구하시오.
select embarked,
		avg(survived) as avg_survived,
		avg(fare) as avg_fare,
        avg(age) as avg_age,
        avg(sibsp+parch) as family,
        avg(gender = 'female') as female_avg,
        if(pclass = 1,avg(pclass=1),if(pclass = 2,avg(pclass = 2),avg(pclass = 3))) as avg_pclass
from titanic_raw
group by embarked order by embarked;
-- 강사님 답
select embarked,
		avg(survived) as survived_rate,
		avg(fare) as avg_fare,
        avg(age) as avg_age,
        avg(sibsp+parch) as avg_family,
        avg(if(gender = 'female',1,0)) as female_avg,
        avg(if(pclass = 1,1,0)) as pclass_1_rate,
        avg(if(pclass = 2,1,0)) as pclass_2_rate,
        avg(if(pclass = 3,1,0)) as pclass_3_rate
from titanic_raw
group by embarked order by embarked;

-- 남성 승객들에 대해서 각 항구에 대하여 객실등급별로 생존률 확인하기.
select embarked, pclass,
avg(survived) as survived_rate
from titanic_raw
where gender = 'male'
group by embarked, pclass;

-- 각 항구에 대하여 생존여부별 특징을 알아보자
-- 가족(sibsp+parch)수에 평균,
-- 운임료 평균,
-- 티켓에 대한 고유값의 개수와,
-- cabin에 대한 고유값의 개수,
-- 가족이 없는 승객의 비율을 구하시오.
select embarked,
		avg(sibsp+parch) family_avg,
		avg(fare) avg_fare,
        count(distinct(ticket)) as count_ticket,
        count(distinct(cabin)) as count_cabin,
        avg(if(sibsp+parch = 0,1,0)) as alone
from titanic_raw
group by embarked, survived order by embarked, survived;
# Q항구는 부유하지 못하다.(운임료가 높을 수록 생존률 높아지는데 q는 아니다.)
# 가족이 없는 사람이 생존율이 높다. 등등...

# having 절
-- group by 집계 결과에 대한 조건 걸기

-- 객실 별로 생존률이 0.7 이상의 객실만 보고싶다면???
select cabin,
	   avg(survived) as survived_rate
from titanic_raw
group by cabin
having survived_rate >= 0.7
order by survived_rate;

-- 티켓별로 생존률이 0.7 이상의 티켓들만 보고 싶다면?
select ticket,
		avg(survived) as survived_rate
from titanic_raw
group by ticket
having survived_rate >= 0.7;

-- 객실별로 티켓의 고유한 값 개수가 1개인 객실들만 조회해주세요.alter
select cabin, 
		count(distinct ticket) as ticket_count
from titanic_raw
group by cabin
having ticket_count = 1;

# limit
-- 조회되는 행 갯수를 지정할 수 있다.
select * from titanic_raw;

select * from titanic_raw limit 2,10; # 행번호, 몇개
-- 행번호 값을 생략 시
select * from titanic_raw limit 5; # 기본 값으로 0이 들어간다.

# 게시글 조회 방식
-- (페이지 번호 -1) * 페이지 당 게시글 개수
-- if page = 1
-- 페이지당 게시글 개수는 10개일 경우
-- 페이지당 게시글 개수는 행갯수
-- (1-1) * 10 = 0 <= 행번호
-- (2-1) * 10 = 0 <= 행번호
select * from titanic_raw limit 10,10;

# SQL 실행순서
-- From -> Where -> Group by -> Having -> Select -> Order by -> Limit

/*
# dept 테이블
deptno - 부서번호 (pk)
dname - 부서이름
loc - 지역

# emp 테이블
empno - 사원번호
ename - 사원이름
job - 직무
mgr - 상급자의 사원번호
hiredate - 입사일
sal - 급여
comm - 커미션
deptno - 부서번호 (fk)
*/

# Join이란??
-- 다수의 table 간에 공통된 데이터를 기준으로 조회하는 명령어
-- 컬럼을 기준으로 데이터가 매칭될 경우 결합한다.
-- 다수의 테이블을 결합하여 조회할 때 사용

# inner join=> (줄어들거나 늘어날 수 있다.), left join 알기! => (늘어날 수 있다.)
-- 전처리 시 left join을 많이 쓴다.
select * from dept; # 부서정보
select * from emp;	# 사원정보

# inner join (순서가 중요하지 않다.)
-- 테이블 사이에 on 조건에 맞는 데이터만 join 함.
select * # 이것을 사용하는 것을 권장!
from emp
inner join dept
on emp.deptno = dept.deptno;

select * # 이렇게도 가능!
from emp,dept
where emp.deptno = dept.deptno;

select * # 이렇게도 가능
from emp
join dept
on emp.deptno = dept.deptno;

-- join시는 select 절에 컬럼명을 명시하자.
select ename, job, mgr, dname, loc
from emp
inner join dept
on emp.deptno = dept.deptno;

-- table 별칭을 적용해서 적용해서 join하기
select ename, job, mgr, d.dname, loc
from emp e
inner join dept d
on e.deptno = d.deptno;

select e.ename, d.dname, d.loc
From emp e
inner join dept d
on e.deptno = d.deptno and e.ename = "scott";

-- 뉴욕 지역에 근무하는 사원이름과 , 급여 , 지역 등을 조회해보세요.
select e.ename, sal, loc
from emp as e
inner join dept as d
on e.deptno = d.deptno and loc = 'new york';

-- research 부서에 소속된 사원의 이름과 , 입사일, 급여를 조회해보세요.
select e.ename, hiredate, sal
from emp as e
inner join dept as d
on e.deptno = d.deptno and dname = 'research';

-- 직무가 manager인 사원의 이름과, 부서명 , 급여, 커미션을 조회해 보세요.
select e.ename, d.dname, e.sal, e.comm
from emp e
inner join dept d
on e.deptno = d.deptno and job = 'manager';

# self 조인
-- 동일 테이블에서 진행되는 조인

-- 각 사원의 관리자 이름을 알고 싶다면?
select e.ename as "사원이름",
		m.ename as "상사이름"
from emp e
inner join emp m
on e.mgr = m.empno;

-- 관리자 이름이 King인 사원의 이름과 상사이름을 조회하시오.
select e.ename as "사원이름",
		m.ename as "상사이름"
from emp e
inner join emp m
on e.mgr = m.empno and m.ename = "King";

-- allen의 동료이름(같은 부서에서 일하는 동료)을 조회하시오.
select e.deptno, m.ename
from emp e
inner join emp m
on e.ename = 'Allen' and e.deptno = m.deptno and m.ename != "Allen";

# left join
-- 왼쪽 테이블 기준으로 join(right join은 오른쪽 테이블 join)
-- 왼쪽 테이블에 컬럼값과 on 조건에 맞는 행이 없을 경우 Null이 들어간다.
-- join 후 행이 늘어날 수도 있으나 줄어들지 않는다.

-- king도 같이 조회하고 싶다면?
select e.ename as '사원명', m.ename as '상사이름' # king이 안사라지고 존재
from emp e
left join emp m
on e.mgr = m.empno;

select * from dept;	# 40번이 사라지지 않음!
select * from emp;
select d.deptno, d.dname, e.ename
from dept d
left join emp e
on d.deptno = e.deptno;

-- 모든 부서 정보와 함께 급여가 3000 이상인 직원들의 연봉과 이름을 조회하시오.
select d.*, sal,ename 
from dept d
left join emp e
on d.deptno = e.deptno and e.sal >= 3000;

-- 모든 부서 정보와 함께 커미션이 있는 직원들의 커미션과 이름을 조회하시오.
select d.*, e.comm,e.ename 
from dept d
left join emp e
on d.deptno = e.deptno and e.comm > 0;

-- 모든 부서의 부서별 연봉에 대한 총합과 평균과 표준편차를 구하고,
-- 모든 부서의 사원 수를 구하시오.
select  d.*,
		sum(e.sal) as sum_sal, 
		avg(e.sal) as avg_sal,
        std(e.sal) as std_sal,
        count(e.empno) as everybody
from dept d
left join emp e
on d.deptno = e.deptno
group by d.deptno;

-- 각 관리자의 부하직원 수와 부하직원들의 평균연봉을 구하시오. # 다시보기!
select m.empno, m.ename,
		count(e.empno) as count_empno,
		avg(e.sal) as avg_sal
from emp e
inner join emp m # 관리자 테이블이라 생각
on m.empno = e.mgr
group by m.empno;

# SubQuery
-- 쿼리 안쪽에 쿼리를 넣을 수 있다.
-- select 절에서 서브쿼리
select *, (select dname from dept d where d.deptno=e.deptno) as dname
from emp e;

-- where 절에서 서브쿼리
-- soctt과 같은 부서에 있는 직원 이름을 검색
select ename
from emp
where deptno = (select deptno from emp where ename = "scott")
and ename != "scott";

-- smith와 동일한 직무를 가진 직원들을 정보를 검색
select *
from emp
where job = (select job from emp where ename = 'smith')
and ename != 'smith';

-- smith의 급여 이상을 받는 사원명과 급여를 검색해보세요.
select ename, sal
from emp
where sal >= (select sal from emp where ename = 'smith') and ename != 'smith';

-- DALLAS에 근무하는 사원의 이름, 부서번호를 사원이름으로 오름차순으로 정렬해서 조회하시오.
select ename, deptno
from emp
where deptno = (select deptno from dept where loc = 'DALLAS')
order by ename;

-- 직무(job)가 Manager인 사람들이 속한 부서의 부서번호와 부서명, 지역을 조회하시오.
	-- manager 사람들이 다수이기 때문에 where 절에 in을 활용
select deptno,dname,loc
from dept
where deptno in (select deptno from emp where job = 'manager');

-- from 절에서 서브쿼리 (table)이라 생각하기!

-- emp 테이블에서 급여가 2000이 넘는 사람들의 이름과 부서번호, 부서이름, 지역조회
select e.ename, e.deptno, d.dname, d.loc
from (select ename, deptno from emp where sal > 2000) as e
inner join dept as d
on d.deptno = e.deptno;

-- emp 테이블에서 커미션이 있는 사람들의 이름과 부서번호, 부서이름, 지역조회
select e.ename, e.deptno, d.dname, d.loc
from (select ename, deptno from emp where comm > 0) as e
inner join dept as d
on d.deptno = e.deptno;

-- join 절에서 서브쿼리
-- 모든 부서의 부서이름과, 지역, 부서 내의 평균급여를 조회하시오.
select d.dname, d.loc, avg_sal
from dept as d # 여기를 기준으로 left join이 붙는다.
left join (select avg(sal) as avg_sal, deptno from emp group by deptno) as e
on e.deptno = d.deptno;

-- 서브쿼리 이용해서 테이블 복제하기
create table emp01 as select * from emp;
select * from emp01;
desc emp01; # 제약조건은 복사가 안된다.

-- 거짓 조건을 줘서 테이블 구조만 복제하기
create table emp02 as select * from emp where 1=0;
select * from emp02;

-- 서브쿼리를 활용한 insert
insert into emp02 select * from emp;

-- 타이타닉 테이블에서 기혼여성(Mrs.)에 대한 이름과 나이, 가족이름, 가족의 나이를 조회하시오.
select *	# 다시 해보기
from (select name from titanic_raw where name like 'Mrs.') as a
inner join titanic_raw as b
on a.cabin = b.cabin;

select * from titanic_Raw;
-- 항구별 평균 운임료를 특성으로 추가
select a.*, add_feature # 컬럼이 추가됨!
from titanic_Raw as a
left join (
	select embarked, avg(fare) as add_feature
    from titanic_raw
    group by embarked
) as b
on a.embarked = b.embarked;

-- 항구별 평균 나이와 여성비율을 특성으로 추가
select a.*, add_feature1, add_feature2
from titanic_raw as a
left join(select embarked,avg(age) as add_feature1,
		avg(if(gender = 'female',1,0)) as add_feature2
from titanic_raw
group by embarked) as b
on a.embarked = b.embarked;

-- 각 객실번호의 빈도수를 구해서 객실번호를 기준으로 조인하시오.
-- 각 객실번호의 빈도수를 특성으로 추가
select a.*,cnt_cabin
from titanic_raw as a
left join(select cabin, count(cabin) as cnt_cabin
from titanic_raw
group by cabin) as b
on a.cabin = b.cabin;


# 미니 토의
-- 가족이 있는 집단에 데이터를 정렬
select a.*, family_name
from titanic_raw as a
left join  (select name, SUBSTRING_INDEX(name,",",1) as family_name
from titanic_raw) as b
on b.name = a.name
where sibsp+parch != 0
order by family_name;

-- 가족있는 집단에 대한 pclass와 embarked 생존율
select embarked, pclass, avg(survived) as avg_survived
from titanic_raw as a
left join  (select name, SUBSTRING_INDEX(name,",",1) as family_name
from titanic_raw) as b
on b.name = a.name
where sibsp+parch != 0
group by embarked,pclass
order by embarked,pclass;

-- 가장 많이 살아남은 가문 위 5개 아래 5개 가문 대조 (pclass,fare)
select family_name, avg(survived) as avg_survived, pclass, fare
from titanic_raw as a
left join  (select name, SUBSTRING_INDEX(name,",",1) as family_name
from titanic_raw) as b
on b.name = a.name
where sibsp+parch != 0 
group by family_name
order by avg_survived desc;

-- 동행자가 있을 경우에 생존율이 더 높았다.
