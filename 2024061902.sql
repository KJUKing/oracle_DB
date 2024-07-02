2024-0619-02) JOIN
    - ������ �����ͺ��̽����� ���� �߿��� ����
    - �ټ��� ���̺��� ������ �÷��� �̿��Ͽ� �ʿ��� �ڷḦ ��ȸ
    - ������ ����
     . �������� (INNER JOIN) / �ܺ����� (OUTER JOIN)
     . �Ϲ����� / �Ⱦ�����(ANSI JOIN)
     . �������� / �񵿵�����
     . SELF JOIN, CARTESIAN PRODUCT(CROSS JOIN)
     
     1. Cartesian Product(Cross Join)
        - ���������� �����Ǿ��ų� �߸� ������ ���
        - ����� ���� ���ϱ޼������� ����(���꿡 ������ ���̺��� ���� ��� ���� ���)
        - ����� ���� ���꿡 ������ ���̺��� ���� ��� ���� ����� ��
        - ��뿡 ���Ǹ� ����(�ݵ�� �ʿ��� ��츦 �����ϰ� ����� �����ؾ���)
        (ansi ����)
        SELECT �÷�list
        FROM ���̺��1 [��Ī1]
        CROSS JOIN ���̺��2 [��Ī2] [ON(��������)]
                        :
        [WHERE �Ϲ�����]
    ��뿹)
        SELECT COUNT(*) AS "BUYPROD"
        FROM BUYPROD;
        
        SELECT COUNT(*) AS "CART"
        FROM CART;
        
        SELECT (*)
        FROM CART, BUYPROD, PROD
        -- WHERE CART_PROD = BUY_PROD;
        
        (ANSI FORMAT)
        SELECT COUNT(*)
        FROM CART
        CROSS JOIN BUYPROD ON(CART_NO=BUY_PROD)
        CROSS JOIN PROD ON(CART_PROD=PROD_ID);
     
     1. ��������
        - ���� ������ �����ϴ� �ڷḸ�� ������� ��
        - ��������(Equi-Join) �� ��κ��� ���� ������ �̿� ���Ե�
     (�������)
        (1)�Ϲ� ��������
            SELECT �÷� LIST
            FROM    ���̺�1 [��Ī1]
            -- ���̺�1�� 2�� �ݵ�� ���������̵Ǿ����
            INNER JOIN ���̺�2 [��Ī2] ON [�������� [AND �Ϲ�����])
            [INNER JOIN ���̺�3 [��Ī3] ON [�������� [AND �Ϲ�����])]
            --���̺�3�� 1�� 2�� ���ΰ���� ���ε�
            WHERE ���� ����
             [AND ���� ����]
                    :
             [AND �Ϲ� ����]
             
    
    (1) HR ���� ������̺��� 50���μ��� ���� ����� �����ȣ, �����,�μ���ȣ,�μ����� 
    ����Ͻÿ�.
    (�Ϲ�����)
        SELECT EMPLOYEE_ID AS �����ȣ,
               EMP_NAME AS �����,
               DEPARTMENTS.DEPARTMENT_ID AS �μ���ȣ,
               DEPARTMENT_NAME AS �μ���
        FROM EMPLOYEES, DEPARTMENTS
        WHERE EMPLOYEES.DEPARTMENT_ID =50
          AND EMPLOYEES.DEPARTMENT_ID=DEPARTMENTS.DEPARTMENT_ID
          
        -> ����� ��Īȭ
        
        SELECT EMPLOYEE_ID AS �����ȣ,
               EMP_NAME AS �����,
               B.DEPARTMENT_ID AS �μ���ȣ,
               DEPARTMENT_NAME AS �μ���
        FROM EMPLOYEES A, DEPARTMENTS B
        WHERE A.DEPARTMENT_ID =50
          AND A.DEPARTMENT_ID= B.DEPARTMENT_ID
          
        -> �Ƚ�����
        
        SELECT EMPLOYEE_ID AS �����ȣ,
               EMP_NAME AS �����,
               B.DEPARTMENT_ID AS �μ���ȣ,
               DEPARTMENT_NAME AS �μ���
        FROM EMPLOYEES A
