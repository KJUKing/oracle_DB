2024-0611-02)������
1. ���������
    - ��Ģ������ ���� : +, -, *, /(������ �����ڴ� �������� ����-�Լ��� ����)
��뿹)HR���� ������̺��� ���������� ���� ���ʽ��� ����ϰ� ���޾��� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�.
    ���޾��� ���� ������ �����Ͻÿ�. -- ORDER BY �÷��� ; �ϸ� �ڵ� ���� ���������� �⺻��
    -- ������ ���� ��� WHERE �����
    ALIAS�� �����ȣ(EMPLOYEE_ID),�����(EMP_NAME),����(SALARY),���ʽ�,���޾�
    -- ALIAS�� ������ ��5���� ����Ѵٴ°�
    ���ʽ�(BONUS)=����*���������ڵ�(COMMISSION_PCT)
    ���޾�(SAL_AMT)=����+���ʽ�
    
    SELECT EMPLOYEE_ID AS �����ȣ,
           EMP_NAME AS �����,
           SALARY AS "�� ��",   --" " �� �̿��ϸ� �������� ���� ����
           NVL(SALARY * COMMISSION_PCT,0) AS "�� �� ��",           --NVL(    ,0) NULL�� ������ 0���� �����ض� ��¶� ���ϸ�
           SALARY + (NVL(SALARY * COMMISSION_PCT,0)) AS "�� �� ��" --NULL�� �����ԵǸ� ������� NULL�� ���ͼ� ������� ������ �����
    
        FROM HR.EMPLOYEES
        ORDER BY 5;
        
2. ���迬����
    - �������� ũ�⸦ ��
    - ����� TRUE, FALSE �� �ϳ�
    - ���� ���ǽ� ������ ���     --WHERE�� , SELET�� HAVING ��
    - >, <, =, <=, >=, !=(<>)
��뿹)
    1)��ǰ���̺��� �ǸŰ��� 50���� �̻��� ��ǰ�� ��ȸ�Ͻÿ�
    ��, �ǸŰ��� ū ��ǰ���� ���
    AIIAS�� ��ǰ�ڵ�, ��ǰ��, �ǸŰ���
    SELECT PROD_ID AS ��ǰ�ڵ�,
           PROD_NAME AS ��ǰ��,
           PROD_PRICE AS �ǸŰ���
        FROM PROD
        WHERE PROD_PRICE >= 500000
        ORDER BY 3 DESC;
    
    
    2)ȸ�����̺��� 20��ȸ���� ��ȸ�Ͻÿ�
    ��, ���̰� ���� ȸ������ ����Ͻÿ�
    ALIAS�� ȸ����ȣ, ȸ����, �ֹι�ȣ, ����
    SELECT MEM_ID AS ȸ����ȣ,
           MEM_NAME AS ȸ����,
           MEM_REGNO1||'-'||MEM_REGNO2 AS �ֹι�ȣ,  -- �ֹι�ȣ ǥ�ù����� '-'���� ����� ������
           EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR) AS ����         --EXTRACT �����Ҷ� ���� �Լ�
           FROM MEMBER                       --(YEAR ���� ������Ÿ�� 6�� �� ������, �����ϰ��� ���ڷ� �����)
           WHERE EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR)>=20 AND
                 EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR)<=29
        -- WHERE TRUNC(EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR))/10)=2 �̷��Ե� ������
        -- TRUNC �� �Ҽ��� ���ϸ� ������� �Լ�
           ORDER BY ���� DESC;    --���̶�� ��Ī�� �ν��̵Ǽ� ORDER BY �� �տ� �ٸ� ������ �����̉�⿡ ����
    
    ** HR������ ������̺��� ������� �Ի����� 16�� �ķ� �����Ͻÿ�.
       UPDATE HR.EMPLOYEES
          SET HIRE_DATE=ADD_MONTHS(HIRE_DATE,192);    -- �տ� MONTHS�� 192������ 16��ġ
          COMMIT;
        
    ����]HR������ ������̺��� �ټӳ���� 5�� �̻��� ��������� ��ȸ�Ͻÿ�.
        ��, �ټӳ���� ���� ������� ����Ͻÿ�.
        ALIAS�� �����ȣ,�����,�Ի���,�ټӳ��
        SELECT EMPLOYEE_ID AS �����ȣ,
               EMP_NAME AS �����,
               HIRE_DATE AS �Ի���,
               EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM HIRE_DATE) AS �ټӳ��
        FROM HR.EMPLOYEES
        WHERE EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM HIRE_DATE)>=5 
        ORDER BY 3 ;  -- �̷���� �ټӳ���� ������������ �ϸ� �ټӳ���� ����������� �Ի����� �ٸ������־
                      -- �Ի����� ������������ �����Ѵ�.
                      
3. ��������
    - NOT, AND, OR     --���� ���� NOT - AND - OR // NOT�� ���׿����� // AND ���׿����� // OR ���׿����� ��
    --------------------------
    A       B      AND     OR        -- AND�� �� / OR�� ����
    --------------------------
    0       0       0       0
    0       1       0       1
    1       0       0       1
    1       1       1       1
    
��뿹)
    Ű����� �⵵�� �Է¹޾� ����� ����� �����Ͻÿ�
    ACCEPT P_YEAR   PTOMPT '�⵵(XXXX) : '
    DECLARE
        L_YEAR NUMBER := TO_NUMBER('&P_YEAR');
        L_RES VARCHAR2(200);
    BEGIN
        IF (MOD(L_YEAR,4)=0 AND MOD(L_YEAR,100)!=0) OR (MOD(L_YEAR,400)=0) THEN
            L_RES:=L_YEAR||'���� �����Դϴ�';
        ELSE
            L_RES:=L_YEAR||'���� ����Դϴ�';
        END IF;
        DBMS_OUTPUT.PUT_LINE(L_RES);
    END;
    -- (4/0=0 AND 100!=0) OR 400/0=0
    