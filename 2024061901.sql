2024-0619-01)오라클 순위함수
    - 특정 컬럼을 기준으로 순위를 구하는 함수
    - RANK() OVER, DENSE_RANK OVER, ROW_NUMBER() OVER 가 제공
    
    (사용형식)
      RANK() OVER(ORDER BY 컬럼명 [DESC|ASC] [,컬럼명 [DESC|ASC],...])
    
    - RANK() OVER : 일반적인 순위(동일 값이면 동일 순위, 동일 순위 다음 순위는
                                동일 순위+동일순의 갯수가 됨)
    ex) 9,9,7,6,5,5,5,4  경우
    순위 1 1 3 4 5 5 5 8
    
    - DENSE_RANK() OVER : 동일 값이면 동일 순위, 동일 순위 다음 순위는 동일 순위 +1
    ex) 9,9,7,6,5,5,5,4  경우
    순위 1 1 2 3 4 4 4 5
    
    -ROW_NUMBER() OVER : 정렬 후 동일 값에 상관없이 차례대로 순위 부여
    ex) 9,9,7,6,5,5,5,4  경우
    순위 1 2 3 4 5 6 7 8
    
    사용예) 
    
    (1) 사원테이블에서 80번 부서의 사원 중 급여 순으로 순위를 부여하시오
            ALIAS는 사원번호, 사원병, 급여, 순위
            SELECT EMPLOYEE_ID AS 사원번호,
                   EMP_NAME AS 사원명,
                   HIRE_DATE AS 입사일,
                   SALARY AS 급여,
                   RANK() OVER(ORDER BY SALARY DESC, HIRE_DATE ) AS 순위
            FROM EMPLOYEES
            WHERE DEPARTMENT_ID =80;
            
    
    (2) 상품테이블에서 분류코드 'P101'에 속한 상품들의 판매가격 순으로 순위를 부여하시오
        ALIAS 상품번호, 상품명, 판매가격, 순위
        
        SELECT PROD_ID AS 상품번호,
               PROD_NAME AS 상품명,
               PROD_PRICE AS 판매가격,
               RANK() OVER(ORDER BY PROD_PRICE) AS 순위
        FROM PROD
        WHERE PROD_LGU = 'P101'
        
    (3) 2020년 월별 매입을 계산하고 순위를 부여하시오
        
        SELECT EXTRACT(MONTH FROM BUY_DATE)||'월' AS 월 ,
               TO_CHAR(SUM(BUY_QTY * BUY_COST), '999,999,999,999') AS 매입금액,
               RANK() OVER(ORDER BY SUM(BUY_QTY*BUY_COST) DESC) AS 순위
        FROM BUYPROD
        WHERE EXTRACT(YEAR FROM BUY_DATE) = 2020
        GROUP BY EXTRACT(MONTH FROM BUY_DATE)
        
    
    (4) 2020년 상반기(1~6월) 구매액 기준으로 구매를 가장 많이한 회원의 5명을 조회하시오
        ALIAS 회원번호, 회원명, 구매액, 순위
        
        SELECT TBLA.AID AS 회원번호,
               TBLA.ANAME AS 회원명,
               TBLA.ASUM AS 구매액,
               TBLA.ARANK AS 순위
        FROM     (SELECT A.CART_MEMBER AS AID,
                         C.MEM_NAME AS ANAME,
                         SUM(A.CART_QTY*B.PROD_PRICE) AS ASUM,
                         RANK() OVER(ORDER BY SUM(A.CART_QTY*B.PROD_PRICE) DESC) AS ARANK
                  FROM CART A, PROD B, MEMBER C
                  WHERE A.CART_PROD=B.PROD_ID AND
                        A.CART_MEMBER = C.MEM_ID
                        AND SUBSTR(A.CART_NO,1,6) BETWEEN '202001' AND '202006'
                  GROUP BY A.CART_MEMBER, C.MEM_NAME) TBLA
        WHERE ROWNUM <= 5
        
        
    - 그룹내 순위
    (사용형식)
    RANK() OVER(PARTITION BY 컬럼명 [,컬럼명,...] ORDER BY 컬럼명 [DESC|ASC]
                [컬럼명 [DESC|ASC] , ...])
                
    사용예)
    (1) 사원테이블에서 각 부서별 급여를 기준으로 순위를 부여하시오.
        Alias 사원번호, 사원명, 부서번호, 급여, 순위
        부서코드 순으로 출력
        
        SELECT EMPLOYEE_ID AS 사원번호,
               EMP_NAME AS 사원명,
               DEPARTMENT_ID AS 부서번호,
               SALARY AS 급여,
               RANK() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) AS 순위
        FROM EMPLOYEES
        ORDER BY 3
    
    (2) 상품테이블에서 분류코드별 매입가격 순으로 순위를 부여하시오.
        Alias는 분류코드, 상품명, 매입가격, 순위
        
        SELECT PROD_LGU AS 분류코드,
               RROD_NAME AS 상품명,
               TO_CHAR(SUM(PROD_COST),'999,999,999') AS "매입 총 가격",
               RANK() OVER (PARTITION BY PROD_LGU ORDER_BY SUM(PROD_COST) DESC) AS 순위
        FROM PROD
        GROUP BY PROD_LGU, PROD_NAME
        ORDER BY 1
        