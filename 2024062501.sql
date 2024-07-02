2024-0625-01)
2. UPDATE문과 SUBQUERY
    - SET 절의 '='연산자 오른쪽에 서브쿼리 사용
    (사용형식)
    UPDATE 테이블명 [별칭]
        SET (컬럼명1,...컬럼명n)=(SELECT 컬럼명1,...컬럼명n
                                    FROM~ )
                                    
    [WHERE 조건]
        . SET 절에 기술된 컬럼의 갯수와 순서는 서브쿼리의 SELECT절의
          컬럼의 갯수와 순서가 일치해야함
        

사용예)
    (1) 2020년 1월~3월 사이에 발생한 매입정보를 사용하여 재고수불 테이블의
        정보를 갱신하시오
        
        [서브쿼리 : 2020년 1-3월 상품별 매입수량집계]
        SELECT B.BSUM
        FROM  (SELECT  BUY_PROD,
                       SUM(BUY_QTY) AS BSUM
               FROM BUYPROD
               WHERE BUY_DATE BETWEEN TO_DATE('20200101')
                              AND LAST_DAY(TO_DATE('20200331'))
               GROUP BY BUY_PROD) B
       
        
        [메인쿼리]
        UPDATE REMAIN A
        SET (A.REMAIN_I, REMAIN_J_99, A.REMAIN_DATE)=
            (SELECT A.REMAIN_I + B.BSUM, A.REMAIN_J_99 +B.BSUM,
                    LAST_DAY(TO_DATE('20200301'))
             FROM  (SELECT  BUY_PROD,
                            SUM(BUY_QTY) AS BSUM
                    FROM BUYPROD
                    WHERE BUY_DATE BETWEEN TO_DATE('20200301')
                                    AND LAST_DAY(TO_DATE('20200301'))
                    GROUP BY BUY_PROD) B
             WHERE A.PROD_ID = B.BUY_PROD) --재고수불테이블에서 변경할 상품을 선택하는것 하나씩
        WHERE A.PROD_ID IN (SELECT DISTINCT BUY_PROD
                            FROM BUYPROD
                            WHERE BUY_DATE BETWEEN TO_DATE('20200301')
                                           AND LAST_DAY(TO_DATE('20200301')))
                                           
    (2) 2020년 4월~7월 사이에 발생한 매입/매출정보를 사용하여
        재고수불테이블의 정보를 갱신하시오
            
            UPDATE REMAIN A
            SET (A.REMAIN_I, REMAIN_O, REMAIN_J_99, A.REMAIN_DATE)=
                (SELECT  B.BUY_PROD,
                         SUM(B.BUY_QTY) AS BSUM,
                         C.CART_PROD,
                         SUM(C.CART_QTY) AS CSUM
                 FROM BUYPROD B, CART C
                 WHERE B.BUY_PROD = C.CART_PROD
                    AND BUY_DATE BETWEEN TO_DATE('20200401')
                                 AND LAST_DAY(TO_DATE('20200701'))
                 GROUP BY BUY_PROD, CART_PROD) D
                 
                 [서브쿼리 : 2020년 4월-7월 사이에 발생한 매입/매출정보
                 SELECT D.매입수량, D.매출수량
                 FROM  (SELECT 상품코드, 매입수량, 매출수량
                        FROM (제품별 매입수량) A, (제품별 매출수량) B, PROD C
                        WHERE C.PROD_ID=A.상품번호(+)
                        AND C.PROD_ID=B.상품번호(+))D
                 [제품별 매입수량]
                 SELECT BUY_PROD,
                        SUM(BUY_QTY) AS BSUM
                 FROM BUYPROD
                 WHERE BUY_DATE BETWEEN TO_DATE('20200401')
                                 AND LAST_DAY(TO_DATE('20200701'))
                 GROUP BY BUY_PROD
                 [제품별 매출수량]
                 SELECT CART_PROD,
                        SUM(CART_QTY) AS CSUM
                 FROM CART
                 WHERE SUBSTR(CART_NO, 1,6) BETWEEN '202004' AND '202007'
                 GROUP BY CART_PROD
                 
                 [결합]
                 SELECT D.ABSUM,
                        D.BCSUM
                 FROM  (SELECT C.PROD_ID AS PID,
                               NVL(A.BSUM,0) AS ABSUM,
                               NVL(B.CSUM,0) AS BCSUM
                        FROM (SELECT BUY_PROD,
                                     SUM(BUY_QTY) AS BSUM
                              FROM BUYPROD
                              WHERE BUY_DATE BETWEEN TO_DATE('20200401')
                                             AND LAST_DAY(TO_DATE('20200701'))
                              GROUP BY BUY_PROD) A,
                             (SELECT CART_PROD,
                                     SUM(CART_QTY) AS CSUM
                              FROM CART
                              WHERE SUBSTR(CART_NO, 1,6) BETWEEN '202004' AND '202007'
                              GROUP BY CART_PROD) B,
                              PROD C
                        WHERE C.PROD_ID=A.BUY_PROD(+)
                        AND C.PROD_ID=B.CART_PROD(+)) D
                        
                [메인쿼리]
                UPDATE REMAIN R
                SET (R.REMAIN_I, R.REMAIN_O, R.REMAIN_J_99, R.REMAIN_DATE)=
                    (SELECT R.REMAIN_I + D.ABSUM, R.REMAIN_O + D.BCSUM,
                            R.REMAIN_J_99 + D.ABSUM - D.BCSUM, TO_DATE('20200731')
                     FROM  (SELECT C.PROD_ID AS PID,
                               NVL(A.BSUM,0) AS ABSUM,
                               NVL(B.CSUM,0) AS BCSUM
                            FROM  (SELECT BUY_PROD,
                                     SUM(BUY_QTY) AS BSUM
                                   FROM BUYPROD
                                   WHERE BUY_DATE BETWEEN TO_DATE('20200401')
                                                 AND TO_DATE('20200731')
                                   GROUP BY BUY_PROD) A,
                                  (SELECT CART_PROD,
                                          SUM(CART_QTY) AS CSUM
                                   FROM CART
                                   WHERE SUBSTR(CART_NO, 1,6) BETWEEN '202004' AND '202007'
                                   GROUP BY CART_PROD) B,
                                   PROD C
                            WHERE C.PROD_ID=A.BUY_PROD(+)
                                AND C.PROD_ID=B.CART_PROD(+))D
                            WHERE D.PID=R.PROD_ID)