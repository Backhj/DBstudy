/*
    공백제거 TRIM
    왼쪽:LTRIM 오른쪽: RTRIM 공백제거
*/
SELECT LTRIM(' ABC ') as ex1
      ,RTRIM(' ABC ') as ex2
      ,TRIM(' ABC ') as ex3
FROM dual;
/* SPAD, RPAD 채우는
   (대상, 길이, 표현)
*/
SELECT LPAD(123,5,'0')  as ex1
      ,LPAD(1,5,'0')    as ex2
      ,LPAD(1123,5,'0') as ex3
      ,LPAD(11232,5,'0')as ex4 --출력이 무조건 2번째가 매개변수 길이
      ,RPAD(2,5, '0')   as ex5
FROM dual;
/*REPLACE, TRANSLATE 변환*/
SELECT REPLACE('나는 너를 모르는데 너는 나를 알겠는가?', '나는','너를') as ex1
      ,TRANSLATE ('나는 너를 모르는데 너는 나를 알겠는가?','나는','너를') as ex2
FROM dual;
-- LENGTH 문자열길이, LENGTHB 문자열 크기(byte)
SELECT LENGTH('abc1')  as ex1 --숫자, 특수문자, 영어 byte
      ,LENGTHB('abc1') as ex2
      ,LENGTH('팽수1')  as ex3
      ,LENGTHB('팽수1') as ex4-- utf-8 기준 한글 3byte
FROM dual;




/*member 테이블에 있는 회원중
  직업이 주부, 회사원, 자영업자인 회원의 등급을 출력하시오
  2500 이하 silver, 2500초과 5000 이하 gold, 5000 초과 vip
*/
SELECT men_name
      ,men__mileage
      , CASE WHEN men_mileage <= 2500 THEN 'silver'
             WHEN men_mileage > 2500 AND men_mileage <=5000 THEN 'gold'
             ELSE 'vip'
        END as ratings
      , men_job
FROM member
WHERE men_job IN ('주부','자영업','회사원')
ORDER BY men_mileage DESC;

--TABLE 수정 ALTER
CREATE TABLE ex5_1(
    nm VARCHAR2(100) NOT NULL
    ,point NUMBER(5)
    ,gender CHAR(1)
);
--컬럼명 수정
ALTER TABLE ex5_1 RENAME COLUMN point TO user_point;
--타입 수정(타입 수정시 테이블에 데이터가 있다면 주의해야함)
ALTER TABLE ex5_1 MODIFY gender VARCHAR2(1);
--제약조건 추가
ALTER TABLE ex5_1 ADD CONSTRAINT pk_ex5 PRIMARY KEY (nm);
--컬럼 추가
ALTER TABLE ex5_1 ADD creat_dt DATE;
--컬럼 삭제
ALTER TABLE ex5_1 DROP COLUMN gender;
--tb_info 테이블에 MBTI 컬럼을 추가하세요(type: VARCHAR2, size :4byte)
ALTER TABLE tb_info ADD MBTI VARCHAR2(4);

SELECT *
FROM member;
    
/*숫자 함수 (매개변수 숫자형)
  ABS:절대값, ROUND 반올림 TRUNC버림 CEIL올리 SQRT 제곱근
*/    
SELECT ABS(-10)          as ex1
      ,ABS (10)          as ex2
      ,ROUND(10.55555)   as ex3 
      ,ROUND(10.55555,1) AS ex4--default 정수
      ,ROUND(10.55555,1) AS ex5 --소수점 2째 자리에서 반올림
      ,MOD(4,2)          AS ex6
      ,MOD(5,2)          AS ex7
FROM dual;
/*날짜 함수*/
SELECT SYSDATE      --현재시간
      ,SYSTIMESTAMP
FROM dual;
--ADD_MONTHS(날짜, 1) 다음달
SELECT ADD_MONTHS(SYSDATE, 1) AS ex1
      ,ADD_MONTHS(SYSDATE, -1) AS ex2
      ,LAST_DAY(SYSDATE) AS ex3
      ,NEXT_DAY(SYSDATE,'수요일') AS ex4
      ,NEXT_DAY(SYSDATE,'목요일') AS ex5 --오늘이 목요일이라면 다음주 목요일
FROM dual;
SELECT SYSDATE -1 -- <-- --1day 연산가능
      ,ADD_MONTHS(SYSDATE, 1) -ADD_MONTHS(SYSDATE, -1) --날짜 연산가능
FROM dual;
--이번달은 몇일 남았을까요?
SELECT 'd-day:' || (LAST_DAY(SYSDATE)-SYSDATE) || '일' as dday
FORM dual;

