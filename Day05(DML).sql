--INSERT UPDATE DELETE 문을 작성하면 COMMIT명령으로 실제 반영을 처리하는 작업이 필요
--INSERT
DESC DEPARTMENTS;
--전체 행을 넣는 경우 컬럼명 생략 가능
INSERT INTO DEPARTMENTS VALUES (300, 'DEV',NULL,1700);
-- 선택적으로 넣는 경우 컬럼명 표현
INSERT INTO DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME)VALUES (310,'SYSTEM');
SELECT * FROM DEPARTMENTS;
ROLLBACK;

--사본 테이블(테이블 구조만 복사) (암기 할 필요X)
CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES WHERE 1=2);
SELECT * FROM EMPS;
--INSERT 문에서도 서브쿼리 사용가능
INSERT INTO EMPS (SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');
--INSERT 문의 VALUES에도 서브쿼리를 사용할 수 있다.
INSERT INTO EMPS (EMPLOYEE_ID, LAST_NAME, EMAIL,HIRE_DATE, JOB_ID)
VALUES (200,
       (SELECT LAST_NAME FROM EMPLOYEES WHERE EMPLOYEE_ID = 200),
       (SELECT EMAIL FROM EMPLOYEES WHERE EMPLOYEE_ID = 200),
       SYSDATE,
       'TEST');
-------------------UPDATE --------------------------------------
SELECT * FROM EMPS;
SELECT * FROM EMPS WHERE EMPLOYEE_ID=103;

UPDATE EMPS
SET HIRE_DATE =SYSDATE,
        LAST_NAME = 'HONG',
        SALARY = SALARY+1000
WHERE EMPLOYEE_ID = 103;
ROLLBACK;
--EX2 
UPDATE EMPS 
SET COMMISSION_PCT = 0.1
WHERE JOB_ID IN('IT_PROG','SA_MAN');
SELECT * FROM EMPS;
--EX3 
--ID = 200 인 사람을 103번의 급여로 변경
UPDATE EMPS
SET SALARY = (SELECT SALARY FROM EMPS WHERE EMPLOYEE_ID = 103)
WHERE EMPLOYEE_ID = 200;

--EX4 
SELECT * FROM EMPS;
UPDATE EMPS
SET (JOB_ID, SALARY,COMMISSION_PCT) 
    = (SELECT JOB_ID, SALARY, COMMISSION_PCT 
        FROM EMPS WHERE EMPLOYEE_ID = 103)
WHERE EMPLOYEE_ID = 200;
COMMIT;
------------------------------------------------------
--DELETE
--테이블 복사 , 데이터 복사 동시에
CREATE TABLE DEPTS AS ( SELECT * FROM DEPARTMENTS WHERE 1=1); 
SELECT * FROM DEPTS;
--EX 삭제할 때는 꼭 PK를 활용해서 삭제
DELETE FROM EMPS WHERE EMPLOYEE_ID = 200;
SELECT * FROM EMPS;
--EX2
DELETE FROM EMPS 
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME='IT');
                        
SELECT * FROM EMPLOYEES;                        
SELECT * FROM DEPARTMENTS;
--EMPLOYEE가 60번 부서를 사용하고 있기 때문에 사용 불가 
DELETE FROM DEPARTMENTS WHERE DEPARTMENT_ID = 60;
--------------------------------------------------------------------------
--MERGE ( 테이블 병합하기 ) 
--두 테이블을 비교해서 데이터가 있으면 업데이트, 없다면 INSERT 
SELECT * FROM EMPS;

MERGE INTO EMPS E
USING (SELECT * FROM EMPLOYEES 
        WHERE JOB_ID IN ('IT_PROG','SA_MAN'))J
ON (E.EMPLOYEE_ID = J.EMPLOYEE_ID)
WHEN MATCHED THEN
    UPDATE SET 
        E.HIRE_DATE = J.HIRE_DATE,
        E.SALARY = J.SALARY,
        E.COMMISSION_PCT = J.COMMISSION_PCT
WHEN NOT MATCHED THEN
    INSERT VALUES
        (J.EMPLOYEE_ID,J.FIRST_NAME,J.LAST_NAME,
         J.EMAIL,J.PHONE_NUMBER,J.HIRE_DATE,J.JOB_ID,
         J.SALARY,J.COMMISSION_PCT,J.MANAGER_ID,J.DEPARTMENT_ID);
SELECT * FROM EMPS;
              
--MERGE2
SELECT * FROM EMPS;

MERGE INTO EMPS E
USING DUAL
ON (E.EMPLOYEE_ID = 103)
WHEN MATCHED THEN
    UPDATE SET LAST_NAME = 'DEMO'
WHEN NOT MATCHED THEN
    INSERT (EMPLOYEE_ID,
            LAST_NAME,
            EMAIL,
            HIRE_DATE,
            JOB_ID) 
            VALUES (1000,
                    'DEMO',
                    'DEMO',
                    SYSDATE,
                    'DEMO');
