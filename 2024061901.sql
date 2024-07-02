2024-0619-01)����Ŭ �����Լ�
    - Ư�� �÷��� �������� ������ ���ϴ� �Լ�
    - RANK() OVER, DENSE_RANK OVER, ROW_NUMBER() OVER �� ����
    
    (�������)
      RANK() OVER(ORDER BY �÷��� [DESC|ASC] [,�÷��� [DESC|ASC],...])
    
    - RANK() OVER : �Ϲ����� ����(���� ���̸� ���� ����, ���� ���� ���� ������
                                ���� ����+���ϼ��� ������ ��)
    ex) 9,9,7,6,5,5,5,4  ���
    ���� 1 1 3 4 5 5 5 8
    
    - DENSE_RANK() OVER : ���� ���̸� ���� ����, ���� ���� ���� ������ ���� ���� +1
    ex) 9,9,7,6,5,5,5,4  ���
    ���� 1 1 2 3 4 4 4 5
    
    -ROW_NUMBER() OVER : ���� �� ���� ���� ������� ���ʴ�� ���� �ο�
    ex) 9,9,7,6,5,5,5,4  ���
    ���� 1 2 3 4 5 6 7 8
    
    ��뿹) 
    
    (1) ������̺��� 80�� �μ��� ��� �� �޿� ������ ������ �ο��Ͻÿ�
            ALIAS�� �����ȣ, �����, �޿�, ����
            SELECT EMPLOYEE_ID AS �����ȣ,
                   EMP_NAME AS �����,
                   HIRE_DATE AS �Ի���,
                   SALARY AS �޿�,
                   RANK() OVER(ORDER BY SALARY DESC, HIRE_DATE ) AS ����
            FROM EMPLOYEES
            WHERE DEPARTMENT_ID =80;
            
    
    (2) ��ǰ���̺��� �з��ڵ� 'P101'�� ���� ��ǰ���� �ǸŰ��� ������ ������ �ο��Ͻÿ�
        ALIAS ��ǰ��ȣ, ��ǰ��, �ǸŰ���, ����
        
        SELECT PROD_ID AS ��ǰ��ȣ,
               PROD_NAME AS ��ǰ��,
               PROD_PRICE AS �ǸŰ���,
               RANK() OVER(ORDER BY PROD_PRICE) AS ����
        FROM PROD
        WHERE PROD_LGU = 'P101'
        
    (3) 2020�� ���� ������ ����ϰ� ������ �ο��Ͻÿ�
        
        SELECT EXTRACT(MONTH FROM BUY_DATE)||'��' AS �� ,
               TO_CHAR(SUM(BUY_QTY * BUY_COST), '999,999,999,999') AS ���Աݾ�,
               RANK() OVER(ORDER BY SUM(BUY_QTY*BUY_COST) DESC) AS ����
        FROM BUYPROD
        WHERE EXTRACT(YEAR FROM BUY_DATE) = 2020
        GROUP BY EXTRACT(MONTH FROM BUY_DATE)
        
    
    (4) 2020�� ��ݱ�(1~6��) ���ž� �������� ���Ÿ� ���� ������ ȸ���� 5���� ��ȸ�Ͻÿ�
        ALIAS ȸ����ȣ, ȸ����, ���ž�, ����
        
        SELECT TBLA.AID AS ȸ����ȣ,
               TBLA.ANAME AS ȸ����,
               TBLA.ASUM AS ���ž�,
               TBLA.ARANK AS ����
        FROM     (SELECT A.CART_MEMBER AS AID,
                         C.MEM_NAME AS ANAME,
                         SUM(A.CART_QTY*B.PROD_PRICE) AS ASUM,
                         RANK() OVER(ORDER BY SUM(A.CART_QTY*B.PROD_PRICE) DESC) AS ARANK
                  FROM CART A, PROD B, MEMBER C
                  WHERE A.CART_PROD=B.PROD_ID AND
                        A.CART_MEMBER = C.MEM_ID
                        AND SUBSTR(A.CART_NO,1,6) BETWEEN '202001' AND '202006'
                  GROUP BY A.CART_MEMBER, C.MEM_NAME) TBLA
        WHERE ROWNUM <= 5
        
        
    - �׷쳻 ����
    (�������)
    RANK() OVER(PARTITION BY �÷��� [,�÷���,...] ORDER BY �÷��� [DESC|ASC]
                [�÷��� [DESC|ASC] , ...])
                
    ��뿹)
    (1) ������̺��� �� �μ��� �޿��� �������� ������ �ο��Ͻÿ�.
        Alias �����ȣ, �����, �μ���ȣ, �޿�, ����
        �μ��ڵ� ������ ���
        
        SELECT EMPLOYEE_ID AS �����ȣ,
               EMP_NAME AS �����,
               DEPARTMENT_ID AS �μ���ȣ,
               SALARY AS �޿�,
               RANK() OVER(PARTITION BY DEPARTMENT_ID ORDER BY SALARY DESC) AS ����
        FROM EMPLOYEES
        ORDER BY 3
    
    (2) ��ǰ���̺��� �з��ڵ庰 ���԰��� ������ ������ �ο��Ͻÿ�.
        Alias�� �з��ڵ�, ��ǰ��, ���԰���, ����
        
        SELECT PROD_LGU AS �з��ڵ�,
               RROD_NAME AS ��ǰ��,
               TO_CHAR(SUM(PROD_COST),'999,999,999') AS "���� �� ����",
               RANK() OVER (PARTITION BY PROD_LGU ORDER_BY SUM(PROD_COST) DESC) AS ����
        FROM PROD
        GROUP BY PROD_LGU, PROD_NAME
        ORDER BY 1
        