2024-0626-01) ROLLUP�� CUBE
    - �پ��� ���踦 ��ȯ
    - �ݵ�� GROUP BY�� �ȿ� ����ؾ���
    1. ROLLUP
        (�������)
        SELECT �÷�list
        FROM �÷���
        [WHERE ����]
        GROUP BY [�÷���,...] CUBE|ROLLUP(�÷���1, �÷���2...�÷���n)[,�÷���,...]
        
        - ROLLUP(�÷���1, �÷���2,...�÷���n) : ���� �÷���1~�÷���n�� ��� ����� ���� ��ȯ �� �÷��� n����
          �ϳ��� ���ŵ� �÷����� ����� ���� ��ȯ
        - ���������� ��� �÷����� ���ŵ� ����(��ü ����)�� ��ȯ
        - ��� �÷��� ����� ��� �� ���������̶� �ϰ� �ϳ��� ������ ���� ���������̶�� �Ѵ�.
        - ROLLUP ��, �ڷ� �÷��� ���� �� �ְ� �̰�� �κ� ROLLUP �̶�� ��
        - ROLLUP�� ���� ������ ������ ���� �÷��� �� +1����
        
        - CUBE���� CUBE���� ���� �÷���� ������ �� �ִ� ��� ����� ���踦 ��ȯ��
        - CUBE���� ���� ������ ������ ���� (�÷��� ��)^2����
        - CUBE�� ���� ������ ����
        
    ��뿹)
        2020�� ����, ȸ����, ��ǰ�� �������踦 ��ȸ�Ͻÿ�.
        alias �� ȸ�� ��ȣ ��ǰ�ڵ� �����
        
        SELECT SUBSTR(A.CART_NO,5,2) AS ��, 
               A.CART_MEMBER AS ȸ����ȣ,
               A.CART_PROD AS ��ǰ�ڵ�,
               SUM(A.CART_QTY*B.PROD_PRICE) AS �����
        FROM CART A, PROD B
        WHERE A.CART_PROD = B.PROD_ID
            AND A.CART_NO LIKE '2020%'
        GROUP BY SUBSTR(A.CART_NO,5,2), A.CART_MEMBER, A.CART_PROD
        ORDER BY 1,2,3
        
        [�Ѿ��� ���]
        
        SELECT SUBSTR(A.CART_NO,5,2) AS ��, 
               A.CART_MEMBER AS ȸ����ȣ,
               A.CART_PROD AS ��ǰ�ڵ�,
               SUM(A.CART_QTY*B.PROD_PRICE) AS �����
        FROM CART A, PROD B
        WHERE A.CART_PROD = B.PROD_ID
            AND A.CART_NO LIKE '2020%'
        GROUP BY SUBSTR(A.CART_NO,5,2) ,ROLLUP(A.CART_MEMBER, A.CART_PROD)
        ORDER BY 1,2,3
        
        [ť���� ���]
        SELECT SUBSTR(A.CART_NO,5,2) AS ��, 
               A.CART_MEMBER AS ȸ����ȣ,
               A.CART_PROD AS ��ǰ�ڵ�,
               SUM(A.CART_QTY*B.PROD_PRICE) AS �����
        FROM CART A, PROD B
        WHERE A.CART_PROD = B.PROD_ID
            AND A.CART_NO LIKE '2020%'
        GROUP BY CUBE(SUBSTR(A.CART_NO,5,2), A.CART_MEMBER, A.CART_PROD)
        ORDER BY 1,2,3