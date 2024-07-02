2024-0701-02)TRIGGER
    - Ư�� ���̺��� �߻��� DML���(INSERT, UPDATE, DELETE)�� �ٸ� ���̺��� Ư�� �����
      �ڵ� ����ǰ� �ϴ� Ư�������� ���ν���
    - �� Ʈ������ Ʈ����� ������ �Ϸ�� �� �ٸ� Ʈ���Ű� ����Ǿ����
    - Ʈ������ ���� : ������� Ʈ����/ ����� Ʈ����
    
    (�������)
    CREATE [OR REPLACE] TRIGGER Ʈ�����̸�
        BEFORE|AFTER    UPDATE|INSERT|DELETE ON ���̺� ��
        [FOR EACH ROW]
        [WHEN ����]
    [DECLARE]
    
    BEGIN
        Ʈ���� ����;
    END;
    
        - 'BEFORE|AFTER' : Ʈ���� ������ ����� TIMMING
            . BEFORE : INSERT/UPDATE/DELETE �̺�Ʈ�� �߻��Ǳ� ���� Ʈ���� ���� ����
            . AFTER : INSERT/UPDATE/DELETE �̺�Ʈ�� �߻��� �Ŀ� Ʈ���� ���� ����
        - 'UPDATE|INSERT|DELETE ON ���̺��'
            . '���̺�'�� �߻���(Ʈ���Ÿ� ���߽�Ű�� ����) DML������� 'OR'�����ڸ� ����� �� �ִ�.
            . ex) INSERT OR UPDATE -> INSERT �� UPDATE ����� �߻����� ��[��]�� Ʈ���� ���� ����
        - 'FOR EACH ROW' " ����� Ʈ���� ����
        - WHEN ���� : Ʈ���� �߻��� ���� ��ü���� ������ ����
            ex)
            CREATE TRIGGER INSRT_CART
                AFTER INSERT ON CART
                FOR EACH ROW
                WHEN CART_QTY>=10
                
    ��뿹)
    (1) ��ǰ�� �з����̺� ������ �ڷḦ �Է½�Ű�� ��� ���� �� '�ű� �з��ڵ尡 �ԷµǾ����ϴ�'���
            �޼����� ����Ͻÿ�
    [�ڷ�]
     ------------------------------------------------------------
     lprod_id    lprod_gu    lprod_nm
    -----------------------------------------------------------
        10        P501        ��깰
        11        P502        ���깰
        12        P503        �ӻ깰
    ---------------------------------------------------------------
    CREATE OR REPLACE TRIGGER tg_lprod
        AFTER INSERT ON LPROD
    BEGIN
        DBMS_OUTPUT.PUT_LINE('�ű� �з��ڵ尡 �ԷµǾ����ϴ�');
    END;
    
    INSERT INTO LPROD VALUES(10,'P501','��깰');
    INSERT INTO LPROD VALUES(10,'P502','���깰');
    COMMIT;
    INSERT INTO LPROD VALUES(12,'P503','�ӻ깰');
    SELECT * FROM LPROD;
    
    (2) �з����̺��� �ڷ� �� 'P501'~'P503'�ڷḦ �����Ͻÿ�. ���� ��
        '�з��ڵ� ���� ����'�� ����Ͻÿ�.
        
    CREATE OR REPLACE TRIGGER tg_del_lprod
        AFTER DELETE ON LPROD
    BEGIN
        DBMS_OUTPUT.PUT_LINE('�з��ڵ� ���� ����');
    END;
    
    DELETE FROM LPROD
    WHERE LPROD_GU LIKE 'P50%';
    COMMIT;
    
    CREATE TABLE EMP AS
        SELECT EMPLOYEE_ID, EMP_NAME, DEPARTMENT_ID, SALARY
        FROM EMPLOYEES;
        
    ��뿹) EMP���̺��� ����ڷ� �� �����ȣ 113, 132, 157�� ��������� ����(����) ó���Ϸ��Ѵ�
           -> �������̺� ������ �̵� +��¥
           
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
    
    ** Ʈ���� �ǻ緹�ڵ�(Pseudo record) : ����� Ʈ���ſ����� ���
    --------------------------------------------------
        �ǻ緹�ڵ�   ����
    --------------------------------------------------
        :NEW        �̺�Ʈ�� INSERT, UPDATE�϶� ���Ǹ� ����(����)�� ����
                    �߰��Ǵ� �����͸� ������� ��Ī��. DELETE�� ��� �� ��
                    ��簪�� NULL��(��������� :NEW.�÷���)
                    
        :OLD        �̺�Ʈ�� DELETE, UPDATE�϶� ���Ǹ� ����(����)�� ����
                    �̹� �����ϰ� �ִ� �����͸� ������� ��Ī��. INSERT�� ��� �� ��
                    ��簪�� NULL��(��������� :OLD.�÷���)
    
    ** Ʈ���� �Լ�
    --------------------------------------------------
        �Լ�            ����
    --------------------------------------------------
      inserting       Ʈ���� �̺�Ʈ�� INSERT ����̸� true
      updating        Ʈ���� �̺�Ʈ�� UPDATE ����̸� true
      deleting        Ʈ���� �̺�Ʈ�� DELETE ����̸� true
    --------------------------------------------------
    
    
    ��뿹) ���� ��¥�� 'i001'ȸ����(���ϸ��� :900->1750) ������ ��ǰ�� �������� �� �̸� ó���Ͻÿ�
    ��ǰ��ȣ            ����
    ------------------------
    P202000005          5   (���ϸ��� 170 * 5)
    INSERT INTO CART VALUES('i001',fn_cart_no_NEW(SYSDATE,'i001'),'P202000005',5);
    ** �ش� ��ǰ�� ���ż����� 10���� ����
    UPDATE CART
    SET CART_QTY=10
    WHERE CART_NO = '2024070200001';
    
    
    ** �ش� ��ǰ�� ���ż����� 3���� ����
    UPDATE CART
    SET CART_QTY=3
    WHERE CART_NO = '2024070200001';
    
    ** �ش� ��ǰ�� ���Ÿ� ���(ȯ��)
    DELETE
    FROM CART
    WHERE CART_NO = '2024070200001';
    ROLLBACK;

    p202000012          10  (���ϸ��� 330 * 10)
    p302000021          10  (���ϸ��� 190 * 10)
    
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
        
    --������ ����
        UPDATE REMAIN A
        SET A.REMAIN_O=A.REMAIN_O+L_QTY,
            A.REMAIN_J_99=A.REMAIN_J_99 - L_QTY,
            A.REMAIN_DATE=L_DATE
        WHERE A.PROD_ID=L_PID;
    
    --���ϸ��� ��� �� ����
        SELECT PROD_MILEAGE*L_QTY INTO L_MILE
        FROM PROD
        WHERE PROD_ID=L_PID;
        
        UPDATE MEMBER
        SET MEM_MILEAGE=MEM_MILEAGE+L_MILE
        WHERE MEM_ID=L_MID;
    END;
    
    **��ǰ���̺��� ��ǰ�� �ǸŰ��� �ش��ǰ�� ���ϸ����� ����Ͽ� �Է��Ͻÿ�
      ��ǰ�� ���ϸ��� = ��ǰ�� �ǸŰ��� 0.5%�� ���� ���� �ڸ����� �ݿø��� ��
      UPDATE PROD
      SET PROD_MILEAGE=ROUND(PROD_PRICE*0.005,-1)
      
      
      
      
      
      
      
      
      
      
      