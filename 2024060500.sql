2024-0605-01)���ڿ� �ڷ�
    - ' '�� ���� �����ڷ�
    - ������Ÿ�� : ��������(VARCHAR, VARCHAR2, NVARCHAR2, LONG, CLOB, NCLOB)��
                  �������� (CHAR)�� ����
    - (�������)
      �÷��� CHAR|VARCHAR2 (ũ��[BYTE|CHAR])
      �÷��� CLOB|LONG
      
��뿹)
    CREATE TABLE TBL_CHAR(
        COL1 CHAR(20),
        COL2 CHAR(20 CHAR),
        COL3 VARCHAR2(4000),
        COL4 VARCHAR2(200 CHAR)
    );
    
** ������ ���� ���
    INSERT INTO ���̺��[(�÷��� [,�÷���,...])]
      VALUES(��1, ��2, ...);
      - ���̺�� : �����͸� ������ ���̺��
      - [(�÷��� [,�÷���,...])] : �÷����� �����Ǹ� ��� �÷��� ����� �����͸�
        VALUES���� ����ؾ� ��
      - '�÷��� [,�÷���,...]'�� ����ϴ� ���� �Ϻ� �÷����� �����͸� �Է��ϴ� ���
      - INTO���� ���� �÷����� ������ ������ VALUES�� ���� ����, ������ ��ġ�ؾ� ��
      
    INSERT INTO TBL_CHAR (COL1, COL2)
        VALUES ('������ �߱�', '������ �߱�');
        
    INSERT INTO TBL_CHAR (COL3, COL4)
        VALUES ('������ �߱�', '������ �߱�');
        
    SELECT * FROM TBL_CHAR;
    
    CREATE TABLE TBL_LONG(
    COL1 LONG,
    COL2 CLOB,
    COL3 CLOB
    );
    
    INSERT INTO TBL_LONG VALUES('������ �߱� ���� 846',
                                '������ �߱� ���� 846',
                                '������ �߱� ���� 846');
                                
    SELECT * FROM TBL_LONG;
    
    SELECT -- LENGTHB(COL1) AS "LONG�� ����",
           LENGTH(COL2) AS "CLOB�� ����",
           DBMS_LOB.GETLENGTH(COL2) AS "CLOB�� ����"
      FROM TBL_LONG;