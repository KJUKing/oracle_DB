2024-0619-02) JOIN
    - 관계형 데이터베이스에서 가장 중요한 연산
    - 다수의 테이블에서 공통의 컬럼을 이용하여 필요한 자료를 조회
    - 조인의 종류
     . 내부조인 (INNER JOIN) / 외부조인 (OUTER JOIN)
     . 일반조인 / 안씨조인(ANSI JOIN)
     . 동등조인 / 비동등조인
     . SELF JOIN, CARTESIAN PRODUCT(CROSS JOIN)
     
     1. Cartesian Product(Cross Join)
        - 조인조건이 생략되었거나 잘못 설정한 경우
        - 결과의 행이 기하급수적으로 증가(연산에 참여한 테이블의 행을 모두 곱한 결과)
        - 결과의 열은 연산에 참여한 테이블의 열을 모두 더한 결과가 됨
        - 사용에 주의를 요함(반드시 필요한 경우를 제외하고 사용을 자제해야함)
        (ansi 형식)
        SELECT 컬럼list
        FROM 테이블명1 [별칭1]
        CROSS JOIN 테이블명2 [별칭2] [ON(조인조건)]
                        :
        [WHERE 일반조건]
    사용예)
        SELECT COUNT(*) AS "BUYPROD"
        FROM BUYPROD;
        
        SELECT COUNT(*) AS "CART"
        FROM CART;
        
        SELECT (*)
        FROM CART, BUYPROD, PROD
        -- WHERE CART_PROD = BUY_PROD;
        
        (ANSI FORMAT)
        SELECT COUNT(*)
        FROM CART
        CROSS JOIN BUYPROD ON(CART_NO=BUY_PROD)
        CROSS JOIN PROD ON(CART_PROD=PROD_ID);
     
     1. 내부조인
        - 조인 조건을 만족하는 자료만을 대상으로 함
        - 동등조인(Equi-Join) 등 대부분의 조인 연산이 이에 포함됨
     (사용형식)
        (1)일반 조인형식
            SELECT 컬럼 LIST
            FROM    테이블1 [별칭1]
            -- 테이블1과 2는 반드시 직접조인이되어야함
            INNER JOIN 테이블2 [별칭2] ON [조인조건 [AND 일반조건])
            [INNER JOIN 테이블3 [별칭3] ON [조인조건 [AND 일반조건])]
            --테이블3은 1과 2의 조인결과와 조인됨
            WHERE 조인 조건
             [AND 조인 조건]
                    :
             [AND 일반 조건]
             
    
    (1) HR 계정 사원테이블에서 50번부서에 속한 사원의 사원번호, 사원명,부서번호,부서명을 
    출력하시오.
    (일반조인)
        SELECT EMPLOYEE_ID AS 사원번호,
               EMP_NAME AS 사원명,
               DEPARTMENTS.DEPARTMENT_ID AS 부서번호,
               DEPARTMENT_NAME AS 부서명
        FROM EMPLOYEES, DEPARTMENTS
        WHERE EMPLOYEES.DEPARTMENT_ID =50
          AND EMPLOYEES.DEPARTMENT_ID=DEPARTMENTS.DEPARTMENT_ID
          
        -> 축약어로 별칭화
        
        SELECT EMPLOYEE_ID AS 사원번호,
               EMP_NAME AS 사원명,
               B.DEPARTMENT_ID AS 부서번호,
               DEPARTMENT_NAME AS 부서명
        FROM EMPLOYEES A, DEPARTMENTS B
        WHERE A.DEPARTMENT_ID =50
          AND A.DEPARTMENT_ID= B.DEPARTMENT_ID
          
        -> 안시조인
        
        SELECT EMPLOYEE_ID AS 사원번호,
               EMP_NAME AS 사원명,
               B.DEPARTMENT_ID AS 부서번호,
               DEPARTMENT_NAME AS 부서명
        FROM EMPLOYEES A
