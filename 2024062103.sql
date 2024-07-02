2024-0621-03) 서브쿼리
    - 쿼리 안의 또 다른 쿼리를 서브쿼리라 함
    - 알려지지 않은 조건으로 데이터를 검색할 때 사용
    - 반드시 (  )안에 기술해야함
        -하지만 INSERT와 CREATE 문에는 괄호 사용하지않음
    - 조건절에 사용되는 서브쿼리는 '=' 연산자 우측에 사용되어야 함
    - 서브쿼리는 ORDER BY 절을 포함하지 않음
    - 실행순서는 해당 절이 실행될 때 가장 먼저 실행됨
    - 종류
        . 연관성 있는 서브쿼리/ 연관성 없는 서브쿼리
        . 일반 서브쿼리(SELECT)/중첩 서브쿼리(WHERE)/인라인 서브쿼리(FROM)
        . 단일행 서브쿼리/다중행 서브쿼리/(단일컬럼/다중컬럼)
        
        
    사용예
        (1) 사원테이블에서 사원들의 평균급여보다 많은 급여를 받는 사원의
            사원번호, 사원명, 급여를 조회하시오.
            [서브쿼리 : 사원들의 평균 급여]
            SELECT AVG(SALARY)
            FROM HR.EMPLOYEES
            [메인쿼리 : 사원의 사원번호, 사원명, 급여를 조회]
            SELECT EMPLOYEE_ID AS 사원번호,
                   EMP_NAME AS 사원명,
                   SALARY AS 급여
            FROM HR.EMPLOYEES
            WHERE SALARY > (평균급여:서브쿼리)
            [결합]
            SELECT EMPLOYEE_ID AS 사원번호,
                   EMP_NAME AS 사원명,
                   SALARY AS 급여,
                   (SELECT ROUND(AVG(SALARY))
                    FROM HR.EMPLOYEES) AS 평균급여
            FROM HR.EMPLOYEES
            WHERE SALARY > (SELECT AVG(SALARY)
                            FROM HR.EMPLOYEES)
                            
                            
            SELECT A.EMPLOYEE_ID AS 사원번호,
                   A.EMP_NAME AS 사원명,
                   A.SALARY AS 급여,
                   ROUND(B.SAL) AS 평균급여
            FROM HR.EMPLOYEES A, (SELECT AVG(SALARY) AS SAL
                                  FROM HR.EMPLOYEES) B
            WHERE SALARY > (B.SAL)
        
        (2) 사원들의 평균급여보다 더 많은 급여를 받는 사원들이 근무하는 부서를 조회하시오.
            alias 부서번호, 부서명, 책임사원이름
            [서브쿼리 : 평균급여]
            SELECT AVG(SALARY)
            FROM HR.EMPLOYEES
            
            [메인쿼리 : 부서조회]
            SELECT A.DEPARTMENT_ID AS 부서번호,
                   A.DEPARTMENT_NAME AS 부서명,
                   B.EMP_NAME AS 책임사원이름
            FROM HR.DEPARTMENTS A, HR.EMPLOYEES B
            WHERE A.MANAGER_ID = B.EMPLOYEE_ID
                AND B.SALARY > (서브쿼리)
                
            [결합]
            SELECT A.DEPARTMENT_ID AS 부서번호,
                   A.DEPARTMENT_NAME AS 부서명,
                   B.EMP_NAME AS 책임사원이름
            FROM HR.DEPARTMENTS A, HR.EMPLOYEES B
            WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                AND A.MANAGER_ID = B.EMPLOYEE_ID
                AND B.SALARY > (SELECT AVG(SALARY)
                                FROM HR.EMPLOYEES)
                
            SELECT A.DEPARTMENT_ID AS 부서번호,
                  A.DEPARTMENT_NAME AS 부서명,
                   B.EMP_NAME AS 책임사원이름
            FROM HR.DEPARTMENTS A, HR.EMPLOYEES B
            WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                AND A.MANAGER_ID = B.EMPLOYEE_ID
                AND EXISTS (SELECT 1
                            FROM HR.EMPLOYEES C
                            WHERE C.SALARY > (SELECT AVG(D.SALARY)
                                              FROM HR.EMPLOYEES D
                                              AND C.DEPARTMENT_ID = A.DEPARTMENT_ID) 
            --EXISTS는 오른쪽에 반드시 서브쿼리가 나옴
            --값은 중요하지않고 개수가 1개라도 참이라면 적용
            
        
        (3) 회원테이블에서 회원들의 평균 마일리지보다 많은 마일리지를 소유한 회원의
            회원번호, 회원명, 마일리지를 조회하시오.
            
            SELECT M.MEM_ID AS 회원번호,
                   M.MEM_NAME AS 회원명,
                   M.MILEAGE AS 마일리지
            FROM MEMBER M, (SELECT MEM_ID AS AID,
                                   AVG(MEM_MILEAGE) AS AMILE
                            FROM MEMBER) A
            WHERE M.MEM ID = A.
                AND M.MILEAGE > A.AMILE
                   
                   
            SELECT A.EMPLOYEE_ID AS 사원번호,
                   A.EMP_NAME AS 사원명,
                   A.DEPARTMENT_ID AS 부서번호,
                   B.DEPARTMENT_NAME AS 부서명,
                   C.ASAL AS 부서평균급여,
                   A.SALARY AS 급여
            FROM HR.EMPLOYEES A, HR.DEPARTMENTS B,
                                                  (SELECT DEPARTMENT_ID,
                                                   ROUND(AVG(SALARY)) AS ASAL
                                                   FROM HR.EMPLOYEES
                                                   GROUP BY DEPARTMENT_ID) C
            WHERE A.SALARY > C.ASAL
                AND A.DEPARTMENT_ID=C.DEPARTMENT_ID
                AND A.DEPARTMENT_ID=B.DEPARTMENT_ID
            ORDER BY 3,6
                
            
        (4) 2020년 5월 가장 많은 구매를 한 회원 3명의 회원번호, 회원명, 직업, 마일리지,
            성별을 조회하시오.
            
            [서브쿼리 : 2020년 5월 가장 많은 구매를 한 회원 3명의 회원번호]
            SELECT C.AID
            FROM (SELECT A.CART_MEMBER AS AID,
                         SUM(A.CART_QTY*B.PROD_PRICE) AS 구매금액합계
                  FROM CART A, PROD B
                  WHERE A.CART_PROD = B.PROD_ID
                    AND A.CART_NO LIKE '202005%'
                  GROUP BY A.CART_MEMBER
                  ORDER BY 2 DESC) C
            WHERE ROWNUM<=3
            
            [메인쿼리 : 서브쿼리 결과의 회원들의 회원번호, 회원명, 직업, 마일리지, 성별]
            SELECT M.MEM_ID AS 회원번호,
                   M.MEM_NAME AS 회원명,
                   M.MEM_JOB AS 직업,
                   M.MEM_MILEAGE마일리지,
                   CASE WHEN SUBSTR(M.MEM_REGNO2,1,) IN('2','4') THEN 
                        '여성'
                   ELSE
                        '남성'
                   END AS 성별
            FROM MEMBER M,
                (서브쿼리) D
            WHERE M.MEM_ID = D.회원번호
            
            [결합]
            SELECT M.MEM_ID AS 회원번호,
                   M.MEM_NAME AS 회원명,
                   M.MEM_JOB AS 직업,
                   M.MEM_MILEAGE AS 마일리지,
                   CASE WHEN SUBSTR(M.MEM_REGNO2,1,1) IN('2','4') THEN 
                        '여성'
                   ELSE
                        '남성'
                   END AS 성별
            FROM MEMBER M,
                (SELECT C.AID AS CID
                 FROM (SELECT A.CART_MEMBER AS AID,
                              SUM(A.CART_QTY*B.PROD_PRICE) AS 구매금액합계
                       FROM CART A, PROD B
                       WHERE A.CART_PROD = B.PROD_ID
                         AND A.CART_NO LIKE '202005%'
                       GROUP BY A.CART_MEMBER
                       ORDER BY 2 DESC) C
                 WHERE ROWNUM<=3) D
            WHERE M.MEM_ID = D.CID
            
            
            
            
        (5) 사원테이블에서 자기부서의 평균급여보다 더 많은 급여를 받는 사원의 사원번호,
            사원명, 부서번호, 부서명, 부서평균급여, 급여를 조회하시오.
            
            
            SELECT A.EMPLOYEE_ID AS 사원번호,
                   A.EMP_NAME AS 사원명,
                   A.DEPARTMENT_ID AS 부서번호,
                   B.DEPARTMENT_NAME AS 부서명,
                   C.ASAL AS 부서평균급여,
                   A.SALARY AS 급여
            FROM HR.EMPLOYEES A, HR.DEPARTMENTS B,
                                                  (SELECT DEPARTMENT_ID,
                                                   ROUND(AVG(SALARY)) AS ASAL
                                                   FROM HR.EMPLOYEES
                                                   GROUP BY DEPARTMENT_ID) C
            WHERE A.SALARY > C.ASAL
                AND A.DEPARTMENT_ID=C.DEPARTMENT_ID
                AND A.DEPARTMENT_ID=B.DEPARTMENT_ID
            ORDER BY 3,6

             
    숙제는 WHERE절로 생성하는 SQL 만들기
    
    
            SELECT A.EMPLOYEE_ID AS 사원번호,
                   A.EMP_NAME AS 사원명,
                   A.DEPARTMENT_ID AS 부서번호,
                   B.DEPARTMENT_NAME AS 부서명,
                   A.SALARY AS 급여
            FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
            WHERE A.SALARY > (SELECT DEPARTMENT_ID,
                                     ROUND(AVG(SALARY)) AS ASAL
                              FROM HR.EMPLOYEES
                              GROUP BY DEPARTMENT_ID)
                AND A.DEPARTMENT_ID=B.DEPARTMENT_ID
                
            SELECT A.EMPLOYEE_ID AS 사원번호,
                   A.EMP_NAME AS 사원명,
                   A.DEPARTMENT_ID AS 부서번호,
                   B.DEPARTMENT_NAME AS 부서명,
                   ROUND(AVG(A.SALARY)) AS 평균급여,
                   A.SALARY AS 급여
            FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
            WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                AND A.SALARY > (SELECT ROUND(AVG(SALARY))
                                FROM HR.EMPLOYEES
                                WHERE DEPARTMENT_ID = A.DEPARTMENT_ID)
            GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME, A.EMPLOYEE_ID, A.EMP_NAME,
                     A.SALARY
            
** 재고수불테이블 생성
  1. 테이블명 : REMAIN
  2. 컬럼
  
   컬럼명          데이터 타입             기본값          pk/fk
   -------------------------------------------------------------------
  REMAIN_YEAR     CHAR(4)                                 PK
  PROD_ID         VARCHAR2(10)                          PK & FK
  REMAIN_J_00     NUMBER(5)               0             --기초재고
  REMAIN_I        NUMBER(5)               0             --입고
  REMAIN_O        NUMBER(5)               0             --출고
  REMAIN_J_99     NUMBER(5)               0             --현재고 (기초재고+입고 -출고)
  REMAIN_DATE     DATE                                  --입출고 발생날짜
  