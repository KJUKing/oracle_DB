2024-0614-02) 날짜함수
    - SYSDATE, SYSTIMESTAMP
    - ADD MONTHS(d ,n), NEXT_DAY(d, c), LAST_DAY(d)
    - MONTH_BETWEEN(d1, d2)
    - EXTRACT(fmt FROM d)
    
    1) SYSDATE, SYSTIMESTAMP
        . SYSDATE : 기본 날짜데이터(년원일 시분초) 반환
          - '+' '-' 연산 가능
        . SYSTIMESTAMP : TIMESTAMP 타입의 날짜 자료 변환
    
    2) ADD_MONTHS(d, n), NEXT_DAY(d,c), LAST_DAY(d)
        . ADD_MONTHS: 주어진 날짜 d에 b개월을 더한 날짜 반환
        . NEXT_DAY : 주어진 날짜 d 이후에 맨 처음 만나느 c요일의 날짜 반환
                      c는 '월요일', '월', ~'일요일', '일'을 사용
        . LAST_DAY : 주어진 날짜 d에 포함된 월의 마지막 날짜 반환
                     동적 쿼리에서 월을 입력 받아 해당 월에 대한 작업이 필요한 경우 많이 사용됨
    
    사용예)
        (1) 사원테이블에서 입사 후 3개월이 지난날 정식 발령을 받는다고 한다
            각 사원의 정식 발령일을 조회하시오.
            
            SELECT EMPLOYEE_ID AS 사원번호,
                   EMP_NAME AS 사원명,
                   HIRE_DATE AS 입사일,
                   ADD_MONTHS(HIRE_DATE, 3) AS 발령일
                   FROM HR.EMPLOYEES;
    
        (2) SELECT NEXT_DAY (SYSDATE, '월요일'), --지금이 월요일이였다면 오늘은 제외하고 다음 월요일
                   NEXT_DAY (SYSDATE, '토')
                FROM DUAL;
                
        (3) 매입테이블에서 2020년 2월 제품별 매입수량과 매입금액을 조회
        
            SELECT BUY_PROD AS 제품코드,
                   SUM(BUY_QTY) AS 매입수량,
                   SUM(BUY_QTY*BUY_COST) AS 매입금액
                FROM BUYPROD
               WHERE BUY_DATE BETWEEN TO_DATE('20200201')
                                -- 20200201이라는 문자열을 DATE형식으로 강제 형변환한다.
                     AND LAST_DAY (TO_DATE('20200201')) --2월이라는 형식을 갖고있기때문에
                                    --LAST_DAY써서 2월 첫날부터 2월의 마지막날까지 계산
               GROUP BY BUY_PROD
               ORDER BY 1;
               
        (4) 키보드로 4-7월을 입력 받아 해당 월에 발생한 매출현황을 조회하시오
            ACCEPT P_MONTH PROMPT '판매 월(04~07) : '
            DECLARE
                L_DAY DATE;
                L_PROD PROD.PROD_ID%TYPE;
                L_MONTH DATE := TO_DATE('2020'||'&P_MONTH'||'01');
                L_QTR NUMBER :=0;
                CURSOR CUR_CART IS

                SELECT DISTINCT CART_PROD
                FROM CART
                WHERE SUBSTR(CART_NO,1,8) BETWEEN L_MONTH
                    AND LAST_DAY(L_MONTH)
            BEGIN
                OPEN CUR_CART;
                LOOP
                    FETCH CUR_CART INTO L_PROD;
                    EXIT WHEN CUR_CART%NOTFOUND;
                    SELECT TO_DATE(SUBSTR(CART_NO,1,8)), CART_PROD, CART_QTY
                    INTO L_DAY, L_PROD, L_QTY
                    FROM CART
                    WHERE CART_PROD=L_PROD;
                    
                    DBMS_OUTPUT.PUT_LINE(L_DAY||' '|| L_PROD||' '||L_QTY);
                    DBMS_OUTPUT.PUT_LINE('--------------------------------');
            END LOOP;
            CLOSE CUR_CART;
            END;
            
    3) MONTHS_BETWEEN(d1, d2)
        -두 날짜 자료 사이의 달 수를 숫자로 반환
        사용예)
            SELECT MONTH_BETWEEN(SYSDATE, '19880210')
                FROM DUAL;
        
        사용예) 사원테이블에서 50번 부서에 속한 사원들의 재직기간을 월단위까지 조회하시오.
            Alias 사원번호, 사원명, 입사일, 재직기간
            
            SELECT EMPLOYEE_ID AS 사원번호,
                   EMP_NAME AS 사원명,
                   HIRE_DATE AS 입사일,
                   TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) AS 월수,
                   TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/12) || '년'|| ' '||
                   MOD(TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)),12) || '개월' AS 재직기간
            FROM EMPLOYEES
            WHERE DEPARTMENT_ID = 50
            
        4) EXTRACT(fmt FROM d)
            - 주어진 날짜 자료 d에서 'fmt'로 정의된 값을 숫자로 반환
            - 'fmt'는 형식문자열로 'YEAR', 'MONTH', 'DAY', 'HOUR', 'MINUTE', 'SECOND'
                중 하나이어야함
                
        사용예) 장바구니 테이블에서 7월에 판매된 상품 정보를 조회하시오
                Alias는 구매회원번호, 상품코드, 수량
            SELECT CART_MEMBER AS 구매회원번호,
                   CART_NO AS 장바구니번호,
                   CART_PROD AS 상품코드,
                   CART_QTY AS 수량
            FROM CART
            WHERE EXTRACT(YEAR FROM TO_DATE (SUBSTR(CART_NO,1,8)))=2020
                AND EXTRACT(MONTH FROM TO_DATE (SUBSTR(CART_NO,1,8)))=7
            ORDER BY SUBSTR(CART_NO,1,8);