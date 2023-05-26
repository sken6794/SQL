
--1. USER 생성
-- 아이디 USER01, 비번 USER01 
CREATE USER USER01 IDENTIFIED BY USER01;

--2. USER 권한 부여
GRANT CREATE SESSION,CREATE TABLE, CREATE VIEW, CREATE SEQUENCE TO USER01;


--권환 회수
--REVOKE CREATE SESSION FROM USER01;

--3. 데이터가 저장되는 물리적인공간 (테이블 스페이스 연결)
--ALTER USER 유저명 DEFAULT TABLESPACE 테이블 스페이스명 QUOTA UNLIMITED ON 테이블스페이스명
ALTER USER USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;


--4. 계정 삭제 (테이블 삭제 -> 시퀀스 삭제 -> 등등 삭제가 필요함)
-- CASCADE 사용 시 일괄삭제가 된다.
DROP USER USER01 CASCADE;
---------------------------------------------------------------------
--ROLE 을 이용한 계정 생성
CREATE USER USER01 IDENTIFIED BY USER01;

GRANT RESOURCE, CONNECT /*, DBA*/ TO USER01;

ALTER USER USER01 DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;

--비밀번호 변경문
ALTER USER USER01 IDENTIFIED BY 1234;

-------------------------------------------------
--마우스로 생성

--1.테이블 스페이스 생성 > 보기 > DBA > 접속 > SYS관리자로 > 테이블스페이스 생성
--1.DBA계정 접속 > 다른사용자 > 사용자 생성




















































