--그룹함수 : 여러 행에 대하여 집계 출력
-- AVG, SUM, MIN, MAX, COUNT
SELECT * FROM EMPLOYEES;
SELECT AVG(SALARY),SUM(SALARY), MIN(SALARY), MAX(SALARY), COUNT(SALARY) FROM EMPLOYEES;
SELECT MIN(HIRE_DATE), MAX(HIRE_DATE) FROM EMPLOYEES;
SELECT MIN (FIRST_NAME), MAX(FIRST_NAME) FROM EMPLOYEES;

--COUNT(컬럼명): NULL이 아닌 데이터 갯수
SELECT COUNT(FIRST_NAME) FROM EMPLOYEES;
SELECT COUNT(DEPARTMENT_ID) FROM EMPLOYEES;
SELECT COUNT (COMMISSION_PCT) FROM EMPLOYEES;
--COUNT(*) 전체행의 갯수
SELECT COUNT(*) FROM EMPLOYEES;

--그룹함수 : 그룹함수와 일반컬럼을 동시에 출력할 수 없습니다. (오라클만)
SELECT FIRST_NAME, SUM(SALARY) FROM EMPLOYEES;
------------------------05-17----------------------------------
--SELECT 에는 그룹화 시킨 컬럼이 있어야 함
SELECT DEPARTMENT_ID, ROUND(AVG(SALARY)), SUM(SALARY),COUNT(*),MIN(SALARY) FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;
--주의할 점
SELECT DEPARTMENT_ID, FIRST_NAME
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID; --ERR 그룹화한 컬럼 외 다른 컬럼이 있는 경우 조회가 안됨

SELECT DEPARTMENT_ID, JOB_ID, ROUND(AVG(SALARY))FROM EMPLOYEES 
GROUP BY DEPARTMENT_ID, JOB_ID
ORDER BY DEPARTMENT_ID;

--그룹 함수를 WHERE 절에 적용할 수 없다.
--그룹 함수가 아니면 WHERE 절에 사용 가능
-- 그룹 함수와 함께 사용되는 HAVING 절을 이용하여 조건을 걸 수 있다.
SELECT JOB_ID, ROUND(AVG(SALARY))
FROM EMPLOYEES
GROUP BY JOB_ID
HAVING ROUND(AVG(SALARY))>10000;
-------------------------------------------------------------------------
--그룹의 조건은 HAVING절 사용
SELECT JOB_ID, AVG(SALARY)
FROM EMPLOYEES
WHERE JOB_ID LIKE '%MAN'
GROUP BY JOB_ID
HAVING AVG(SALARY)>=10000;

SELECT DEPARTMENT_ID, COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
HAVING COUNT(*)>=30;

SELECT JOB_ID, SUM(SALARY), SUM(NVL(COMMISSION_PCT,0))
FROM EMPLOYEES
WHERE JOB_ID NOT IN('IT_PROG')
GROUP BY JOB_ID
HAVING SUM(SALARY)>=20000
ORDER BY SUM(SALARY) DESC;
-- 부서 아이디가 50번 이상인 부서를 그룹화 시키고 그룹평균급여 5000이상만 출력
SELECT DEPARTMENT_ID, AVG(SALARY)
FROM EMPLOYEES
WHERE DEPARTMENT_ID >= 50
GROUP BY DEPARTMENT_ID
HAVING AVG(SALARY)>=5000
ORDER BY DEPARTMENT_ID;

---------------------------------------------------------------
--ROLLUP 각 그룹의 소계, 총계를 아래에 출력
SELECT DEPARTMENT_ID, TRUNC(AVG(SALARY))
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID);

SELECT DEPARTMENT_ID, JOB_ID, TRUNC(AVG(SALARY))
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID, JOB_ID);

SELECT DEPARTMENT_ID, JOB_ID, AVG(SALARY), COUNT(*)
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID, JOB_ID)
ORDER BY DEPARTMENT_ID, JOB_ID;

SELECT DEPARTMENT_ID, JOB_ID,TRUNC(AVG(SALARY))
FROM EMPLOYEES
GROUP BY CUBE ( DEPARTMENT_ID, JOB_ID)
ORDER BY DEPARTMENT_ID, JOB_ID;

--CUBE 서브그룹에 대한 컬럼출력
SELECT DEPARTMENT_ID, JOB_ID,TRUNC(SUM(SALARY))
FROM EMPLOYEES
GROUP BY CUBE ( DEPARTMENT_ID, JOB_ID)
ORDER BY DEPARTMENT_ID, JOB_ID;

