2024-0611-02)연산자
1. 산술연산자
    - 사칙연산자 제공 : +, -, *, /(나머지 연산자는 제공되지 않음-함수로 제공)
사용예)HR계정 사원테이블에서 영업실적에 따른 보너스를 계산하고 지급액을 조회하는 쿼리를 작성하시오.
    지급액이 낮은 순으로 정렬하시오. -- ORDER BY 컬럼명 ; 하면 자동 비우면 오름차순이 기본값
    -- 조건이 따로 없어서 WHERE 없어도됨
    ALIAS는 사원번호(EMPLOYEE_ID),사원명(EMP_NAME),본봉(SALARY),보너스,지급액
    -- ALIAS가 나오면 이5가지 출력한다는것
    보너스(BONUS)=본봉*영업실적코드(COMMISSION_PCT)
    지급액(SAL_AMT)=본봉+보너스
    
    SELECT EMPLOYEE_ID AS 사원번호,
           EMP_NAME AS 사원명,
           SALARY AS "본 봉",   --" " 를 이용하면 오류없이 띄어쓰기 가능
           NVL(SALARY * COMMISSION_PCT,0) AS "보 너 스",           --NVL(    ,0) NULL이 있으면 0으로 대입해라 라는뜻 안하면
           SALARY + (NVL(SALARY * COMMISSION_PCT,0)) AS "지 급 액" --NULL이 나오게되면 결과값이 NULL이 나와서 결과값에 문제가 생긴다
    
        FROM HR.EMPLOYEES
        ORDER BY 5;
        
2. 관계연산자
    - 데이터의 크기를 비교
    - 결과는 TRUE, FALSE 중 하나
    - 보통 조건식 구성에 사용     --WHERE절 , SELET절 HAVING 절
    - >, <, =, <=, >=, !=(<>)
사용예)
    1)상품테이블에서 판매가가 50만원 이상인 제품을 조회하시오
    단, 판매가가 큰 상품부터 출력
    AIIAS는 상품코드, 상품명, 판매가격
    SELECT PROD_ID AS 상품코드,
           PROD_NAME AS 상품명,
           PROD_PRICE AS 판매가격
        FROM PROD
        WHERE PROD_PRICE >= 500000
        ORDER BY 3 DESC;
    
    
    2)회원테이블에서 20대회원만 조회하시오
    단, 나이가 많은 회원부터 출력하시오
    ALIAS는 회원번호, 회원명, 주민번호, 나이
    SELECT MEM_ID AS 회원번호,
           MEM_NAME AS 회원명,
           MEM_REGNO1||'-'||MEM_REGNO2 AS 주민번호,  -- 주민번호 표시법으로 '-'으로 가운데를 붙힌다
           EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR) AS 나이         --EXTRACT 추출할때 쓰는 함수
           FROM MEMBER                       --(YEAR 말고도 데이터타입 6개 다 가능함, 추출하고나면 숫자로 추출됨)
           WHERE EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR)>=20 AND
                 EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR)<=29
        -- WHERE TRUNC(EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR))/10)=2 이렇게도 가능함
        -- TRUNC 는 소숫점 이하를 버리라는 함수
           ORDER BY 나이 DESC;    --나이라는 별칭이 인식이되서 ORDER BY 절 앞에 다른 절들이 실행이됬기에 가능
    
    ** HR계정의 사원테이블에서 사원들의 입사일을 16년 후로 변경하시오.
       UPDATE HR.EMPLOYEES
          SET HIRE_DATE=ADD_MONTHS(HIRE_DATE,192);    -- 앞에 MONTHS라서 192개월이 16년치
          COMMIT;
        
    문제]HR계정의 사원테이블에서 근속년수가 5년 이상인 사원정보를 조회하시오.
        단, 근속년수가 많은 사원부터 출력하시오.
        ALIAS는 사원번호,사원명,입사일,근속년수
        SELECT EMPLOYEE_ID AS 사원번호,
               EMP_NAME AS 사원명,
               HIRE_DATE AS 입사일,
               EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM HIRE_DATE) AS 근속년수
        FROM HR.EMPLOYEES
        WHERE EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM HIRE_DATE)>=5 
        ORDER BY 3 ;  -- 이런경우 근속년수를 내림차순으로 하면 근속년수가 같은사람끼리 입사일이 다를수가있어서
                      -- 입사일을 오름차순으로 정렬한다.
                      
3. 논리연산자
    - NOT, AND, OR     --연산 순서 NOT - AND - OR // NOT이 단항연산자 // AND 이항연산자 // OR 이항연산자 라서
    --------------------------
    A       B      AND     OR        -- AND는 곱 / OR는 덧셈
    --------------------------
    0       0       0       0
    0       1       0       1
    1       0       0       1
    1       1       1       1
    
사용예)
    키보드로 년도를 입력받아 윤년과 평년을 구별하시오
    ACCEPT P_YEAR   PTOMPT '년도(XXXX) : '
    DECLARE
        L_YEAR NUMBER := TO_NUMBER('&P_YEAR');
        L_RES VARCHAR2(200);
    BEGIN
        IF (MOD(L_YEAR,4)=0 AND MOD(L_YEAR,100)!=0) OR (MOD(L_YEAR,400)=0) THEN
            L_RES:=L_YEAR||'년은 윤년입니다';
        ELSE
            L_RES:=L_YEAR||'년은 평년입니다';
        END IF;
        DBMS_OUTPUT.PUT_LINE(L_RES);
    END;
    -- (4/0=0 AND 100!=0) OR 400/0=0
    