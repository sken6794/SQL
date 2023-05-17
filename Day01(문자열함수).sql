--문자열함수
--LOWER(), INITCAP(), UPPER()
--소문자로, 첫글자만 대문자로, 대문자로
--DUAL 은 가상테이블을 만들어준다
SELECT LOWER('HELLO'), INITCAP('HELLO'), UPPER('HELLO') FROM DUAL;
SELECT 'HELLO WORLD' FROM DUAL;
SELECT FIRST_NAME FROM EMPLOYEES;

SELECT LOWER(FIRST_NAME), INITCAP(FIRST_NAME), LOWER(FIRST_NAME) FROM EMPLOYEES;
--함수는 WHERE절에도 적용된다.
SELECT FIRST_NAME FROM EMPLOYEES WHERE UPPER (FIRST_NAME) = 'STEVEN';

-- LENGTH(), INSTR() 
-- => 길이, 문자 찾기
SELECT FIRST_NAME, LENGTH(FIRST_NAME), INSTR(FIRST_NAME, 'e') FROM EMPLOYEES;

--SUBSTR() , CONCAT() 
-- => 문자열 자르기, 문자열 합치기
-- SUBSTR(컬럼, 시작위치, 자르고자하는 갯수)
SELECT FIRST_NAME, SUBSTR(FIRST_NAME, 1, 3) FROM EMPLOYEES;
SELECT FIRST_NAME, CONCAT(FIRST_NAME,' '||LAST_NAME) FULL_NAME FROM EMPLOYEES;

-- LPAD(), RPAD()
-- =>왼쪽 채우기, 오른쪽 채우기
SELECT LPAD('HELLO', 10, '*') FROM DUAL;
SELECT LPAD(SALARY, 10, '-') FROM EMPLOYEES;
SELECT RPAD(SALARY, 10, '-') FROM EMPLOYEES;

-- LTRIM(), RTRIM(), TRIM()
--=> 왼족 제거, 오른쪽 제거, 양쪽 제거
SELECT LTRIM('     HELLO') FROM DUAL;
--왼쪽에서 첫번째 글자가 매개변수일 경우 삭제
SELECT LTRIM(FIRST_NAME, 'S') FROM EMPLOYEES; 
SELECT RTRIM('   HELLO ') AS RESULT FROM DUAL;
SELECT TRIM ('     HELLO      ') AS RESULT FROM DUAL;

--   REPLACE()
-- => 문자열 변경
SELECT REPLACE('HELLO WORLD', 'HELLO', 'BYE') FROM DUAL;
--공백 제거
SELECT REPLACE('  H E L LO WORLD ~!', ' ', '') FROM DUAL;

--중첩
SELECT REPLACE (REPLACE('HELLO WORLD ~!', 'HELLO','BYE'),' ','') FROM DUAL;

--문제 1.
--EMPLOYEES 테이블 에서 이름, 입사일자 컬럼으로 변경해서 이름순으로 오름차순 출력 합니다.
--조건 1) 이름 컬럼은 first_name, last_name을 붙여서 출력합니다.
--조건 2) 입사일자 컬럼은 xx/xx/xx로 저장되어 있습니다. xxxxxx형태로 변경해서 출력합니다.
SELECT CONCAT(FIRST_NAME, ' '||LAST_NAME) NAME, REPLACE(HIRE_DATE,'/','') FROM EMPLOYEES
ORDER BY NAME ASC;

--문제 2.
--EMPLOYEES 테이블 에서 phone_numbe컬럼은 ###.###.####형태로 저장되어 있다
--여기서 처음 세 자리 숫자 대신 서울 지역변호 (02)를 붙여 전화 번호를 출력하도록 쿼리를 작성하세요
SELECT * FROM EMPLOYEES;
SELECT '(02)'||SUBSTR(PHONE_NUMBER, 4,18) FROM EMPLOYEES;
SELECT '(02)'||SUBSTR(PHONE_NUMBER, INSTR(PHONE_NUMBER, '.'), LENGTH(PHONE_NUMBER))
FROM EMPLOYEES;
--문제 3. 
--EMPLOYEES 테이블에서 JOB_ID가 it_prog인 사원의 이름(first_name)과 급여(salary)를 출력하세요.
--조건 1) 비교하기 위한 값은 소문자로 입력해야 합니다.(힌트 : lower 이용)
--조건 2) 이름은 앞 3문자까지 출력하고 나머지는 *로 출력합니다. 
--이 열의 열 별칭은 name입니다.(힌트 : rpad와 substr 또는 substr 그리고 length 이용)
--조건 3) 급여는 전체 10자리로 출력하되 나머지 자리는 *로 출력합니다. 
--이 열의 열 별칭은 salary입니다.(힌트 : lpad 이용)
SELECT FIRST_NAME FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG';

SELECT RPAD(SUBSTR(FIRST_NAME,1,3),LENGTH(FIRST_NAME) ,'*')NAME,
LPAD(SALARY, 10, '*') SALARY
FROM EMPLOYEES
WHERE LOWER(JOB_ID) = 'it_prog';

SELECT RPAD(SUBSTR(FIRST_NAME,1,3), LENGTH(FIRST_NAME),'*') NAME, 
LPAD(SALARY, 10 , '*')
FROM EMPLOYEES WHERE LOWER(JOB_ID)= 'it_prog';


