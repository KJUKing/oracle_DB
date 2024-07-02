2024-0618-01) �����Լ�
    - ������ Ư�� �÷��� �������� �з��� �� �� �׷쿡 ������ �� �ִ� �Լ�
    - �������� ����� ��ȯ
    - SUM(co1), AVG(co2), MAX(co1), MIN(co1), COUNT(*|co1)
    (�������)
    SELECT �÷���1|SUM(co1)|AVG(co2)|MAX(co1)|MIN(co1)|COUNT(*|co1)
    
    FROM ���̺��
    [WHERE ����]
    GROUP BY �÷���1 [,�÷���2,...]
    [HAVING ����]
    [ORDER BY �÷���|�÷��ε��� [ASC|DESC],...];
    . SELECT���� �����Լ��� ������ �Ϲ� �÷��� ���Ǹ� �ݵ�� GROUP BY ���� ���
      SELECT���� ����� �Ϲ� �÷��� ��� GROUP BY���� ����Ǿ�� ��
      SELECT���� �����Լ��� ���� ��� GROUP BY�� ����
      �����Լ��� ������ �ο��� ��� HAVING���� ó���ؾ���
      COUNT�Լ��� �Ű������� '*'�� �÷����� ����� �� �ִ�.
      - '*'�� ����ϸ� NULL�� ������ �൵ ī��Ʈ�Ǿ� ��ȯ
      - �÷����� ����ϸ� �÷��� NULL�� �ƴҶ��� ī��Ʈ ��.
      - �ܺ����ο� COUNT�� ���ɶ��� �⺻Ű�� '�÷���'�� ����ϸ�,
        ������ ���������� '*'�� ����ص� ������ ��� ��ȯ
    
    ��뿹)
      (1) ������̺��� ��ü ������� ��ȸ�Ͻÿ�
        SELECT COUNT(*) AS �����,
                COUNT(EMPLOYEE_ID) AS �����2,
                ROUND(AVG(SALARY),1) AS ����ӱ�,
                SUM(SALARY) AS �ӱ��հ�
            FROM HR.EMPLOYEES;
      (2) ��ǰ���̺� ����� ��ǰ�� ���� ��ȸ�Ͻÿ�
       
        SELECT SUM(PROD_PROPERSTOCK) AS "��ǰ�� ��"
        FROM PROD
  
      
      
      (3) ȸ�����̺� ����� ȸ������ ��ȸ�Ͻÿ�
      
        SELECT COUNT(MEM_ID) AS ȸ����
        FROM MEMBER        
      
      (4) 2020�� 3�� ���Ի�ǰ�� ���� ��ȸ�Ͻÿ�
      
        SELECT COUNT(DISTINCT BUY_PROD) AS ���Ի�ǰ�Ǽ�
            FROM BUYPROD
            WHERE BUY_DATE BETWEEN ('20200301') AND ('20200331');
      
      (4-1) ȸ�����̺��� ȸ������ ������ ������ ���� ����Ͻÿ�
            
        SELECT COUNT(DISTINCT SUBSTR(MEM_ADD1,1,2)) AS ������
        FROM MEMBER;
        
      (5) ������̺��� �� �μ��� ������� ��ձ޿��� ��ȸ�Ͻÿ�
      
        SELECT DEPARTMENT_ID AS �μ���ȣ, COUNT(*) AS ����� , ROUND(AVG(SALARY),1) AS ��ձ޿�
            FROM EMPLOYEES
            GROUP BY DEPARTMENT_ID
       
        SELECT A.DEPARTMENT_ID AS �μ���ȣ,
               B.DEPARTMENT_NAME AS �μ���, 
               COUNT(*) AS �����, 
               ROUND(AVG(SALARY),1) AS ��ձ޿�
            FROM EMPLOYEES A, DEPARTMENTS B
            WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
            GROUP BY A.DEPARTMENT_ID,B.DEPARTMENT_NAME
            ORDER BY 1;
       
            
      (5-1) ��ǰ���̺� ����� �з��� ��ǰ�� ���� ��ȸ�Ͻÿ�
      
        SELECT  PROD_LGU,
                COUNT(*) AS "��ǰ�� ��"
            FROM PROD
            GROUP BY PROD_LGU
        
      (6) 2020�� ���� ���Լ����հ�� ���Աݾ��հ踦 ��ȸ�Ͻÿ�
      
        SELECT EXTRACT(MONTH FROM BUY_DATE)||'��' AS �� ,
                SUM(BUY_QTY) AS ���Լ����հ�,
                SUM(BUY_QTY*BUY_COST) AS ���Աݾ��հ�
        FROM BUYPROD
        WHERE EXTRACT(YEAR FROM BUY_DATE) = 2020
        GROUP BY EXTRACT(MONTH FROM BUY_DATE)
        ORDER BY 1;
        
      (7) 2020�� ���� ȸ���� ���Լ����հ踦 ���Ͻÿ�
      
      SELECT SUBSTR(CART_NO,5,2) AS ��,
            CART_MEMBER AS ȸ����ȣ,
            SUM(CART_QTY) AS ���ż����հ�
        FROM CART
        WHERE SUBSTR (CART_NO,1,4)='2020'
        GROUP BY SUBSTR(CART_NO,5,2),CART_MEMBER
        ORDER BY 1, 3 DESC; -- 1��°�� ��� -- 2��°�� �𼾵� ����
      
      (8) 2020�� ��ǰ�� ���Աݾ��� ���ϰ� �ݾ��� 1000���� �̻��� ��ǰ�� ��ȸ�Ͻÿ�
      
       SELECT EXTRACT(YEAR FROM BUY_DATE) AS �� ,
                BUY_PROD AS ��ǰ,
                SUM(BUY_QTY*BUY_COST) AS ���Աݾ��հ�
        FROM BUYPROD
        WHERE EXTRACT(YEAR FROM BUY_DATE) = 2020
        GROUP BY EXTRACT(YEAR FROM BUY_DATE), BUY_PROD
        HAVING SUM(BUY_COST*BUY_QTY) >= 10000000
        ORDER BY 1;
      
      (9) ������� 5�� �̻��� �μ���ȣ�� ��ȸ�Ͻÿ�
      
        SELECT DEPARTMENT_ID �μ���ȣ,
                COUNT(*) AS �����
        FROM EMPLOYEES
        GROUP BY DEPARTMENT_ID
        HAVING COUNT(*) > 5
        ORDER BY 2 DESC;
 
        
      
      (10) ȸ�����̺��� ���� ���ϸ��� �հ�� ��� ���ϸ����� ���Ͻÿ�
      SELECT
            CASE WHEN SUBSTR(MEM_REGNO2, 1, 1) IN ('1', '3') THEN '����'
                 WHEN SUBSTR(MEM_REGNO2, 1, 1) IN ('2', '4') THEN '����'
            END AS ����,
            SUM(MEM_MILEAGE) AS "���ϸ��� �հ�",
            TRUNC(AVG(MEM_MILEAGE)) AS "���ϸ��� ���"
      FROM MEMBER
      GROUP BY
            CASE WHEN SUBSTR(MEM_REGNO2, 1, 1) IN ('1', '3') THEN '����'
                 WHEN SUBSTR(MEM_REGNO2, 1, 1) IN ('2', '4') THEN '����'
            END;

      (11) ȸ�����̺��� ���ɴ뺰 ��ո��ϸ����� ȸ������ ��ȸ�Ͻÿ�
      
      SELECT
            TRUNC((EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR))/10)*10||'��' AS ���ɴ�,
            ROUND(AVG(MEM_MILEAGE)) AS "��� ���ϸ���",
            COUNT(MEM_ID) AS ȸ����
            
      FROM MEMBER
      GROUP BY TRUNC((EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR))/10)*10
      ORDER BY 1, 2 DESC;
      
      (12) ȸ�����̺��� �������� ȸ������ ��ȸ�Ͻÿ�
      SELECT DISTINCT SUBSTR(MEM_ADD1, 1,2) AS ����,
      COUNT(MEM_ID) AS ȸ����
            
      FROM MEMBER
      GROUP BY SUBSTR(MEM_ADD1, 1,2)
      ORDER BY 2;
      