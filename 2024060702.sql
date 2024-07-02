2024-0607-02)�����ڷ�Ÿ��
  - RAW, LONG RAW, BFILE, BLOB Ÿ�� ����
  - ����Ŭ���� 2���ڷḦ �ؼ��ϰų� ��ȯ���� ����
    
    1. RAW
        - ���� ���� ũ���� 2���ڷ�
        - 2000BYTE ���� ���� ����
        - �ε��� ó������
        - 16������ 2���� ���·� ����
        (��� ����)
            �÷��� RAW(ũ��)
        (��� ��)
            CREATE TABLE TBL_RAW(
            COL1 RAW(2000)
            );
            INSERT INTO TBL_RAW VALUES('FFCD63A7'); --4BYTE
            INSERT INTO TBL_RAW VALUES(HEXTORAW('FFCD63A7'));
            INSERT INTO TBL_RAW VALUES('111111111100110101100011101000111');
            
            SELECT * FROM TBL_RAW;

    2. BFILE
        - �����ڷ� ����
        - 4GB�ڷ� ���� ����
        - ���� ������ Ư�� ������ �����ϰ� DATABASE���� ��ο� ���ϸ� ����
        - ���� ����Ǵ� �������� ó���� ����
        (�������)
            �÷��� BFILE
            - �׸������� BFILE�������� �����ϴ� ����
                1)�׸����� �غ� (���� jpg����)
                2)��ΰ�ü(DIRECTORY ��ü) ����
                    -��θ� : 30byte, ���ϸ� : 256byte���� ���
                    (�������)
                    create or replace directory ���丮��ü�� as '�����θ�'
                    
                    CREATE OR REPLACE DIRECTORY TEST_DIR AS 'D:\A_TeachingMaterial\02_Oracle\work';
                3)DB�� ����
                INSERT INTO TBL_BFILE VALUES (BFILENAME('TEST_DIR', 'sample.jpg'));
        (��뿹)
            CREATE TABLE TBL_BFILE(
            COL1 BFILE);
    3. BLOB(Binary Large Object)
        - �����ڷ� ����
        - 4GB�ڷ� ���� ����
        - ���� ������ DATABASE ���� ����
        - ������ �߻����� �ʴ� �ڷ�ó���� ����
        (�������)
        �÷��� BLOB 
            -�ڷ����� ����� ǥ�� SQL�� �ƴ� PL/SQL������� ó���ؾ���
            
        (��뿹)
        CREATE TABLE TBL_BLOB(
            COL1 BLOB
        );
        
        ������ �Է� ���
        
        DECLARE
            L_DIR VARCHAR2(20) := 'TEST_DIR';
            L_FILE VARCHAR2(30) := 'sample.jpg';
            L_BFILE BFILE;
            L_BLOB BLOB;
            
        BEGIN
            INSERT INTO TBL_BLOB(COL1) VALUES(EMPTY_BLOB())
            RETURN COL1 INTO L_BLOB;
            L_BFILE := BFILENAME (L_DIR, L_FILE);
            DBMS_LOB.FILEOPEN(L_BFILE, DBMS_LOB.FILE_READONLY);
            DBMS_LOB.LOADFROMFILE(L_BLOB, L_BFILE, DBMS_LOB.GETLENGTH(L_BFILE));
            DBMS_LOB.FILECLOSE(L_BFILE);
            
            COMMIT;
            
        END;
        