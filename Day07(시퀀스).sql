--������ ( ���������� �����ϴ� �� )
-- PK�� ���� ���ȴ�.
SELECT * FROM USER_SEQUENCES;

--����� ������ ����
CREATE SEQUENCE DEPTS_SEQ
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 10
    MINVALUE 1
    NOCYCLE
    NOCACHE;
    
--������ (�� ���ǰ� �ִ� ��������� ����) 
DROP SEQUENCE DEPTS_SEQ;
    
DROP TABLE DEPTS;    
CREATE TABLE DEPTS AS ( SELECT * FROM DEPARTMENTS WHERE 1=2);
ALTER TABLE DEPTS ADD CONSTRAINT DEPTS_PK PRIMARY KEY (DEPARTMENT_ID);
SELECT * FROM DEPTS;
--������ ���

--�������� ���� �� Ȯ�� (������ ��)
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL; 
--�������� ���� �� Ȯ��
SELECT DEPTS_SEQ.CURRVAL FROM DUAL;
--�������� �ִ밪�� 10���� �����س��⿡ 10 �Ѿ�� INSERT�� ���� �ʴ´�.
--�������� �ִ밪 �����ϸ� �� �̻� ����� �� ����.
INSERT INTO DEPTS VALUES (DEPTS_SEQ.NEXTVAL, 'TEST',100,1000);
SELECT * FROM DEPTS;
--������ ����
ALTER SEQUENCE DEPTS_SEQ MAXVALUE 99999;
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY 10;
CREATE SEQUENCE DEPTS2_SEQ NOCACHE;
SELECT * FROM USER_SEQUENCES;

--������ �ʱ�ȭ(�������� ���̺��� ���ǰ� �ִ� ���, ������ DROP �ϸ� �ȵ�.
--1. ��������� Ȯ��
SELECT DEPTS_SEQ.CURRVAL FROM DUAL;
--2. �������� ������ ����
-- ���� �������� 1�� ����
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY -49;
--3. ������ ����
SELECT DEPTS_SEQ.NEXTVAL FROM DUAL;
--4. ������ �������� �ٽ� 1�� ����
ALTER SEQUENCE DEPTS_SEQ INCREMENT BY 1;
-- ���� �������� 2����  �����ϰ� �ȴ�.

--������ vs �⺰�� ������ vs �����ѹ��ڿ�
--ex) 20230523-00001-��ǰ��ȣ 
CREATE TABLE DEPTS3 (
    DEPT_NO VARCHAR2(30) PRIMARY KEY,
    DEPT_NAME VARCHAR2(20)
);
CREATE SEQUENCE DEPT3_SEQ NOCACHE;

INSERT INTO DEPTS3 VALUES (
    TO_CHAR(SYSDATE, 'YYYYMMDD')||'-'||LPAD(DEPT3_SEQ.NEXTVAL,5,'0')||'-'||'��ǰ��ȣ', 'TEST');
SELECT * FROM DEPTS3;
-------------------------------------------------------------
--INDEX
--�ε����� PK, UK���� �ڵ������Ǵ� UNIQUE�ε����� �ִ�.
--�ε����� ������ ��ȸ�� ������ ���ִ� HINT ������ �Ѵ�.
--���� ������� �ʴ� �Ϲ��÷��� �ε����� ������ �� �ִ�.
CREATE TABLE EMPS_IT AS (SELECT * FROM EMPLOYEES WHERE 1=1);
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Allan';

--�ε��� ���� (�ε����� ��ȸ�� ������ �ϱ� ������, ������ �ϰ� ���� �����ϸ�, ������ ������ ������ �� �ִ�.
--����ũ �ε��� (�÷����� ����ũ�ؾ� �Ѵ�)
CREATE UNIQUE INDEX EMPS_IT_IDX ON EMPS_IT (FIRST_NAME);
--�ε��� ����
DROP INDEX EMPS_IT_IDX;
--�ε����� (�����ε���) �����÷��� ������ �� �ִ�.
CREATE INDEX EMPS_IT_IDX ON EMPS_IT (FIRST_NAME, LAST_NAME);
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Allan';
SELECT * FROM EMPS_IT WHERE FIRST_NAME = 'Allan' AND LAST_NAME = 'McEwen';    
    
--FIRST_NAME �������� ����
--�ε����� �������� ��Ʈ�� �ִ� ��� ( ����Ŭ���� ������) 
SELECT /*+ INDEX_DESC (E EMPS_IT_IDX)*/ 
    ROWNUM RN, E.*
FROM EMPS_IT E
ORDER BY FIRST_NAME DESC;

SELECT *
FROM (SELECT /*+ INDEX_DESC (E EMPS_IT_IDX)*/ 
    ROWNUM RN, E.*
    FROM EMPS_IT E)
WHERE RN >10 AND RN <=20;




