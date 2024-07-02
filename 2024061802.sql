2024-0618-02) NULLó���Լ�
    - ����Ŭ���� NULL�� �ڷ��� ���������� �Ǵ��� �� ���
    - NULL�� ����� ����� �׻� NULL��
    - NULL ó�� ������ : IS NULL, IS NOT NULL
    - NULL ó�� ���� �Լ� : NVL(expr, ��), NVL2(expr,��1,��2), NULLIF(c, d)
    
    1)IS NULL, IS NOT NULL
        - NULL�� �񱳴� '=' �����ڷ� ������ �� ����
        - �ݵ�� IS NULL, IS NOT NULL�� ���ؾ� ��
        
    ��뿹) ������̺��� ���������� NULL�� �ƴ� ����� �����ȣ, �����, �μ���ȣ, �޿���
            ��ȸ�Ͻÿ�.
        SELECT EMPLOYEE_ID AS �����ȣ,
               EMP_NAME AS �����,
               DEPARTMENT_ID AS �μ���ȣ,
               SALARY AS �޿�
        FROM EMPLOYEES
        WHERE EMPLOYEE_ID IS NOT NULL AND
              EMP_NAME IS NOT NULL AND
              DEPARTMENT_ID IS NOT NULL AND
              SALARY IS NOT NULL
              
    2) NVL(expr, ��)
        - expr ���� NULL�̸� '��'�� ��ȯ�ϰ� NULL�� �ƴϸ� �ڽ��� ���� ��ȯ
        
        - expr�� '��'�� ������ Ÿ���� �ݵ�� ��ġ�ؾ���
        
    ��뿹) ��ǰ���̺��� ��ǰ�� ����� NULL�� ��ǰ�� 'ũ������ ����'�� ����Ͻÿ�
    Alias�� ��ǰ�ڵ�, ��ǰ��, ũ��, �ǸŰ�
        SELECT 
                PROD_ID AS ��ǰ�ڵ�,
                PROD_NAME AS ��ǰ��,
                PROD_SIZE AS ũ��,
                NVL(PROD_SIZE, 'ũ������ ����') AS ����,
                PROD_PRICE AS �ǸŰ�
        FROM PROD
    
    ��뿹) ������̺��� 2022�� ���� �Ի��� ������� ���ʽ��� ����Ͽ� ����Ͻÿ�
            �� �ݼӳ���� ���� ������� ���
            ���ʽ� = (BONUS)=�޿�(SALARY)*��������(COMMISSION_PCT)
            ALIAS   �� �����ȣ, �����, �Ի���, �Ի���, ��������, �޿�, ���ʽ�
            SELECT EMPLOYEE_ID AS �����ȣ,
                   EMP_NAME AS �����,
                   HIRE_DATE AS �Ի���,
                   COMMISSION_PCT AS ��������,
                   SALARY AS �޿�,
                   NVL(TO_CHAR((SALARY*COMMISSION_PCT), '999,999'), '���ʽ�����') AS ���ʽ�
            FROM EMPLOYEES
            WHERE EXTRACT(YEAR FROM SYSDATE) >= 2022
            ORDER BY 3;
            
    3) NVL2(expr,��1,��2)
        - expr�� ���� NULL�� �ƴϸ� '��1'�� ��ȯ�ϰ�, NULL�̸� '��2'�� ��ȯ
        - '��1'��'��2'�� ���� ������ Ÿ���̾�� �Ѵ�
        - NVL�� NVL2�� �ٲپ� ����� �� ����[NVL2(expr,expr,'��2')]
    
    4) NULLIF(c,d)
        -c�� d�� ���� ���̸� NULL�� ��ȯ�ϰ�, NULL�� �ƴϸ� C�� ��ȯ
        
    ** ��ǰ���̺��� �з��ڵ� 'P301'�� ���� ��ǰ�� �ǸŰ����� ���԰������� �����Ͻÿ�
            UPDATE PROD
            SET PROD_PRICE = PROD_COST
            WHERE PROD_LGU = 'P301'
            
    ��뿹) ��ǰ���̺��� ���԰��� ���Ⱑ�� ���� ��ǰ�� ������ '��������'�� ����ϰ�
            ���԰��� ���Ⱑ�� ���� ���� ��ǰ�� ���Ⱑ �Ǹ� ������ ����Ͻÿ�
            ALIAS ��ǰ�ڵ�, ��ǰ��, ���԰�, ���Ⱑ, ���
            SELECT PROD_ID AS ��ǰ�ڵ�,
                   PROD_NAME AS ��ǰ��,
                   PROD_COST AS ���԰�,
                   PROD_PRICE AS ���Ⱑ,
                   NVL2(NULLIF(PROD_COST , PROD_PRICE),
                        TO_CHAR((PROD_PRICE -PROD_COST),'9,999,999'),
                        LPAD('��������',11)) AS���
            FROM PROD