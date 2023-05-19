--���� ����
--SELECT ���� SELECT �������� ���� ���� : ��Į�� ��������
--SELECT ���� FROM �������� ���� ���� : �ζ��� ��
--SELECT ���� WHERE �������� ���� : ��������
--���������� �ݵ�� () �ȿ� ���´�.

--������ �������� : ���ϵǴ� ���� 1���� ��������

SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy';

SELECT * FROM EMPLOYEES 
WHERE SALARY > (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'Nancy');

--EMPLOYEE_ID �� 103���� ����� ������ ����
SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103;
SELECT * FROM EMPLOYEES 
WHERE JOB_ID = (SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103);

--������ �� , ������ �̾��  �Ѵ�. �÷����� 1�� ���� �Ѵ�.
SELECT * FROM EMPLOYEES
WHERE JOB_ID = (SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID = 103);

SELECT * FROM EMPLOYEES
WHERE JOB_ID = (SELECT JOB_ID FROM EMPLOYEES WHERE EMPLOYEE_ID = 103 OR EMPLOYEE_ID = 104);
------------------------------------------------------
--������ �������� => IN, ANY, ALL �� ��
SELECT SALARY FROM EMPLOYEES
WHERE FIRST_NAME = 'David';

--IN ������ ���� ã�� IN (4800,6800,9500) ó�� ���� �Ͱ� �����ϴ�.
SELECT * FROM EMPLOYEES
WHERE SALARY IN (SELECT SALARY FROM EMPLOYEES
                    WHERE FIRST_NAME = 'David');
--ANY 
-- �������� ���� �ִ밪 ���� ����, �ּҰ� ���� ū ���� �����ش�
SELECT * FROM EMPLOYEES
WHERE SALARY < ANY (SELECT SALARY FROM EMPLOYEES
                    WHERE FIRST_NAME = 'David');
-- ALL 
--�������� ���� �ּҰ� ���� ���� , �ִ밪 ���� ū ���� �����ش�
SELECT * FROM EMPLOYEES
WHERE SALARY < ALL (SELECT SALARY FROM EMPLOYEES
                    WHERE FIRST_NAME = 'David');

--������ IT_PROG�� ����麸�� ū �޿��� �޴� �����
SELECT * FROM EMPLOYEES
WHERE SALARY > ALL (SELECT SALARY FROM EMPLOYEES WHERE JOB_ID='IT_PROG');
--������ IT_PROG�� ������� �ּҺ��� ū �޿��� �޴� �����
SELECT * FROM EMPLOYEES
WHERE SALARY > ANY (SELECT SALARY FROM EMPLOYEES WHERE JOB_ID='IT_PROG');
------------------------------------------------------------------------
--��Į�� ��������
--JOIN �ÿ� Ư�����̺��� �ϳ����÷��� ������ �� �� �����ϴ�.
SELECT FIRST_NAME, EMAIL,  
    (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D 
        WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID)
FROM EMPLOYEES E
ORDER BY EMAIL;
--F10
--���� ������ JOIN���� ǥ������ ���
SELECT FIRST_NAME, EMAIL, DEPARTMENT_NAME
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
ORDER BY EMAIL;
---�� �μ��� �Ŵ��� �̸��� ���
SELECT * FROM EMPLOYEES ORDER BY DEPARTMENT_ID;
SELECT * FROM DEPARTMENTS;

SELECT D.*,
    (SELECT FIRST_NAME FROM EMPLOYEES E 
    WHERE E.EMPLOYEE_ID = D.MANAGER_ID)MANAGER
FROM DEPARTMENTS D;

SELECT D.*,
    E.FIRST_NAME
FROM DEPARTMENTS D LEFT JOIN EMPLOYEES E ON D.MANAGER_ID = E.EMPLOYEE_ID;
--��Į�� ���
SELECT D.*,
    (SELECT FIRST_NAME FROM EMPLOYEES E WHERE E.EMPLOYEE_ID = D.MANAGER_ID)
