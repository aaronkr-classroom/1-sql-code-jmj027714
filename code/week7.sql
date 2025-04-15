--숫자 내장 함수
select ABS(17), ABS (-17), CEIL(3.28),FLOOR(4.97);

SELECT 학번,
	SUM(기말성적)::FLOAT / COUNT(*) AS 평균성적
--	,ROUND(SUM(기말성적) :: FLOAT/COUNT(*),2)
	from 수강
	group by 학번;



SELECT CURRENT_TIMESTAMP, 신청날짜 - DATE '2019-01-01' AS 일수차이
FROM 수강2

	SELECT LENGTH(소속학과), RIGHT(학번,2), REPEAT('*',나이), CONCAT(소속학과,'학과') FROM 학생;

SELECT SUBSTRING(주소,1,2), REPLACE(SUBSTRING(휴대폰번호,5,9),'-',',')
	FROM 학생;

SELECT 신청날짜, DATE_TRUNC('MONTH',신청날짜) + INTERVAL '1 MONTH - 1 DAY' AS 마지막날
	FROM 수강
	WHERE EXTRACT(YEAR FROM 신청날짜) = 2019;


SELECT CURRENT_TIMESTAMP, 신청날짜 - DATE '2019-01-01' AS 일수차이
	FROM 수강;
	
SELECT 신청날짜,
	TO_CHAR(신청날짜, 'MON/DD/YY') AS 형식1,
	TO_CHAR(신청날짜, 'YYYY"년"MM"월"DD"일"') AS 형식2
	FROM 수강2



DROP PROCEDURE IF EXISTS InsertOrUpdateCourse(CourseNo, CoursseName,CourseRoom,CourseDept,CourseCredit);

-- 저장 프로시저
	create oR replace procedure InsertOrUpdateCourse(
			IN CourseNo VARCHAR(4),
			IN CourseName VARCHAR(20),
			IN CourseRoom CHAR(3),
			IN CourseDept VARCHAR(20),
			IN CourseCredit INT
	)

	LANGUAGE plpgsql
	AS $$
	DECLARE
		COUNT INT;--지역변수
	BEGIN
	--프로시저 (과목이 존재하는지 확인)
		SELECT COUNT(*) INTO Count FROM 과목2 WHERE 과목번호 = CourseNo; 
		IF Count = 0 then--과목이 존재하지 않으면 새 과목 추가
				insert into 과목2(과목번호, 이름, 강의실, 개설학과, 시수)
				values (CourseNo, CourseName, CourseRoom, CourseDept,CourseCredit);
		else -- 과목이 존재하면 기존 과목 업데이트
				update 과목2
				set 이름 = CourseName, 강의실 = CourseRoom, 개설학과 = CourseDept, 사수 = CourseCredit
				where 과목번호 = CourseNo;
		end if;
	END
		$$;

--새과목 추가
	call InsertOrUpdateCourse('c006','연극학개론','310','교양학부',2);

	select * from 과목2;

	call InsertOrUpdateCourse('c006','연극학개론','410','교양학부',2);




-- 저장 프로시저
	create oR replace procedure InsertOrUpdateCours(
			IN CourseNo VARCHAR(4),
			IN CourseName VARCHAR(20),
			IN CourseRoom CHAR(3),
			IN CourseDept VARCHAR(20),
			IN CourseCredit INT
	)

	LANGUAGE plpgsql
	AS $$
	DECLARE
		COUNT INT;--지역변수
	BEGIN
	--프로시저 (과목이 존재하는지 확인)
		SELECT COUNT(*) INTO Count FROM 과목2 WHERE 과목번호 = CourseNo; 
		IF Count = 0 then--과목이 존재하지 않으면 새 과목 추가
				insert into 과목2(과목번호, 이름, 강의실, 개설학과, 시수)
				values (CourseNo, CourseName, CourseRoom, CourseDept,CourseCredit);
		else -- 과목이 존재하면 기존 과목 업데이트
				update 과목2
				set 이름 = CourseName, 강의실 = CourseRoom, 개설학과 = CourseDept, 시수 = CourseCredit
				where 과목번호 = CourseNo;
		end if;
	END
		$$;


