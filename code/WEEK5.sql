
-- 학생 테이블생성
CREATE TABLE 학생
( 학번 CHAR(4) NOT NULL,
이름 VARCHAR(20) NOT NULL,
주소 VARCHAR(50) NULL DEFAULT '미정',
학년 INT NOT NULL,
나이 INT NULL,
성별 CHAR(1) NOT NULL,
휴대폰번호 CHAR(14) NULL,
소속학과 VARCHAR(20) NULL,
PRIMARY KEY (학번) );




-- 과목 테이블 생성
CREATE TABLE 과목
( 과목번호 CHAR(4) NOT NULL PRIMARY KEY,
이름 VARCHAR(20) NOT NULL,
강의실 CHAR(3) NOT NULL,
개설학과 VARCHAR(20) NOT NULL,
시수 INT NOT NULL );

-- 수강 테이블 생성
CREATE TABLE 수강
( 학번 CHAR(6) NOT NULL,
과목번호 CHAR(4) NOT NULL,
신청날짜 DATE NOT NULL,
중간성적 INT NULL DEFAULT 0,
기말성적 INT NULL DEFAULT 0,
평가학점 CHAR(1) NULL,
PRIMARY KEY( 학번, 과목번호) );


-- 학생 테이블입력
INSERT INTO 학생
VALUES 
	('s001', '김연아', '서울 서초', 4, 23, '여', '010-1111-2222', '컴퓨터'),
	('s002', '홍길동', DEFAULT, 1, 26, '남', NULL, '통계'),
	('s003', '이승엽', NULL, 3, 30, '남', NULL, '정보통신'),
	('s004', '이영애', '경기 분당', 2, NULL, '여', '010-4444-5555', '정보통신'),
	('s005', '송윤아', '경기 분당', 4, 23, '여', '010-6666-7777', '컴퓨터'),
	('s006', '홍길동', '서울 종로', 2, 26, '남', '010-8888-9999', '컴퓨터'),
	('s007', '이온진', '경기 과천', 1, 23, '여', '010-2222-3333', '경영');

-- 학생 테이블입력
INSERT INTO 학생 VALUES ( 's001', '김연아', '서울 서초', 4, 23, '여', '010-1111-2222', '컴퓨터' );
INSERT INTO 학생 VALUES ( 's002', '홍길동', DEFAULT, 1, 26, '남', NULL, '통계' );
INSERT INTO 학생 VALUES ('s003', '이승엽', NULL, 3, 30, '남', NULL, '정보통신' );
INSERT INTO 학생 VALUES ('s004', '이영애', '경기 분당', 2, NULL, '여', '010-4444-5555', '정보통신' );
INSERT INTO 학생 VALUES ('s005', '송윤아', '경기 분당', 4, 23, '여', '010-6666-7777', '컴퓨터' );
INSERT INTO 학생 VALUES ('s006', '홍길동', '서울 종로', 2, 26, '남', '010-8888-9999', '컴퓨터' );
INSERT INTO 학생 VALUES ('s007', '이온진', '경기 과천', 1, 23, '여', '010-2222-3333', '경영' );

select * from 학생

-- 괴목 테이블 입력
INSERT INTO 과목
VALUES
('c001', '데이터베이스', '126', '컴퓨터', 3),
('c002', '정보보호', '137', '정보통신', 3),
('c003', '모바일웹', '128', '컴퓨터', 3),
('c004', '철학개론', '117', '철학', 2),
('c005', '전공글쓰기', '120', '교양학부', 1);


-- 수강 테이블 입력
INSERT INTO 수강
VALUES 
('s001', 'c002', '2019-09-03', 93, 98, 'A'),
('s004', 'c005', '2019-03-03', 72, 78, 'C'),
('s003', 'c002', '2017-09-06', 85, 82, 'B'),
('s002', 'c001', '2018-03-10', 31, 50, 'F'),
('s001', 'c004', '2019-03-05', 82, 89, 'B'),
('s004', 'c003', '2020-09-03', 91, 94, 'A'),
('s001', 'c005', '2020-09-03', 74, 79, 'C'),
('s003', 'c001', '2019-03-03', 81, 82, 'B'),
('s004', 'c002', '2018-03-05', 92, 95, 'A');


select 이름, 주소 from 학생;
select all 소속학과 from 학생;
select distinct 소속학과 from 학생;

select 이름, 학년, 소속학과, 휴대폰번호 from 학생
where 학년 >= 2 and 소속학과 = '컴퓨터';

select 이름, 학년, 소속학과, 휴대폰번호 from 학생
where (학년 between 1 and 3) or not (소속학과 = '컴퓨터'); -- between 1 and 3도 ㄱㅊ

select 이름, 학년, 소속학과 from 학생 where 소속학과 = '컴퓨터' or 소속학과 ='정보통신' order by 학년 asc --오름차순

select * from 학생 order by 학년 asc, 이름 desc; -- 학년(오름차순) 이름(내림차순)

select * from 수강 order by 중간성적 desc limit 3; -- limit 5,3 는 mysql에서만

select count(*) as 학생수, count(주소) as 주소수, count(distinct 주소) as 중복되지않는주소 from 학생; --as 이름<< 출력 이름


select * from 학생
select  avg(나이) as 남학생편군나이 from 학생 where 성별 = '남'; 

select 성별, max(나이) as 최고나이, min(나이) as 최저나이 from 학생 group by 성별;


select 학번, 이름 from 학생 where 이름 like '이__';


select 이름, 주소, 학년 from 학생 where 주소 like '%서울%' order by 학년 desc;

select 이름, 휴대폰번호 from 학생 where 휴대폰번호 is null;


select 학번 from 학생 where 성별 ='여자' union select 학번 from 수강 where 평가학점 = 'A';


select 이름 from 학생 where 학번 in(
	select 학번 from 수강 where 과목번호 = (
		select 과목번호 from 과목 where 이름 ='정보보호'
	)
); - 이것은 정보보호 과목을 수강한 학생의 이름 검색하는것

select 이름 from 학생 where exists(
	select * from 수강 where 수강.학번 = 학생.학번 and 과목번호 = 'c002'

); -- 과목 번호가 'c00'인 과목을 수강한 학생이름을 출력


select * from 학생 cross join 수강

select * from  학생 join 수강 on 학생.학번 = 수강.학번;-- 동등 조인

select S1.이름, S2.이름 -- 별명
from 학생 as S1 JOIN 학생 as S2 on S1.주소 = S2.주소
where S1.학년 > S2.학년; -- 셀프 조인

select 학생.학번, 이름, 평가학점 from 학생 left outer join 수강 on 학생.학번 = 수강.학번;--왼쪽 외부조인

select 학생.학번, 이름, 평가학점 from 학생 right outer join 수강 on 학생.학번 = 수강.학번;--오른쪽 외부조인

select 학생.학번, 이름, 평가학점 from 학생 full outer join 수강 on 학생.학번 = 수강.학번;--전체조인

-- CRUD
UPDATE 학생 SET 이름 = '이은진' WHERE 이름 = '이온진';
UPDATE 학생 SET 학년 = 3 WHERE 이름 = '이온진';
SELECT * FROM 학생;

UPDATE 학생
SET 학년 = 학년 + 1, 소속학과 = '자유전공학부' WHERE 학년 = 4;


DELETE FROM 학생 WHERE 이름 = '송윤아';
SELECT * FROM 학생;




















































