2024-0614-01)숫자함수
    - 수학적 함수 (ABS, SIGN, POWER, SQRT)
    - GREATEST(n1, n2, ...), LEAST(n1, n2, ...) --greatest 하나의 행에서 가장 큰값
                                                --max 여러 열중에서 가장 큰 값
    - ROUND(n1, n2), TRUNC(n1, n2)              --round 반올림/ trunc 절삭(내림)
    - FLOOR(n), CEIL(n)                         --가까운 정수값 / 작은쪽으로 가까운 정수값 / 큰쪽으로 가까운 정수값
    - MOD(n1, n2)                               --
    
    1) 수학적 함수 (ABS, SIGN, POWER, SQRT)
        . ABS(n) : n의 절대값
        . SIGN(n) : n의 부호에 따라 음수이면 크기에 관계없이 -1, 양수이면 크기에 관계없이 1,
                    0이면 0을 반환
        . POWER(n1, n2) : n1의 n2승 값(n1을 n2번 거듭 곱한 값)
        . SQRT(n) : n 의 평방근 값
        
    사용예)
        SELECT ABS(10), ABS(-0.05),
               SIGN(-10000), SIGN(0), SIGN(0.0001),
               POWER(2,10), SQRT(3.14)
            FROM DUAL;
            
    2) GREATSET(n1, n2,...), LEAST(n1, n2, ...) - **
        . GREATEST : 주어진 값 중 가장 큰 값을 반환하며, 자료가 문자열인 경우 ASCII 값을 변환하여 비교
        . LEAST :  주어진 값 중 가장 작은 값을 반환하며, 자료가 문자열인 경우 ASCII 값을 변환하여 비교
    
    사용예)
      (1) SELECT GREATEST(256, 30, 90),
                 GREATEST('홍길동', '홍길순', '홍길상')
          FROM DUAL;
        
      (2) 회원테이블에서 회원들의 마일리지 중 2000 미만의 마일리지를 보유한 회원의 마일리지를 
          2000으로 바꾸어 출력하시오
          Alias는 회원번호, 회원명, 원본 마일리지, 변경마일리지
          
          
          SELECT MEM_ID AS 회원번호,
                 MEM_NAME AS 회원명,
                 MEM_MILEAGE AS 원본마일리지,
                 GREATEST(MEM_MILEAGE, 2000) AS 변경마일리지 -- 첫번째 값이 바꿀값 두번째값이 변경값
          FROM MEMBER;
          
      (3) ROUND(n1 [, n2]), TRUNC(n1 [, n2])
        - 주어진 자료 n1을 n2+1자리에서 반올림(ROUND) 또는 절삭(TRUNC)하여 반환
            (만약 2345678.4567 일때 round(su, 2)이라하자
                = 그러면 2345678.46이된다)
        - n2가 생략되면 0으로 간주 (소숫점을 없애고 정수로만 표현됨)
        - n2가 음수이면 데이터의 양수부분에서 n2번째자리에서 반올림 또는 절삭
            (만약 2345678.4567 일때 round(su, -3)이라하자.
                = 그렇다면 23456에서 반올림일 일어나서 2346이 된다.)
        
    사용예)
      (1) 사원테이블에 저장된 급여는 연봉을 표현한 값이다. 각 사원들의
          월 급여를 출력하시오 단, 소숫점 2자리에서 반올림하여 표현
          Alias는 사원번호, 사원명, 연봉(salary), 월 급여
          
          SELECT  EMPLOYEE_ID AS 사원번호,
                  EMP_NAME AS 사원명,
                  SALARY AS 연봉,
                  TRUNC(SALARY/12, 1) AS "월 급여",
                  ROUND(SALARY/12, 1) AS "월 급여"
            FROM  HR.EMPLOYEES;
          
      (2) 상품테이블에서 분류코드 'P100'~'P199'에 속한 제품의 부가가치세액을 계산하려한다.
          원단위에서 절삭된 부가세액을 계산하여 출력하시오.
          Alias는 상품코드, 상품명, 매입가격, 매출가격
          단, 부가세액=(매출가격-매입가격)*7%
          SELECT PROD_ID AS 상품코드, 
                 PROD_NAME AS 상품명,
                 PROD_COST AS 매입가격,
                 PROD_PRICE AS 매출가격,
                 TRUNC((PROD_PRICE - PROD_COST) * 0.07) AS 부가가치세액
          FROM PROD
          WHERE PROD_LGU BETWEEN 'P100' AND 'P199'
        
                 
    4) FLOOR(n), CEIL(n)
      - FLOOR : n과 같거나(n이 정수인 경우) 작은쪽에서 제일 큰 정수
      - CEIL : n과 같거나(n이 정수인 경우) 큰쪽에서 제일 작은 정수
      - 금액에 관련된 경우 자주 사용됨
      
    사용예)
      (1) SELECT FLOOR(12.456), FLOOR(12), FLOOR(-12.567),
                 CEIL(12.456), CEIL(12), CEIL(-12.567)
            FROM DUAL;
    5) MOD(n1, n2)
        -주어진 자료 n1을 n2로 나눈 나머지 변환
        -java의 %연산자의 기능
    사용예)
    
      (1) 150초(SECOND)를 분과 초로 나타내시오
          SELECT TRUNC(150/60) ||'분 ' ||MOD(150, 60)||'초'
          FROM DUAL;
      
      (2) 키보드로 점수를 입력받아 그 값이
        90 -93 : A-
        94 -96 : A0,
        97 - 100 : A+
        80 - 83 : B-
        84 - 86 : B0,
        87 - 100 : B+
        79이하면 F를 출력
        
         ACCEPT P_SCORE  PROMPT '점수입력 : '
  DECLARE
    L_SCORE NUMBER:=TO_NUMBER('&P_SCORE');
    L_RES VARCHAR2(100);
  BEGIN
    IF TRUNC(L_SCORE/10)=10 THEN L_RES:=L_SCORE||'는 A+학점입니다.';
    ELSIF TRUNC(L_SCORE/10)=9 THEN 
          L_RES:='A';
          CASE WHEN MOD(L_SCORE,10) IN(0,1,2,3) THEN
                    L_RES:=L_SCORE||'는 '||(L_RES||'-')||'학점입니다';
               WHEN MOD(L_SCORE,10) IN(4,5,6) THEN
                    L_RES:=L_SCORE||'는 '||(L_RES||'0')||'학점입니다';
               ELSE 
                    L_RES:=L_SCORE||'는 '||(L_RES||'+')||'학점입니다';
          END CASE;
    ELSIF TRUNC(L_SCORE/10)=8 THEN 
          L_RES:='B';
          CASE WHEN MOD(L_SCORE,10) IN(0,1,2,3) THEN
                    L_RES:=L_SCORE||'는 '||(L_RES||'-')||'학점입니다';
               WHEN MOD(L_SCORE,10) IN(4,5,6) THEN
                    L_RES:=L_SCORE||'는 '||(L_RES||'0')||'학점입니다';
               ELSE 
                    L_RES:=L_SCORE||'는 '||(L_RES||'+')||'학점입니다';
          END CASE;
    ELSE
          L_RES:=L_SCORE||'는 F학점입니다';
    END IF;
    DBMS_OUTPUT.PUT_LINE(L_RES);   
                          
  END;