create table 과목2(
	과목번호 char(4) not null primary key,
	이름 varchar(20) not null,
	강의실 char(5) not null,
	개설학과 varchar(20) not null,
	시수 int not null
)

create table 학생2(
	학번 char(4) not null,
	이름 varchar(20) not null,
	주소 varchar(50) default '미정', 
	학년 int not null,
	나이 int null,
	성별 char(1) not null,
	휴대폰번호 char(13) null,
	소속학과 varchar(20) null,
	primary key (학번),
	unique (휴대폰번호)
);

create table 수강2(
	학번 char(6) not null,
	과목번호 char(4) not null,
	신청날짜 date not null,
	중간고사 int null default 0,
	기말성적 int null default 0,
	평가학점 char(1) null,
	primary key (학번, 과목번호),
	foreign key (학번) references 학생2(학번),
	foreign key (과목번호) references 과목2(과목번호)
);

-- 존재하는 테이블 데이터를 불러오고 사본 만든다.
insert into 과목2 select * from 과목;
insert into 학생2 select * from 학생;
insert into 수강2 select * from 수강;

-- 이미 s003이 존재하여서 오류
-- insert into 학생2
-- value('s003','이순신', default, 4 , 54, '남',null,null);

table 학생2;
table 과목2;
table 수강2;

-- alter table (테이블 수정/변경)
alter table 학생2
	ADD COLUMN 등록날짜 DATE NOT NULL DEFAULT '2025-04-08';

TABLE 학생2

alter table 수강2
	ADD COLUMN 등록날짜 DATE NOT NULL DEFAULT '2025-04-08';

TABLE 수강2

ALTER TABLE 수강2
	DROP COLUMN 등록날짜

-- 학생2 테이블 사본
CREATE TABLE 학생3 AS SELECT * FROM 학생2;
DROP TABLE 학생3;
TABLE 학생3;

-- 사용자와 권한에 대한 명령문

SELECT CURRENT_USER;--현재유저 > postgres(기본사용자)

create user supermanager with password 'krypto';
ALTER USER supermanager with password 'jmj123';

grant all PRIVILEGES on database univdb25 to supermanager; -- db에서만 권한 부여

grant all PRIVILEGES on 학생2,수강2,과목2 to supermanager; -- 테이블에서도 권한 부여

alter database univdb25 owner to supermanager; -- 소유자로 변경하면 모든 권한이있다

insert into 과목2
values('c012','데이터', 'dj408', '정보보안' , 4);
--사용자 변경 CONNECT 로 사용자 변경(사용자 비번 입력)

table 과목2
insert into 과목2
values('c022','데이터 과학', 'dj40', '정보보안' , 5);
select current_user


--- 뷰 생성하기
create view v1_고학년학생(학생이름, 나이, 성, 학년) as 
	Select 이름, 나이, 성별, 학년 from 학생2
	where 학년 >= 3 and 학년 <= 4;

select * from v1_고학년학생

create view v2_과목수강현황(과목번호, 강의실, 수강인원수) as
	select 과목2.과목번호, 강의실, count(과목2.과목번호)
	from 과목2 join 수강2 on 과목2.과목번호 = 수강2.과목번호
	group by 과목2.과목번호
	order by 과목2.과목번호;
select * from v2_과목수강현황

drop view if exists v2_과목수강현황;


create view V3_고학년여학생 as
	select * from V1_고학년학생
	where 성 = '여';

select * from V3_고학년여학생;

-- 인덱스
grant all on schema public to supermanager;
create index idx_수강 on 수강2(학번, 과목번호);
alter table 수강2 owner to supermanager;
alter table 과목2 owner to supermanager;
create unique index idx_과목 on 과목2(이름 asc);
create unique index idx_학생 on 학생2(학번);





