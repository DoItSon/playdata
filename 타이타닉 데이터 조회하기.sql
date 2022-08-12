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