SELECT * FROM EMPS;
DELETE FROM EMPS WHERE EMPLOYEE_ID = 103;
-------------------------------------------------
--문제 1.
INSERT INTO DEPTS 
VALUES (280,'개발',NULL,1800);
INSERT INTO DEPTS 
VALUES (290,'회계부',NULL,1800);
INSERT INTO DEPTS 
VALUES (300,'재정',301,1800);
INSERT INTO DEPTS 
VALUES (310,'인사',302,1800);
INSERT INTO DEPTS 
VALUES (320,'영업',303,1700);
SELECT * FROM DEPTS;                  
--문제 2
--DEPTS테이블의 데이터를 수정합니다
--1. department_name 이 IT Support 인 데이터의 department_name을 IT bank로 변경
--2. department_id가 290인 데이터의 manager_id를 301로 변경
--3. department_name이 IT Helpdesk인 데이터의 부서명을 IT Help로 , 매니저아이디를 303으로, 지역아이디를
--1800으로 변경하세요
--4. 재정,인사,영업 의 매니저아이디를 301로 한번에 변경하세요
UPDATE DEPTS SET DEPARTMENT_NAME = 'IT BANK'
WHERE DEPARTMENT_NAME = 'IT Support';

UPDATE DEPTS SET MANAGER_ID = 301
WHERE DEPARTMENT_ID = 290;

UPDATE DEPTS 
SET DEPARTMENT_NAME = 'IT Help',
    MANAGER_ID = 303,
    LOCATION_ID = 1800
WHERE DEPARTMENT_NAME = 'IT Helpdesk';

UPDATE DEPTS
SET MANAGER_ID = 301
WHERE DEPARTMENT_NAME IN ('재정','인사','영업');
--문제 3.
--삭제의 조건은 항상 primary key로 합니다, 여기서 primary key는 department_id라고 가정합니다.
--1. 부서명 영업부를 삭제 하세요
--2. 부서명 NOC를 삭제하세요
DELETE FROM DEPTS
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID 
                        FROM DEPTS WHERE DEPARTMENT_NAME = '영업');
DELETE FROM DEPTS
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID 
                        FROM DEPTS WHERE DEPARTMENT_NAME = 'NOC');
SELECT * FROM DEPTS;
COMMIT;
--문제4
--1. Depts 사본테이블에서 department_id 가 200보다 큰 데이터를 삭제하세요.
--2. Depts 사본테이블의 manager_id가 null이 아닌 데이터의 manager_id를 전부 100으로 변경하세요.
--3. Depts 테이블은 타겟 테이블 입니다.
--4. Departments테이블은 매번 수정이 일어나는 테이블이라고 가정하고 Depts와 비교하여
--일치하는 경우 Depts의 부서명, 매니저ID, 지역ID를 업데이트 하고
--새로유입된 데이터는 그대로 추가해주는 merge문을 작성하세요.
DELETE FROM DEPTS 
WHERE DEPARTMENT_ID > 200;
UPDATE DEPTS 
SET MANAGER_ID = 100
WHERE MANAGER_ID IS NOT NULL;
SELECT * FROM DEPTS;
COMMIT;

MERGE INTO DEPTS D
USING DEPARTMENTS O
ON ( D.DEPARTMENT_ID = O.DEPARTMENT_ID)
    WHEN MATCHED THEN
        UPDATE SET 
              D.DEPARTMENT_NAME=O.DEPARTMENT_NAME,
              D.MANAGER_ID = O.MANAGER_ID,
              D.LOCATION_ID=O.LOCATION_ID
    WHEN NOT MATCHED THEN
        INSERT VALUES (
                O.DEPARTMENT_ID,
                O.DEPARTMENT_NAME,
                O.MANAGER_ID,
                O.LOCATION_ID);
SELECT * FROM DEPARTMENTS;
SELECT * FROM DEPTS;
COMMIT;

--문제 5
--1. jobs_it 사본 테이블을 생성하세요 (조건은 min_salary가 6000보다 큰 데이터만 복사합니다)
--2. jobs_it 테이블에 다음 데이터를 추가하세요
--3. jobs_it은 타겟 테이블 입니다
--4. jobs테이블은 매번 수정이 일어나는 테이블이라고 가정하고 jobs_it과 비교하여
--min_salary컬럼이 0보다 큰 경우 기존의 데이터는 min_salary, max_salary를 업데이트 하고 새로 유입된
--데이터는 그대로 추가해주는 merge문을 작성하세요
CREATE TABLE JOBS_IT AS SELECT * FROM JOBS
WHERE MIN_SALARY>6000;
SELECT * FROM JOBS_IT;

MERGE INTO JOBS_IT J 
USING (SELECT * FROM JOBS WHERE MIN_SALARY>0)O
ON (J.JOB_ID = O.JOB_ID)
    WHEN MATCHED THEN
        UPDATE SET
            J.MIN_SALARY = O.MIN_SALARY,
            J.MAX_SALARY = O.MAX_SALARY
    WHEN NOT MATCHED THEN
        INSERT VALUES
            (O.JOB_ID,O.JOB_TITLE,O.MIN_SALARY,O.MAX_SALARY);
COMMIT;