--DECODE 표현식
SELECT cust_name
      ,cust_gender
      -- 조건1, true값, false(그밖에)
      ,DECODE(cust_gender, 'M','남자','여자') as gender
      --조건1, true, 값, 조건2, true값, 그밖에 )
      ,DECODE(cust_gender, 'M','남자','F','여자','?') as gender2
      
FROM customers;

--member 의 회원의 성별을 출력하시오
--member의 정보에는 성별이 없음.
--회원이름, 성별을 출력
--ex) mem_regno2 는 주민번호 뒷자리
SELECT mem_name
     , DECODE(SUBSTR(mem_regno2,1,1), 1, '남자', 2, '여자', '?') as gender
FROM member;

/*변환함수(타입) 
  TO_CHAR 문자형으로
  TO_DATE 날짜형으로
  TO_NUMBER 숫자형으로
*/
SELECT TO_CHAR(123456, '999,999,999') as ex1
      ,TO_CHAR(SYSDATE, 'YYYY-MM-DD') as ex2
      ,TO_CHAR(SYSDATE, 'YYYYMMDD') as ex3
      ,TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') as ex4
      ,TO_CHAR(SYSDATE, 'YYYY/MM/DD HH12:MI:SS') as ex5
      ,TO_CHAR(SYSDATE, 'day') as ex6
      ,TO_CHAR(SYSDATE, 'YYYY') as ex7
      ,TO_CHAR(SYSDATE, 'YY') as ex8
      ,TO_CHAR(SYSDATE, 'dd') as ex9
      ,TO_CHAR(SYSDATE, 'd') as ex10
FROM dual;
SELECT TO_DATE('231229','YYMMDD')
      ,TO_DATE('2023 12 29 09:10:00','YYYY MM DD HH24:MI:SS')
      ,TO_DATE('45','YY')
      ,TO_DATE('25','YY')
      -- RR은 세기를 자동으로 추적
      -- 50 ->1950
      --49 ->2049 (Y2K 2000년 문제)에 대한 대응책으로 도입된.
      ,TO_DATE('50','RR') as ex5
FROM dual;
CREAT TABLE ex5_2(
    title VARCHAR(100)
    ,d_day DATE
);
INSERT INTO ex5_2 VALUES ('종료일','20240614');
INSERT INTO ex5_2 VALUES ('종료일','2024.06.14');
INSERT INTO ex5_2 VALUES ('종료일','2024/06/14');
SELECT *
FROM ex5_2;
INSERT INTO ex5_2 VALUES ('종료일','2024 06 14');
INSERT INTO ex5_2 VALUES ('종료일',TO_DATE('2024 06 14 09','YYYY MM DD HH24'));
CREATE TABLE ex5_3(
    seq1 VARCHAR2(100)
    ,seq2 NUMBER
);
INSERT INTO ex5_3 VALUES ('1234','1234');
INSERT INTO ex5_3 VALUES ('99','99');
INSERT INTO ex5_3 VALUES ('123456','123456');
SELECT *
FROM ex5_3;
ORDER BY TO NUMBER (seq2) DESC;
--member 회원의 생년월일을 이용하여 나이를 계산하시오
-- 올해년도를 이용하여 (ex 2004 -2000 =>24세)

SELECT mem_name
      ,mem_bir
      ,(TO_CHAR(SYSDATE, 'YYYY') - TO_CHAR(mem_bir, 'YYYY')||'세') as age
FROM member
ORDER BY age DESC;
/*
고객 테이블(CUSTOMERS)에는
고객의 출생년도(cust_year_of_birth) 컬럼이 있다.
현재일 기준으로 이 컬럼을 활용해 30대. 30대, 50대를 구분해 출력하고,
나머지 연령대는 '기타'로 출력하는 쿼리를 작성해보자    
*/

SELECT cust_year_of_birth
      ,CASE WHEN TO_CHAR(SYSDATE, 'YYYY') - cust_year_of_birth < 60 
            AND TO_CHAR(SYSDATE, 'YYYY') - cust_year_of_birth >=50 THEN '50대'
            WHEN TO_CHAR(SYSDATE, 'YYYY') - cust_year_of_birth < 50 
            AND TO_CHAR(SYSDATE, 'YYYY') - cust_year_of_birth >=40 THEN '40대'
            WHEN TO_CHAR(SYSDATE, 'YYYY') - cust_year_of_birth < 40 
            AND TO_CHAR(SYSDATE, 'YYYY') - cust_year_of_birth >=30 THEN '30대'
       ELSE '기타'
       END as 연령대
FROM customers;











