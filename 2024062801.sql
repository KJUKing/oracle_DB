2024-0628-01) Stored Procedure
    - 저장 프로시저를 처음 수행될 때 문법을 검사하고 컴파일이 된다.
    - 컴파일된 버전은 프로시져 캐시에 저장되므로 이후에 호출될 때 빠르게 수행될 수 있다.
    - 클라이언트간 처리 루틴 공유
      모든 응용 프로그램에서 사용할 수 있도록 기능을 캡슐화 하므로 일관성 있는 데이터 변경을 보장한다.
    - 데이터베이스 내부 구조 보안 : view와 동일한 개념
    - 서버 보호, 자료 무결성(integrity)권한 구현
    - query처리 속도 향상
    - Network Traffic 감소
    
    (사용형식)
    CREATE [OR REPLACE] PROCEDURE 프로시저명[(
    변수명 [IN|OUT|INOUT] 데이터 타입 [:=default 값][,]
                    :
    변수명 [IN|OUT|INOUT] 데이터 타입 [:=default 값])]
    IS|AS
        선언블록
    BEGIN
        실행블록
        [EXCEPTION
            예외처리]
    END;
    . OR REPLACE :이미 존재하는 프로시저이면 OVERWRITE
    . 변수명 [IN|OUT|INOUT] : 변수의 MODE 설정
        - IN : 기본 변수 모드 타입(생략시 IN으로 간주) : 입력용 설정
        - OUT : 변수가 출력용 설정
        - INOUT : 입출력 공용으로 사용될 수 있음을 설정
    . '데이터 타입' : 크기를 지정할 수 없음
    . :=default 값 : 매개변수 설정 후 값을 배정하지 않은 경우 자동 설정되는 값
    (실행문 사용형식)
        - 독립실행(다른 블록안에서 실행하지 않는 경우)
            EXCUTE|EXEC 프로시저명[(매개변수list)];
        
        - 다른 블록안에서 실행하는 경우
          프로시저명[(매개변수list)];
    사용예)오늘 날짜에 매입현황이 다음과 같다. 이를 처리하시오
            ------------------------------
                매입상품번호      매입수량
            ------------------------------
               p201000005          10
               p202000010           5
               p302000016          20
               p102000005           5
            ------------------------------
            
    CREATE OR REPLACE PROCEDURE PROC_BUYPROD(
        P_PID IN PROD.PROD_ID%TYPE,
        P_QTY IN NUMBER)
    IS
    
    BEGIN
        INSERT INTO BUYPROD(BUY_DATE, BUY_PROD, BUY_QTY)
            VALUES (SYSDATE, P_PID, P_QTY);
            
        UPDATE REMAIN
        SET REMAIN_I = REMAIN_I+P_QTY,
            REMAIN_J_99 = REMAIN_J_99+P_QTY,
            REMAIN_DATE = SYSDATE
        WHERE PROD_ID = P_PID;
        
        COMMIT;
    END;
    
    [실행]
    EXECUTE PROC_BUYPROD('P201000005', 10);
    
    
    오류 메시지에 따르면 BUYPROD 테이블의 BUY_COST 열이 NOT NULL 제약 조건을 가지고 있으며,
    이 열에 NULL 값을 삽입하려고 했기 때문에 오류가 발생한 것입니다. BUY_COST 열에 값을 제공해야 합니다.

    해결 방법은 다음과 같습니다:

    BUYPROD 테이블의 BUY_COST 열에 유효한 값을 삽입합니다.
    PROCEDURE의 INSERT 문을 수정하여 BUY_COST 열에 값을 제공합니다.
    
    BUYPROD 테이블의 BUY_COST 컬럼이 NOT NULL 제약 조건을 가지고 있기 때문에, 이 컬럼에 값을 삽입해야 합니다.
    만약 BUY_COST 컬럼이 NOT NULL 제약 조건을 가지고 있고, 이를 무시할 수 없다면,
    이 컬럼에 기본값을 제공해야 합니다.

    하지만 만약 BUY_COST 컬럼이 필요 없다면, 해당 컬럼의 NOT NULL 제약 조건을 제거하거나,
    프로시저에서 BUY_COST 값을 제공해야 합니다.
    
    --------------------------------------------------------------------------------
    
    사용예) 회원번호를 입력 받아 해당 회원이 2020년 구매한 구매금액을 조회하시오
    
    CREATE OR REPLACE PROCEDURE PROC_SUM_BUY(
        P_MID IN MEMBER.MEM_ID%TYPE,
        P_AMT OUT NUMBER)
    IS
        L_AMT NUMBER :=0;
    BEGIN
        SELECT SUM(A.CART_QTY * B.PROD_PRICE) INTO L_AMT
        FROM CART A, PROD B
        WHERE A.CART_PROD = B.PROD_ID
            AND A.CART_NO LIKE '2020%'
            AND A.CART_MEMBER=P_MID;
        P_AMT := L_AMT;
    END;
    
    DECLARE
        L_SUM NUMBER := 0;
    BEGIN
        PROC_SUM_BUY('c001', L_SUM);
        DBMS_OUTPUT.PUT_LINE('c001회원의 구매금액 : '||L_SUM);
    END;
    
    
    
    사용예)키보드로 부서번호를 입력받아 해당부서에 근무하는 사원정보(사원번호, 사원명, 입사일,
          직무번호)를 출력하는 프로시저를 작성하시오.
          
    (실행)
    ACCEPT P_DEPT PROMPT '부서번호 : '
    DECLARE
    BEGIN
        PROC_EMP02(TO_NUMBER('&P_DEPT'));
    END;
    
    --(프로시저)
    CREATE OR REPLACE PROCEDURE PROC_EMP02(
        P_DID IN NUMBER)
    IS
        EID HR.EMPLOYEES.EMPLOYEE_ID%TYPE;
        ENAME HR.EMPLOYEES.EMP_NAME%TYPE;
        L_DATE DATE;
        L_JOB HR.EMPLOYEES.JOB_ID%TYPE;
        CURSOR CUR_EMP02(DID NUMBER) IS
            SELECT EMPLOYEE_ID, EMP_NAME, HIRE_DATE, JOB_ID
            FROM HR.EMPLOYEES
            WHERE DEPARTMENT_ID = DID;
    BEGIN
        OPEN CUR_EMP02(P_DID);
            LOOP
                FETCH CUR_EMP02 INTO EID, ENAME, L_DATE, L_JOB;
                EXIT WHEN CUR_EMP02%NOTFOUND;
                DBMS_OUTPUT.PUT(EID||'  '||RPAD(ENAME,16)||'  '||L_DATE||'  '||L_JOB);
                DBMS_OUTPUT.PUT_LINE('----------------------------------------');
            END LOOP;
        CLOSE CUR_EMP02;
    END;
       
    --(FOR문)
    CREATE OR REPLACE PROCEDURE PROC_EMP02(
        P_DID IN HR.DEPARTMENTS.DEPARTMENT_ID%TYPE)
    IS
        CURSOR CUR_EMP02(DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE) IS
            SELECT EMPLOYEE_ID, EMP_NAME, HIRE_DATE, JOB_ID
            FROM HR.EMPLOYEES
            WHERE DEPARTMENT_ID = DID;
    BEGIN
        FOR REC IN CUR_EMP02(P_DID) LOOP
        DBMS_OUTPUT.PUT(REC.EMPLOYEE_ID||'  '||RPAD(REC.EMP_NAME,16)||'  '||
                        REC.HIRE_DATE||'  '||REC.JOB_ID);
        DBMS_OUTPUT.PUT_LINE('----------------------------------------');
        END LOOP;
    END;
    
    