--        INNER JOIN DEPARTMENTS B ON(A.DEPARTMENT_ID =B.DEPARTMENT_ID)--조인조건
--        WHERE A.DEPARTMENT_ID =50--일반조건
        INNER JOIN DEPARTMENTS B ON(A.DEPARTMENT_ID =B.DEPARTMENT_ID
                    AND A.DEPARTMENT_ID =50); -- 일반 조인 조건 합쳐도됨
          
          
    (2) 2020년 5월 회원별 구매집계를 조회하시오
    Alias는 회원번호,회원명,구매수량합계
    
    (일반조인)
        SELECT B.MEM_ID AS 회원번호,
               B.MEM_NAME AS 회원명,
               SUM(A.CART_QTY) AS 구매수량합계
        FROM    CART A, MEMBER B
        WHERE  A.CART_MEMBER = B.MEM_ID --조인조건
          AND  A.CART_NO LIKE '202005%' --일반조건
        GROUP BY B.MEM_ID, B.MEM_NAME
        
    (안시형식)
        SELECT B.MEM_ID AS 회원번호,
               B.MEM_NAME AS 회원명,
               SUM(A.CART_QTY) AS 구매수량합계
        FROM    CART A
        INNER  JOIN MEMBER B ON(A.CART_MEMBER = B.MEM_ID)
        WHERE  A.CART_NO LIKE '202005%' --일반조건
        GROUP BY B.MEM_ID, B.MEM_NAME
        ORDER BY 1;
        
        
    (3) 2020년 2월 상품별 매입집계를 조회하시오
    Alias 는 상품번호,상품명,매입수량,매입금액
    
        SELECT A.PROD_ID AS 상품번호,
               A.PROD_NAME AS 상품명,
               B.BUY_QTY AS 매입수량,
               SUM(A.PROD_COST*B.BUY_QTY) AS 매입금액
        FROM  PROD A, BUYPROD B
        WHERE  A.PROD_ID = B.BUY_PROD
          AND  EXTRACT(YEAR FROM A.PROD_INSDATE) =2020
          AND  EXTRACT(MONTH FROM A.PROD_INSDATE) =02
        GROUP BY A.PROD_ID, A.PROD_NAME, B.BUY_QTY
        ORDER BY 1;
        
    (안시형식)
        SELECT A.PROD_ID AS 상품번호,
               A.PROD_NAME AS 상품명,
               B.BUY_QTY AS 매입수량,
               SUM(A.PROD_COST*B.BUY_QTY) AS 매입금액
        FROM  PROD A
        INNER JOIN BUYPROD B ON(A.PROD_ID = B.BUY_PROD)
        WHERE  EXTRACT(YEAR FROM A.PROD_INSDATE) =2020
          AND  EXTRACT(MONTH FROM A.PROD_INSDATE) =02
        GROUP BY A.PROD_ID, A.PROD_NAME, B.BUY_QTY
        ORDER BY 1;
        

    (4) HR계정의 각 부서별 사원수와 평균급여를 조회하시오.
    Alias는 부서번호,부서명,사원수,평균급여
    
        SELECT A.DEPARTMENT_ID AS 부서번호,
               B.DEPARTMENT_NAME AS 부서명,
               COUNT(A.EMP_NAME) AS 사원수,
               ROUND(AVG(A.SALARY)) AS 평균급여
        FROM EMPLOYEES A, DEPARTMENTS B
        WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
        GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME;
        
