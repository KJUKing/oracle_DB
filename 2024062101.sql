2024-0621-01) �ܺ�����
    - ���������� ���������� �����ϴ� �ุ���� ������ ����ǰ�
      �ܺ������� ���������� �������� �ʴ� ����� �˻��ǰ��ϴ� ���� ����
    - ���������� �������� �ʴ� ���̺� NULL���� �߰��Ͽ� ���� ����
    (�Ϲ� �ܺ����� �������)
        SELECT �÷�list
        FROM ���̺�1 [��Ī1], ���̺�2 [��Ī2],...
        WHERE ��Ī1.�÷�=��Ī2.�÷���(+)...
    - �Ϲ� �ܺ����� �����ڴ� '(+)'�̸�,
      �ڷᰡ ������ ���̺��� �÷��� �߰���
    - �ܺ����� ������ �������϶� ��� �������ǿ� '(+)'�� ����ؾ���
    - 3���̻��� ���̺��� ���꿡 �����Ѱ�� �� ���̺��� �ܺ����ο� ���ÿ� ������ �� ����.
      ��, A, B, C���̺��� �ܺ����� �Ǵ� ��� �������ǿ� A=B(+) AND C=B(+)�� ������ ����
    - �Ϲ� �ܺ� ���ΰ� �Ϲ������� ���ÿ� ����Ǹ� ������������ ����Ǿ�
      ����� ��ȯ(�ذ� : �������� ��� �Ǵ� ANSI�ܺ����� ���)
      
      (ANSI �������)
        SELECT �÷�list
        FROM ���̺�1 [��Ī1]
        LEFT|RIGHT|FULL OUTER JOIN ���̺�2 [��Ī2] ON(�������� [AND �Ϲ�����])
        LEFT|RIGHT|FULL OUTER JOIN ���̺�3 [��Ī3] ON(�������� [AND �Ϲ�����])
        
        [WHERE �Ϲ�����];
            . 'LEFT': ���̺�1�� �ڷᰡ ���̺�2�� �ڷẸ�� ���� ���
            . 'RIGHT': ���̺�2�� �ڷᰡ ���̺�1�� �ڷẸ�� ���� ���
            . 'FULL': ���� ���̺� ��� �ڷᰡ ������ ���
            . 'WHERE �Ϲ�����'�� ����ϸ� �ܺ����� ����� �Ϲ������� ����Ǿ� ���ϴ� ����� ������ ����
    ��뿹
        (1) NULL�μ��ڵ带 �����ϰ� ��� �μ��� �ο����� ��ȸ�Ͻÿ�
        SELECT B.DEPARTMENT_ID AS �μ��ڵ�,
               B.DEPARTMENT_NAME AS �μ���,
               COUNT(A.EMPLOYEE_ID) AS �ο���
        FROM EMPLOYEES A, DEPARTMENTS B
        WHERE A.DEPARTMENT_ID(+) = B.DEPARTMENT_ID
        GROUP BY B.DEPARTMENT_ID, B.DEPARTMENT_NAME
        ORDER BY 1;
        
        (ANSI)
        SELECT B.DEPARTMENT_ID AS �μ��ڵ�,
               B.DEPARTMENT_NAME AS �μ���,
               COUNT(A.EMPLOYEE_ID) AS �ο���
        FROM EMPLOYEES A
        RIGHT OUTER JOIN DEPARTMENTS B ON(A.DEPARTMENT_ID = B.DEPARTMENT_ID)
        GROUP BY B.DEPARTMENT_ID, B.DEPARTMENT_NAME
        ORDER BY 1;
        
        
        (2) 2020�� 1�� ��� ��ǰ�� ���Աݾ��� ��ȸ
        SELECT B.PROD_ID AS ��ǰ��ȣ,
               B.PROD_NAME AS ��ǰ��,
               SUM(A.BUY_QTY*B.PROD_COST) AS ���Աݾ�
        FROM BUYPROD A, PROD B
        WHERE A.BUY_PROD(+)=B.PROD_ID
          AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
        GROUP BY B.PROD_ID, B.PROD_NAME
        ORDER BY 1;
        
        
        (ANSI)
        SELECT B.PROD_ID AS ��ǰ��ȣ,
               B.PROD_NAME AS ��ǰ��,
               NVL(SUM(A.BUY_QTY*B.PROD_COST),0) AS ���Աݾ�
        FROM BUYPROD A
        RIGHT OUTER JOIN PROD B ON (A.BUY_PROD =B.PROD_ID
                                    AND A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131'))
        GROUP BY B.PROD_ID, B.PROD_NAME
        ORDER BY 1;
        
        (SUBQUERY)
        SELECT P.PROD_ID AS ��ǰ��ȣ,
               P.PROD_NAME AS ��ǰ��,
               NVL(R.BSUM,0) AS ���Աݾ�
        FROM  (     SELECT A.BUY_PROD AS BID,
                    SUM(A.BUY_QTY*B.PROD_COST) AS BSUM
                    FROM BUYPROD A, PROD B
                    WHERE A.BUY_DATE BETWEEN TO_DATE('20200101') AND TO_DATE('20200131')
                        AND A.BUY_PROD=B.PROD_ID
                    GROUP BY A.BUY_PROD) R, PROD P
        WHERE P.PROD_ID=R.BID(+)
        ORDER BY 1;
        
        
        (3) 2020�� ��� ��ǰ�� ����/���� ������ ��ȸ�Ͻÿ�
        (���� ANSI)
        SELECT B.PROD_ID AS ��ǰ�ڵ�,
               B.PROD_NAME AS ��ǰ��,
               SUM(B.PROD_COST * A.BUY_QTY) AS ���Աݾ��հ�
        FROM BUYPROD A
        RIGHT OUTER JOIN PROD B ON(A.BUY_PROD = B.PROD_ID
                                   AND EXTRACT(YEAR FROM A.BUY_DATE)=2020)
        GROUP BY B.PROD_ID, B.PROD_NAME
        ORDER BY 1;
        
        (���� ANSI)
        SELECT B.PROD_ID AS ��ǰ�ڵ�,
               B.PROD_NAME AS ��ǰ��,
               SUM(B.PROD_PRICE * A.CART_QTY) AS ����ݾ��հ�
        FROM CART A
        RIGHT OUTER JOIN PROD B ON(A.CART_PROD = B.PROD_ID
                                   AND A.CART_NO LIKE '2020%')
        GROUP BY B.PROD_ID, B.PROD_NAME
        ORDER BY 1;
        
        (����/���� ��ġ��)
        
        SELECT 
        FROM   (SELECT B.PROD_ID AS BID,
                       SUM(B.PROD_COST * A.BUY_QTY) AS BSUM
                FROM PROD B
                LEFT OUTER JOIN BUYPROD A ON (A.BUY_PROD = B.PROD_ID
                    AND EXTRACT(YEAR FROM A.BUY_DATE)=2020)
                GROUP BY B.PROD_ID)TA,
                
                (SEL
        FROM BUYPROD A

        LEFT OUTER JOIN CART C ON (B.PROD_ID=C.CART_PROD
                                   AND C.CART_NO LIKE '2020%')
        GROUP BY B.PROD_ID, B.PROD_NAME
        ORDER BY 1;
        
        
        
        
        SELECT A.PROD_ID,
               A.PROD_NAME,
               B.BSUM,
               C.CSUM
        FROM PROD A, 
                (SELECT A.BUY_PROD AS BID, -- �������� B
                        SUM(A.BUY_QTY*B.PROD_COST) AS BSUM
                 FROM BUYPROD A, PROD B
                 WHERE A.BUY_PROD=B.PROD_ID
                    AND EXTRACT(YEAR FROM A.BUY_DATE)=2020
                 GROUP BY A.BUY_PROD) B, -- ��
                 
                (SELECT A.CART_PROD AS CID, -- �������� C
                        SUM(A.CART_QTY*B.PROD_PRICE) AS CSUM
                FROM CART A, PROD B
                WHERE A.CART_PROD=B.PROD_ID
                    AND CART_NO LIKE '2020%'
                GROUP BY A.CART_PROD) C -- ��
                
        WHERE A.PROD_ID=B.BID(+) -- ����
            AND A.PROD_ID=C.CID(+) -- ����
            
        ORDER BY 1;  
  
                
                
           
                