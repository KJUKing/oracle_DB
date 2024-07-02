2024-0626-02)PL/SQL(Procedural Language SQL)
    - block ������ ������ ���� �����ϵǾ� ����
    - ���ø����̼ǵ鿡 ������ �� ����
    - ������ ����� Ư¡(�ݺ���,�б⹮,�Լ�,���� ��)�� ���
    - ����ó���� ����
    - ���� ��Ʈ��ũ�� ��ŷ��� �ٿ� ���� ȿ������ ����
    - �͸� ���, stored procedure, User Defined Function, Trigger, Package �� ����
    
    (�⺻����)
    
    DECLARE
        ����� => ����, ���, Ŀ������
    BEGIN
        ����� => ����� ��ȯ�� �� �ִ� �����Ͻ� ���� ������ �ʿ��� SQL �� ��ɹ�
          :
        [����ó��]
          :   => EXCEPTION WHEN ~
    END;
    
    ��뿹)
    DECLARE
        L_NAME LPROD.LPROD_NM%TYPE;
    BEGIN
        SELECT LPOD_NM INTO L_NAME
        FROM LPROD
        WHERE LPORD_GU='P102';
        
        DBMS_OUTPUT.PUT_LINE ('�з���: '||L_NAME);
        DBMS_OUTPUT.PUT_LINE ('�ڷ��: '||SQL%ROWCOUNT);
    END;
    
    1. ����
        - �Ϲ� ���ø����̼��� ������ ����� ����
        - ������ ���� : CALAR���� ,REFERENCE ����, BIND ���� ,  COMPOSITE ����
        - ������
            ������ ������ Ÿ��|���̺��.�÷���%TYPE | ���̺��%ROWTYPE [:=�ʱⰪ]
            
    2. �б⹮�� �ݺ���
        1) if��
            - ���ø����̼� ����� if�� ���� ���
            (������� 1)
            IF ���� THEN
            [ELSE
               ���2;]
            END IF;
            
            (������� 2)
            IF ����1 THEN
               ���1;
            ELSIF ����2 THEN
               ���2;
                :
            [ELSE
               ��� n;]
            END IF;
            
            (������� 3)
            IF ����1 THEN
              IF ����2 THEN
                   ���1;
              ELSE
                   ���2;
              END IF;
                   :
              [ELSE
                ���n;]
               END IF;
                   
        2) CASE WHEN ~ THEN ��
            - ���� �б⹮
            (�������-1)
            CASE WHEN ����1 THEN ���1;
                 WHEN ����2 THEN ���2;
                     :
                 [ELSE ���n;]
            END CASE;
            
            (�������-2)
            CASE ���� WHEN ��1 THEN ���1;
                      WHEN ��2 THEN ���2;
                     :
                 [ELSE ���n;]
            END CASE;
            
        ��뿹) ����(1-100��)�� ������ �����ϰ� �� ������ ����
               100-90 : A,
               89-80 : B,
               79-70 : C,
               69-60 : D
               ������ : F�� ����Ͻÿ�
        
        DECLARE
            L_SCORE NUMBER:=85;
            L_RES VARCHAR2 (200);
        BEGIN
            IF L_SCORE >=90 THEN
               L_RES:=TO_CHAR(L_SCORE)||'���� A���� �Դϴ�';
            ELSIF L_SCORE >=80 THEN
               L_RES:=TO_CHAR(L_SCORE)||'���� B���� �Դϴ�';
            ELSIF L_SCORE >=70 THEN
               L_RES:=TO_CHAR(L_SCORE)||'���� C���� �Դϴ�';
            ELSIF L_SCORE >=60 THEN
               L_RES:=TO_CHAR(L_SCORE)||'���� D���� �Դϴ�';
            ELSE
               L_RES:=TO_CHAR(L_SCORE)||'���� F���� �Դϴ�';
        END IF;
        
        DBMS_OUTPUT.PUT_LINE(L_RES);
        END;
        
        DECLARE
            L_SCORE NUMBER:=85;
            L_RES VARCHAR2 (200);
        BEGIN
            CASE TRUNC(L_SCORE/10)
                WHEN 10 THEN
                L_RES:=TO_CHAR(L_SCORE)||'���� A���� �Դϴ�';
                WHEN 9 THEN
                L_RES:=TO_CHAR(L_SCORE)||'���� A���� �Դϴ�';
                WHEN 8 THEN
                L_RES:=TO_CHAR(L_SCORE)||'���� B���� �Դϴ�';
                WHEN 7 THEN
                L_RES:=TO_CHAR(L_SCORE)||'���� C���� �Դϴ�';
                WHEN 6 THEN
                L_RES:=TO_CHAR(L_SCORE)||'���� D���� �Դϴ�';
                ELSE
                L_RES:=TO_CHAR(L_SCORE)||'���� D���� �Դϴ�';
        END CASE;
        
        DBMS_OUTPUT.PUT_LINE(L_RES);
        END;
        
        
        ��뿹) ���� ��뷮�� ��(TON)������ �Է¹޾� ��������� ����Ͻÿ�
               ������� = �������� + �ϼ������
               �������� = ��뷮 + �ܰ�
               ��뷮         �ܰ� 
               ---------------------------------
                1-10         350
                10-19        450
                20-29        750
                30-39       1200
                ���̻�       1800
            �ϼ��� ��� = ��뷮 * 450
               
        ��뿹) 
        
            
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             