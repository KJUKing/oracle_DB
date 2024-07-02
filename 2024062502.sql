2024-0625-02)집합연산자
    - 여러 개의 질의 결과를 연결하여 하나의 결과를 반환
    - 서로 다른 테이블에서 유사한 형태의 결과를 반환하는 경우나,
      동일 테이블에서 서로 다른 질의의 결과를 합칠때 사용
    - 튜닝 관점에서 실행계획을 분리하고자 할때 사용
    - UNION, UNION ALL, INTERSECT, MINUS 연산자 제공
    - 첫 번째 SELECT 문에 적용된 SELECT절의 별칭이 결과의 별칭으로 사용
    - 각 SELECT 문의 SELECT 절의 컬럼의 수가 동일해야하며, 같은 위치의 컬럼
      데이터 타입이 동일해야함
    - ORDER BY절은 맨 마지막 SELECT문에서만 사용 가능
    
    1. UNION과 UNION ALL
        - 합집합의 결과를 반환
        - UNION ALL은 공통자료를 중복출력
        
    사용예)
        (1) 회원테이블에서 마일리지가 2000이상인 회원과 직업이 '자영업'인 회원의
        회원번호, 회원명, 나이를 구하시오.
        
        (UNION)
        SELECT MEM_ID AS 회원번호,
               MEM_NAME AS 회원명,
               EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR) AS 나이
        FROM MEMBER
        WHERE MEM_MILEAGE >= 4000
        
    UNION ALL
        SELECT MEM_ID AS 회원번호,
               MEM_NAME AS 회원명,
               EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR) AS 나이
        FROM MEMBER
        WHERE MEM_JOB = '자영업'
        
        (2) 사원테이블에서 부서별 급여합계와 전체 급여합계를 구하는
            QUERY를 작성하시오
        SELECT TO_CHAR(A.DEPARTMENT_ID) AS 부서코드,
               B.DEPARTMENT_NAME AS 부서명,
               SUM(SALARY) AS "부서별 급여합계"
        FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
        WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
        GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
    UNION ALL
        SELECT '  ',
               '합계',
               SUM(SALARY)
        FROM HR.EMPLOYEES
        
        (3) 2020년 3월과 2020년 6월에 매입된 상품정보를 조회하시오(중복배제)
            ALIAS 상품번호, 상품명을 각각 출력하고 마지막행에는 상품명컬럼에
            전체 매입금액을 출력하시오
            
            SELECT DISTINCT B.BUY_PROD AS 상품번호,
                   A.PROD_NAME AS 상품명
            FROM PROD A, BUYPROD B
            WHERE A.PROD_ID = B.BUY_PROD
            AND BUY_DATE BETWEEN TO_DATE('20200401')
                                AND TO_DATE('20200430')
        UNION
            SELECT C.PROD_ID AS 상품번호,
                   C.PROD_NAME AS 상품명
            FROM PROD C, BUYPROD D
            WHERE C.PROD_ID = D.BUY_PROD
            AND BUY_DATE BETWEEN TO_DATE('20200601')
                                AND TO_DATE('20200630')
        UNION
            SELECT '합계',
                   TO_CHAR(SUM(BUY_QTY*PROD_COST),'999,999,999')
            FROM BUYPROD A, PROD B
            WHERE A.BUY_PROD=B.PROD_ID
                AND (A.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630') OR
                    A.BUY_DATE BETWEEN TO_DATE('20200301') AND TO_DATE('20200331'))
                    
        2. INTERSECT
            -교집합의 결과를 반환
        
        사용예)
        (1) 사원테이블에서 직무가 'IT_PROG'이고 급여가 5000이상이며 근속년수가
            3년이 안된 직원의 사원번호, 사원명, 부서명, 직무코드, 급여, 입사일를 조회하시오
            
            SELECT A.EMPLOYEE_ID AS 사원번호,
                   A.EMP_NAME AS 사원명,
                   B.DEPARTMENT_NAME AS 부서명,
                   A.JOB_ID AS 직무코드,
                   A.SALARY AS 급여,
                   A.HIRE_DATE AS 입사일
            FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
            WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
            AND A.JOB_ID = 'IT_PROG'
    INTERSECT     
            SELECT A.EMPLOYEE_ID,
                   A.EMP_NAME,
                   B.DEPARTMENT_NAME,
                   A.JOB_ID,
                   A.SALARY,
                   A.HIRE_DATE
            FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
            WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID    
            AND MONTHS_BETWEEN(SYSDATE, A.HIRE_DATE) <=36
    INTERSECT
            SELECT A.EMPLOYEE_ID,
                   A.EMP_NAME,
                   B.DEPARTMENT_NAME,
                   A.JOB_ID,
                   A.SALARY,
                   A.HIRE_DATE
            FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
            WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID            
            AND A.SALARY >= 5000
            
    (2) 2020년 3월에 매입된 상품 중 4월에 판매된 상품을 조회하시오
        ALIAS는 상품번호, 상품명, 매입가, 매출가
        [2020년 3월에 매입된 상품]
        SELECT A.BUY_PROD AS 상품번호,
               B.PROD_NAME AS 상품명,
               B.PROD_COST AS 매입가,
               B.PROD_PRICE AS 매출가
        FROM BUYPROD A, PROD B
        WHERE A.BUY_PROD=B.PROD_ID
            AND A.BUY_DATE BETWEEN TO_DATE('20200301') AND TO_DATE('20200331')
    INTERSECT
        SELECT DISTINCT A.CART_PROD,
               B.PROD_NAME,
               B.PROD_COST,
               B.PROD_PRICE
        FROM CART A, PROD B
        WHERE A.CART_PROD=B.PROD_ID
            AND A.CART_NO LIKE '202004%'
            [2020년 4월에 판매된 상품]
            
