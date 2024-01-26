/*집계함수 대상 데이터를 특징 그룹으로 묶은 다음 그룹에 대한 총합, 평귣,최댓값, 
최솟값 등을 구하는 함수.*/

--COUNT 로우 수를 반환하는 집계함수
SELECT COUNT(*)
      ,COUNT (department_id) --null 포함
      ,COUNT(ALL department_id) -- default ALL
      ,COUNT(DISTINCT department_id) -- 중복 포함, null x
      ,COUNT(DISTINCT department_id) -- 중복제거
      ,COUNT(employee_id)
FROM employees;
SELECT COUNT(meme_id)
      ,COUNT(*)
FROM member;
SELECT SUM(salary)          as 합계
      ,ROUND(AVG(salary),2) as 평균
      ,MAX(salary)          as 최대
      ,MIN(salary)          as 최소
      ,COUNT(employee_id)   as 직원수
FROM employees;
-- 부서별 집계 <-- 그룹의 대상 부서
SELECT department_id
      ,SUM(salary)          as 합계
      ,ROUND(AVG(salary),2) as 평균
      ,MAX(salary)          as 최대
      ,MIN(salary)          as 최소
      ,COUNT(employee_id)   as 직원수
FROM employees
GROUP BY department_id
ORDER BY 1;
--30,60,90 부서의 집계
SELECT department_id
      ,SUM(salary)          as 합계
      ,ROUND(AVG(salary),2) as 평균
      ,MAX(salary)          as 최대
      ,MIN(salary)          as 최소
      ,COUNT(employee_id)   as 직원수
FROM employees
WHERE department_id IN(30,60,90)
GROUP BY department_id 
ORDER BY 1;
--member 회원의 직업별 마일리지의 합계, 평균, 최대 , 최소 값과 회원수를 출력하시오

SELECT *
FROM member;

SELECT mem_job
      ,SUM(mem_mileage)          as 마일리지합계
      ,ROUND(AVG(mem_mileage),2) as 마일리지평균 -- 2는 소숫점 두번째 자리까지 표현
      ,MAX(mem_mileage)          as 마일리지최대
      ,MIN(mem_mileage)          as 마일리지최소
      ,COUNT(mem_id)             as 회원수
FROM member
GROUP BY mem_job 
ORDER BY 4 DESC;

-- kor_loan_status 테이블에 loan_jan_amt 컬럼을 활용하여
--2013년도 기간별 총 대출잔액을 출력하시오
SELECT *
FROM kor_loan_status;
SELECT PERIOD
      ,SUM(LOAN_JAN_AMT) as 총잔액
FROM kor_loan_status
WHERE SUBSTR(period,1,4) ='2013'
GROUP BY PERIOD
ORDER BY 1;
--기간별, 지역별, 대출총합계를 출력하시오
SELECT period
      ,region
      ,SUM(loan_jan_amt) as 합계
FROM kor_loan_status
GROUP BY period
        ,region
ORDER BY 1;
--년도별, 지역별 대출합계
SELECT SUBSTR(period,1,4) as 년도
      ,region
      ,SUM(loan_jan_amt) as 합계
FROM kor_loan_status
WHERE region ='대전'
GROUP BY SUBSTR(period,1,4)
        ,region
ORDER BY 1;      


-- employees 직원들의 입사년도별 직원수를 출력하시오

SELECT TO_CHAR(hire_date,'YYYY') as 년도
      ,COUNT(*) as 직원수
FROM employees
GROUP BY TO_CHAR(hire_date,'YYYY')
ORDER BY 년도;
-- 집계 데이터에 대해서 검색조건을 사용하려면 HAVING 사용
-- 입사직원이 10명 이상인 년도에 직원수 출력
-- select문 실행순서
-- from -> where -> group by -> having -> select -> order by
SELECT TO_CHAR(hire_date,'YYYY') as 년도
      ,COUNT(*) as 직원수
FROM employees
GROUP BY TO_CHAR(hire_date,'YYYY')
HAVING COUNT(*) >=10
ORDER BY 년도;

--member 테이블을 활용하여
--직업별 마일리지 평균금액을 구하시오
--소수점 2째 자리까지 반올림하여 출력
--1)정렬 평균마일리지 내림차순
--2)평균 마일리지가 3000이상인 데이터만 출력

SELECT mem_job
      ,ROUND(AVG(mem_mileage),2) as AVG_MILEAGE --ROUND는 소숫점 반올림 해주는 함수     
FROM member
GROUP BY mem_job
HAVING ROUND(AVG(mem_mileage),2) >= 3000
ORDER BY AVG_MILEAGE DESC;
-- customers 회원의 전체 회원수, 남자 회원수, 여자 회원수를 출력하시오
SELECT *
FROM customers;

SELECT COUNT(cust_gender) as 전체
       , SUM(DECODE(cust_gender,'F',1,0)) as 여자
       , SUM(DECODE(cust_gender,'M',1,0)) as 남자
FROM customers;



