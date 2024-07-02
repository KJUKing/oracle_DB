2024-0701-02)TRIGGER
    - 특정 테이블이 발생된 DML명령(INSERT, UPDATE, DELETE)이 다른 테이블의 특정 기능이
      자동 수행되게 하는 특수목적의 프로시저
    - 한 트리거의 트랜잭션 수행이 완료된 후 다른 트리거가 수행되어야함
    - 트리거의 종류 : 문장단위 트리거/ 행단위 트리거
    
    (사용형식)
    CREATE [OR REPLACE] TRIGGER 트리거이름
        BEFORE|AFTER    UPDATE|INSERT|DELETE ON 테이블 명
        [FOR EACH ROW]
        [WHEN 조건]
    [DECLARE]
    
    BEGIN
        트리거 본문;
    END;
    
        - 'BEFORE|AFTER' : 트리거 본문이 실행될 TIMMING
            . BEFORE : INSERT/UPDATE/DELETE 이벤트가 발생되기 전에 트리거 본문 실행
            . AFTER : INSERT/UPDATE/DELETE 이벤트가 발생된 후에 트리거 본문 실행
        - 'UPDATE|INSERT|DELETE ON 테이블명'
            . '테이블'에 발생될(트리거를 유발시키는 원인) DML명령으로 'OR'연산자를 사용할 수 있다.
            . ex) INSERT OR UPDATE -> INSERT 나 UPDATE 명령이 발생도니 후[전]에 트리거 본문 실행
        - 'FOR EACH ROW' " 행단위 트리거 정의
        - WHEN 조건 : 트리거 발생에 대한 구체적인 조건을 제시
            ex)
            CREATE TRIGGER INSRT_CART
                AFTER INSERT ON CART
                FOR EACH ROW
                WHEN CART_QTY>=10
                
    사용예)
    (1) 상품의 분류테이블에 다음의 자료를 입력시키고 명령 수행 후 '신규 분류코드가 입력되었습니다'라는
            메세지를 출력하시오
    [자료]
     ------------------------------------------------------------
     lprod_id    lprod_gu    lprod_nm
    -----------------------------------------------------------
        10        P501        농산물
        11        P502        수산물
        12        P503        임산물
    ---------------------------------------------------------------
    CREATE OR REPLACE TRIGGER tg_lprod
        AFTER INSERT ON LPROD
    BEGIN
        DBMS_OUTPUT.PUT_LINE('신규 분류코드가 입력되었습니다');
    END;
    
    INSERT INTO LPROD VALUES(10,'P501','농산물');
    INSERT INTO LPROD VALUES(10,'P502','수산물');
    COMMIT;
    INSERT INTO LPROD VALUES(12,'P503','임산물');
    SELECT * FROM LPROD;
    
    (2) 분류테이블의 자료 중 'P501'~'P503'자료를 삭제하시오. 삭제 후
        '분류코드 삭제 성공'을 출력하시오.
        
    CREATE OR REPLACE TRIGGER tg_del_lprod
        AFTER DELETE ON LPROD
    BEGIN
        DBMS_OUTPUT.PUT_LINE('분류코드 삭제 성공');
    END;
    
    DELETE FROM LPROD
    WHERE LPROD_GU LIKE 'P50%';
    COMMIT;
    
    CREATE TABLE EMP AS
        SELECT EMPLOYEE_ID, EMP_NAME, DEPARTMENT_ID, SALARY
        FROM EMPLOYEES;
        
    사용예) EMP테이블의 사원자료 중 사원번호 113, 132, 157번 사원정보를 삭제(퇴직) 처리하려한다
           -> 퇴직테이블에 데이터 이동 +날짜
           
    CREATE OR REPLACE TRIGGER tg_del_emp
        BEFORE DELETE ON EMP
        FOR EACH ROW
    BEGIN
        INSERT INTO RETIRE VALUES(:OLD.EMPLOYEE_ID,:OLD.EMP_NAME,:OLD.DEPARTMENT_ID,SYSDATE);
    END;
    
    DELETE FROM EMP
    WHERE EMPLOYEE_ID = 113;
        
    DELETE FROM EMP
    WHERE EMPLOYEE_ID IN (132, 157);
    
    COMMIT;
    
    ** 트리거 의사레코드(Pseudo record) : 행단위 트리거에서만 사용
    --------------------------------------------------
        의사레코드   내용
    --------------------------------------------------
        :NEW        이벤트가 INSERT, UPDATE일때 사용되며 삽입(갱신)을 위해
                    추가되는 데이터를 행단위로 지칭함. DELETE에 사용 할 때
                    모든값이 NULL임(사용형식은 :NEW.컬럼명)
                    
        :OLD        이벤트가 DELETE, UPDATE일때 사용되며 삭제(갱신)을 위해
                    이미 존재하고 있는 데이터를 행단위로 지칭함. INSERT에 사용 할 때
                    모든값이 NULL임(사용형식은 :OLD.컬럼명)
    
    ** 트리거 함수
    --------------------------------------------------
        함수            내용
    --------------------------------------------------
      inserting       트리거 이벤트가 INSERT 명령이면 true
      updating        트리거 이벤트가 UPDATE 명령이면 true
      deleting        트리거 이벤트가 DELETE 명령이면 true
    --------------------------------------------------
    
    
    사용예) 오늘 날짜에 'i001'회원이(마일리지 :900->1750) 다음의 상품을 구매했을 때 이를 처리하시오
    상품번호            수량
    ------------------------
    P202000005          5   (마일리지 170 * 5)
    INSERT INTO CART VALUES('i001',fn_cart_no_NEW(SYSDATE,'i001'),'P202000005',5);
    ** 해당 상품의 구매수량을 10개로 변경
    UPDATE CART
    SET CART_QTY=10
    WHERE CART_NO = '2024070200001';
    
    
    ** 해당 상품의 구매수량을 3개로 변경
    UPDATE CART
    SET CART_QTY=3
    WHERE CART_NO = '2024070200001';
    
    ** 해당 상품의 구매를 취소(환불)
    DELETE
    FROM CART
    WHERE CART_NO = '2024070200001';
    ROLLBACK;

    p202000012          10  (마일리지 330 * 10)
    p302000021          10  (마일리지 190 * 10)
    
    CREATE OR REPLACE TRIGGER tg_change_cart
        AFTER INSERT OR UPDATE OR DELETE ON CART
        FOR EACH ROW
    DECLARE
        L_MILE NUMBER:=0;
        L_MID MEMBER.MEM_ID%TYPE;
        L_DATE DATE;
        L_QTY NUMBER:=0;
        L_PID PROD.PROD_ID%TYPE;
    BEGIN
        IF INSERTING THEN
            L_QTY:=(:NEW.CART_QTY);
            L_MID:= :NEW.CART_MEMBER;
            L_PID:= :NEW.CART_PROD;
            L_DATE:= TO_DATE(SUBSTR(:NEW.CART_NO,1,8));
        ELSIF UPDATING THEN
            L_QTY:=(:NEW.CART_QTY)-(:OLD.CART_QTY);
            L_MID:= :NEW.CART_MEMBER;
            L_PID:= :NEW.CART_PROD;
            L_DATE:= TO_DATE(SUBSTR(:NEW.CART_NO,1,8));
        ELSIF DELETING THEN
            L_QTY:= -(:OLD.CART_QTY);
            L_MID:= :OLD.CART_MEMBER;
            L_PID:= :OLD.CART_PROD;
            L_DATE:= TO_DATE(SUBSTR(:OLD.CART_NO,1,8));
        END IF;
        
    --재고수불 갱신
        UPDATE REMAIN A
        SET A.REMAIN_O=A.REMAIN_O+L_QTY,
            A.REMAIN_J_99=A.REMAIN_J_99 - L_QTY,
            A.REMAIN_DATE=L_DATE
        WHERE A.PROD_ID=L_PID;
    
    --마일리지 계산 및 갱신
        SELECT PROD_MILEAGE*L_QTY INTO L_MILE
        FROM PROD
        WHERE PROD_ID=L_PID;
        
        UPDATE MEMBER
        SET MEM_MILEAGE=MEM_MILEAGE+L_MILE
        WHERE MEM_ID=L_MID;
    END;
    
    **상품테이블에서 상품의 판매가로 해당상품의 마일리지를 계산하여 입력하시오
      상품의 마일리지 = 상품의 판매가의 0.5%의 값에 일의 자리에서 반올림한 값
      UPDATE PROD
      SET PROD_MILEAGE=ROUND(PROD_PRICE*0.005,-1)
      
      
      
      
      
      
      
      
      
      
      