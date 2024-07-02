2024-0628-01) Stored Procedure
    - ���� ���ν����� ó�� ����� �� ������ �˻��ϰ� �������� �ȴ�.
    - �����ϵ� ������ ���ν��� ĳ�ÿ� ����ǹǷ� ���Ŀ� ȣ��� �� ������ ����� �� �ִ�.
    - Ŭ���̾�Ʈ�� ó�� ��ƾ ����
      ��� ���� ���α׷����� ����� �� �ֵ��� ����� ĸ��ȭ �ϹǷ� �ϰ��� �ִ� ������ ������ �����Ѵ�.
    - �����ͺ��̽� ���� ���� ���� : view�� ������ ����
    - ���� ��ȣ, �ڷ� ���Ἲ(integrity)���� ����
    - queryó�� �ӵ� ���
    - Network Traffic ����
    
    (�������)
    CREATE [OR REPLACE] PROCEDURE ���ν�����[(
    ������ [IN|OUT|INOUT] ������ Ÿ�� [:=default ��][,]
                    :
    ������ [IN|OUT|INOUT] ������ Ÿ�� [:=default ��])]
    IS|AS
        ������
    BEGIN
        ������
        [EXCEPTION
            ����ó��]
    END;
    . OR REPLACE :�̹� �����ϴ� ���ν����̸� OVERWRITE
    . ������ [IN|OUT|INOUT] : ������ MODE ����
        - IN : �⺻ ���� ��� Ÿ��(������ IN���� ����) : �Է¿� ����
        - OUT : ������ ��¿� ����
        - INOUT : ����� �������� ���� �� ������ ����
    . '������ Ÿ��' : ũ�⸦ ������ �� ����
    . :=default �� : �Ű����� ���� �� ���� �������� ���� ��� �ڵ� �����Ǵ� ��
    (���๮ �������)
        - ��������(�ٸ� ��Ͼȿ��� �������� �ʴ� ���)
            EXCUTE|EXEC ���ν�����[(�Ű�����list)];
        
        - �ٸ� ��Ͼȿ��� �����ϴ� ���
          ���ν�����[(�Ű�����list)];
    ��뿹)���� ��¥�� ������Ȳ�� ������ ����. �̸� ó���Ͻÿ�
            ------------------------------
                ���Ի�ǰ��ȣ      ���Լ���
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
    
    [����]
    EXECUTE PROC_BUYPROD('P201000005', 10);
    
    
    ���� �޽����� ������ BUYPROD ���̺��� BUY_COST ���� NOT NULL ���� ������ ������ ������,
    �� ���� NULL ���� �����Ϸ��� �߱� ������ ������ �߻��� ���Դϴ�. BUY_COST ���� ���� �����ؾ� �մϴ�.

    �ذ� ����� ������ �����ϴ�:

    BUYPROD ���̺��� BUY_COST ���� ��ȿ�� ���� �����մϴ�.
    PROCEDURE�� INSERT ���� �����Ͽ� BUY_COST ���� ���� �����մϴ�.
    
    BUYPROD ���̺��� BUY_COST �÷��� NOT NULL ���� ������ ������ �ֱ� ������, �� �÷��� ���� �����ؾ� �մϴ�.
    ���� BUY_COST �÷��� NOT NULL ���� ������ ������ �ְ�, �̸� ������ �� ���ٸ�,
    �� �÷��� �⺻���� �����ؾ� �մϴ�.

    ������ ���� BUY_COST �÷��� �ʿ� ���ٸ�, �ش� �÷��� NOT NULL ���� ������ �����ϰų�,
    ���ν������� BUY_COST ���� �����ؾ� �մϴ�.
    
    --------------------------------------------------------------------------------
    
    ��뿹) ȸ����ȣ�� �Է� �޾� �ش� ȸ���� 2020�� ������ ���űݾ��� ��ȸ�Ͻÿ�
    
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
        DBMS_OUTPUT.PUT_LINE('c001ȸ���� ���űݾ� : '||L_SUM);
    END;
    
    
    
    ��뿹)Ű����� �μ���ȣ�� �Է¹޾� �ش�μ��� �ٹ��ϴ� �������(�����ȣ, �����, �Ի���,
          ������ȣ)�� ����ϴ� ���ν����� �ۼ��Ͻÿ�.
          
    (����)
    ACCEPT P_DEPT PROMPT '�μ���ȣ : '
    DECLARE
    BEGIN
        PROC_EMP02(TO_NUMBER('&P_DEPT'));
    END;
    
    --(���ν���)
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
       
    --(FOR��)
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


(����)
 ACCEPT P_DEPT  PROMPT '�μ���ȣ : '
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
 
[FOR��] 
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