--        INNER JOIN DEPARTMENTS B ON(A.DEPARTMENT_ID =B.DEPARTMENT_ID)--��������
--        WHERE A.DEPARTMENT_ID =50--�Ϲ�����
        INNER JOIN DEPARTMENTS B ON(A.DEPARTMENT_ID =B.DEPARTMENT_ID
                    AND A.DEPARTMENT_ID =50); -- �Ϲ� ���� ���� ���ĵ���
          
          
    (2) 2020�� 5�� ȸ���� �������踦 ��ȸ�Ͻÿ�
    Alias�� ȸ����ȣ,ȸ����,���ż����հ�
    
    (�Ϲ�����)
        SELECT B.MEM_ID AS ȸ����ȣ,
               B.MEM_NAME AS ȸ����,
               SUM(A.CART_QTY) AS ���ż����հ�
        FROM    CART A, MEMBER B
        WHERE  A.CART_MEMBER = B.MEM_ID --��������
          AND  A.CART_NO LIKE '202005%' --�Ϲ�����
        GROUP BY B.MEM_ID, B.MEM_NAME
        
    (�Ƚ�����)
        SELECT B.MEM_ID AS ȸ����ȣ,
               B.MEM_NAME AS ȸ����,
               SUM(A.CART_QTY) AS ���ż����հ�
        FROM    CART A
        INNER  JOIN MEMBER B ON(A.CART_MEMBER = B.MEM_ID)
        WHERE  A.CART_NO LIKE '202005%' --�Ϲ�����
        GROUP BY B.MEM_ID, B.MEM_NAME
        ORDER BY 1;
        
        
    (3) 2020�� 2�� ��ǰ�� �������踦 ��ȸ�Ͻÿ�
    Alias �� ��ǰ��ȣ,��ǰ��,���Լ���,���Աݾ�
    
        SELECT A.PROD_ID AS ��ǰ��ȣ,
               A.PROD_NAME AS ��ǰ��,
               B.BUY_QTY AS ���Լ���,
               SUM(A.PROD_COST*B.BUY_QTY) AS ���Աݾ�
        FROM  PROD A, BUYPROD B
        WHERE  A.PROD_ID = B.BUY_PROD
          AND  EXTRACT(YEAR FROM A.PROD_INSDATE) =2020
          AND  EXTRACT(MONTH FROM A.PROD_INSDATE) =02
        GROUP BY A.PROD_ID, A.PROD_NAME, B.BUY_QTY
        ORDER BY 1;
        
    (�Ƚ�����)
        SELECT A.PROD_ID AS ��ǰ��ȣ,
               A.PROD_NAME AS ��ǰ��,
               B.BUY_QTY AS ���Լ���,
               SUM(A.PROD_COST*B.BUY_QTY) AS ���Աݾ�
        FROM  PROD A
        INNER JOIN BUYPROD B ON(A.PROD_ID = B.BUY_PROD)
        WHERE  EXTRACT(YEAR FROM A.PROD_INSDATE) =2020
          AND  EXTRACT(MONTH FROM A.PROD_INSDATE) =02
        GROUP BY A.PROD_ID, A.PROD_NAME, B.BUY_QTY
        ORDER BY 1;
        

    (4) HR������ �� �μ��� ������� ��ձ޿��� ��ȸ�Ͻÿ�.
    Alias�� �μ���ȣ,�μ���,�����,��ձ޿�
    
        SELECT A.DEPARTMENT_ID AS �μ���ȣ,
               B.DEPARTMENT_NAME AS �μ���,
               COUNT(A.EMP_NAME) AS �����,
               ROUND(AVG(A.SALARY)) AS ��ձ޿�
        FROM EMPLOYEES A, DEPARTMENTS B
        WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
        GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME;
        
