2024-0701-01)User Defined Function
    - ��ȯ���� ������ �ִ� ���
    - ������ Ư¡�� PROCEDURE�� ����
    (���� ��� ����)
    CREATE [OR REPLACE[ FUNCTION �Լ���[(
        ������ [IN|OUT|INOUT] ������ Ÿ�� [:=default ��][,]
                    :
        ������ [IN|OUT|INOUT] ������ Ÿ�� [:=default ��])]
    RETURN Ÿ�Ը�
    IS|AS
        ������
    BEGIN
        ������
        [EXCEPTION
            ����ó��]
    END;
        - 'RETURN Ÿ�Ը�' : ��ȯ�� ������ Ÿ���� ���(��ȯ �� ����� �ƴ�)
        - ������ �ȿ� 1�� �̻��� 'RETURN ��|expr' ���� �־����
        - �Ű����� Ÿ�Կ� OUT ��尡 ���Ǳ�� ������ ����� �� ����
        
    ��뿹)
    
    (1) ȸ�� ���̵� �Է� �޾� ���ϸ����� ��ȯ�ϴ� �Լ� �ۼ�
    
    CREATE OR REPLACE FUNCTION fn_mileage(
        PMID MEMBER.MEM_ID%TYPE)
        RETURN NUMBER
    IS
        L_MILEAGE MEMBER.MEM_MILEAGE%TYPE;
    BEGIN
        SELECT MEM_MILEAGE INTO L_MILEAGE
        FROM MEMBER
        WHERE MEM_ID=PMID;
        RETURN L_MILEAGE;
    END;
    
    [����]
    SELECT  MEM_ID, MEM_NAME, fn_mileage(MEM_ID)
    FROM MEMBER
    ORDER BY 3 DESC;
    
    (2) ��� ���� ȸ����ȣ�� �Է¹޾� ���űݾ��հ踦 ��ȯ�ϴ� �Լ� �ۼ�
    CREATE OR REPLACE FUNCTION FN_SUM_CART(
        P_PERIOD CHAR, P_MID MEMBER.MEM_ID%TYPE) --MOD�������� IN���ΰ���
        RETURN NUMBER
    IS
        L_SUM NUMBER :=0;
    BEGIN
        SELECT SUM(A.CART_QTY * B.PROD_PRICE) INTO L_SUM
        FROM CART A, PROD B
        WHERE A.CART_PROD=B.PROD_ID
            AND A.CART_MEMBER = P_MID
            AND A.CART_NO LIKE P_PERIOD||'%';
        RETURN L_SUM;
        EXCEPTION WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('�����߻� : '||SQLERRM);
    END;
    
    [����]
    SELECT MEM_ID AS ȸ����ȣ,
           MEM_NAME AS ȸ����,
           FN_SUM_CART('202005', MEM_ID) AS ���űݾ��հ�
    FROM MEMBER
    WHERE MEM_ADD1 LIKE '����%';
    
    (3) ���� ��¥�� �Է¹޾� ��ٱ��� ��ȣ�� �����Ͻÿ�.
    CREATE OR REPLACE FUNCTION fn_cart_no(P_DATE IN DATE)
        RETURN VARCHAR2
    IS
        L_CNT NUMBER := 0;
        L_CART_NO CART.CART_NO%TYPE;
        L_NUM NUMBER(5) := 0;
        L_DATE CHAR(9) := TO_CHAR(P_DATE, 'YYYYMMDD')||'%';
    BEGIN
        SELECT COUNT(*) INTO L_CNT
        FROM CART
        WHERE CART_NO LIKE L_DATE;
        
        IF L_CNT=0 THEN
            L_CART_NO := TO_CHAR(P_DATE, 'YYYYMMDD')||TRIM('00001');
        ELSE
            SELECT MAX(CART_NO)+1 INTO L_CART_NO
            FROM CART
            WHERE CART_NO LIKE L_DATE;
        END IF;
        RETURN L_CART_NO;
    END;
    
    [����]
    (1) 2020 �� 4�� 5�� �̶��ϰ� 'a001'ȸ���� 'P201000006'��ǰ�� 5�� ����
    INSERT INTO CART VALUES('a001', fn_cart_no(TO_DATE('20200405')),
                            'P201000006',5);
    (2) ���� ��¥�� ȸ�� 'q001'ȸ���� 'P302000016'�� 15�� ����
    INSERT INTO CART VALUES('q001', fn_cart_no(SYSDATE), 'P302000016', 15)
    
    
    ----------------------------------------------------
    [���� ������ ���]
    CREATE OR REPLACE FUNCTION fn_cart_no_NEW(P_DATE IN DATE,
                                              P_MID IN MEMBER.MEM_ID%TYPE)
        RETURN VARCHAR2
    IS
        L_CNT NUMBER := 0;
        L_CART_NO CART.CART_NO%TYPE;
        L_MID MEMBER.MEM_ID%TYPE;
        L_DATE CHAR(9) := TO_CHAR(P_DATE, 'YYYYMMDD')||'%';
    BEGIN
        SELECT COUNT(*) INTO L_CNT
        FROM CART
        WHERE CART_NO LIKE L_DATE;
        
        IF L_CNT=0 THEN
            L_CART_NO := TO_CHAR(P_DATE, 'YYYYMMDD')||TRIM('00001');
        ELSE
            SELECT MAX(CART_NO) INTO L_CART_NO
            FROM CART
            WHERE CART_NO LIKE L_DATE;
            
            SELECT DISTINCT CART_MEMBER INTO L_MID
            FROM CART
            WHERE CART_NO = L_CART_NO;
            
            IF L_MID <> P_MID THEN 
                L_CART_NO:=L_CART_NO+1;
            END IF;
        END IF;
        RETURN L_CART_NO;
    END;
    
    [����]
    (1) 2020 �� 4�� 15�� �̶��ϰ� 'w001'ȸ���� 'P201000006'��ǰ�� 5�� ����
    INSERT INTO CART VALUES('w001', fn_cart_no_NEW(TO_DATE('20200415'), 'w001'), 'P201000006', 5);
    (2) 2020SUS 4�� 1���̶� �ϰ� 't001'ȸ���� 'P201000006'�� 15�� ����
    INSERT INTO CART VALUES('t001', fn_cart_no_NEW(TO_DATE('20200401'), 't001'), 'P302000016', 15);
                            
    ��뿹) �з��ڵ带 �Է¹޾� 2020�� ��ݱ� �з��� �ǸŽ����� ��ȸ�Ͻÿ�
            ALIAS �з��ڵ�, �з���, �Ǹż����հ�, �Ǹűݾ��հ�
            
    [�����հ�]
    CREATE OR REPLACE FUNCTION FN_AMT_QTY(P_LPROD_GU IN LPROD.LPROD_GU%TYPE)
        RETURN NUMBER
    IS
        L_AMT NUMBER := 0;
    BEGIN
        SELECT SUM(A.CART_QTY) INTO L_AMT
        FROM CART A, PROD B
        WHERE B.PROD_LGU= P_LPROD_GU
            AND B.PROD_ID = A.CART_PROD
            AND SUBSTR(A.CART_NO,1,6) BETWEEN '202001' AND '202006';
        RETURN L_AMT;
    END;
    
    [�ݾ��հ�]
    CREATE OR REPLACE FUNCTION FN_AMT_SUM(P_LPROD_GU IN LPROD.LPROD_GU%TYPE)
        RETURN NUMBER
    IS
        L_SUM NUMBER := 0;
    BEGIN
        SELECT SUM(A.CART_QTY*B.PROD_PRICE) INTO L_SUM
        FROM CART A, PROD B
        WHERE B.PROD_LGU= P_LPROD_GU
            AND B.PROD_ID = A.CART_PROD
            AND SUBSTR(A.CART_NO,1,6) BETWEEN '202001' AND '202006';
        RETURN L_SUM;
    END;
    
    [������]
    SELECT LPROD_GU AS �з��ڵ�,
           LPROD_NM AS �з���,
           NVL(FN_AMT_QTY(LPROD_GU),0) AS �Ǹż����հ�,
           NVL(FN_AMT_SUM(LPROD_GU),0) AS �Ǹűݾ��հ�
    FROM LPROD;
    
[�Լ� ���� ����]


    SELECT LPROD_GU AS �з��ڵ�,
           LPROD_NM AS �з���,
           NVL(TA.BAMT,0) AS �Ǹż����հ�,
           NVL(TA.CAMT,0) AS �Ǹűݾ��հ�
    FROM LPROD L,
         (SELECT B.PROD_LGU AS BPID,
                 SUM(A.CART_QTY) AS BAMT,
                 SUM(A.CART_QTY*B.PROD_PRICE) AS CAMT
          FROM CART A, PROD B
          WHERE B.PROD_ID = A.CART_PROD
            AND SUBSTR(A.CART_NO,1,6) BETWEEN '202001' AND '202006'
            GROUP BY B.PROD_LGU) TA
    WHERE L.LPROD_GU = TA.BPID(+)
        