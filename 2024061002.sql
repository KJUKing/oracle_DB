2024-0610-01)UPDATE
    -������ ������ �����Ҷ� ���
    (�������)
    UPDATE TABLE ���̺��
        SET �÷���=�� | ��������
                .
                .
        WHERE ����;
        
        -������ �ڷḦ �����ϴ� ����. �����ϸ� ��� �ڷᰡ �����
        
    ��뿹) HR�������� 30�� �μ��� ���� ����� �޿��� 0���� �����Ͻÿ�
    UPDATE HR.EMPLOYEES
        SET SALARY = 10
        WHERE DEPARTMENT_ID=30;
        
        
    SELECT FIRST_NAME, DEPARTMENT_ID, SALARY
    FROM HR.EMPLOYEES
    ORDER BY 2;

    UPDATE ORDERS
    SET ORDER_AMT = (SELECT SUM(A.PRICE*B.ORDER_QTY)
        FORM GOODS A, ORDER_GOODS B
        WHERE B.ORDER_NUM ='20240610001'
        AND A.GID = B.GID)
        
    WHERE CUST_ID =101;

��뿹) HR������ ������̺� EMP_NAME VARCHAR2(60)�÷��� ���Խ�Ű�ÿ�
��뿹) HR������ ������̺� EMP_NAME�÷��� FIRST_NAME��  LAST_NAME�� ���� �����Ͽ� �����Ͻÿ�.
       �� �� �̸� ������ ��ĭ ���� ����
    UPDATE HR.EMPLOYEES
        SET EMP_NAME=FIRST_NAME||' '||LAST_NAME;
        


