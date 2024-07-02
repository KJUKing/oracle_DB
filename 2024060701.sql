2024-0607-01)��¥������ Ÿ��
    - DATE, TIMESTAMP Ÿ�� ����
    (��� ����)
    �÷���     DATE
    �÷���     TIMESTAMP
    �÷���     TIMESTAMP WITH TIME ZONE
    �÷���     TIMESTAMP WITH LOCAL TIME ZONE
    
    (��� ��)
    CREATE TABLE TBL_DATE(
        COL_DATE DATE,
        COL_TS   TIMESTAMP,
        COL_LTZ  TIMESTAMP WITH LOCAL TIME ZONE,
        COL_TZ   TIMESTAMP WITH TIME ZONE
        );
        
  ** SYSDATE : �ý��ۿ��� �����ϴ� ǥ�� �ð�����(��,��,��,��,��,��)�� ��ȯ
     SYSTIMESTAMP : �ý��ۿ��� �����ϴ� ǥ�� ������ �ð�����(��,��,��,��,��,��)�� ��ȯ
                    (10����� 1�ʿ� Ÿ���� ����)
  ** ��¥ �ڷ�� ������ ������ ����� ��
     ���� : �������� ������ŭ �ٰ��� ���� ��¥ ��ȯ
     ���� : ���ǵ� ������ŭ ������ ���� ��¥ ��ȯ
     ��¥�ڷ������ ���� : �� ��¥������ ����� �ϼ� ��ȯ
     
    INSERT INTO TBL_DATE VALUES (SYSDATE, SYSTIMESTAMP, SYSTIMESTAMP+10,
                                SYSTIMESTAMP-10);
                                
    SELECT * FROM TBL_DATE;
    
  ** DATEŸ���� �ڷḦ �ú��ʱ��� ����Ϸ��� TO_CHAR�Լ��� ���
  SELECT TO_CHAR(COL_DATE, 'YYYY-MM-DD HH24:MI:SS')
    FROM TBL_DATE;

  **Ű����� ��¥�� �Է� �޾� ������ ����ϴ� �͸� ����� �ۼ��Ͻÿ�.
  
    ACCEPT P_DATE PROMPT '��¥�Է� (YYYYMMDD)'
    DECLARE
        L_DATE DATE := TO_DATE('&P_DATE');
        L_DAYS NUMBER :=0;
        L_RES VARCHAR2(100);
        
    BEGIN
    --������� ����ǥ���̰� �ú��ʴ� �Ҽ���ǥ���̶� TRUNCATE����ϸ� �Ҽ��� �����Ҽ��ִ�.
        L_DAYS :=TRUNC(L_DATE) - TRUNC(TO_DATE ('00010101')) -1;
            IF MOD(L_DAYS, 7) = 0 THEN
            L_RES:=TO_CHAR(L_DATE, 'YYYY/MM/DD') ||'���� ������ �Ͽ����Դϴ�.';
            ELSIF MOD(L_DAYS, 7) = 1 THEN
            L_RES:=TO_CHAR(L_DATE, 'YYYY/MM/DD') ||'���� ������ �������Դϴ�.';
            ELSIF MOD(L_DAYS, 7) = 2 THEN 
            L_RES:=TO_CHAR(L_DATE, 'YYYY/MM/DD') ||'���� ������ ȭ�����Դϴ�.';
            ELSIF MOD(L_DAYS, 7) = 3 THEN 
            L_RES:=TO_CHAR(L_DATE, 'YYYY/MM/DD') ||'���� ������ �������Դϴ�.';
            ELSIF MOD(L_DAYS, 7) = 4 THEN 
            L_RES:=TO_CHAR(L_DATE, 'YYYY/MM/DD') ||'���� ������ ������Դϴ�.';
            ELSIF MOD(L_DAYS, 7) = 5 THEN 
            L_RES:=TO_CHAR(L_DATE, 'YYYY/MM/DD') ||'���� ������ �ݿ����Դϴ�.';
            ELSE
            L_RES:=TO_CHAR(L_DATE, 'YYYY/MM/DD') ||'���� ������ ������Դϴ�.';
            END IF;
            
        DBMS_OUTPUT.PUT_LINE(L_RES);
            
    
    END;
    