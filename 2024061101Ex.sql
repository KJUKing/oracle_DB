2024-0611-EX)
문제 1] 회원테이블에서 보유 마일리지가 2000~4000에 속하며 직업이 주부인 회원들을 조회 하시오.
    SELECT * FROM MEMBER
    WHERE   (MEM_MILEAGE>=2000 AND MEM_MILEAGE<=4000)
            AND MEM_JOB = '주부';

문제2] HR계정의 사원 테이블에서 급여가 3000 이상인 사원의 사원번호, 이름, 직책코드, 급 여를 조회 하시오.
    SELECT EMPLOYEE_ID AS 사원번호,
           EMP_NAME AS 이름,
           JOB_ID AS 직책코드,
           SALARY AS 급여
    
    FROM HR.EMPLOYEES
    WHERE SALARY >= 3000;

문제3] HR계정의 사원 테이블에서 급여가 1500 이상이고 부서번호가 10 또는 30인 사원의 이름과 급여를 조회 하시오
    SELECT EMP_NAME AS 사원이름,
           SALARY AS 급여,
           DEPARTMENT_ID AS 부서번호
           
    FROM HR.EMPLOYEES
    WHERE SALARY >=1500
            AND (DEPARTMENT_ID =10 OR DEPARTMENT_ID =30);
            
문제4] HR계정의 사원 테이블에서 중복되지 않는 부서번호를 출력하시오
    SELECT DISTINCT DEPARTMENT_ID AS 부서번호
    FROM HR.EMPLOYEES;
    
문제5] HR계정의 사원 테이블에서 30번 부서 내의 모든 직책 들을 중복되지 않게 조회하시오
    SELECT DISTINCT JOB_ID
    FROM HR.EMPLOYEES
    WHERE DEPARTMENT_ID = 30;
    