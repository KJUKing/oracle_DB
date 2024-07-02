2024-0611-01)
    1)회원테이블의 모든 회원정보를 조회하시오.    -- 모든행이니까 WHERE 없이 -- 모든이니까 *
    SELECT * FROM MEMBER;
    
    2)분류테이블의 모든 분류 정보를 조회하십시오 -- LPROD 분류정보
    SELECT * FROM LPROD;
    
    3)회원테이블에서 마일리지가 3000이상인 회원의 회원번호, 회원명, 주소, 마일리지를 조회하시오.
    -- 먼저 계산되는 순서에 따라 SELECT FROM WHERE 순
    -- AS 를 통해 계속 고른다
    SELECT MEM_ID AS 회원번호, 
           MEM_NAME AS 회원명, 
           MEM_ADD1||' '||MEM_ADD2 AS 주소,
           MEM_MILEAGE AS 마일리지
        FROM MEMBER
        WHERE MEM_MILEAGE >= 3000;            -- 작업할 행을 선택할때 WHERE을 사용
        
    4)HR계정의 사원테이블에서 50번 부서에 속한 사원의 사원번호, 사원명, 직책코드, 급여를 출력하되 급여가 많은 사원부터 출력하시오
    DESCENDING을 이용해 내림차순
    SELECT EMPLOYEE_ID AS 사원번호,
           EMP_NAME AS 사원명,    -- F_NAME, L_NMAE 합쳐놓은 것이 EMP_NAME
           JOB_ID AS 직책코드,
           SALARY AS 급여
           FROM HR.EMPLOYEES
           WHERE DEPARTMENT_ID=50
           ORDER BY 4 DESC;     --SALARY를 안쓰고 SELECT절 4번째로 썼기에 4라고 써도됨
        
        
    