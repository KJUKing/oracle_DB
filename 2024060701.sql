2024-0607-01)날짜데이터 타입
    - DATE, TIMESTAMP 타입 제공
    (사용 형식)
    컬럼명     DATE
    컬럼명     TIMESTAMP
    컬럼명     TIMESTAMP WITH TIME ZONE
    컬럼명     TIMESTAMP WITH LOCAL TIME ZONE
    
    (사용 예)
    CREATE TABLE TBL_DATE(
        COL_DATE DATE,
        COL_TS   TIMESTAMP,
        COL_LTZ  TIMESTAMP WITH LOCAL TIME ZONE,
        COL_TZ   TIMESTAMP WITH TIME ZONE
        );
        
  ** SYSDATE : 시스템에서 제공하는 표준 시각정보(년,월,일,시,분,초)를 반환
     SYSTIMESTAMP : 시스템에서 제공하는 표준 정밀한 시각정보(년,월,일,시,분,초)를 반환
                    (10억분의 1초와 타임존 정보)
  ** 날짜 자료는 덧셈과 뺄셈의 대상이 됨
     덧셈 : 더해지는 정수만큼 다가올 날의 날짜 반환
     뺄셈 : 정의된 정수만큼 지나온 날의 날짜 반환
     날짜자료사이의 뺄셈 : 두 날짜사이의 경과된 일수 반환
     
    INSERT INTO TBL_DATE VALUES (SYSDATE, SYSTIMESTAMP, SYSTIMESTAMP+10,
                                SYSTIMESTAMP-10);
                                
    SELECT * FROM TBL_DATE;
    
  ** DATE타입의 자료를 시분초까지 출력하려면 TO_CHAR함수를 사용
  SELECT TO_CHAR(COL_DATE, 'YYYY-MM-DD HH24:MI:SS')
    FROM TBL_DATE;

  **키보드로 날짜를 입력 받아 요일을 출력하는 익명 블록을 작성하시오.
  
    ACCEPT P_DATE PROMPT '날짜입력 (YYYYMMDD)'
    DECLARE
        L_DATE DATE := TO_DATE('&P_DATE');
        L_DAYS NUMBER :=0;
        L_RES VARCHAR2(100);
        
    BEGIN
    --년월일은 정수표현이고 시분초는 소수점표현이라서 TRUNCATE사용하면 소수점 삭제할수있다.
        L_DAYS :=TRUNC(L_DATE) - TRUNC(TO_DATE ('00010101')) -1;
            IF MOD(L_DAYS, 7) = 0 THEN
            L_RES:=TO_CHAR(L_DATE, 'YYYY/MM/DD') ||'일의 요일은 일요일입니다.';
            ELSIF MOD(L_DAYS, 7) = 1 THEN
            L_RES:=TO_CHAR(L_DATE, 'YYYY/MM/DD') ||'일의 요일은 월요일입니다.';
            ELSIF MOD(L_DAYS, 7) = 2 THEN 
            L_RES:=TO_CHAR(L_DATE, 'YYYY/MM/DD') ||'일의 요일은 화요일입니다.';
            ELSIF MOD(L_DAYS, 7) = 3 THEN 
            L_RES:=TO_CHAR(L_DATE, 'YYYY/MM/DD') ||'일의 요일은 수요일입니다.';
            ELSIF MOD(L_DAYS, 7) = 4 THEN 
            L_RES:=TO_CHAR(L_DATE, 'YYYY/MM/DD') ||'일의 요일은 목요일입니다.';
            ELSIF MOD(L_DAYS, 7) = 5 THEN 
            L_RES:=TO_CHAR(L_DATE, 'YYYY/MM/DD') ||'일의 요일은 금요일입니다.';
            ELSE
            L_RES:=TO_CHAR(L_DATE, 'YYYY/MM/DD') ||'일의 요일은 토요일입니다.';
            END IF;
            
        DBMS_OUTPUT.PUT_LINE(L_RES);
            
    
    END;
    