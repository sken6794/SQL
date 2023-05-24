--VIEW
/*
VIEW�� �������� �ڷḦ ���� ���� ����ϴ� �������̺��̴�.
VIEW�� �̿��ؼ� �ʿ��� �÷��� �����صθ�, ������ �����ϴ�.
VIEW�� ���ؼ� �����Ϳ� �����ϸ�, ���� �����ϰ� �����͸� ������ �� �ִ�.
*/
SELECT * FROM EMP_DETAILS_VIEW;
--�並 �����Ϸ��� ������ �ʿ��ϴ�.
SELECT * FROM USER_SYS_PRIVS;

--CREATE OR REPLACE VIEW
--���� ����
CREATE OR REPLACE VIEW EMPS_VIEW
AS (
SELECT EMPLOYEE_ID, 
       FIRST_NAME || ' '||LAST_NAME AS NAME,
       JOB_ID,
       SALARY
FROM EMPLOYEES
);
SELECT * FROM EMPS_VIEW;
--���� ������ OR REPLACE���� ������ �ȴ�.
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

--���� ��
--JOIN�� �̿��ؼ� �ʿ��� �����͸� ��� ������
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
VIEW�� ���� DML�� �����ϱ� ������, ��� ��������� �ִ�.
1. ���� �̸� �ȵȴ�. (�����÷�)
2. JOIN�� �̿��� ���̺� �Ұ���.
3. �������̺�  NOT NULL������ �ִٸ� �ȵȴ�.
*/

SELECT * FROM EMPS_VIEW;

INSERT INTO EMPS_VIEW(EMPLOYEE_ID, NAME, DEPARTMENT_NAME,
    JOB_TITLE) VALUES (1000,'DEMO HONE','DEMO_IT','DEMO_IT_PROG');
    
INSERT INTO EMPS_VIEW( DEPARTMENT_NAME) VALUES ('DEMO');

DESC DEPARTMENTS;

INSERT INTO EMPS_VIEW(EMPLOYEE_ID, JOB_TITLE) VALUES(300,'TEST');
--------------------------------------------------
-- ���� �������� READ ONLY
-- DML������ �並 ���ؼ��� �� �� ����.
CREATE OR REPLACE VIEW EMPS_VIEW
AS (
    SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY
    FROM EMPLOYEES
) WITH READ ONLY;






