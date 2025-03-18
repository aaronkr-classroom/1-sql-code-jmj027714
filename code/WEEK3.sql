CREATE TABLE 학원쌤(
	id bigserial,--bigserial은 PostgreSQL에서만 사용할 수 있는 자동 증가하는 숫자
	학원생이름 varchar(20),	--varchar(n) < n은 사용자가 입력 가능한 글자 숫자 
	폰번호 varchar(13), 
	나이 int,-- int는 정수 자료형
	학교이름 varchar(25),
	학년 int,
	반 int,
	반번호 int
);
SELECT * FROM  학원쌤; -- SELECT * << 모든 속성과 행을 가져온다는 것 FROM TABLE_NAME

INSERT INTO 학원쌤(학원생이름, 폰번호, 나이, 학교이름, 학년, 반, 반번호)--INSERT INTO TABLE_NAME (열값) VALUE(열값)
VALUES('홍길동','010-1237-6542',19,'송원고',3,1,10),
('김하나','010-3218-8765',18,'한빛고',2,2,7),
('홍길동','010-4587-9834',19,'송원고',3,1,31),
('박순희','010-7789-6754',17,'이슬고',1,3,16);


CREATE TABLE 학교(
	id bigserial,--bigserial은 PostgreSQL에서만 사용할 수 있는 자동 증가하는 숫자
	학교명 varchar(20),	--varchar(n) < n은 사용자가 입력 가능한 글자 숫자 
	분류 int,-- int는 정수 자료형
	학생수 int,
	주소 varchar(100)
);

SELECT * FROM 학원쌤


INSERT INTO 학교(학교명, 분류,학생수,  주소)
VALUES('송원고',3, 435,'경기 성남 분당구 황생을로 123'),
('한빛고',2,377,'경기 성남 분당구 한교여로 67'),
('이슬고',1,507,'경기 성남 분당구 미금로 567');

DELETE FROM 학교 DROP COLUMN 반번호
DROP TABLE 학교

SELECT * FROM 학교





CREATE TABLE TEST(
	id bigserial,--bigserial은 PostgreSQL에서만 사용할 수 있는 자동 증가하는 숫자
	학교명 varchar(20),	--varchar(n) < n은 사용자가 입력 가능한 글자 숫자 
	분류 int,-- int는 정수 자료형
	학생수 int,
	주소 varchar(100)
);
SELECT * FROM 학원쌤
ALTER TABLE 학원쌤 RENAME TO 학원생

SELECT * FROM 학원생

ALTER TABLE TEST DROP COLUMN 학생수

SELECT * FROM TEST
DROP TABLE TEST


--기본키와 외래키 추가
ALTER TABLE 학원생 
ADD CONSTRAINT 폰번호_키 PRIMARY KEY(폰번호) -- 기본키 만드는 쿼리

TABLE 학원생

ALTER TABLE 학교 
ADD CONSTRAINT 학교명 PRIMARY KEY(학교명) -- 기본키 만드는 쿼리

TABLE 학교
TABLE 학원생
ALTER TABLE 학교 -- 외래키 만드는 쿼리
ADD CONSTRAINT 학교_학원생_FK 
FOREIGN KEY(학교명)
REFERENCES 학원생(학교이름)
ON DELETE CASCADE;




