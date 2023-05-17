--���ڿ��Լ�
--LOWER(), INITCAP(), UPPER()
--�ҹ��ڷ�, ù���ڸ� �빮�ڷ�, �빮�ڷ�
--DUAL �� �������̺��� ������ش�
SELECT LOWER('HELLO'), INITCAP('HELLO'), UPPER('HELLO') FROM DUAL;
SELECT 'HELLO WORLD' FROM DUAL;
SELECT FIRST_NAME FROM EMPLOYEES;

SELECT LOWER(FIRST_NAME), INITCAP(FIRST_NAME), LOWER(FIRST_NAME) FROM EMPLOYEES;
--�Լ��� WHERE������ ����ȴ�.
SELECT FIRST_NAME FROM EMPLOYEES WHERE UPPER (FIRST_NAME) = 'STEVEN';

-- LENGTH(), INSTR() 
-- => ����, ���� ã��
SELECT FIRST_NAME, LENGTH(FIRST_NAME), INSTR(FIRST_NAME, 'e') FROM EMPLOYEES;

--SUBSTR() , CONCAT() 
-- => ���ڿ� �ڸ���, ���ڿ� ��ġ��
-- SUBSTR(�÷�, ������ġ, �ڸ������ϴ� ����)
SELECT FIRST_NAME, SUBSTR(FIRST_NAME, 1, 3) FROM EMPLOYEES;
SELECT FIRST_NAME, CONCAT(FIRST_NAME,' '||LAST_NAME) FULL_NAME FROM EMPLOYEES;

-- LPAD(), RPAD()
-- =>���� ä���, ������ ä���
SELECT LPAD('HELLO', 10, '*') FROM DUAL;
SELECT LPAD(SALARY, 10, '-') FROM EMPLOYEES;
SELECT RPAD(SALARY, 10, '-') FROM EMPLOYEES;

-- LTRIM(), RTRIM(), TRIM()
--=> ���� ����, ������ ����, ���� ����
SELECT LTRIM('     HELLO') FROM DUAL;
--���ʿ��� ù��° ���ڰ� �Ű������� ��� ����
SELECT LTRIM(FIRST_NAME, 'S') FROM EMPLOYEES; 
SELECT RTRIM('   HELLO ') AS RESULT FROM DUAL;
SELECT TRIM ('     HELLO      ') AS RESULT FROM DUAL;

--   REPLACE()
-- => ���ڿ� ����
SELECT REPLACE('HELLO WORLD', 'HELLO', 'BYE') FROM DUAL;
--���� ����
SELECT REPLACE('  H E L LO WORLD ~!', ' ', '') FROM DUAL;

--��ø
SELECT REPLACE (REPLACE('HELLO WORLD ~!', 'HELLO','BYE'),' ','') FROM DUAL;

--���� 1.
--EMPLOYEES ���̺� ���� �̸�, �Ի����� �÷����� �����ؼ� �̸������� �������� ��� �մϴ�.
--���� 1) �̸� �÷��� first_name, last_name�� �ٿ��� ����մϴ�.
--���� 2) �Ի����� �÷��� xx/xx/xx�� ����Ǿ� �ֽ��ϴ�. xxxxxx���·� �����ؼ� ����մϴ�.
SELECT CONCAT(FIRST_NAME, ' '||LAST_NAME) NAME, REPLACE(HIRE_DATE,'/','') FROM EMPLOYEES
ORDER BY NAME ASC;

--���� 2.
--EMPLOYEES ���̺� ���� phone_numbe�÷��� ###.###.####���·� ����Ǿ� �ִ�
--���⼭ ó�� �� �ڸ� ���� ��� ���� ������ȣ (02)�� �ٿ� ��ȭ ��ȣ�� ����ϵ��� ������ �ۼ��ϼ���
SELECT * FROM EMPLOYEES;
SELECT '(02)'||SUBSTR(PHONE_NUMBER, 4,18) FROM EMPLOYEES;
SELECT '(02)'||SUBSTR(PHONE_NUMBER, INSTR(PHONE_NUMBER, '.'), LENGTH(PHONE_NUMBER))
FROM EMPLOYEES;
--���� 3. 
--EMPLOYEES ���̺��� JOB_ID�� it_prog�� ����� �̸�(first_name)�� �޿�(salary)�� ����ϼ���.
--���� 1) ���ϱ� ���� ���� �ҹ��ڷ� �Է��ؾ� �մϴ�.(��Ʈ : lower �̿�)
--���� 2) �̸��� �� 3���ڱ��� ����ϰ� �������� *�� ����մϴ�. 
--�� ���� �� ��Ī�� name�Դϴ�.(��Ʈ : rpad�� substr �Ǵ� substr �׸��� length �̿�)
--���� 3) �޿��� ��ü 10�ڸ��� ����ϵ� ������ �ڸ��� *�� ����մϴ�. 
--�� ���� �� ��Ī�� salary�Դϴ�.(��Ʈ : lpad �̿�)
SELECT FIRST_NAME FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG';

SELECT RPAD(SUBSTR(FIRST_NAME,1,3),LENGTH(FIRST_NAME) ,'*')NAME,
LPAD(SALARY, 10, '*') SALARY
FROM EMPLOYEES
WHERE LOWER(JOB_ID) = 'it_prog';

SELECT RPAD(SUBSTR(FIRST_NAME,1,3), LENGTH(FIRST_NAME),'*') NAME, 
LPAD(SALARY, 10 , '*')
FROM EMPLOYEES WHERE LOWER(JOB_ID)= 'it_prog';