FROM DEPARTMENTS D;

--��Į�������� ������ ����
SELECT * FROM JOBS; -- JOB_TITLE �ʿ�
SELECT * FROM DEPARTMENTS; --  �μ��̸� �ʿ�
SELECT * FROM EMPLOYEES; 

SELECT E.FIRST_NAME,
       E.JOB_ID,
       (SELECT JOB_TITLE FROM JOBS J WHERE J.JOB_ID = E.JOB_ID)JOB_TITLE,
       (SELECT DEPARTMENT_NAME FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID)�μ���
FROM EMPLOYEES E;

--�� �μ��� ��� ��, �μ������� ���
SELECT DEPARTMENT_ID, COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

SELECT D.*,
    NVL((SELECT COUNT(*) FROM EMPLOYEES E WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
        GROUP BY DEPARTMENT_ID),0)��
FROM DEPARTMENTS D;

-----------------------------------------------------------------------------
--�ζ��� ��
--FROM ���� SELECT ���� ��
--��¥ ���̺� ����
SELECT ROWNUM, E.* FROM EMPLOYEES E ORDER BY SALARY DESC;

--ROWNUM�� ��ȸ�� �����̱� ������, ORDER �� ���� ���Ǹ� ROWNUM�� ���̴� ������ �߻��Ѵ�.
SELECT ROWNUM, SALARY, FIRST_NAME
FROM(SELECT * FROM EMPLOYEES E ORDER BY SALARY DESC);

SELECT ROWNUM, A.*
FROM ( SELECT FIRST_NAME,SALARY
        FROM EMPLOYEES
        ORDER BY SALARY
    ) A ;

--ROWNUM�� ������ 1��°���� ��ȸ�� �����ϱ� ������ �׷���.
SELECT ROWNUM, SALARY, FIRST_NAME
FROM(SELECT * FROM EMPLOYEES ORDER BY SALARY DESC)
WHERE ROWNUM BETWEEN 1 AND 10;

--2��° �ζ��κ信�� ROWNUM�� RN���� �÷�ȭ
SELECT *
FROM (SELECT ROWNUM AS RN , SALARY, FIRST_NAME
    FROM(SELECT * 
        FROM EMPLOYEES ORDER BY SALARY DESC)
)
WHERE RN>50 AND RN<100;
--�ζ��� ���� ����
SELECT TO_CHAR(REGDATE, 'YY-MM-DD')AS REGDATE, NAME
FROM (SELECT 'ȫ�浿' AS NAME,SYSDATE AS REGDATE FROM DUAL
        UNION ALL
        SELECT '�̼���', SYSDATE FROM DUAL);

--�ζ��� ���� ����
--�μ��� ��� ��
SELECT D.*,E.TOTAL
FROM DEPARTMENTS D
LEFT JOIN (SELECT DEPARTMENT_ID, COUNT(*)AS TOTAL
    FROM EMPLOYEES 
    GROUP BY DEPARTMENT_ID)E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;

--����
--������ (��Һ�) VS ������ ��������(IN,ANY,ALL)
--��Į�� ���� :  LEFT JOIN�� ���� ����, �ѹ��� 1���� �÷��� ������ ��
--�ζ��� ��  : FROM���� ���� ��¥ ���̺�
--------------------------------------------------------------------------
--���� 1.
---EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� �����͸� ��� �ϼ��� ( AVG(�÷�) ���)
---EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� ���� ����ϼ���
---EMPLOYEES ���̺��� job_id�� IT_PFOG�� ������� ��ձ޿����� ���� ������� �����͸� ����ϼ���
SELECT * FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);
SELECT COUNT(*) FROM EMPLOYEES 
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);
SELECT * FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG');

--���� 2.
---DEPARTMENTS���̺��� manager_id�� 100�� ����� department_id��
--EMPLOYEES���̺��� department_id�� ��ġ�ϴ� ��� ����� ������ �˻��ϼ���.
SELECT * FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE MANAGER_ID = 100);