-- 사원수 계산: SUM(A.EMP_NAME)에서 A.EMP_NAME은 일반적으로 사원의 이름이나 식별자를 나타내는 것으로 보입니다. 일반적으로 사원의 수를 세는 것은 COUNT 함수를 사용해야 합니다.
-- 평균급여 계산: AVG(A.SALARY)은 집계 함수이므로 이를 사용할 때는 GROUP BY 절에는 포함될 수 없습니다.

    (5) 2020년 6월 회원별 상품별 판매집계를 조회하시오
    Alias는 회원번호, 회원명, 상품명, 구매수량, 구매금액
    
        SELECT A.MEM_ID AS 회원번호,
               A.MEM_NAME AS 회원명,
               C.PROD_NAME AS 상품명,
               COUNT(B.CART_QTY) AS 구매수량,
               SUM(B.CART_QTY * C.PROD_PRICE) AS 구매금액
        FROM  MEMBER A, CART B, PROD C
        WHERE A.MEM_ID = B.CART_MEMBER
          AND B.CART_PROD = C.PROD_ID
          AND SUBSTR(B.CART_NO, 1, 6)='202006'
        GROUP BY A.MEM_ID, A.MEM_NAME, C.PROD_NAME, B.CART_QTY
        ORDER BY 1;
        
    (안시형식)
    
        SELECT A.MEM_ID AS 회원번호,
               A.MEM_NAME AS 회원명,
               C.PROD_NAME AS 상품명,
               COUNT(B.CART_QTY) AS 구매수량,
               SUM(B.CART_QTY * C.PROD_PRICE) AS 구매금액
        FROM  MEMBER A
        INNER JOIN CART B ON(A.MEM_ID = B.CART_MEMBER)
        INNER JOIN PROD C ON(B.CART_PROD = C.PROD_ID)
        WHERE SUBSTR(B.CART_NO, 1, 6)='202006'
        GROUP BY A.MEM_ID, A.MEM_NAME, C.PROD_NAME, B.CART_QTY
        ORDER BY 1;

    (6) HR계정에서 미국 이외의 나라에 위치한 부서을 조회하시오
    Alias는 부서번호,부서명,주소,나라명
    미국의 국가코드='US'
    
        SELECT C.DEPARTMENT_ID AS 부서번호,
               C.DEPARTMENT_NAME AS 부서명,
               B.STREET_ADDRESS||' '||B.CITY||' '||B.STATE_PROVINCE AS 주소,
               A.COUNTRY_NAME AS 나라명
        FROM   COUNTRIES A, LOCATIONS B, DEPARTMENTS C
        WHERE C.LOCATION_ID = B.LOCATION_ID
          AND B.COUNTRY_ID = A.COUNTRY_ID
          AND A.COUNTRY_ID != 'US'
        
        
    (안시 형식)
        SELECT C.DEPARTMENT_ID AS 부서번호,
               C.DEPARTMENT_NAME AS 부서명,
               B.STREET_ADDRESS||' '||B.CITY||' '||B.STATE_PROVINCE AS 주소,
               A.COUNTRY_NAME AS 나라명
        FROM  COUNTRIES A
        INNER JOIN LOCATIONS B ON(B.COUNTRY_ID = A.COUNTRY_ID)
        INNER JOIN DEPARTMENTS C ON(C.LOCATION_ID = B.LOCATION_ID)
        WHERE A.COUNTRY_ID != 'US'
        
    (6-1) HR계정에서 미국 이외의 나라에 위치한 부서에 근무하는 사원들을 조회하시오
    Alias는 부서번호,부서명,주소,나라명
    미국의 국가코드='US'
    
        SELECT C.DEPARTMENT_ID AS 부서번호,
               C.DEPARTMENT_NAME AS 부서명,
               D.EMP_NAME AS 사원명,
               B.STREET_ADDRESS||' '||B.CITY||' '||B.STATE_PROVINCE AS 주소,
               A.COUNTRY_NAME AS 나라명
        FROM   COUNTRIES A, LOCATIONS B, DEPARTMENTS C, EMPLOYEES D
        WHERE C.LOCATION_ID = B.LOCATION_ID
          AND B.COUNTRY_ID = A.COUNTRY_ID
          AND C.DEPARTMENT_ID = D.DEPARTMENT_ID
          AND A.COUNTRY_ID != 'US'
          
    (안시형식)
        SELECT C.DEPARTMENT_ID AS 부서번호,
               C.DEPARTMENT_NAME AS 부서명,
               D.EMP_NAME AS 사원명,
               B.STREET_ADDRESS||' '||B.CITY||' '||B.STATE_PROVINCE AS 주소,
               A.COUNTRY_NAME AS 나라명
        FROM   COUNTRIES A
        INNER JOIN LOCATIONS B ON (B.COUNTRY_ID = A.COUNTRY_ID)
        INNER JOIN DEPARTMENTS C ON (C.LOCATION_ID = B.LOCATION_ID)
        INNER JOIN EMPLOYEES D ON (C.DEPARTMENT_ID = D.DEPARTMENT_ID)
        WHERE A.COUNTRY_ID != 'US'

    (7) 2020년 거래처별 매출액집계를 조회하시오
        
        SELECT A.BUYER_NAME AS 거래처명,
               A.BUYER_ID AS 거래처코드,
               SUM(B.PROD_PRICE * C.CART_QTY) AS 매출액
        FROM BUYER A, PROD B, CART C
        WHERE A.BUYER_ID = B.PROD_BUYER
        AND B.PROD_ID = C.CART_PROD
        AND SUBSTR(C.CART_NO, 1, 4) ='2020'
        GROUP BY A.BUYER_NAME, A.BUYER_ID
        
    (안시형식)
    
        SELECT A.BUYER_ID AS 거래처코드,
               A.BUYER_NAME AS 거래처명,
               SUM(B.PROD_PRICE * C.CART_QTY) AS 매출액
        FROM BUYER A
        INNER JOIN PROD B ON (A.BUYER_ID = B.PROD_BUYER)
        INNER JOIN CART C ON (B.PROD_ID = C.CART_PROD)
        WHERE C.CART_NO LIKE '2020%'
        GROUP BY A.BUYER_NAME, A.BUYER_ID


    (8) 2020년 상품별 매입/매출집계를 조회하시오. 
    