-- ����� ���: SUM(A.EMP_NAME)���� A.EMP_NAME�� �Ϲ������� ����� �̸��̳� �ĺ��ڸ� ��Ÿ���� ������ ���Դϴ�. �Ϲ������� ����� ���� ���� ���� COUNT �Լ��� ����ؾ� �մϴ�.
-- ��ձ޿� ���: AVG(A.SALARY)�� ���� �Լ��̹Ƿ� �̸� ����� ���� GROUP BY ������ ���Ե� �� �����ϴ�.

    (5) 2020�� 6�� ȸ���� ��ǰ�� �Ǹ����踦 ��ȸ�Ͻÿ�
    Alias�� ȸ����ȣ, ȸ����, ��ǰ��, ���ż���, ���űݾ�
    
        SELECT A.MEM_ID AS ȸ����ȣ,
               A.MEM_NAME AS ȸ����,
               C.PROD_NAME AS ��ǰ��,
               COUNT(B.CART_QTY) AS ���ż���,
               SUM(B.CART_QTY * C.PROD_PRICE) AS ���űݾ�
        FROM  MEMBER A, CART B, PROD C
        WHERE A.MEM_ID = B.CART_MEMBER
          AND B.CART_PROD = C.PROD_ID
          AND SUBSTR(B.CART_NO, 1, 6)='202006'
        GROUP BY A.MEM_ID, A.MEM_NAME, C.PROD_NAME, B.CART_QTY
        ORDER BY 1;
        
    (�Ƚ�����)
    
        SELECT A.MEM_ID AS ȸ����ȣ,
               A.MEM_NAME AS ȸ����,
               C.PROD_NAME AS ��ǰ��,
               COUNT(B.CART_QTY) AS ���ż���,
               SUM(B.CART_QTY * C.PROD_PRICE) AS ���űݾ�
        FROM  MEMBER A
        INNER JOIN CART B ON(A.MEM_ID = B.CART_MEMBER)
        INNER JOIN PROD C ON(B.CART_PROD = C.PROD_ID)
        WHERE SUBSTR(B.CART_NO, 1, 6)='202006'
        GROUP BY A.MEM_ID, A.MEM_NAME, C.PROD_NAME, B.CART_QTY
        ORDER BY 1;

    (6) HR�������� �̱� �̿��� ���� ��ġ�� �μ��� ��ȸ�Ͻÿ�
    Alias�� �μ���ȣ,�μ���,�ּ�,�����
    �̱��� �����ڵ�='US'
    
        SELECT C.DEPARTMENT_ID AS �μ���ȣ,
               C.DEPARTMENT_NAME AS �μ���,
               B.STREET_ADDRESS||' '||B.CITY||' '||B.STATE_PROVINCE AS �ּ�,
               A.COUNTRY_NAME AS �����
        FROM   COUNTRIES A, LOCATIONS B, DEPARTMENTS C
        WHERE C.LOCATION_ID = B.LOCATION_ID
          AND B.COUNTRY_ID = A.COUNTRY_ID
          AND A.COUNTRY_ID != 'US'
        
        
    (�Ƚ� ����)
        SELECT C.DEPARTMENT_ID AS �μ���ȣ,
               C.DEPARTMENT_NAME AS �μ���,
               B.STREET_ADDRESS||' '||B.CITY||' '||B.STATE_PROVINCE AS �ּ�,
               A.COUNTRY_NAME AS �����
        FROM  COUNTRIES A
        INNER JOIN LOCATIONS B ON(B.COUNTRY_ID = A.COUNTRY_ID)
        INNER JOIN DEPARTMENTS C ON(C.LOCATION_ID = B.LOCATION_ID)
        WHERE A.COUNTRY_ID != 'US'
        
    (6-1) HR�������� �̱� �̿��� ���� ��ġ�� �μ��� �ٹ��ϴ� ������� ��ȸ�Ͻÿ�
    Alias�� �μ���ȣ,�μ���,�ּ�,�����
    �̱��� �����ڵ�='US'
    
        SELECT C.DEPARTMENT_ID AS �μ���ȣ,
               C.DEPARTMENT_NAME AS �μ���,
               D.EMP_NAME AS �����,
               B.STREET_ADDRESS||' '||B.CITY||' '||B.STATE_PROVINCE AS �ּ�,
               A.COUNTRY_NAME AS �����
        FROM   COUNTRIES A, LOCATIONS B, DEPARTMENTS C, EMPLOYEES D
        WHERE C.LOCATION_ID = B.LOCATION_ID
          AND B.COUNTRY_ID = A.COUNTRY_ID
          AND C.DEPARTMENT_ID = D.DEPARTMENT_ID
          AND A.COUNTRY_ID != 'US'
          
    (�Ƚ�����)
        SELECT C.DEPARTMENT_ID AS �μ���ȣ,
               C.DEPARTMENT_NAME AS �μ���,
               D.EMP_NAME AS �����,
               B.STREET_ADDRESS||' '||B.CITY||' '||B.STATE_PROVINCE AS �ּ�,
               A.COUNTRY_NAME AS �����
        FROM   COUNTRIES A
        INNER JOIN LOCATIONS B ON (B.COUNTRY_ID = A.COUNTRY_ID)
        INNER JOIN DEPARTMENTS C ON (C.LOCATION_ID = B.LOCATION_ID)
        INNER JOIN EMPLOYEES D ON (C.DEPARTMENT_ID = D.DEPARTMENT_ID)
        WHERE A.COUNTRY_ID != 'US'

    (7) 2020�� �ŷ�ó�� ��������踦 ��ȸ�Ͻÿ�
        
        SELECT A.BUYER_NAME AS �ŷ�ó��,
               A.BUYER_ID AS �ŷ�ó�ڵ�,
               SUM(B.PROD_PRICE * C.CART_QTY) AS �����
        FROM BUYER A, PROD B, CART C
        WHERE A.BUYER_ID = B.PROD_BUYER
        AND B.PROD_ID = C.CART_PROD
        AND SUBSTR(C.CART_NO, 1, 4) ='2020'
        GROUP BY A.BUYER_NAME, A.BUYER_ID
        
    (�Ƚ�����)
    
        SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
               A.BUYER_NAME AS �ŷ�ó��,
               SUM(B.PROD_PRICE * C.CART_QTY) AS �����
        FROM BUYER A
        INNER JOIN PROD B ON (A.BUYER_ID = B.PROD_BUYER)
        INNER JOIN CART C ON (B.PROD_ID = C.CART_PROD)
        WHERE C.CART_NO LIKE '2020%'
        GROUP BY A.BUYER_NAME, A.BUYER_ID


    (8) 2020�� ��ǰ�� ����/�������踦 ��ȸ�Ͻÿ�. 
    