--���� 3.
---EMPLOYEES���̺��� ��Pat���� manager_id���� ���� manager_id�� ���� ��� ����� �����͸� ����ϼ���
---EMPLOYEES���̺��� ��James��(2��)���� manager_id�� ���� ��� ����� �����͸� ����ϼ���.
SELECT * FROM EMPLOYEES
WHERE MANAGER_ID > (SELECT MANAGER_ID FROM EMPLOYEES WHERE FIRST_NAME = 'Pat');

--���� 4.
---EMPLOYEES���̺� ���� first_name�������� �������� �����ϰ�, 41~50��° �������� �� ��ȣ, �̸��� ����ϼ���
SELECT ROWNUM, E2.* FROM (
    SELECT ROWNUM AS RN ,E1.* FROM 
        (SELECT * FROM EMPLOYEES E ORDER BY FIRST_NAME DESC) E1
)E2
WHERE RN BETWEEN 41 AND 50;
--���� 5.
---EMPLOYEES���̺��� hire_date�������� �������� �����ϰ�, 31~40��° �������� �� ��ȣ, ���id, �̸�, ��ȣ, 
--�Ի����� ����ϼ���
SELECT ROWNUM, EMPLOYEE_ID,FIRST_NAME,PHONE_NUMBER,HIRE_DATE FROM (
    SELECT ROWNUM AS RN ,E1.* FROM 
        (SELECT * FROM EMPLOYEES E ORDER BY HIRE_DATE) E1
)E2
WHERE RN BETWEEN 31 AND 40;
---����԰� ------
SELECT *
FROM (SELECT E.* ,ROWNUM RN
      FROM(SELECT EMPLOYEE_ID, FIRST_NAME||' '||LAST_NAME AS NAME,
                PHONE_NUMBER, HIRE_DATE
           FROM EMPLOYEES
           ORDER BY HIRE_DATE) E
      )
WHERE RN BETWEEN 31 AND 40;

--���� 6.
--employees���̺� departments���̺��� left �����ϼ���
--����) �������̵�, �̸�(��, �̸�), �μ����̵�, �μ��� �� ����մϴ�.
--����) �������̵� ���� �������� ����
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.LAST_NAME, E.DEPARTMENT_ID, D.DEPARTMENT_NAME FROM 
EMPLOYEES E LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID ORDER BY EMPLOYEE_ID ASC;


--���� 7.
--���� 6�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.LAST_NAME, E.DEPARTMENT_ID,
(SELECT D.DEPARTMENT_NAME FROM DEPARTMENTS D WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID) �μ���
FROM EMPLOYEES E 
ORDER BY EMPLOYEE_ID ASC;

--���� 8.
--departments���̺� locations���̺��� left �����ϼ���
--����) �μ����̵�, �μ��̸�, �Ŵ������̵�, �����̼Ǿ��̵�, ��Ʈ��_��巹��, ����Ʈ �ڵ�, ��Ƽ �� ����մϴ�
--����) �μ����̵� ���� �������� ����
SELECT * FROM LOCATIONS;
SELECT D.DEPARTMENT_ID,D.DEPARTMENT_NAME,D.MANAGER_ID,L.LOCATION_ID,L.STREET_ADDRESS,
    L.POSTAL_CODE,L.CITY 
FROM DEPARTMENTS D JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
ORDER BY DEPARTMENT_ID;
--���� 9.
--���� 8�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
SELECT D.DEPARTMENT_ID,D.DEPARTMENT_NAME,D.MANAGER_ID,D.LOCATION_ID,
    (SELECT L.STREET_ADDRESS
        FROM LOCATIONS L WHERE D.LOCATION_ID = L.LOCATION_ID)�ּ�,
        (SELECT L.POSTAL_CODE
            FROM LOCATIONS L WHERE D.LOCATION_ID = L.LOCATION_ID)�����ȣ,
            (SELECT L.CITY 
                FROM LOCATIONS L WHERE D.LOCATION_ID = L.LOCATION_ID)����
FROM DEPARTMENTS D ORDER BY DEPARTMENT_ID;

--���� 10.
--locations���̺� countries ���̺��� left �����ϼ���
--����) �����̼Ǿ��̵�, �ּ�, ��Ƽ, country_id, country_name �� ����մϴ�
--����) country_name���� �������� ����
SELECT L.LOCATION_ID, L.STREET_ADDRESS, L.CITY,L.COUNTRY_ID,
    C.COUNTRY_NAME
FROM LOCATIONS L LEFT JOIN COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID
ORDER BY c.country_name;

--���� 11.
--���� 10�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
SELECT L.LOCATION_ID, L.STREET_ADDRESS, L.CITY, L.COUNTRY_ID,
    (SELECT C.COUNTRY_NAME FROM COUNTRIES C WHERE L.COUNTRY_ID = C.COUNTRY_ID)����
FROM LOCATIONS L 
ORDER BY ����;

--���� 12. 
--employees���̺�, departments���̺��� left���� hire_date�� �������� �������� 1-10��° �����͸� ����մϴ�
--����) rownum�� �����Ͽ� ��ȣ, �������̵�, �̸�, ��ȭ��ȣ, �Ի���, �μ����̵�, �μ��̸� �� ����մϴ�.
--����) hire_date�� �������� �������� ���� �Ǿ�� �մϴ�. rownum�� Ʋ������ �ȵ˴ϴ�.
SELECT ROWNUM,E2.*
FROM (SELECT ROWNUM AS RN,E1.* 
        FROM (SELECT E.EMPLOYEE_ID,E.FIRST_NAME,E.PHONE_NUMBER,E.HIRE_DATE,E.DEPARTMENT_ID,D.DEPARTMENT_NAME
                FROM EMPLOYEES E JOIN DEPARTMENTS D ON E.DEPARTMENT_ID =D.DEPARTMENT_ID ORDER BY HIRE_DATE)E1)E2
WHERE RN BETWEEN 1 AND 10;
---------------����԰� ----------------------

SELECT *
FROM(SELECT ROWNUM RN,A.*
        FROM (SELECT EMPLOYEE_ID,
                     FIRST_NAME,
                     PHONE_NUMBER,
                     HIRE_DATE,
                     E.DEPARTMENT_ID,
                     D.DEPARTMENT_NAME
                FROM EMPLOYEES E
                LEFT JOIN DEPARTMENTS D 
                ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
                ORDER BY HIRE_DATE)A)
WHERE RN BETWEEN 1 AND 10;



--���� 13. 
----EMPLOYEES �� DEPARTMENTS ���̺��� JOB_ID�� SA_MAN ����� ������ LAST_NAME, JOB_ID, 
--DEPARTMENT_ID,DEPARTMENT_NAME�� ����ϼ���
SELECT E.LAST_NAME,E.JOB_ID,E.DEPARTMENT_ID,D.DEPARTMENT_NAME
FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE E.JOB_ID = 'SA_MAN';

------�ѹ� �� ���� --------------
SELECT LAST_NAME,
       JOB_ID,
       E.DEPARTMENT_ID,
       DEPARTMENT_NAME
FROM EMPLOYEES E
JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE E.JOB_ID 
IN (SELECT JOB_ID FROM EMPLOYEES WHERE JOB_ID = 'SA_MAN');
---------------����԰�------
SELECT E.LAST_NAME,
       E.JOB_ID,
       E.DEPARTMENT_ID,
       D.DEPARTMENT_NAME
FROM (SELECT *
        FROM EMPLOYEES
        WHERE JOB_ID = 'SA_MAN')E
JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

--���� 14
----DEPARTMENT���̺��� �� �μ��� ID, NAME, MANAGER_ID�� �μ��� ���� �ο����� ����ϼ���.
----�ο��� ���� �������� �����ϼ���.
----����� ���� �μ��� ������� ���� �ʽ��ϴ�
SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, D.MANAGER_ID, E.�����
FROM DEPARTMENTS D 
JOIN (SELECT DEPARTMENT_ID, COUNT(*) ����� FROM EMPLOYEES GROUP BY DEPARTMENT_ID) E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID;

