2024-0702-01) VIEW
    - View�� Table�� ������ ��ü�̴�.
    - View�� ������ ���̺��̳� �ٸ� View ��ü�� ���Ͽ� ���ο� SELECT���� ����� ���̺�ó�� ����Ѵ�.(�������̺�)
    - View�� SELECT���� �ͼӵǴ� ���� �ƴϰ�, ���������� ���̺�ó�� ����
    - View�� �̿��ϴ� ���
        . �ʿ��� ������ �� ���� ���̺� ���� �ʰ�, ���� ���� ���̺� �л�Ǿ� �ִ� ���
        . ���̺� ��� �ִ� �ڷ��� �Ϻκи� �ʿ��ϰ� �ڷ��� ��ü row�� column�� �ʿ����� ���� ���
        . Ư�� �ڷῡ ���� ������ �����ϰ��� �� ���(����)
    (�������)
    CREATE [OR REPLACE] [FORCE|NOFORCE] VIEW view_name [(columnName_list ...)]
    AS
    select-statment
    [WITH CHECK OPTION]
    [WITH READ ONLY]
    - 'FORCE' : �������̺��� ��� �� ����. �⺻���� NOFORCE
    - 'WITH CHECK OPTION' : �並 �����ϴ� SELECT���� WHERE���� WHERE������ ������ ��� ����
    - 'WITH READ ONLY' : �б� ���� ��, WITH READ ONLY�� WITH CHECK OPTION�� ���� ����� �� ����
    
    ** VIEW ���� ������ ��
        - View�� ������ �� ��������(WITH)�� �ִ� ��� ORDER BY �� �Ұ�.
        - View ���� �Լ�, GROUP BY��, DISTINCT�� ����Ͽ� ������� ���
          INSERT, UPDATE, DELETE ������ ����� �� ����.
        - ��� �÷��� ǥ����, �Ϲ� �Լ��� ���Ͽ� ������� ��� �ش� �÷��� �߰� �� ���� �Ұ���
        - CURRVAL, NEXTVAL �ǻ��÷�(pseudo column) ���Ұ�
        - ROWID, ROWNUM, LEVEL �ǻ��÷��� ����� ��� alias�� ����ؾ���
        
    CREATE OR REPLACE VIEW V_MEM_MILEAGE
    AS
        SELECT MEM_ID AS ȸ����ȣ, MEM_NAME AS ȸ����, MEM_MILEAGE AS ���ϸ���
        FROM MEMBER
        WHERE MEM_MILEAGE >=3000;
        
    1) MEMBER ���̺��� 'c001'ȸ���� ���ϸ����� 1500���� ����
    UPDATE MEMBER
    SET MEM_MILEAGE = 1500
    WHERE MEM_ID='c001'
    
    2)�� V_MEM_MILEAGE���� ��ö��('k001')�� ���ϸ����� 4000���� �����Ű��
    SELECT * FROM V_MEM_MILEAGE
    
    UPDATE V_MEM_MILEAGE
    SET ���ϸ��� = 4000
    WHERE ȸ����ȣ = 'k001'
    
    SELECT MEM_ID, MEM_NAME, MEM_MILEAGE
    FROM MEMBER
    WHERE MEM_ID='k001'