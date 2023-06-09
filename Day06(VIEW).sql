--VIEW
/*
VIEW는 제한적인 자료를 보기 위해 사용하는 가상테이블이다.
VIEW를 이용해서 필요한 컬럼을 정의해두면, 관리가 용이하다.
VIEW를 통해서 데이터에 접근하면, 비교적 안전하게 데이터를 관리할 수 있다.
*/
SELECT * FROM EMP_DETAILS_VIEW;
--뷰를 생성하려면 권한이 필요하다.
SELECT * FROM USER_SYS_PRIVS;

--CREATE OR REPLACE VIEW
--뷰의 생성
CREATE OR REPLACE VIEW EMPS_VIEW
AS (
SELECT EMPLOYEE_ID, 
       FIRST_NAME || ' '||LAST_NAME AS NAME,
       JOB_ID,
       SALARY
FROM EMPLOYEES
);
SELECT * FROM EMPS_VIEW;
--뷰의 수정은 OR REPLACE문이 있으면 된다.
CREATE OR REPLACE VIEW EMPS_VIEW
AS (
SELECT EMPLOYEE_ID,
       FIRST_NAME ||' '||LAST_NAME AS NAME,
       JOB_ID,
       SALARY,
       COMMISSION_PCT
FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG'
);

--복합 뷰
--JOIN을 이용해서 필요한 데이터를 뷰로 생성함
CREATE OR REPLACE VIEW EMPS_VIEW
AS (
SELECT E.EMPLOYEE_ID,
       FIRST_NAME||' '||LAST_NAME AS NAME,
       D.DEPARTMENT_NAME,
       J.JOB_TITLE
FROM EMPLOYEES E 
LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
LEFT JOIN JOBS J ON E.JOB_ID = J.JOB_ID
);

SELECT * FROM EMPS_VIEW
WHERE NAME LIKE '%Nancy%';
DROP VIEW EMPS_VIEW;

-----------------------------------------------------
/*
VIEW를 통한 DML은 가능하긴 하지만, 몇가지 제약사항이 있다.
1. 가상열 이면 안된다. (가상컬럼)
2. JOIN을 이용한 테이블 불가능.
3. 원본테이블  NOT NULL제약이 있다면 안된다.
*/

SELECT * FROM EMPS_VIEW;

INSERT INTO EMPS_VIEW(EMPLOYEE_ID, NAME, DEPARTMENT_NAME,
    JOB_TITLE) VALUES (1000,'DEMO HONE','DEMO_IT','DEMO_IT_PROG');
    
INSERT INTO EMPS_VIEW( DEPARTMENT_NAME) VALUES ('DEMO');

DESC DEPARTMENTS;

INSERT INTO EMPS_VIEW(EMPLOYEE_ID, JOB_TITLE) VALUES(300,'TEST');
--------------------------------------------------
-- 뷰의 제약조건 READ ONLY
-- DML문장이 뷰를 통해서는 할 수 없음.
CREATE OR REPLACE VIEW EMPS_VIEW
AS (
    SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY
    FROM EMPLOYEES
) WITH READ ONLY;