------------�ѹ� �� ���� �������� �����ؼ� ----------

SELECT DEPARTMENT_NAME,
       MANAGER_ID,
       E.*
FROM DEPARTMENTS D
JOIN (SELECT DEPARTMENT_ID,
            COUNT(*)�����
      FROM EMPLOYEES
      GROUP BY DEPARTMENT_ID) E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
ORDER BY E.����� DESC;
-------����� �� ------------------
SELECT D.DEPARTMENT_ID,
       D.DEPARTMENT_NAME,
       D.MANAGER_ID,
       E.�ο���
FROM DEPARTMENTS D
JOIN (SELECT DEPARTMENT_ID,
             COUNT(*)AS �ο���
       FROM EMPLOYEES
       GROUP BY DEPARTMENT_ID)E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
ORDER BY �ο��� DESC;

--���� 15
----�μ��� ���� ���� ���ο�, �ּ�, �����ȣ, �μ��� ��� ������ ���ؼ� ����ϼ���
----�μ��� ����� ������ 0���� ����ϼ���

SELECT D.*, L.STREET_ADDRESS,L.POSTAL_CODE, NVL(E1.��տ���,0)
    FROM DEPARTMENTS D 
        JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
        JOIN (SELECT D.DEPARTMENT_ID, TRUNC(AVG(E.SALARY))��տ��� 
            FROM EMPLOYEES E RIGHT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
            GROUP BY D.DEPARTMENT_ID) E1 ON E1.DEPARTMENT_ID = D.DEPARTMENT_ID; 
-----------�ѹ� �� ���� ���� ���� -------------
SELECT D.*,
       NVL(E.���,0)���
FROM (SELECT D.*,
               L.STREET_ADDRESS,
               L.POSTAL_CODE
      FROM DEPARTMENTS D
      JOIN LOCATIONS L
      ON D.LOCATION_ID = L.LOCATION_ID)D
LEFT JOIN (SELECT DEPARTMENT_ID,
                  TRUNC(AVG(SALARY))���
           FROM EMPLOYEES
           GROUP BY DEPARTMENT_ID) E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
ORDER BY ��� DESC;
-------------����԰�-----------------
SELECT D.*,
       L.STREET_ADDRESS,
       L.POSTAL_CODE,
       NVL(E.SALARY,0)SALARY
FROM DEPARTMENTS D
LEFT JOIN (SELECT DEPARTMENT_ID,
                  TRUNC(AVG(SALARY)) AS SALARY
           FROM EMPLOYEES
           GROUP BY DEPARTMENT_ID)E
ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
LEFT JOIN LOCATIONS L 
ON D.LOCATION_ID = L.LOCATION_ID;
--���� 16
----�μ��� ���� ���� ���ο�, �ּ�, �����ȣ, �μ��� ��� ������ ���ؼ� ����ϼ���
----�μ��� ����� ������ 0���� ����ϼ���
----DEPARTMENT_ID�������� �������� �����ؼ� ROWNUM�� �ٿ� 1-10������ ������
--  ����ϼ���
SELECT * FROM DEPARTMENTS;
SELECT DEPARTMENT_ID,TRUNC(AVG(SALARY)) FROM EMPLOYEES GROUP BY DEPARTMENT_ID;

SELECT D.*, NVL(E.���,0)�޿����, 
    (SELECT L.STREET_ADDRESS FROM LOCATIONS L
        WHERE D.LOCATION_ID=L.LOCATION_ID) STREET_ADDRESS,
    (SELECT L.POSTAL_CODE FROM LOCATIONS L
        WHERE D.LOCATION_ID = L.LOCATION_ID) POSTAL_CODE
