2024-0618-01) 집계함수
    - 데이터 특정 컬럼을 기준으로 분류한 뒤 각 그룹에 적용할 수 있는 함수
    - 복수개의 결과가 반환
    - SUM(co1), AVG(co2), MAX(co1), MIN(co1), COUNT(*|co1)
    (사용형식)
    SELECT 컬럼명1|SUM(co1)|AVG(co2)|MAX(co1)|MIN(co1)|COUNT(*|co1)
    
    FROM 테이블명
    [WHERE 조건]
    GROUP BY 컬럼명1 [,컬럼명2,...]
    [HAVING 조건]
    [ORDER BY 컬럼명|컬럼인덱스 [ASC|DESC],...];
    . SELECT절에 집계함수를 제외한 일반 컬럼이 사용되면 반드시 GROUP BY 절을 사용
      SELECT절에 기술된 일반 컬럼은 모두 GROUP BY절에 기술되어야 함
      SELECT절에 집계함수만 사용된 경우 GROUP BY절 생략
      집계함수에 조건이 부여된 경우 HAVING절로 처리해야함
      COUNT함수는 매개변수로 '*'와 컬럼명을 사용할 수 있다.
      - '*'을 사용하면 NULL로 구성된 행도 카운트되어 반환
      - 컬럼명을 사용하면 컬럼에 NULL이 아닐때만 카운트 함.
      - 외부조인에 COUNT가 사용될때는 기본키로 '컬럼명'에 기술하며,
        나머지 구문에서는 '*'를 사용해도 동일한 결과 반환
    
    사용예)
      (1) 사원테이블에서 전체 사원수를 조회하시오
        SELECT COUNT(*) AS 사원수,
                COUNT(EMPLOYEE_ID) AS 사원수2,
                ROUND(AVG(SALARY),1) AS 평균임금,
                SUM(SALARY) AS 임금합계
            FROM HR.EMPLOYEES;
      (2) 상품테이블에 저장된 상품의 수를 조회하시오
       
        SELECT SUM(PROD_PROPERSTOCK) AS "상품의 수"
        FROM PROD
  
      
      
      (3) 회원테이블에 저장된 회원수를 조회하시오
      
        SELECT COUNT(MEM_ID) AS 회원수
        FROM MEMBER        
      
      (4) 2020년 3월 매입상품의 수를 조회하시오
      
        SELECT COUNT(DISTINCT BUY_PROD) AS 매입상품의수
            FROM BUYPROD
            WHERE BUY_DATE BETWEEN ('20200301') AND ('20200331');
      
      (4-1) 회원테이블에서 회원들의 거주지 종류의 수를 출력하시오
            
        SELECT COUNT(DISTINCT SUBSTR(MEM_ADD1,1,2)) AS 거주지
        FROM MEMBER;
        
      (5) 사원테이블에서 각 부서별 사원수와 평균급여를 조회하시오
      
        SELECT DEPARTMENT_ID AS 부서번호, COUNT(*) AS 사원수 , ROUND(AVG(SALARY),1) AS 평균급여
            FROM EMPLOYEES
            GROUP BY DEPARTMENT_ID
       
        SELECT A.DEPARTMENT_ID AS 부서번호,
               B.DEPARTMENT_NAME AS 부서명, 
               COUNT(*) AS 사원수, 
               ROUND(AVG(SALARY),1) AS 평균급여
            FROM EMPLOYEES A, DEPARTMENTS B
            WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
            GROUP BY A.DEPARTMENT_ID,B.DEPARTMENT_NAME
            ORDER BY 1;
       
            
      (5-1) 상품테이블에 저장된 분류별 상품의 수를 조회하시오
      
        SELECT  PROD_LGU,
                COUNT(*) AS "상품의 수"
            FROM PROD
            GROUP BY PROD_LGU
        
      (6) 2020년 월별 매입수량합계와 매입금액합계를 조회하시오
      
        SELECT EXTRACT(MONTH FROM BUY_DATE)||'월' AS 월 ,
                SUM(BUY_QTY) AS 매입수량합계,
                SUM(BUY_QTY*BUY_COST) AS 매입금액합계
        FROM BUYPROD
        WHERE EXTRACT(YEAR FROM BUY_DATE) = 2020
        GROUP BY EXTRACT(MONTH FROM BUY_DATE)
        ORDER BY 1;
        
      (7) 2020년 월별 회원별 매입수량합계를 구하시오
      
      SELECT SUBSTR(CART_NO,5,2) AS 월,
            CART_MEMBER AS 회원번호,
            SUM(CART_QTY) AS 구매수량합계
        FROM CART
        WHERE SUBSTR (CART_NO,1,4)='2020'
        GROUP BY SUBSTR(CART_NO,5,2),CART_MEMBER
        ORDER BY 1, 3 DESC; -- 1번째는 어센딩 -- 2번째는 디센딩 지정
      
      (8) 2020년 제품별 매입금액을 구하고 금액이 1000만원 이상인 제품만 조회하시오
      
       SELECT EXTRACT(YEAR FROM BUY_DATE) AS 년 ,
                BUY_PROD AS 제품,
                SUM(BUY_QTY*BUY_COST) AS 매입금액합계
        FROM BUYPROD
        WHERE EXTRACT(YEAR FROM BUY_DATE) = 2020
        GROUP BY EXTRACT(YEAR FROM BUY_DATE), BUY_PROD
        HAVING SUM(BUY_COST*BUY_QTY) >= 10000000
        ORDER BY 1;
      
      (9) 사원수가 5명 이상인 부서번호를 조회하시오
      
        SELECT DEPARTMENT_ID 부서번호,
                COUNT(*) AS 사원수
        FROM EMPLOYEES
        GROUP BY DEPARTMENT_ID
        HAVING COUNT(*) > 5
        ORDER BY 2 DESC;
 
        
      
      (10) 회원테이블에서 성별 마일리지 합계와 평균 마일리지를 구하시오
      SELECT
            CASE WHEN SUBSTR(MEM_REGNO2, 1, 1) IN ('1', '3') THEN '남성'
                 WHEN SUBSTR(MEM_REGNO2, 1, 1) IN ('2', '4') THEN '여성'
            END AS 성별,
            SUM(MEM_MILEAGE) AS "마일리지 합계",
            TRUNC(AVG(MEM_MILEAGE)) AS "마일리지 평균"
      FROM MEMBER
      GROUP BY
            CASE WHEN SUBSTR(MEM_REGNO2, 1, 1) IN ('1', '3') THEN '남성'
                 WHEN SUBSTR(MEM_REGNO2, 1, 1) IN ('2', '4') THEN '여성'
            END;

      (11) 회원테이블에서 연령대별 평균마일리지와 회원수를 조회하시오
      
      SELECT
            TRUNC((EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR))/10)*10||'대' AS 연령대,
            ROUND(AVG(MEM_MILEAGE)) AS "평균 마일리지",
            COUNT(MEM_ID) AS 회원수
            
      FROM MEMBER
      GROUP BY TRUNC((EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR))/10)*10
      ORDER BY 1, 2 DESC;
      
      (12) 회원테이블에서 거주지별 회원수를 조회하시오
      SELECT DISTINCT SUBSTR(MEM_ADD1, 1,2) AS 지역,
      COUNT(MEM_ID) AS 회원수
            
      FROM MEMBER
      GROUP BY SUBSTR(MEM_ADD1, 1,2)
      ORDER BY 2;
      