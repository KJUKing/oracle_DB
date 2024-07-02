2024-0625-02)���տ�����
    - ���� ���� ���� ����� �����Ͽ� �ϳ��� ����� ��ȯ
    - ���� �ٸ� ���̺��� ������ ������ ����� ��ȯ�ϴ� ��쳪,
      ���� ���̺��� ���� �ٸ� ������ ����� ��ĥ�� ���
    - Ʃ�� �������� �����ȹ�� �и��ϰ��� �Ҷ� ���
    - UNION, UNION ALL, INTERSECT, MINUS ������ ����
    - ù ��° SELECT ���� ����� SELECT���� ��Ī�� ����� ��Ī���� ���
    - �� SELECT ���� SELECT ���� �÷��� ���� �����ؾ��ϸ�, ���� ��ġ�� �÷�
      ������ Ÿ���� �����ؾ���
    - ORDER BY���� �� ������ SELECT�������� ��� ����
    
    1. UNION�� UNION ALL
        - �������� ����� ��ȯ
        - UNION ALL�� �����ڷḦ �ߺ����
        
    ��뿹)
        (1) ȸ�����̺��� ���ϸ����� 2000�̻��� ȸ���� ������ '�ڿ���'�� ȸ����
        ȸ����ȣ, ȸ����, ���̸� ���Ͻÿ�.
        
        (UNION)
        SELECT MEM_ID AS ȸ����ȣ,
               MEM_NAME AS ȸ����,
               EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR) AS ����
        FROM MEMBER
        WHERE MEM_MILEAGE >= 4000
        
    UNION ALL
        SELECT MEM_ID AS ȸ����ȣ,
               MEM_NAME AS ȸ����,
               EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR) AS ����
        FROM MEMBER
        WHERE MEM_JOB = '�ڿ���'
        
        (2) ������̺��� �μ��� �޿��հ�� ��ü �޿��հ踦 ���ϴ�
            QUERY�� �ۼ��Ͻÿ�
        SELECT TO_CHAR(A.DEPARTMENT_ID) AS �μ��ڵ�,
               B.DEPARTMENT_NAME AS �μ���,
               SUM(SALARY) AS "�μ��� �޿��հ�"
        FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
        WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
        GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
    UNION ALL
        SELECT '  ',
               '�հ�',
               SUM(SALARY)
        FROM HR.EMPLOYEES
        
        (3) 2020�� 3���� 2020�� 6���� ���Ե� ��ǰ������ ��ȸ�Ͻÿ�(�ߺ�����)
            ALIAS ��ǰ��ȣ, ��ǰ���� ���� ����ϰ� �������࿡�� ��ǰ���÷���
            ��ü ���Աݾ��� ����Ͻÿ�
            
            SELECT DISTINCT B.BUY_PROD AS ��ǰ��ȣ,
                   A.PROD_NAME AS ��ǰ��
            FROM PROD A, BUYPROD B
            WHERE A.PROD_ID = B.BUY_PROD
            AND BUY_DATE BETWEEN TO_DATE('20200401')
                                AND TO_DATE('20200430')
        UNION
            SELECT C.PROD_ID AS ��ǰ��ȣ,
                   C.PROD_NAME AS ��ǰ��
            FROM PROD C, BUYPROD D
            WHERE C.PROD_ID = D.BUY_PROD
            AND BUY_DATE BETWEEN TO_DATE('20200601')
                                AND TO_DATE('20200630')
        UNION
            SELECT '�հ�',
                   TO_CHAR(SUM(BUY_QTY*PROD_COST),'999,999,999')
            FROM BUYPROD A, PROD B
            WHERE A.BUY_PROD=B.PROD_ID
                AND (A.BUY_DATE BETWEEN TO_DATE('20200601') AND TO_DATE('20200630') OR
                    A.BUY_DATE BETWEEN TO_DATE('20200301') AND TO_DATE('20200331'))
                    
        2. INTERSECT
            -�������� ����� ��ȯ
        
        ��뿹)
        (1) ������̺��� ������ 'IT_PROG'�̰� �޿��� 5000�̻��̸� �ټӳ����
            3���� �ȵ� ������ �����ȣ, �����, �μ���, �����ڵ�, �޿�, �Ի��ϸ� ��ȸ�Ͻÿ�
            
            SELECT A.EMPLOYEE_ID AS �����ȣ,
                   A.EMP_NAME AS �����,
                   B.DEPARTMENT_NAME AS �μ���,
                   A.JOB_ID AS �����ڵ�,
                   A.SALARY AS �޿�,
                   A.HIRE_DATE AS �Ի���
            FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
            WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
            AND A.JOB_ID = 'IT_PROG'
    INTERSECT     
            SELECT A.EMPLOYEE_ID,
                   A.EMP_NAME,
                   B.DEPARTMENT_NAME,
                   A.JOB_ID,
                   A.SALARY,
                   A.HIRE_DATE
            FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
            WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID    
            AND MONTHS_BETWEEN(SYSDATE, A.HIRE_DATE) <=36
    INTERSECT
            SELECT A.EMPLOYEE_ID,
                   A.EMP_NAME,
                   B.DEPARTMENT_NAME,
                   A.JOB_ID,
                   A.SALARY,
                   A.HIRE_DATE
            FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
            WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID            
            AND A.SALARY >= 5000
            
    (2) 2020�� 3���� ���Ե� ��ǰ �� 4���� �Ǹŵ� ��ǰ�� ��ȸ�Ͻÿ�
        ALIAS�� ��ǰ��ȣ, ��ǰ��, ���԰�, ���Ⱑ
        [2020�� 3���� ���Ե� ��ǰ]
        SELECT A.BUY_PROD AS ��ǰ��ȣ,
               B.PROD_NAME AS ��ǰ��,
               B.PROD_COST AS ���԰�,
               B.PROD_PRICE AS ���Ⱑ
        FROM BUYPROD A, PROD B
        WHERE A.BUY_PROD=B.PROD_ID
            AND A.BUY_DATE BETWEEN TO_DATE('20200301') AND TO_DATE('20200331')
    INTERSECT
        SELECT DISTINCT A.CART_PROD,
               B.PROD_NAME,
               B.PROD_COST,
               B.PROD_PRICE
        FROM CART A, PROD B
        WHERE A.CART_PROD=B.PROD_ID
            AND A.CART_NO LIKE '202004%'
            [2020�� 4���� �Ǹŵ� ��ǰ]
            
