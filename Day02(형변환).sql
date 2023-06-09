--형변환 함수
-- 자동 형변환
-- 문자로 넣어도 숫자로 형변환 되어서 값을 찾아줌
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = '30'; 
SELECT SYSDATE -5, SYSDATE - '5' FROM EMPLOYEES; --자동 형변환

--강제 형변환
-- TO CHAR(날짜, 날짜포맷)
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YY/MM/DD HH24/MI/SS') FROM DUAL;
--SELECT TO_CHAR(SYSDATE, 'YYYY년MM월DD일') FROM DUAL;
--포맷 문자가 아닌 내가 원하는 문자로 형식을만들고 싶으면 " " 을 사용한다.
SELECT TO_CHAR(SYSDATE, 'YYYY"년"MM"월"DD"일"') FROM DUAL;
SELECT TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') FROM EMPLOYEES;

--TO_CHAR(숫자, 숫자포맷)
SELECT TO_CHAR(200000, '$999,999,999') FROM DUAL;
SELECT TO_CHAR(200000, '999999.999') FROM DUAL;
-- L999 지역화폐가 나옴 나라에 맞춰서
SELECT TO_CHAR( SALARY*1300, 'L999,999,999') FROM EMPLOYEES ORDER BY SALARY DESC;
-- 자리수를 0으로 채움
SELECT FIRST_NAME, TO_CHAR(SALARY*1300, 'L0999,999,999') FROM EMPLOYEES; 

--TO_NUMBER (문자, 숫자포맷)
SELECT '3.14' + 2000 FROM DUAL; -- 자동 형변환
SELECT TO_NUMBER('3.14') + 2000 FROM DUAL; --명시적 형변환
--SELECT '￦3,300' + 2000 FROM DUAL; 그냥 문자를 사용하면 자동 형변환이 안됨
--문자포맷을 이용한 숫자로 명시적 형변환
SELECT TO_NUMBER('$3,300','$999,999')+2000 FROM DUAL;

--TO_DATE (문자, 날짜포맷)
SELECT '2023-05-16' FROM DUAL;
SELECT TO_DATE('2023-05-18', 'YYYY-MM-DD') - SYSDATE FROM DUAL;
SELECT TO_DATE('2023-05-18 11:31:23', 'YYYY/MM/DD HH:MI:SS') - SYSDATE FROM DUAL;
SELECT TO_DATE('2023-05-18', 'YYYY-MM-DD')  FROM DUAL;


--아래 값을 YYYY년 MM월 DD일 형태로 출력
SELECT '20050105' FROM DUAL;
SELECT TO_CHAR(TO_DATE('20050105', 'YYYY/MM/DD'),'YYYY"년"MM"월"DD"일"') 날짜  FROM DUAL; 



--아래 값과 현재 날짜와 일 수 차이를 구하세요
SELECT '2005년01월05일' FROM DUAL;
SELECT SYSDATE - TO_DATE('2005년01월05일','YYYY"년"MM"월"DD"일"') FROM DUAL;

-----------------------------------------------------------------------------
--NULL값에 대한 변환 
--NVL(컬럼, NULL일 경우 처리)
SELECT NVL(NULL,0) FROM DUAL;
SELECT NVL(COMMISSION_PCT,0) FROM EMPLOYEES;
SELECT FIRST_NAME, COMMISSION_PCT *100 FROM EMPLOYEES; --NULL 연산 시 NULL
SELECT FIRST_NAME, NVL(COMMISSION_PCT,0)*100 FROM EMPLOYEES
ORDER BY COMMISSION_PCT;

--NVL2(컬럼, NULL이 아닌경우처리, NULL인 경우 처리)
--총 월급은 얼마인지
SELECT FIRST_NAME, SALARY,
NVL2(COMMISSION_PCT,SALARY+(SALARY*COMMISSION_PCT),SALARY) 급여 
FROM EMPLOYEES ORDER BY 급여 DESC;

--DECODE() -ELSE IF 문을 대체하는 함수
SELECT DECODE('D', 'A','A입니다'
                  ,'B', 'B임'
                  ,'C', 'C임'
                  ,'ABC아님') FROM DUAL;

SELECT JOB_ID, DECODE (JOB_ID, 'IT_PROG',SALARY*0.3,
                              'FI_MGR',SALARY*0.2
                              , SALARY) REVISED_SALARY 
FROM EMPLOYEES;


--CASE WHEN THEN ELSE
SELECT JOB_ID, SALARY,
    CASE JOB_ID WHEN 'IT_PROG' THEN SALARY*1.10
                WHEN 'FI_MGE' THEN SALARY*1.15
                WHEN 'FI_ACCOUNT' THEN SALARY*1.20
        ELSE SALARY
    END AS REVISED_SALARY
FROM EMPLOYEES;

SELECT JOB_ID,
    CASE  WHEN JOB_ID= 'IT_PROG' THEN SALARY*0.3
          WHEN JOB_ID='FI_MGR' THEN SALARY*0.2
          ELSE SALARY
    END AS REVISED_SALARY
FROM EMPLOYEES;

--COALESCE(A, B) -NVL이랑 유사 NULL일 경우 0으로 치환
SELECT COALESCE ( COMMISSION_PCT,0) FROM EMPLOYEES;

--------------------------------------------------------------------

----문제 1.
SELECT EMPLOYEE_ID, FIRST_NAME || LAST_NAME, HIRE_DATE,
TRUNC((SYSDATE-HIRE_DATE)/365)  근속년수 FROM EMPLOYEES 
WHERE TRUNC((SYSDATE-HIRE_DATE)/365)>15 
ORDER BY 근속년수 DESC;
-- WHERE 절에는 ALIAS를 사용할 수 없다.
----문제 2.
SELECT FIRST_NAME, MANAGER_ID, 
DECODE( MANAGER_ID, 100, '사원',
                    120, '주임',
                    121, '대리',
                    122, '과장',
                    '임원') 직급
FROM EMPLOYEES WHERE DEPARTMENT_ID = 50
ORDER BY MANAGER_ID DESC;
----------------------------------------------------------------------------