----------------------------------------------------------------------


(실행)
 ACCEPT P_DEPT  PROMPT '부서번호 : '
 DECLARE
 BEGIN
   PROC_EMP02(TO_NUMBER('&P_DEPT'));
 END;
     
(PROCEDURE)
 CREATE OR REPLACE PROCEDURE PROC_EMP02(
   P_DID IN NUMBER)
 IS
   EID HR.EMPLOYEES.EMPLOYEE_ID%TYPE;
   ENAME HR.EMPLOYEES.EMP_NAME%TYPE;
   L_DATE DATE;
   L_JOB HR.EMPLOYEES.JOB_ID%TYPE;
   CURSOR CUR_EMP02(DID NUMBER) IS
     SELECT EMPLOYEE_ID, EMP_NAME, HIRE_DATE, JOB_ID
       FROM HR.EMPLOYEES
      WHERE DEPARTMENT_ID=DID; 
 BEGIN
   OPEN CUR_EMP02(P_DID);
   LOOP
     FETCH CUR_EMP02 INTO EID,ENAME,L_DATE,L_JOB;
     EXIT WHEN CUR_EMP02%NOTFOUND;
     DBMS_OUTPUT.PUT_LINE(EID||'  '||RPAD(ENAME,30)||'  '||L_DATE||'  '||
                          L_JOB);
     DBMS_OUTPUT.PUT_LINE('-------------------------------------');
   END LOOP;
   CLOSE  CUR_EMP02;
 END;
 
[FOR문] 
 CREATE OR REPLACE PROCEDURE PROC_EMP02(
   P_DID IN HR.DEPARTMENTS.DEPARTMENT_ID%TYPE)
 IS
   CURSOR CUR_EMP02(DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE) IS
     SELECT EMPLOYEE_ID, EMP_NAME, HIRE_DATE, JOB_ID
       FROM HR.EMPLOYEES
      WHERE DEPARTMENT_ID=DID; 
 BEGIN
   FOR REC IN CUR_EMP02(P_DID) LOOP
     DBMS_OUTPUT.PUT_LINE(REC.EMPLOYEE_ID||'  '||RPAD(REC.EMP_NAME,16)||'  '||
                          REC.HIRE_DATE||'  '||REC.JOB_ID);
     DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------');
   END LOOP;
 END; 