2024-0621-03) ��������
    - ���� ���� �� �ٸ� ������ ���������� ��
    - �˷����� ���� �������� �����͸� �˻��� �� ���
    - �ݵ�� (  )�ȿ� ����ؾ���
        -������ INSERT�� CREATE ������ ��ȣ �����������
    - �������� ���Ǵ� ���������� '=' ������ ������ ���Ǿ�� ��
    - ���������� ORDER BY ���� �������� ����
    - ��������� �ش� ���� ����� �� ���� ���� �����
    - ����
        . ������ �ִ� ��������/ ������ ���� ��������
        . �Ϲ� ��������(SELECT)/��ø ��������(WHERE)/�ζ��� ��������(FROM)
        . ������ ��������/������ ��������/(�����÷�/�����÷�)
        
        
    ��뿹
        (1) ������̺��� ������� ��ձ޿����� ���� �޿��� �޴� �����
            �����ȣ, �����, �޿��� ��ȸ�Ͻÿ�.
            [�������� : ������� ��� �޿�]
            SELECT AVG(SALARY)
            FROM HR.EMPLOYEES
            [�������� : ����� �����ȣ, �����, �޿��� ��ȸ]
            SELECT EMPLOYEE_ID AS �����ȣ,
                   EMP_NAME AS �����,
                   SALARY AS �޿�
            FROM HR.EMPLOYEES
            WHERE SALARY > (��ձ޿�:��������)
            [����]
            SELECT EMPLOYEE_ID AS �����ȣ,
                   EMP_NAME AS �����,
                   SALARY AS �޿�,
                   (SELECT ROUND(AVG(SALARY))
                    FROM HR.EMPLOYEES) AS ��ձ޿�
            FROM HR.EMPLOYEES
            WHERE SALARY > (SELECT AVG(SALARY)
                            FROM HR.EMPLOYEES)
                            
                            
            SELECT A.EMPLOYEE_ID AS �����ȣ,
                   A.EMP_NAME AS �����,
                   A.SALARY AS �޿�,
                   ROUND(B.SAL) AS ��ձ޿�
            FROM HR.EMPLOYEES A, (SELECT AVG(SALARY) AS SAL
                                  FROM HR.EMPLOYEES) B
            WHERE SALARY > (B.SAL)
        
        (2) ������� ��ձ޿����� �� ���� �޿��� �޴� ������� �ٹ��ϴ� �μ��� ��ȸ�Ͻÿ�.
            alias �μ���ȣ, �μ���, å�ӻ���̸�
            [�������� : ��ձ޿�]
            SELECT AVG(SALARY)
            FROM HR.EMPLOYEES
            
            [�������� : �μ���ȸ]
            SELECT A.DEPARTMENT_ID AS �μ���ȣ,
                   A.DEPARTMENT_NAME AS �μ���,
                   B.EMP_NAME AS å�ӻ���̸�
            FROM HR.DEPARTMENTS A, HR.EMPLOYEES B
            WHERE A.MANAGER_ID = B.EMPLOYEE_ID
                AND B.SALARY > (��������)
                
            [����]
            SELECT A.DEPARTMENT_ID AS �μ���ȣ,
                   A.DEPARTMENT_NAME AS �μ���,
                   B.EMP_NAME AS å�ӻ���̸�
            FROM HR.DEPARTMENTS A, HR.EMPLOYEES B
            WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                AND A.MANAGER_ID = B.EMPLOYEE_ID
                AND B.SALARY > (SELECT AVG(SALARY)
                                FROM HR.EMPLOYEES)
                
            SELECT A.DEPARTMENT_ID AS �μ���ȣ,
                  A.DEPARTMENT_NAME AS �μ���,
                   B.EMP_NAME AS å�ӻ���̸�
            FROM HR.DEPARTMENTS A, HR.EMPLOYEES B
            WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                AND A.MANAGER_ID = B.EMPLOYEE_ID
                AND EXISTS (SELECT 1
                            FROM HR.EMPLOYEES C
                            WHERE C.SALARY > (SELECT AVG(D.SALARY)
                                              FROM HR.EMPLOYEES D
                                              AND C.DEPARTMENT_ID = A.DEPARTMENT_ID) 
            --EXISTS�� �����ʿ� �ݵ�� ���������� ����
            --���� �߿������ʰ� ������ 1���� ���̶�� ����
            
        
        (3) ȸ�����̺��� ȸ������ ��� ���ϸ������� ���� ���ϸ����� ������ ȸ����
            ȸ����ȣ, ȸ����, ���ϸ����� ��ȸ�Ͻÿ�.
            
            SELECT M.MEM_ID AS ȸ����ȣ,
                   M.MEM_NAME AS ȸ����,
                   M.MILEAGE AS ���ϸ���
            FROM MEMBER M, (SELECT MEM_ID AS AID,
                                   AVG(MEM_MILEAGE) AS AMILE
                            FROM MEMBER) A
            WHERE M.MEM ID = A.
                AND M.MILEAGE > A.AMILE
                   
                   
            SELECT A.EMPLOYEE_ID AS �����ȣ,
                   A.EMP_NAME AS �����,
                   A.DEPARTMENT_ID AS �μ���ȣ,
                   B.DEPARTMENT_NAME AS �μ���,
                   C.ASAL AS �μ���ձ޿�,
                   A.SALARY AS �޿�
            FROM HR.EMPLOYEES A, HR.DEPARTMENTS B,
                                                  (SELECT DEPARTMENT_ID,
                                                   ROUND(AVG(SALARY)) AS ASAL
                                                   FROM HR.EMPLOYEES
                                                   GROUP BY DEPARTMENT_ID) C
            WHERE A.SALARY > C.ASAL
                AND A.DEPARTMENT_ID=C.DEPARTMENT_ID
                AND A.DEPARTMENT_ID=B.DEPARTMENT_ID
            ORDER BY 3,6
                
            
        (4) 2020�� 5�� ���� ���� ���Ÿ� �� ȸ�� 3���� ȸ����ȣ, ȸ����, ����, ���ϸ���,
            ������ ��ȸ�Ͻÿ�.
            
            [�������� : 2020�� 5�� ���� ���� ���Ÿ� �� ȸ�� 3���� ȸ����ȣ]
            SELECT C.AID
            FROM (SELECT A.CART_MEMBER AS AID,
                         SUM(A.CART_QTY*B.PROD_PRICE) AS ���űݾ��հ�
                  FROM CART A, PROD B
                  WHERE A.CART_PROD = B.PROD_ID
                    AND A.CART_NO LIKE '202005%'
                  GROUP BY A.CART_MEMBER
                  ORDER BY 2 DESC) C
            WHERE ROWNUM<=3
            
            [�������� : �������� ����� ȸ������ ȸ����ȣ, ȸ����, ����, ���ϸ���, ����]
            SELECT M.MEM_ID AS ȸ����ȣ,
                   M.MEM_NAME AS ȸ����,
                   M.MEM_JOB AS ����,
                   M.MEM_MILEAGE���ϸ���,
                   CASE WHEN SUBSTR(M.MEM_REGNO2,1,) IN('2','4') THEN 
                        '����'
                   ELSE
                        '����'
                   END AS ����
            FROM MEMBER M,
                (��������) D
            WHERE M.MEM_ID = D.ȸ����ȣ
            
            [����]
            SELECT M.MEM_ID AS ȸ����ȣ,
                   M.MEM_NAME AS ȸ����,
                   M.MEM_JOB AS ����,
                   M.MEM_MILEAGE AS ���ϸ���,
                   CASE WHEN SUBSTR(M.MEM_REGNO2,1,1) IN('2','4') THEN 
                        '����'
                   ELSE
                        '����'
                   END AS ����
            FROM MEMBER M,
                (SELECT C.AID AS CID
                 FROM (SELECT A.CART_MEMBER AS AID,
                              SUM(A.CART_QTY*B.PROD_PRICE) AS ���űݾ��հ�
                       FROM CART A, PROD B
                       WHERE A.CART_PROD = B.PROD_ID
                         AND A.CART_NO LIKE '202005%'
                       GROUP BY A.CART_MEMBER
                       ORDER BY 2 DESC) C
                 WHERE ROWNUM<=3) D
            WHERE M.MEM_ID = D.CID
            
            
            
            
        (5) ������̺��� �ڱ�μ��� ��ձ޿����� �� ���� �޿��� �޴� ����� �����ȣ,
            �����, �μ���ȣ, �μ���, �μ���ձ޿�, �޿��� ��ȸ�Ͻÿ�.
            
            
            SELECT A.EMPLOYEE_ID AS �����ȣ,
                   A.EMP_NAME AS �����,
                   A.DEPARTMENT_ID AS �μ���ȣ,
                   B.DEPARTMENT_NAME AS �μ���,
                   C.ASAL AS �μ���ձ޿�,
                   A.SALARY AS �޿�
            FROM HR.EMPLOYEES A, HR.DEPARTMENTS B,
                                                  (SELECT DEPARTMENT_ID,
                                                   ROUND(AVG(SALARY)) AS ASAL
                                                   FROM HR.EMPLOYEES
                                                   GROUP BY DEPARTMENT_ID) C
            WHERE A.SALARY > C.ASAL
                AND A.DEPARTMENT_ID=C.DEPARTMENT_ID
                AND A.DEPARTMENT_ID=B.DEPARTMENT_ID
            ORDER BY 3,6

             
    ������ WHERE���� �����ϴ� SQL �����
    
    
            SELECT A.EMPLOYEE_ID AS �����ȣ,
                   A.EMP_NAME AS �����,
                   A.DEPARTMENT_ID AS �μ���ȣ,
                   B.DEPARTMENT_NAME AS �μ���,
                   A.SALARY AS �޿�
            FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
            WHERE A.SALARY > (SELECT DEPARTMENT_ID,
                                     ROUND(AVG(SALARY)) AS ASAL
                              FROM HR.EMPLOYEES
                              GROUP BY DEPARTMENT_ID)
                AND A.DEPARTMENT_ID=B.DEPARTMENT_ID
                
            SELECT A.EMPLOYEE_ID AS �����ȣ,
                   A.EMP_NAME AS �����,
                   A.DEPARTMENT_ID AS �μ���ȣ,
                   B.DEPARTMENT_NAME AS �μ���,
                   ROUND(AVG(A.SALARY)) AS ��ձ޿�,
                   A.SALARY AS �޿�
            FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
            WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
                AND A.SALARY > (SELECT ROUND(AVG(SALARY))
                                FROM HR.EMPLOYEES
                                WHERE DEPARTMENT_ID = A.DEPARTMENT_ID)
            GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME, A.EMPLOYEE_ID, A.EMP_NAME,
                     A.SALARY
            
** ���������̺� ����
  1. ���̺�� : REMAIN
  2. �÷�
  
   �÷���          ������ Ÿ��             �⺻��          pk/fk
   -------------------------------------------------------------------
  REMAIN_YEAR     CHAR(4)                                 PK
  PROD_ID         VARCHAR2(10)                          PK & FK
  REMAIN_J_00     NUMBER(5)               0             --�������
  REMAIN_I        NUMBER(5)               0             --�԰�
  REMAIN_O        NUMBER(5)               0             --���
  REMAIN_J_99     NUMBER(5)               0             --����� (�������+�԰� -���)
  REMAIN_DATE     DATE                                  --����� �߻���¥
  