FROM DEPARTMENTS D 
    JOIN (SELECT D1.DEPARTMENT_ID,TRUNC(AVG(E1.SALARY))��� 
            FROM EMPLOYEES E1 RIGHT JOIN DEPARTMENTS D1 
                ON E1.DEPARTMENT_ID=D1.DEPARTMENT_ID GROUP BY D1.DEPARTMENT_ID) E
    ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
ORDER BY D.DEPARTMENT_ID DESC;

SELECT ROWNUM RN,E2.* 
FROM (SELECT D.*, NVL(E.���,0)�޿����, 
        (SELECT L.STREET_ADDRESS FROM LOCATIONS L
            WHERE D.LOCATION_ID=L.LOCATION_ID) STREET_ADDRESS,
        (SELECT L.POSTAL_CODE FROM LOCATIONS L
            WHERE D.LOCATION_ID = L.LOCATION_ID) POSTAL_CODE
    FROM DEPARTMENTS D 
        JOIN (SELECT D1.DEPARTMENT_ID,TRUNC(AVG(E1.SALARY))��� 
                FROM EMPLOYEES E1 RIGHT JOIN DEPARTMENTS D1 
                    ON E1.DEPARTMENT_ID=D1.DEPARTMENT_ID GROUP BY D1.DEPARTMENT_ID) E
        ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
    ORDER BY D.DEPARTMENT_ID DESC)E2;

SELECT ROWNUM,E3.*
FROM (SELECT ROWNUM RN,E2.* 
        FROM (SELECT D.*, NVL(E.���,0)�޿����, 
                (SELECT L.STREET_ADDRESS FROM LOCATIONS L
                    WHERE D.LOCATION_ID=L.LOCATION_ID) STREET_ADDRESS,
                (SELECT L.POSTAL_CODE FROM LOCATIONS L
                    WHERE D.LOCATION_ID = L.LOCATION_ID) POSTAL_CODE
            FROM DEPARTMENTS D 
                JOIN (SELECT D1.DEPARTMENT_ID,TRUNC(AVG(E1.SALARY))��� 
                        FROM EMPLOYEES E1 RIGHT JOIN DEPARTMENTS D1 
                            ON E1.DEPARTMENT_ID=D1.DEPARTMENT_ID GROUP BY D1.DEPARTMENT_ID) E
                ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
            ORDER BY D.DEPARTMENT_ID DESC)E2) E3
WHERE RN BETWEEN 1 AND 10;

---------------�ѹ� �� ���� ���� ����---------
SELECT *
FROM (SELECT ROWNUM RN, A.*
        FROM (SELECT D.*,
                    L.STREET_ADDRESS,
                    L.POSTAL_CODE,
                    (SELECT TRUNC(AVG(SALARY))
                     FROM EMPLOYEES E
                     WHERE  E.DEPARTMENT_ID = D.DEPARTMENT_ID
                     GROUP BY E.DEPARTMENT_ID) ��տ���
                FROM DEPARTMENTS D
                JOIN LOCATIONS L 
                ON L.LOCATION_ID = D.LOCATION_ID
                ORDER BY DEPARTMENT_ID DESC)A )
WHERE RN BETWEEN 1 AND 10;
    
--------------����԰�------------------

SELECT *
FROM (SELECT ROWNUM RN,A.*
        FROM(SELECT D.*,
                       L.STREET_ADDRESS,
                       L.POSTAL_CODE,
                       NVL(E.SALARY,0)SALARY
                FROM DEPARTMENTS D
                LEFT JOIN (SELECT DEPARTMENT_ID,
                                  TRUNC(AVG(SALARY)) AS SALARY
                           FROM EMPLOYEES
                           GROUP BY DEPARTMENT_ID)E
                ON D.DEPARTMENT_ID = E.DEPARTMENT_ID
                LEFT JOIN LOCATIONS L 
                ON D.LOCATION_ID = L.LOCATION_ID
                ORDER BY D.DEPARTMENT_ID DESC) A)
WHERE RN BETWEEN 1 AND 10;