--GROUPING() - GROUP BY 절로 생성되면 0 반환, ROLLUP CUBE 절로 생성되면 1 반환

SELECT DEPARTMENT_ID, JOB_ID, 
    DECODE(GROUPING(JOB_ID), 1, '소계',JOB_ID),
    GROUPING(DEPARTMENT_ID),
    GROUPING(JOB_ID), SUM(SALARY), COUNT(*)
FROM EMPLOYEES 
GROUP BY ROLLUP(DEPARTMENT_ID, JOB_ID)
ORDER BY DEPARTMENT_ID;
    

















--------------------------------------------------------------------
--문제 1.
--사원 테이블에서 JOB_ID별 사원 수를 구하세요.
--사원 테이블에서 JOB_ID별 월급의 평균을 구하세요. 월급의 평균 순으로 내림차순 정렬하세요
SELECT JOB_ID, COUNT(*) FROM EMPLOYEES GROUP BY JOB_ID;
SELECT JOB_ID, ROUND(AVG(SALARY),1)월급평균 FROM EMPLOYEES GROUP BY JOB_ID 
ORDER BY 월급평균 DESC;

--문제 2.
--사원 테이블에서 입사 년도 별 사원 수를 구하세요.
SELECT SUBSTR(HIRE_DATE, 1,2) 입사년도, COUNT(*) FROM EMPLOYEES 
GROUP BY SUBSTR(HIRE_DATE, 1,2);

SELECT TO_CHAR(HIRE_DATE,'YY') 입사연도,COUNT(*)
FROM EMPLOYEES
GROUP BY TO_CHAR(HIRE_DATE, 'YY');

--문제 3.
--급여가 1000 이상인 사원들의 부서별 평균 급여를 출력하세요. 단 부서 평균 급여가 2000이상인 부서만 출력
SELECT DEPARTMENT_ID, ROUND(AVG(SALARY),1)평균급여 FROM EMPLOYEES
WHERE SALARY >= 1000 
GROUP BY DEPARTMENT_ID 
HAVING AVG(SALARY)>=2000 
ORDER BY 평균급여 DESC;

--문제 4.
--사원 테이블에서 commission_pct(커미션) 컬럼이 null이 아닌 사람들의
--department_id(부서별) salary(월급)의 평균, 합계, count를 구합니다.
--조건 1) 월급의 평균은 커미션을 적용시킨 월급입니다.
--조건 2) 평균은 소수 2째 자리에서 절삭 하세요
SELECT AVG((SALARY*COMMISSION_PCT)+SALARY) FROM EMPLOYEES;
SELECT DEPARTMENT_ID, TRUNC(AVG((SALARY*COMMISSION_PCT)+SALARY),2) 월급평균,
       SUM(SALARY)월급합계,COUNT(COMMISSION_PCT) 사원수 
       FROM EMPLOYEES
       --WHERE COMMISSION_PCT IS NOT NULL
       GROUP BY DEPARTMENT_ID
       HAVING AVG((SALARY*COMMISSION_PCT)+SALARY)IS NOT NULL;
SELECT DEPARTMENT_ID, COMMISSION_PCT FROM EMPLOYEES 
        WHERE COMMISSION_PCT IS NOT NULL;
SELECT * FROM EMPLOYEES;

--문제 5.
--직업별 월급합, 총합계를 출력
SELECT 
DECODE(GROUPING(JOB_ID),1,'합계',JOB_ID)AS JOB_ID ,SUM(SALARY) 월급합
FROM EMPLOYEES
GROUP BY ROLLUP(JOB_ID);
--문제 6.
--부서별, JOB_ID를 그룹핑 하여
--토탈, 합계를 출력하세요.
--GROUPING() 을 이용하여
--소계 합계를 표현하세요
SELECT 
DECODE(GROUPING(DEPARTMENT_ID),1,'합계',DEPARTMENT_ID) AS DEPARTMENT_ID,
DECODE(GROUPING(JOB_ID),1,'소계',JOB_ID)AS JOB_ID,
COUNT(*)AS TOTAL, SUM(SALARY) AS SUM
FROM EMPLOYEES
GROUP BY ROLLUP(DEPARTMENT_ID, JOB_ID)
ORDER BY SUM;
---------------------------------------------------------------------------