--새과목 추가
	call InsertOrUpdateCours('c006','연극학개론','310','교양학부',2);

	select * from 과목2;

	call InsertOrUpdateCours('c006','연극학개론','410','교양학부',2);

	SELECT * FROM 과목2

CREATE OR REPLACE PROCEDURE SelectAverageOfBestScore(
    IN Score INT,
    OUT Count INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    Midterm INT;
    Final INT;
    Best INT;
    SCORELISTCURSOR CURSOR FOR SELECT 중간고사, 기말성적 FROM 수강2;
BEGIN
    Count := 0; -- 초기화
    OPEN SCORELISTCURSOR;
    LOOP
        FETCH SCORELISTCURSOR INTO Midterm, Final;
        EXIT WHEN NOT FOUND;

        -- 더 높은 점수를 Best로 선택
        IF Midterm > Final THEN
            Best := Midterm;
        ELSE
            Best := Final;
        END IF;

        -- Best 점수가 주어진 Score 이상이면 Count 증가
        IF Best >= Score THEN
            Count := Count + 1;
        END IF;
    END LOOP;
    CLOSE SCORELISTCURSOR;
END;
$$;



DO $$
	DECLARE COUNT INT;
		BEGIN
			CALL SelectAverageOfBestScore(95,Count);
			RAISE NOTICE 'Count: %', Count;
	END;
	$$;



create or replace function Fu_Grade(grade CHAR)
RETURNS TEXT AS $$
BEGIN
	case grade -- switch
		when 'A' THEN 
			RETURN '최우수';
		WHEN 'B' THEN
			RETURN '우수';
		WHEN 'C' THEN
			RETURN '보통';
		ELSE RETURN '미흡';
	END CASE;
END;
$$ LANGUAGE plpgsql;

SELECT 학번, 과목번호, 평가학점, Fu_Grade(평가학점) as 평가등급 from 수강2

create table 남녀학생총수
		(
		성별 char(1) NOT NULL DEFAULT 0,
		인원수 INT NOT NULL DEFAULT 0,
		PRIMARY KEY (성별)			
		
		
		);
		INSERT INTO 남녀학생총수 SELECT '남', COUNT(*) FROM 학생2 WHERE 성별 ='남';
		INSERT INTO 남녀학생총수 SELECT '여', COUNT(*) FROM 학생2 WHERE 성별 ='여';
		SELECT * FROM 남녀학생총수

		
CREATE OR REPLACE FUNCTION AfterInsertStudent()
	RETURN TRIGGER AS $$
	BEGIN
		IF(NEW.성별 = '남') THEN
			UPDATE 남녀학생총수 SET 인원수 = 인원수 + 1 WHERE 성별 = '남';
		ELSEIF(NEW.성별 = '여') THEN
			UPDATE 남녀학생총수 SET 인원수 = 인원수 + 1 WHERE 성별 = '여';

		END IF;
		RETURN NEW;
END $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION AfterInsertStudent()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.성별 = '남' THEN
        UPDATE 남녀학생총수 SET 인원수 = 인원수 + 1 WHERE 성별 = '남';
    ELSIF NEW.성별 = '여' THEN
        UPDATE 남녀학생총수 SET 인원수 = 인원수 + 1 WHERE 성별 = '여';
    END IF;
    RETURN NEW;
END;
$$;


 





CREATE OR REPLACE TRIGGER after_insert_student
after insert on 학생 for EACH ROW
BEGIN
IF(NEW.성별 = '남') THEN
	UPDATE 남녀학생총수 SET 

select * from 남녀학생총수;
insert into 학생
values('s008','최동석','경기 수원', 2 , 26,'남','010-8888-6666','컴퓨터');

select * from 학생2
















