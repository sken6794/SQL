-----JOIN

SELECT * FROM EMPLOYEES e 
JOIN DEPARTMENTS d 
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID;

--LEFT OUTER ���� ���� ���̺��� ���� �� ����
--���� ���̺� ��Ī�Ǵ� ������ ���̺��� ������ ���� ��� NULL�� ���´�.
SELECT * FROM EMPLOYEES e 
LEFT OUTER JOIN DEPARTMENTS d 
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID;

--RIGHT OUTER ���� ������ ���̺��� ���� �� ����
--������ ���̺� ��Ī�Ǵ� ���� ���̺��� ������ ���� ��� NULL�� ���´�.
SELECT * FROM EMPLOYEES e 
RIGHT OUTER JOIN DEPARTMENTS d 
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID;

--FULL OUTER 
--�������� ���� ���� ���� ���̺�����, ������ ���̺� ���� ��� ��� �ȴ�.
SELECT * FROM EMPLOYEES e 
FULL OUTER JOIN DEPARTMENTS d 
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID;

--CROSS JOIN
--�߸��� JOIN ������ => ���̵����� ���� ���� ���ǰ� ������ �ʴ´�.
SELECT * FROM EMPLOYEES e 
CROSS JOIN DEPARTMENTS d ;
----------------------------------------------
SELECT * FROM INFO;
SELECT * FROM AUTH;
--INNER JOIN 
-- PKŰ�� FRŰ�� ���� �ʴ� ���� ��ȸ���� �ʴ´�.
SELECT * FROM INFO i JOIN AUTH a ON i.AUTH_ID = a.AUTH_ID;

SELECT i.ID, i.TITLE, i.AUTH_ID , a.NAME
FROM INFO i JOIN AUTH a ON i.AUTH_ID = a.AUTH_ID;

SELECT * FROM INFO i LEFT OUTER JOIN AUTH a ON i.AUTH_ID = a.AUTH_ID;
SELECT * FROM INFO i RIGHT OUTER JOIN AUTH a ON i.AUTH_ID = a.AUTH_ID;
SELECT * FROM INFO i FULL OUTER JOIN AUTH a ON i.AUTH_ID = a.AUTH_ID;
SELECT * FROM INFO i CROSS JOIN AUTH;

--���̺� �ٸ��
SELECT * FROM INFO i 
INNER JOIN AUTH a 
ON i.AUTH_ID = a.AUTH_ID;

-- WHERE
SELECT * 
FROM INFO i JOIN AUTH a 
ON i.AUTH_ID = a.AUTH_ID
WHERE ID IN(1,2)
ORDER BY ID DESC;

SELECT * FROM INFO JOIN AUTH USING (AUTH_ID);
-------------------------------------------------------------------------
--OUTER JOIN
--LEFT OUTER JOIN
SELECT * FROM INFO i LEFT JOIN AUTH a 
ON i.auth_id = a.auth_id;
SELECT * FROM INFO i LEFT JOIN AUTH a 
ON i.auth_id = a.auth_id;
SELECT * FROM AUTH a RIGHT JOIN INFO i
ON i.auth_id = a.auth_id;
SELECT * FROM INFO i FULL OUTER JOIN AUTH a 
ON i.auth_id = a.auth_id;

--CROSS JOIN
-- �߸��� ������ ���¸� ���� ���̵����ͷ� Ȱ��
SELECT * FROM INFO i CROSS JOIN AUTH a;
-----------------------------------------------------------------
SELECT * FROM EMPLOYEES e JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID;
SELECT * FROM EMPLOYEES e LEFT JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID;
--������ ������ �� �� �ִ�.
SELECT * FROM EMPLOYEES e JOIN DEPARTMENTS d ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
                        JOIN LOCATIONS l ON d.LOCATION_ID = l.LOCATION_ID;

--SELF JOUN
SELECT * FROM EMPLOYEES;
SELECT * FROM EMPLOYEES e LEFT JOIN EMPLOYEES m ON e.MANAGER_ID=m.EMPLOYEE_ID
ORDER BY e.EMPLOYEE_ID;
SELECT e1.* , e2.FIRST_NAME AS ����� FROM EMPLOYEES e1 LEFT JOIN EMPLOYEES e2
ON e1.MANAGER_ID = e2.EMPLOYEE_ID;














