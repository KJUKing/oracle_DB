2024-0621-01) 외부조인
    - 내부조인은 조인조건을 만족하는 행만으로 연산이 수행되고
      외부조인은 조인조건을 만족하지 않는 행들이 검색되게하는 조인 연산
    - 조인조건을 만족하지 않는 테이블에 NULL행을 추가하여 조인 수행
    (일반 외부조인 사용형식)
        SELECT 컬럼list
        FROM 테이블1 [별칭1], 테이블2 [별칭2],...
        WHERE 별칭1.컬럼=별칭2.컬럼명(+)...
    - 일반 외부조인 연산자는 '(+)'이며,
      자료가 부족한 테이블의 컬럼명에 추가함
    - 외부조인 조건이 복수개일때 모든 조인조건에 '(+)'를 사용해야함
    - 3개이상의 테이블이 연산에 참여한경우 한 테이블이 외부조인에 동시에 참여할 수 없다.
      즉, A, B, C테이블이 외부조인 되는 경우 조인조건에 A=B(+) AND C=B(+)는 허용되지 않음
    - 일반 외부 조인과 일반조건이 동시에 기술되면 내부조인으로 변경되어
      결과를 반환(해결 : 서브쿼리 사용 또는 ANSI외부조인 사용)
      
      (ANSI 사용형식)
        SELECT 컬럼list
        FROM 테이블1 [별칭1]
        LEFT|RIGHT|FULL OUTER JOIN 테이블2 [별칭2] ON(조인조건 [AND 일반조건])
        LEFT|RIGHT|FULL OUTER JOIN 테이블3 [별칭3] ON(조인조건 [AND 일반조건])
        
        [WHERE 일반조건];
            . 'LEFT': 테이블1의 자료가 테이블2의 자료보다 많은 경우
            . 'RIGHT': 테이블2의 자료가 테이블1의 자료보다 많은 경우
            . 'FULL': 양쪽 테이블에 모두 자료가 부족한 경우
            . 'WHERE 일반조건'을 사용하면 외부조인 결과에 일반조건이 수행되어 원하는 결과를 얻을수 없음
    사용예
        (1) NULL부서코드를 제외하고 모든 부서별 인원수를 조회하시오
        SELECT B.DEPARTMENT_ID AS 부서코드,
               B.DEPARTMENT_NAME AS 부서명,
               COUNT(A.EMPLOYEE_ID) AS 인원수
        FROM EMPLOYEES A, DEPARTMENTS B
        WHERE A.DEPARTMENT_ID(+) = B.DEPARTMENT_ID
        GROUP BY B.DEPARTMENT_ID, B.DEPARTMENT_NAME
        ORDER BY 1;
        
        (ANSI)
        SELECT B.DEPARTMENT_ID AS 부서코드,
               B.DEPARTMENT_NAME AS 부서명,
               COUNT(A.EMPLOYEE_ID) AS 인원수
        FROM EMPLOYEES A
        RIGHT OUTER JOIN DEPARTMENTS B ON(A.DEPARTMENT_ID = B.DEPARTMENT_ID)
        GROUP BY B.DEPARTMENT_ID, B.DEPARTMENT_NAME
        ORDER BY 1;
        
        
        (2) 2020년 1월 모든 상품별 매입금액을 조회
        SELECT B.PROD_ID AS 상품번호,
               B.PROD_NAME AS 상품명,
               SUM(A.BUY_QTY*B.PROD_COST) AS 매입금액
        FROM BUYPROD A, PROD B
        WHERE A.BUY_PROD(+)=B.PROD_ID
          AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
        GROUP BY B.PROD_ID, B.PROD_NAME
        ORDER BY 1;
        
        
        (ANSI)
        SELECT B.PROD_ID AS 상품번호,
               B.PROD_NAME AS 상품명,
               NVL(SUM(A.BUY_QTY*B.PROD_COST),0) AS 매입금액
        FROM BUYPROD A
        RIGHT OUTER JOIN PROD B ON (A.BUY_PROD =B.PROD_ID
                                    AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131'))
        GROUP BY B.PROD_ID, B.PROD_NAME
        ORDER BY 1;
        
        (SUBQUERY)
        SELECT P.PROD_ID AS 상품번호,
               P.PROD_NAME AS 상품명,
               NVL(R.BSUM,0) AS 매입금액
        FROM  (     SELECT A.BUY_PROD AS BID,
                    SUM(A.BUY_QTY*B.PROD_COST) AS BSUM
                    FROM BUYPROD A, PROD B
                    WHERE A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
                        AND A.BUY_PROD=B.PROD_ID
                    GROUP BY A.BUY_PROD) R, PROD P
        WHERE P.PROD_ID=R.BID(+)
        ORDER BY 1;
        
        
        (3) 2020년 모든 상품별 매입/매출 정보를 조회하시오
        (매입 ANSI)
        SELECT B.PROD_ID AS 상품코드,
               B.PROD_NAME AS 상품명,
               SUM(B.PROD_COST * A.BUY_QTY) AS 매입금액합계
        FROM BUYPROD A
        RIGHT OUTER JOIN PROD B ON(A.BUY_PROD = B.PROD_ID
                                   AND EXTRACT(YEAR FROM A.BUY_DATE)=2020)
        GROUP BY B.PROD_ID, B.PROD_NAME
        ORDER BY 1;
        
        (매출 ANSI)
        SELECT B.PROD_ID AS 상품코드,
               B.PROD_NAME AS 상품명,
               SUM(B.PROD_PRICE * A.CART_QTY) AS 매출금액합계
        FROM CART A
        RIGHT OUTER JOIN PROD B ON(A.CART_PROD = B.PROD_ID
                                   AND A.CART_NO LIKE '2020%')
        GROUP BY B.PROD_ID, B.PROD_NAME
        ORDER BY 1;
        
        (매입/매출 합치기)
        
        SELECT 
        FROM   (SELECT B.PROD_ID AS BID,
                       SUM(B.PROD_COST * A.BUY_QTY) AS BSUM
                FROM PROD B
                LEFT OUTER JOIN BUYPROD A ON (A.BUY_PROD = B.PROD_ID
                    AND EXTRACT(YEAR FROM A.BUY_DATE)=2020)
                GROUP BY B.PROD_ID)TA,
                
                (SEL
        FROM BUYPROD A

        LEFT OUTER JOIN CART C ON (B.PROD_ID=C.CART_PROD
                                   AND C.CART_NO LIKE '2020%')
        GROUP BY B.PROD_ID, B.PROD_NAME
        ORDER BY 1;
        
        
        
        
        SELECT A.PROD_ID,
               A.PROD_NAME,
               B.BSUM,
               C.CSUM
        FROM PROD A, 
                (SELECT A.BUY_PROD AS BID, -- 서브쿼리 B
                        SUM(A.BUY_QTY*B.PROD_COST) AS BSUM
                 FROM BUYPROD A, PROD B
                 WHERE A.BUY_PROD=B.PROD_ID
                    AND EXTRACT(YEAR FROM A.BUY_DATE)=2020
                 GROUP BY A.BUY_PROD) B, -- 끝
                 
                (SELECT A.CART_PROD AS CID, -- 서브쿼리 C
                        SUM(A.CART_QTY*B.PROD_PRICE) AS CSUM
                FROM CART A, PROD B
                WHERE A.CART_PROD=B.PROD_ID
                    AND CART_NO LIKE '2020%'
                GROUP BY A.CART_PROD) C -- 끝
                
        WHERE A.PROD_ID=B.BID(+) -- 조인
            AND A.PROD_ID=C.CID(+) -- 조인
            
        ORDER BY 1;  
  
                
                
           
                