3. MINUS
    - ���ʿ� ����� ���տ��� �����ʿ� ����� ������ �� ���(������)�� ��ȯ
    
    ��뿹)
    (1)2020�� 6���� 7���� �Ǹŵ� ��ǰ �� 6������ �Ǹŵ� ��ǰ�� ��ȸ�Ͻÿ�.
        SELECT DISTINCT B.PROD_ID AS ��ǰ��ȣ,
               B.PROD_NAME AS ��ǰ��
        FROM CART A, PROD B
        WHERE A.CART_PROD = B.PROD_ID
            AND A.CART_NO LIKE '202006%'
    MINUS
        SELECT B.PROD_ID,
               B.PROD_NAME
        FROM CART A, PROD B
        WHERE A.CART_PROD = B.PROD_ID
            AND A.CART_NO LIKE '202007%'
            
        �������� ���
        SELECT DISTINCT B.PROD_ID AS,
               B.PROD_NAME AS
        FROM CART A, PROD B
        WHERE A.CART_PROD = B.PROD_ID
            AND A.CART_NO LIKE '202006%'
            AND A.CART_PROD NOT IN(SELECT CART_PROD
                                   FROM CART
                                   WHERE CART_NO LIKE '202007%')
        �����հ���
        SELECT CART_PROD
        FROM CART
        WHERE CART_NO LIKE '202007%'
    INTERSECT
        SELECT CART_PROD
        FROM CART
        WHERE CART_NO LIKE '202006%'
            
   --------------------------------------------------------------------------     
   
    (2)������̺��� LAST_NAME�� 'K'�� ���۵ǰ� ������ 'SA_REP'�� �ƴ�
       ������� �����ȣ, �����, �����ڵ带 ��ȸ�Ͻÿ�
       
       SELECT EMPLOYEE_ID AS �����ȣ,
              EMP_NAME AS �����,
              JOB_ID AS �����ڵ�
       FROM HR.EMPLOYEES
       WHERE LAST_NAME LIKE 'K%'
       AND JOB_ID <> 'SA_REP'; -- !=�ᵵ��
       
       ���̳ʽ� ������
       SELECT EMPLOYEE_ID AS �����ȣ,
              EMP_NAME AS �����,
              JOB_ID AS �����ڵ�
       FROM HR.EMPLOYEES
       WHERE LAST_NAME LIKE 'K%'
    MINUS
       SELECT EMPLOYEE_ID,
              EMP_NAME,
              JOB_ID
       FROM HR.EMPLOYEES
       WHERE JOB_ID = 'SA_REP'
        