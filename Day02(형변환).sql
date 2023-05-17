--����ȯ �Լ�
-- �ڵ� ����ȯ
-- ���ڷ� �־ ���ڷ� ����ȯ �Ǿ ���� ã����
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = '30'; 
SELECT SYSDATE -5, SYSDATE - '5' FROM EMPLOYEES; --�ڵ� ����ȯ

--���� ����ȯ
-- TO CHAR(��¥, ��¥����)
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YY/MM/DD HH24/MI/SS') FROM DUAL;
--SELECT TO_CHAR(SYSDATE, 'YYYY��MM��DD��') FROM DUAL;
--���� ���ڰ� �ƴ� ���� ���ϴ� ���ڷ� ����������� ������ " " �� ����Ѵ�.
SELECT TO_CHAR(SYSDATE, 'YYYY"��"MM"��"DD"��"') FROM DUAL;
SELECT TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') FROM EMPLOYEES;

--TO_CHAR(����, ��������)
SELECT TO_CHAR(200000, '$999,999,999') FROM DUAL;
SELECT TO_CHAR(200000, '999999.999') FROM DUAL;
-- L999 ����ȭ�� ���� ���� ���缭
SELECT TO_CHAR( SALARY*1300, 'L999,999,999') FROM EMPLOYEES ORDER BY SALARY DESC;
-- �ڸ����� 0���� ä��
SELECT FIRST_NAME, TO_CHAR(SALARY*1300, 'L0999,999,999') FROM EMPLOYEES; 

--TO_NUMBER (����, ��������)
SELECT '3.14' + 2000 FROM DUAL; -- �ڵ� ����ȯ
SELECT TO_NUMBER('3.14') + 2000 FROM DUAL; --����� ����ȯ
--SELECT '��3,300' + 2000 FROM DUAL; �׳� ���ڸ� ����ϸ� �ڵ� ����ȯ�� �ȵ�
--���������� �̿��� ���ڷ� ����� ����ȯ
SELECT TO_NUMBER('$3,300','$999,999')+2000 FROM DUAL;

--TO_DATE (����, ��¥����)
SELECT '2023-05-16' FROM DUAL;
SELECT TO_DATE('2023-05-18', 'YYYY-MM-DD') - SYSDATE FROM DUAL;
SELECT TO_DATE('2023-05-18 11:31:23', 'YYYY/MM/DD HH:MI:SS') - SYSDATE FROM DUAL;
SELECT TO_DATE('2023-05-18', 'YYYY-MM-DD')  FROM DUAL;


--�Ʒ� ���� YYYY�� MM�� DD�� ���·� ���
SELECT '20050105' FROM DUAL;
SELECT TO_CHAR(TO_DATE('20050105', 'YYYY/MM/DD'),'YYYY"��"MM"��"DD"��"') ��¥  FROM DUAL; 



--�Ʒ� ���� ���� ��¥�� �� �� ���̸� ���ϼ���
SELECT '2005��01��05��' FROM DUAL;
SELECT SYSDATE - TO_DATE('2005��01��05��','YYYY"��"MM"��"DD"��"') FROM DUAL;

-----------------------------------------------------------------------------
--NULL���� ���� ��ȯ 
--NVL(�÷�, NULL�� ��� ó��)
SELECT NVL(NULL,0) FROM DUAL;
SELECT NVL(COMMISSION_PCT,0) FROM EMPLOYEES;
SELECT FIRST_NAME, COMMISSION_PCT *100 FROM EMPLOYEES; --NULL ���� �� NULL
SELECT FIRST_NAME, NVL(COMMISSION_PCT,0)*100 FROM EMPLOYEES
ORDER BY COMMISSION_PCT;

--NVL2(�÷�, NULL�� �ƴѰ��ó��, NULL�� ��� ó��)
--�� ������ ������
SELECT FIRST_NAME, SALARY,
NVL2(COMMISSION_PCT,SALARY+(SALARY*COMMISSION_PCT),SALARY) �޿� 
FROM EMPLOYEES ORDER BY �޿� DESC;

--DECODE() -ELSE IF ���� ��ü�ϴ� �Լ�
SELECT DECODE('D', 'A','A�Դϴ�'
                  ,'B', 'B��'
                  ,'C', 'C��'
                  ,'ABC�ƴ�') FROM DUAL;

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

--COALESCE(A, B) -NVL�̶� ���� NULL�� ��� 0���� ġȯ
SELECT COALESCE ( COMMISSION_PCT,0) FROM EMPLOYEES;

--------------------------------------------------------------------

----���� 1.
SELECT EMPLOYEE_ID, FIRST_NAME || LAST_NAME, HIRE_DATE,
TRUNC((SYSDATE-HIRE_DATE)/365)  �ټӳ�� FROM EMPLOYEES 
WHERE TRUNC((SYSDATE-HIRE_DATE)/365)>15 
ORDER BY �ټӳ�� DESC;
-- WHERE ������ ALIAS�� ����� �� ����.
----���� 2.
SELECT FIRST_NAME, MANAGER_ID, 
DECODE( MANAGER_ID, 100, '���',
                    120, '����',
                    121, '�븮',
                    122, '����',
                    '�ӿ�') ����
FROM EMPLOYEES WHERE DEPARTMENT_ID = 50
ORDER BY MANAGER_ID DESC;
----------------------------------------------------------------------------



