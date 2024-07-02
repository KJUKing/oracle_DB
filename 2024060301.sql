2024-0604-01)사용자 생성
 - CREATE USER 사용
 (사용형식)
 CREATE USER 계정명 IDENTIFIED BY 암호;
 
 CREATE USER JU IDENTIFIED BY java;
 
 
 
 - GRANT 문으로 권한 설정
 (사용형식)
 GRANT 권한명 [, 권한명, ...] TO 계정명;
 
 GRANT CONNECT, RESOURCE, DBA TO JU;
 
 
 - 접속자로 등록
 
 ** HR계정 활성화
 (사용형식)
 ALTER USER 계정명 ACCOUNT UNLOCK;
 ALTER USER 계정명 IDENTIFIED BY 암호;
 
 (HR 계정 활성화)
 ALTER USER HR ACCOUNT UNLOCK;
 
 ALTER USER HR IDENTIFIED BY java;