--INSERT UPDATE DELETE ���� �ۼ��ϸ� COMMIT������� ���� �ݿ��� ó���ϴ� �۾��� �ʿ�
--INSERT
DESC DEPARTMENTS;
--��ü ���� �ִ� ��� �÷��� ���� ����
INSERT INTO DEPARTMENTS VALUES (300, 'DEV',NULL,1700);
-- ���������� �ִ� ��� �÷��� ǥ��
INSERT INTO DEPARTMENTS (DEPARTMENT_ID,DEPARTMENT_NAME)VALUES (310,'SYSTEM');
SELECT * FROM DEPARTMENTS;
ROLLBACK;

--�纻 ���̺�(���̺� ������ ����) (�ϱ� �� �ʿ�X)
CREATE TABLE EMPS AS (SELECT * FROM EMPLOYEES WHERE 1=2);
SELECT * FROM EMPS;
--INSERT �������� �������� ��밡��
INSERT INTO EMPS (SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');
--INSERT ���� VALUES���� ���������� ����� �� �ִ�.
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
--ID = 200 �� ����� 103���� �޿��� ����
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
--���̺� ���� , ������ ���� ���ÿ�
CREATE TABLE DEPTS AS ( SELECT * FROM DEPARTMENTS WHERE 1=1); 
SELECT * FROM DEPTS;
--EX ������ ���� �� PK�� Ȱ���ؼ� ����
DELETE FROM EMPS WHERE EMPLOYEE_ID = 200;
SELECT * FROM EMPS;
--EX2
DELETE FROM EMPS 
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENTS
                        WHERE DEPARTMENT_NAME='IT');
                        
SELECT * FROM EMPLOYEES;                        
SELECT * FROM DEPARTMENTS;
--EMPLOYEE�� 60�� �μ��� ����ϰ� �ֱ� ������ ��� �Ұ� 
DELETE FROM DEPARTMENTS WHERE DEPARTMENT_ID = 60;
--------------------------------------------------------------------------
--MERGE ( ���̺� �����ϱ� ) 
--�� ���̺��� ���ؼ� �����Ͱ� ������ ������Ʈ, ���ٸ� INSERT 
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
--���� 1.
INSERT INTO DEPTS 
VALUES (280,'����',NULL,1800);
INSERT INTO DEPTS 
VALUES (290,'ȸ���',NULL,1800);
INSERT INTO DEPTS 
VALUES (300,'����',301,1800);
INSERT INTO DEPTS 
VALUES (310,'�λ�',302,1800);
INSERT INTO DEPTS 
VALUES (320,'����',303,1700);
SELECT * FROM DEPTS;                  
--���� 2
--DEPTS���̺��� �����͸� �����մϴ�
--1. department_name �� IT Support �� �������� department_name�� IT bank�� ����
--2. department_id�� 290�� �������� manager_id�� 301�� ����
--3. department_name�� IT Helpdesk�� �������� �μ����� IT Help�� , �Ŵ������̵� 303����, �������̵�
--1800���� �����ϼ���
--4. ����,�λ�,���� �� �Ŵ������̵� 301�� �ѹ��� �����ϼ���
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
WHERE DEPARTMENT_NAME IN ('����','�λ�','����');
--���� 3.
--������ ������ �׻� primary key�� �մϴ�, ���⼭ primary key�� department_id��� �����մϴ�.
--1. �μ��� �����θ� ���� �ϼ���
--2. �μ��� NOC�� �����ϼ���
DELETE FROM DEPTS
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID 
                        FROM DEPTS WHERE DEPARTMENT_NAME = '����');
DELETE FROM DEPTS
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID 
                        FROM DEPTS WHERE DEPARTMENT_NAME = 'NOC');
SELECT * FROM DEPTS;
COMMIT;
--����4
--1. Depts �纻���̺��� department_id �� 200���� ū �����͸� �����ϼ���.
--2. Depts �纻���̺��� manager_id�� null�� �ƴ� �������� manager_id�� ���� 100���� �����ϼ���.
--3. Depts ���̺��� Ÿ�� ���̺� �Դϴ�.
--4. Departments���̺��� �Ź� ������ �Ͼ�� ���̺��̶�� �����ϰ� Depts�� ���Ͽ�
--��ġ�ϴ� ��� Depts�� �μ���, �Ŵ���ID, ����ID�� ������Ʈ �ϰ�
--�������Ե� �����ʹ� �״�� �߰����ִ� merge���� �ۼ��ϼ���.
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

--���� 5
--1. jobs_it �纻 ���̺��� �����ϼ��� (������ min_salary�� 6000���� ū �����͸� �����մϴ�)
--2. jobs_it ���̺� ���� �����͸� �߰��ϼ���
--3. jobs_it�� Ÿ�� ���̺� �Դϴ�
--4. jobs���̺��� �Ź� ������ �Ͼ�� ���̺��̶�� �����ϰ� jobs_it�� ���Ͽ�
--min_salary�÷��� 0���� ū ��� ������ �����ʹ� min_salary, max_salary�� ������Ʈ �ϰ� ���� ���Ե�
--�����ʹ� �״�� �߰����ִ� merge���� �ۼ��ϼ���
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