3. MINUS
    - 왼쪽에 기술된 집합에서 오른쪽에 기술된 집합을 뺀 결과(차집합)를 반환
    
    사용예)
    (1)2020년 6월과 7월에 판매된 상품 중 6월에만 판매된 상품을 조회하시오.
        SELECT DISTINCT B.PROD_ID AS 상품번호,
               B.PROD_NAME AS 상품명
        FROM CART A, PROD B
        WHERE A.CART_PROD = B.PROD_ID
            AND A.CART_NO LIKE '202006%'
    MINUS
        SELECT B.PROD_ID,
               B.PROD_NAME
        FROM CART A, PROD B
        WHERE A.CART_PROD = B.PROD_ID
            AND A.CART_NO LIKE '202007%'
            
        서브쿼리 사용
        SELECT DISTINCT B.PROD_ID AS,
               B.PROD_NAME AS
        FROM CART A, PROD B
        WHERE A.CART_PROD = B.PROD_ID
            AND A.CART_NO LIKE '202006%'
            AND A.CART_PROD NOT IN(SELECT CART_PROD
                                   FROM CART
                                   WHERE CART_NO LIKE '202007%')
        교집합검증
        SELECT CART_PROD
        FROM CART
        WHERE CART_NO LIKE '202007%'
    INTERSECT
        SELECT CART_PROD
        FROM CART
        WHERE CART_NO LIKE '202006%'
            
   --------------------------------------------------------------------------     
   
    (2)사원테이블에서 LAST_NAME이 'K'로 시작되고 직무가 'SA_REP'가 아닌
       사원들의 사원번호, 사원명, 직무코드를 조회하시오
       
       SELECT EMPLOYEE_ID AS 사원번호,
              EMP_NAME AS 사원명,
              JOB_ID AS 직무코드
       FROM HR.EMPLOYEES
       WHERE LAST_NAME LIKE 'K%'
       AND JOB_ID <> 'SA_REP'; -- !=써도됨
       
       마이너스 연산자
       SELECT EMPLOYEE_ID AS 사원번호,
              EMP_NAME AS 사원명,
              JOB_ID AS 직무코드
       FROM HR.EMPLOYEES
       WHERE LAST_NAME LIKE 'K%'
    MINUS
       SELECT EMPLOYEE_ID,
              EMP_NAME,
              JOB_ID
       FROM HR.EMPLOYEES
       WHERE JOB_ID = 'SA_REP'
        