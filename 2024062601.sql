2024-0626-01) ROLLUP과 CUBE
    - 다양한 집계를 반환
    - 반드시 GROUP BY절 안에 기술해야함
    1. ROLLUP
        (사용형식)
        SELECT 컬럼list
        FROM 컬럼명
        [WHERE 조건]
        GROUP BY [컬럼명,...] CUBE|ROLLUP(컬럼명1, 컬럼명2...컬럼명n)[,컬럼명,...]
        
        - ROLLUP(컬럼명1, 컬럼명2,...컬럼명n) : 사용된 컬럼명1~컬럼명n이 모두 적용된 집계 반환 후 컬럼명 n부터
          하나씩 제거된 컬럼들이 적용된 집계 반환
        - 마지막에는 모든 컬럼들이 제거된 집계(전체 집계)를 반환
        - 모든 컬럼이 적용된 경우 최 하위레벨이라 하고 하나씩 제거한 것을 상위레벨이라고 한다.
        - ROLLUP 앞, 뒤로 컬럼이 나올 수 있고 이경우 부분 ROLLUP 이라고 함
        - ROLLUP에 의한 집계의 종류는 사용된 컬럼의 수 +1개임
        
        - CUBE절은 CUBE절에 사용된 컬럼들로 조합할 수 있는 모든 경우의 집계를 반환함
        - CUBE절에 의한 집계의 종류는 사용된 (컬럼의 수)^2개임
        - CUBE는 레벨 개념이 없음
        
    사용예)
        2020년 월별, 회원별, 상품별 매출집계를 조회하시오.
        alias 월 회원 번호 상품코드 매출액
        
        SELECT SUBSTR(A.CART_NO,5,2) AS 월, 
               A.CART_MEMBER AS 회원번호,
               A.CART_PROD AS 상품코드,
               SUM(A.CART_QTY*B.PROD_PRICE) AS 매출액
        FROM CART A, PROD B
        WHERE A.CART_PROD = B.PROD_ID
            AND A.CART_NO LIKE '2020%'
        GROUP BY SUBSTR(A.CART_NO,5,2), A.CART_MEMBER, A.CART_PROD
        ORDER BY 1,2,3
        
        [롤업절 사용]
        
        SELECT SUBSTR(A.CART_NO,5,2) AS 월, 
               A.CART_MEMBER AS 회원번호,
               A.CART_PROD AS 상품코드,
               SUM(A.CART_QTY*B.PROD_PRICE) AS 매출액
        FROM CART A, PROD B
        WHERE A.CART_PROD = B.PROD_ID
            AND A.CART_NO LIKE '2020%'
        GROUP BY SUBSTR(A.CART_NO,5,2) ,ROLLUP(A.CART_MEMBER, A.CART_PROD)
        ORDER BY 1,2,3
        
        [큐브절 사용]
        SELECT SUBSTR(A.CART_NO,5,2) AS 월, 
               A.CART_MEMBER AS 회원번호,
               A.CART_PROD AS 상품코드,
               SUM(A.CART_QTY*B.PROD_PRICE) AS 매출액
        FROM CART A, PROD B
        WHERE A.CART_PROD = B.PROD_ID
            AND A.CART_NO LIKE '2020%'
        GROUP BY CUBE(SUBSTR(A.CART_NO,5,2), A.CART_MEMBER, A.CART_PROD)
        ORDER BY 1,2,3