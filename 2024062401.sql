2024-0624-01) ��������
** DML ��ɰ� ��������
1. INSERT���� SUBQUERY
    - INSERT���� ���������� ����� ��� VALUES���� ������
    - ���������� ( )�� ������� �ʰ� ���
    - ���������� ����� INSERT �Ǵ� �÷��� ��ġ�Ǿ�� ��
    (�������)
        INSERT INTO ���̺�� [(�÷�list)]
            ��������;
    ��뿹) ������ ���̺� ������ ���� �Է��Ͻÿ�.
           ��ǰ�ڵ�� ��ǰ���̺��� ��ǰ�ڵ�,
           �������� PROD_PROPERSTOCK �÷���
           �⵵�� '2020'
           ���Լ���, ��������� 0
           ������ �������� ����
           ��¥�� 2020�� 1�� 1����
           
           INSERT INTO REMAIN
                SELECT '2020', PROD_ID, PROD_PROPERSTOCK, 0, 0, PROD_PROPERSTOCK,
                       TO_DATE('20200101')
                FROM PROD
                
           SELECT * FROM REMAIN