2024-0626-02)PL/SQL(Procedural Language SQL)
    - block 구조로 구성된 모듈로 컴파일되어 제공
    - 애플리케이션들에 공유될 수 있음
    - 절차형 언어의 특징(반복문,분기문,함수,변수 등)을 사용
    - 에러처리가 가능
    - 내부 네트워크의 통신량을 줄여 실행 효율성이 높음
    - 익명 블록, stored procedure, User Defined Function, Trigger, Package 등 제공
    
    (기본구조)
    
    DECLARE
        선언부 => 변수, 상수, 커서선언
    BEGIN
        실행부 => 결과를 반환할 수 있는 비지니스 로직 구현에 필요한 SQL 및 명령문
          :
        [예외처리]
          :   => EXCEPTION WHEN ~
    END;
    
    사용예)
    DECLARE
        L_NAME LPROD.LPROD_NM%TYPE;
    BEGIN
        SELECT LPOD_NM INTO L_NAME
        FROM LPROD
        WHERE LPORD_GU='P102';
        
        DBMS_OUTPUT.PUT_LINE ('분류명: '||L_NAME);
        DBMS_OUTPUT.PUT_LINE ('자료명: '||SQL%ROWCOUNT);
    END;
    
    1. 변수
        - 일반 애플리케이션의 변수의 개념과 동일
        - 변수의 종류 : CALAR변수 ,REFERENCE 변수, BIND 변수 ,  COMPOSITE 변수
        - 선언방법
            변수명 데이터 타입|테이블명.컬럼명%TYPE | 테이블명%ROWTYPE [:=초기값]
            
    2. 분기문과 반복문
        1) if문
            - 애플리케이션 언어의 if와 같은 기능
            (사용형식 1)
            IF 조건 THEN
            [ELSE
               명령2;]
            END IF;
            
            (사용형식 2)
            IF 조건1 THEN
               명령1;
            ELSIF 조건2 THEN
               명령2;
                :
            [ELSE
               명령 n;]
            END IF;
            
            (사용형식 3)
            IF 조건1 THEN
              IF 조건2 THEN
                   명령1;
              ELSE
                   명령2;
              END IF;
                   :
              [ELSE
                명령n;]
               END IF;
                   
        2) CASE WHEN ~ THEN 문
            - 다중 분기문
            (사용형식-1)
            CASE WHEN 조건1 THEN 명령1;
                 WHEN 조건2 THEN 명령2;
                     :
                 [ELSE 명령n;]
            END CASE;
            
            (사용형식-2)
            CASE 조건 WHEN 값1 THEN 명령1;
                      WHEN 값2 THEN 명령2;
                     :
                 [ELSE 명령n;]
            END CASE;
            
        사용예) 점수(1-100점)를 변수에 저장하고 그 점수의 값이
               100-90 : A,
               89-80 : B,
               79-70 : C,
               69-60 : D
               그이하 : F를 출력하시오
        
        DECLARE
            L_SCORE NUMBER:=85;
            L_RES VARCHAR2 (200);
        BEGIN
            IF L_SCORE >=90 THEN
               L_RES:=TO_CHAR(L_SCORE)||'점은 A학점 입니다';
            ELSIF L_SCORE >=80 THEN
               L_RES:=TO_CHAR(L_SCORE)||'점은 B학점 입니다';
            ELSIF L_SCORE >=70 THEN
               L_RES:=TO_CHAR(L_SCORE)||'점은 C학점 입니다';
            ELSIF L_SCORE >=60 THEN
               L_RES:=TO_CHAR(L_SCORE)||'점은 D학점 입니다';
            ELSE
               L_RES:=TO_CHAR(L_SCORE)||'점은 F학점 입니다';
        END IF;
        
        DBMS_OUTPUT.PUT_LINE(L_RES);
        END;
        
        DECLARE
            L_SCORE NUMBER:=85;
            L_RES VARCHAR2 (200);
        BEGIN
            CASE TRUNC(L_SCORE/10)
                WHEN 10 THEN
                L_RES:=TO_CHAR(L_SCORE)||'점은 A학점 입니다';
                WHEN 9 THEN
                L_RES:=TO_CHAR(L_SCORE)||'점은 A학점 입니다';
                WHEN 8 THEN
                L_RES:=TO_CHAR(L_SCORE)||'점은 B학점 입니다';
                WHEN 7 THEN
                L_RES:=TO_CHAR(L_SCORE)||'점은 C학점 입니다';
                WHEN 6 THEN
                L_RES:=TO_CHAR(L_SCORE)||'점은 D학점 입니다';
                ELSE
                L_RES:=TO_CHAR(L_SCORE)||'점은 D학점 입니다';
        END CASE;
        
        DBMS_OUTPUT.PUT_LINE(L_RES);
        END;
        
        
        사용예) 수도 사용량을 톤(TON)단위로 입력받아 수도요금을 계산하시오
               수도요금 = 상수도요금 + 하수도요금
               상수도요금 = 사용량 + 단가
               사용량         단가 
               ---------------------------------
                1-10         350
                10-19        450
                20-29        750
                30-39       1200
                그이상       1800
            하수도 요금 = 사용량 * 450
               
        사용예) 
        
            
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             