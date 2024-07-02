2024-0611-03)
4. 기타연산자
    - IN,ANY,SOME,LIKE,BETWEEN,EXISTS 등의 연산자 제공
  1) IN 연산자      -- 규칙적이지않고 반복적이지않을때 사용하기 유용
   . 주어진 값 중 어느 하나와 일치하면 결과가 참을 반환
   . IN 연산자 내부에 '='기능이 포함되어 있음  -- IN연산자와 관계연산자는 같이 사용 할 수 없음
   (사용형식)
    expr    IN (값1, 값2, ....,값n)    --컬럼명 IN (값1,값2, 불규칙적이고 불연속적인 원하는값)을 하면 한번에나옴
    . expr의 값이 '값1'~ '값n' 중 어느 하나와 일치하면 결과가 참
    . OR 연산자로 바꾸어 사용 가능함
    . =ANY, =SOME으로 바꾸어 사용 할 수 있음   -- =ANI, =SOME은 IN연산자와 같다
    . 불특정, 불연속적인 값을 비교할 때 사용  -- 불연속, 불규칙적일때 IN연산자
 
사용예)
    (1) 사원테이블에서 20, 50, 90번 부서에 속한 사원을 조회하시오.
    ALIAS는 사원번호, 사원명, 부서번호, 입사일
    
    SELECT EMPLOYEE_ID AS 사원번호, 
           EMP_NAME AS 사원명,
           DEPARTMENT_ID AS 부서번호,
           HIRE_DATE AS 입사일
    
    FROM HR.EMPLOYEES
    WHERE DEPARTMENT_ID IN (20,50,90)
    ORDER BY 3;
    
    
    (2) 상품테이블에서 분류코드가 'P201','P302','P101'에 속한 상품들을 조회하시오.
    ALIAS는 상품코드, 상품명, 분류코드, 판매가격
    SELECT PROD_ID AS 상품코드,
           PROD_NAME AS 상품명,
           PROD_LGU AS 분류코드,
           PROD_PRICE AS 판매가격
    
    FROM PROD
    WHERE PROD_LGU IN ('P201','P302','P101');
    
    (3) 회원테이블에서 회원의 성씨가 '이', '박'인 회원을 조회하시오
    ALIAS는 회원번호,회원명,마일리지
    SELECT MEM_ID AS 회원번호,
           MEM_NAME AS 회원명,
           MEM_MILEAGE AS 마일리지
    
    FROM MEMBER
    WHERE SUBSTR(MEM_NAME,1,1) IN ('이','박');   -- SUBSTR(컬럼명,몇번째자리에서부터,몇자리수를가져온다)

  2) ANI, SOME 연산자
    . 제시된 데이터 중에 사용된 관계연산자를 만족하는 값이하나라도 있으면 참의 결과를 반환함
    . ANI와 SOME은 동일기능
    (사용형식)
    expr 관계연산자ANY|SOME(값1, 값2,..., 값n)   -- 모든값중 하나라도 만족하면 실행
    . 사용된 관계연산자가 '='일때 IN연산자가 됨
 사용예)
    (1)회원테이블에서 직업이 회사원인 회원 중 가장 작은 마일리지보다 더 많은 마일리지를 보유한
       회원들을 조회하시오.
    SELECT MEM_MILEAGE
    FROM MEMBER
    WHERE MEM_JOB='회사원';
    
    [ANY 연산자 사용]
    [SUBQUERY 사용]
    SELECT MEM_ID AS 회원번호,
           MEM_NAME AS 회원명,
           MEM_JOB AS 직업,
           MEM_MILEAGE AS 마일리지
    FROM MEMBER                          -- SUBQUERY를 사용하면 ANY( )안에 값부터 먼저 계산이되고나서 계산식 시작 JAVA FOR문과같은형식
    WHERE MEM_MILEAGE > ANY(SELECT MEM_MILEAGE    -- 실행되면 MEMBER 테이블에 첫번째 사람값부터 비교
                            FROM MEMBER             -- 첫번째 조건이 거짓이되면 그사람꺼는 출력없이 두번째사람으로 넘어가서
                            WHERE MEM_JOB='회사원');  -- 참인 결과가 있을때만 SELECT 조건에 있는 것들을 찍어냄
  
  3) ALL 연산자
    . 제시된 데이터 중에 사용된 관계연산자를 만족하는 값이하나라도 있으면 참의 결과를 반환함
    . 관계연산자 중 '='을 사용할 수 없음 -- 존재할 수 없음 값이 다 다른데 다같을수가없다
    (사용형식)
    expr 관계연산자ALL(값1, 값2,..., 값n)   모든 값을 다 만족시켜야함
    (1)회원테이블에서 직업이 회사원인 회원 중 가장 큰 마일리지보다 더 많은 마일리지를 보유한
       회원들을 조회하시오.
     SELECT MEM_ID AS 회원번호,
            MEM_NAME AS 회원명,
            MEM_JOB AS 직업,
            MEM_MILEAGE AS 마일리지
     FROM MEMBER
     WHERE MEM_MILEAGE > ALL(SELECT MEM_MILEAGE
                             FROM MEMBER
                            WHERE MEM_JOB='회사원');
                            
  4) LIKE 연산자  -- 다른자료들이랑 같이 사용하게 되면 힘들어짐 / 되도록 알고만있고 사용은X
    . 문자열 패턴을 비교할 때 사용되는 연산자
    . 와일드 카드(매칭 문자열)로 '%'와 '_'가 사용됨
    . '%'
      - '%'이 사용된 위치 이후의 모든 문자열과 대응
      - ex)
        . '김%' : 김으로 시작되는 모든 문자열과 대응  -- % = NULL값 % 없어도 인식
        . '%김' : '김'으로 끝나는 모든 문자열과 대응
        . '%김%' : 문자열 중 '김'이 존재하는 모든 문자열과 대응
    . '_'
      - '_'이 사용된 위치에서 한글자와 대응
      - ex)
        . '김_' : '김'으로 시작되고 2글자인 문자열과 대응
        . '_김' : '김'으로 끝나는 2글자의 문자열과 대응
        . '_김_' : 중간에 '김'이 존재하는 3글자의 문자열과 대응
    . LIKE는 문자열 연산자임(숫자, 날짜 데이터에는 사용 자제 할 것) -- 문자열에만 사용
    . LIKE는 많은 결과를 반환하므로 효율성이 많이 떨어짐 
    
 사용예)
    (1) 회원테이블에서 대전이외의 도시에 거주하는 회원정보를 조회하시오
    ALIAS는 회원번호, 회원명, 주소
    SELECT MEM_ID AS 회원번호,
           MEM_NAME AS 회원명,
           MEM_ADD1||' '||MEM_ADD2 AS 주소
    
    FROM MEMBER
    WHERE NOT MEM_ADD1 LIKE '대전%';     -- 대전이 아닌 것을 고를때
    (2) 장바구니 테이블(CART)에서 2020년 6월에 발생한 판매정보를 조회하시오.
    ALIAS는 회원번호, 상품번호, 판매수량
    SELECT CART_MEMBER AS 회원번호,
           CART_PROD AS 상품번호,
           CART_QTY AS 판매수량
    
    FROM CART
    WHERE CART_NO LIKE '202006%'
    ORDER BY CART_NO; 
    
    (3) 회원테이블에서 여성회원들을 조회하시오
    ALIAS는 회원번호, 회원명, 주민번호
    SELECT MEM_ID AS 회원번호,
           MEM_NAME AS 회원명,
           MEM_REGNO1||'+'||MEM_REGNO2 AS 주민번호
    
    FROM MEMBER
    WHERE SUBSTR(MEM_REGNO2,1,1) IN ('2','4');
    
    (4) 매입테이블에서 2020년 1월 매입정보를 조회하시오.
    ALIAS는 날짜,상품번호,매입수량,매입금액
    SELECT BUY_DATE AS 날짜,
           BUY_PROD AS 상품번호,
           BUY_QTY AS 매입수량,
           BUY_QTY*BUY_COST AS 매입금액 -- 매입수량*매입금액=총 매입금액
    
    FROM BUYPROD                         --TO_DATE로 바꿔라 TO_ 타입바꾸기 *참고용
    WHERE BUY_DATE>= '20200101' AND BUY_DATE<='20200131' -- 날짜는 LIKE쓰지말아라(DATE는 날짜타입이라 LIKE쓰지말아라)
    ORDER BY 1;
    
 5) BETWEEN 연산자
    . 범위를 지정할 때 사용
    . AND 연산자로 대처 가능
    . 모든 타입에 사용 가능함
    . LIKE 연산자와 같이 사용할 수 없음

 사용예)
    (1) 회원테이블에서 보유 마일리지가 2000~4000이고 직업이 '자영업'인 회원을 조회하시오
    ALIAS는 회원번호,회원명,직업,마일리지
    SELECT MEM_ID AS 회원번호,
           MEM_NAME AS 회원명,
           MEM_JOB AS 직업,
           MEM_MILEAGE AS 마일리지
           
    FROM MEMBER
    -- WHERE MEM_MILEAGE>=2000 AND MEM_MILEAGE <=4000 AND MEM_JOB='자영업';
    WHERE MEM_MILEAGE BETWEEN 2000 AND 4000    -- BETWEEN 사용법
        AND MEM_JOB='자영업'
        
    (2) 2020년 2월 매입자료를 조회하시오
    ALIAS는 날짜, 매입금액
    SELECT BUY_DATE AS 날짜,
           BUY_QTY*BUY_COST AS 매입금액
    
    FROM BUYPROD
    WHERE BUY_DATE BETWEEN TO_DATE('20200201') AND 
          LAST_DAY(TO_DATE('20200201')); -- 날짜의 데이터를 반환 (윤년이면 31 평년이면30일 계산해줌)
                                         -- 윤년일수있다도 생각;;;   