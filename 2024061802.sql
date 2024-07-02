2024-0618-02) NULL처리함수
    - 오라클에서 NULL은 자료의 존재유무를 판단할 때 사용
    - NULL과 연산된 결과는 항상 NULL임
    - NULL 처리 연산자 : IS NULL, IS NOT NULL
    - NULL 처리 연산 함수 : NVL(expr, 값), NVL2(expr,값1,값2), NULLIF(c, d)
    
    1)IS NULL, IS NOT NULL
        - NULL값 비교는 '=' 연산자로 수행할 수 없음
        - 반드시 IS NULL, IS NOT NULL로 비교해야 함
        
    사용예) 사원테이블에서 영업실적이 NULL이 아닌 사원의 사원번호, 사원명, 부서번호, 급여를
            조회하시오.
        SELECT EMPLOYEE_ID AS 사원번호,
               EMP_NAME AS 사원명,
               DEPARTMENT_ID AS 부서번호,
               SALARY AS 급여
        FROM EMPLOYEES
        WHERE EMPLOYEE_ID IS NOT NULL AND
              EMP_NAME IS NOT NULL AND
              DEPARTMENT_ID IS NOT NULL AND
              SALARY IS NOT NULL
              
    2) NVL(expr, 값)
        - expr 값이 NULL이면 '값'을 반환하고 NULL이 아니면 자신의 값을 반환
        
        - expr과 '값'의 데이터 타입은 반드시 일치해야함
        
    사용예) 상품테이블에서 상품의 사이즈가 NULL인 상품은 '크기정보 없음'을 출력하시오
    Alias는 상품코드, 상품명, 크기, 판매가
        SELECT 
                PROD_ID AS 상품코드,
                PROD_NAME AS 상품명,
                PROD_SIZE AS 크기,
                NVL(PROD_SIZE, '크기정보 없음') AS 구분,
                PROD_PRICE AS 판매가
        FROM PROD
    
    사용예) 사원테이블에서 2022년 이후 입사한 사원들의 보너스를 계산하여 출력하시오
            단 금속년수가 많은 사원부터 출력
            보너스 = (BONUS)=급여(SALARY)*영업실적(COMMISSION_PCT)
            ALIAS   는 사원번호, 사원명, 입사일, 입사일, 영업실적, 급여, 보너스
            SELECT EMPLOYEE_ID AS 사원번호,
                   EMP_NAME AS 사원명,
                   HIRE_DATE AS 입사일,
                   COMMISSION_PCT AS 영업실적,
                   SALARY AS 급여,
                   NVL(TO_CHAR((SALARY*COMMISSION_PCT), '999,999'), '보너스없음') AS 보너스
            FROM EMPLOYEES
            WHERE EXTRACT(YEAR FROM SYSDATE) >= 2022
            ORDER BY 3;
            
    3) NVL2(expr,값1,값2)
        - expr의 값이 NULL이 아니면 '값1'을 반환하고, NULL이면 '값2'를 반환
        - '값1'과'값2'는 같은 데이터 타입이어야 한다
        - NVL을 NVL2로 바꾸어 사용할 수 있음[NVL2(expr,expr,'값2')]
    
    4) NULLIF(c,d)
        -c와 d가 같은 값이면 NULL을 반환하고, NULL이 아니면 C를 반환
        
    ** 상품테이블에서 분류코드 'P301'에 속한 상품의 판매가격을 매입가격으로 변경하시오
            UPDATE PROD
            SET PROD_PRICE = PROD_COST
            WHERE PROD_LGU = 'P301'
            
    사용예) 상품테이블에서 매입가와 매출가가 같은 상품은 비고란에 '단종예정'을 출력하고
            매입가와 매출가가 같지 않은 상품은 매출가 판매 이익을 출력하시오
            ALIAS 상품코드, 상품명, 매입가, 매출가, 비고
            SELECT PROD_ID AS 상품코드,
                   PROD_NAME AS 상품명,
                   PROD_COST AS 매입가,
                   PROD_PRICE AS 매출가,
                   NVL2(NULLIF(PROD_COST , PROD_PRICE),
                        TO_CHAR((PROD_PRICE -PROD_COST),'9,999,999'),
                        LPAD('단종예정',11)) AS비고
            FROM PROD