--------------------------------------------------------------------------
--���� 1.
---EMPLOYEES ���̺��, DEPARTMENTS ���̺��� DEPARTMENT_ID�� ����Ǿ� �ֽ��ϴ�.
---EMPLOYEES, DEPARTMENTS ���̺��� ������� �̿��ؼ�
--���� INNER , LEFT OUTER, RIGHT OUTER, FULL OUTER ���� �ϼ���. (�޶����� ���� ���� Ȯ��
SELECT *
FROM EMPLOYEES e
JOIN DEPARTMENTS d
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID;

SELECT *
FROM EMPLOYEES e
LEFT OUTER JOIN DEPARTMENTS d
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID;

SELECT *
FROM EMPLOYEES e
RIGHT OUTER JOIN DEPARTMENTS d
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID;

SELECT *
FROM EMPLOYEES e
FULL OUTER JOIN DEPARTMENTS d
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID;

--���� 2.
---EMPLOYEES, DEPARTMENTS ���̺��� INNER JOIN�ϼ���
--����)employee_id�� 200�� ����� �̸�, department_id�� ����ϼ���
--����)�̸� �÷��� first_name�� last_name�� ���ļ� ����մϴ�
SELECT e.FIRST_NAME ||e.LAST_NAME ����̸�, d.DEPARTMENT_ID, e.EMPLOYEE_ID
FROM EMPLOYEES e
JOIN DEPARTMENTS d
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
WHERE e.EMPLOYEE_ID = 200;

--���� 3.
---EMPLOYEES, JOBS���̺��� INNER JOIN�ϼ���
--����) ��� ����� �̸��� �������̵�, ���� Ÿ��Ʋ�� ����ϰ�, �̸� �������� �������� ����
--HINT) � �÷����� ���� ����� �ִ��� Ȯ��
SELECT e.FIRST_NAME, e.JOB_ID, j.JOB_TITLE
FROM EMPLOYEES e
JOIN JOBS j
ON j.JOB_ID = e.JOB_ID
ORDER BY FIRST_NAME;

--���� 4.
----JOBS���̺�� JOB_HISTORY���̺��� LEFT_OUTER JOIN �ϼ���.

SELECT *
FROM JOBS j 
LEFT OUTER JOIN JOB_HISTORY h
ON j.JOB_ID = h.JOB_ID;
--���� 5.
----Steven King�� �μ����� ����ϼ���.
SELECT * FROM DEPARTMENTS;
SELECT e.FIRST_NAME || e.LAST_NAME ����̸�, d.DEPARTMENT_NAME
FROM EMPLOYEES e JOIN DEPARTMENTS d
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
WHERE FIRST_NAME||LAST_NAME = 'StevenKing';
--���� 6.
----EMPLOYEES ���̺�� DEPARTMENTS ���̺��� Cartesian Product(Cross join)ó���ϼ���
SELECT *
FROM EMPLOYEES e CROSS JOIN DEPARTMENTS d;

--���� 7.
----EMPLOYEES ���̺�� DEPARTMENTS ���̺��� �μ���ȣ�� �����ϰ� SA_MAN ������� �����ȣ, �̸�, 
--�޿�, �μ���, �ٹ����� ����ϼ���. (Alias�� ���)

SELECT EMPLOYEE_ID, FIRST_NAME||LAST_NAME, SALARY, DEPARTMENT_NAME, STREET_ADDRESS
FROM EMPLOYEES e JOIN DEPARTMENTS d
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
JOIN LOCATIONS l 
ON d.LOCATION_ID = l.LOCATION_ID
WHERE e.JOB_ID = 'SA_MAN';


--���� 8.
---- employees, jobs ���̺��� ���� �����ϰ� job_title�� 'Stock Manager', 'Stock Clerk'�� ���� ������
--����ϼ���.

SELECT *
FROM EMPLOYEES e JOIN JOBS j ON e.JOB_ID = j.JOB_ID
WHERE j.JOB_TITLE IN ('Stock Manager','Stock Clerk');

--���� 9.
---- departments ���̺��� ������ ���� �μ��� ã�� ����ϼ���. LEFT OUTER JOIN ���
SELECT * 
FROM DEPARTMENTS d LEFT OUTER JOIN EMPLOYEES e 
ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
WHERE e.EMPLOYEE_ID IS NULL; 

--���� 10. 
---join�� �̿��ؼ� ����� �̸��� �� ����� �Ŵ��� �̸��� ����ϼ���
--��Ʈ) EMPLOYEES ���̺�� EMPLOYEES ���̺��� �����ϼ���.
SELECT * FROM EMPLOYEES ORDER BY MANAGER_ID;
SELECT e.FIRST_NAME||' '||e.LAST_NAME ���, m.FIRST_NAME||' '||m.LAST_NAME �Ŵ���
FROM EMPLOYEES e JOIN EMPLOYEES m
ON e.MANAGER_ID = m.EMPLOYEE_ID
ORDER BY e.EMPLOYEE_ID;

--���� 11. 
----6. EMPLOYEES ���̺��� left join�Ͽ� ������(�Ŵ���)��, �Ŵ����� �̸�, �Ŵ����� �޿� ���� ����ϼ���
----�Ŵ��� ���̵� ���� ����� �����ϰ� �޿��� �������� ����ϼ���


