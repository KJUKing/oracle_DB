2024-0624-01) 서브쿼리
** DML 명령과 서브쿼리
1. INSERT문과 SUBQUERY
    - INSERT문에 서브쿼리를 사용할 경우 VALUES절이 생략됨
    - 서브쿼리를 ( )를 사용하지 않고 기술
    - 서브쿼리의 결과와 INSERT 되는 컬럼이 일치되어야 함
    (사용형식)
        INSERT INTO 테이블명 [(컬럼list)]
            서브쿼리;
    사용예) 재고수불 테이블에 다음의 값을 입력하시오.
           상품코드는 상품테이블의 상품코드,
           기초재고는 PROD_PROPERSTOCK 컬럼값
           년도는 '2020'
           매입수량, 매출수량은 0
           현재고는 기초재고와 같음
           날짜는 2020년 1월 1일임
           
           INSERT INTO REMAIN
                SELECT '2020', PROD_ID, PROD_PROPERSTOCK, 0, 0, PROD_PROPERSTOCK,
                       TO_DATE('20200101')
                FROM PROD
                
           SELECT * FROM REMAIN