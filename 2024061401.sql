2024-0614-01)�����Լ�
    - ������ �Լ� (ABS, SIGN, POWER, SQRT)
    - GREATEST(n1, n2, ...), LEAST(n1, n2, ...) --greatest �ϳ��� �࿡�� ���� ū��
                                                --max ���� ���߿��� ���� ū ��
    - ROUND(n1, n2), TRUNC(n1, n2)              --round �ݿø�/ trunc ����(����)
    - FLOOR(n), CEIL(n)                         --����� ������ / ���������� ����� ������ / ū������ ����� ������
    - MOD(n1, n2)                               --
    
    1) ������ �Լ� (ABS, SIGN, POWER, SQRT)
        . ABS(n) : n�� ���밪
        . SIGN(n) : n�� ��ȣ�� ���� �����̸� ũ�⿡ ������� -1, ����̸� ũ�⿡ ������� 1,
                    0�̸� 0�� ��ȯ
        . POWER(n1, n2) : n1�� n2�� ��(n1�� n2�� �ŵ� ���� ��)
        . SQRT(n) : n �� ���� ��
        
    ��뿹)
        SELECT ABS(10), ABS(-0.05),
               SIGN(-10000), SIGN(0), SIGN(0.0001),
               POWER(2,10), SQRT(3.14)
            FROM DUAL;
            
    2) GREATSET(n1, n2,...), LEAST(n1, n2, ...) - **
        . GREATEST : �־��� �� �� ���� ū ���� ��ȯ�ϸ�, �ڷᰡ ���ڿ��� ��� ASCII ���� ��ȯ�Ͽ� ��
        . LEAST :  �־��� �� �� ���� ���� ���� ��ȯ�ϸ�, �ڷᰡ ���ڿ��� ��� ASCII ���� ��ȯ�Ͽ� ��
    
    ��뿹)
      (1) SELECT GREATEST(256, 30, 90),
                 GREATEST('ȫ�浿', 'ȫ���', 'ȫ���')
          FROM DUAL;
        
      (2) ȸ�����̺��� ȸ������ ���ϸ��� �� 2000 �̸��� ���ϸ����� ������ ȸ���� ���ϸ����� 
          2000���� �ٲپ� ����Ͻÿ�
          Alias�� ȸ����ȣ, ȸ����, ���� ���ϸ���, ���渶�ϸ���
          
          
          SELECT MEM_ID AS ȸ����ȣ,
                 MEM_NAME AS ȸ����,
                 MEM_MILEAGE AS �������ϸ���,
                 GREATEST(MEM_MILEAGE, 2000) AS ���渶�ϸ��� -- ù��° ���� �ٲܰ� �ι�°���� ���氪
          FROM MEMBER;
          
      (3) ROUND(n1 [, n2]), TRUNC(n1 [, n2])
        - �־��� �ڷ� n1�� n2+1�ڸ����� �ݿø�(ROUND) �Ǵ� ����(TRUNC)�Ͽ� ��ȯ
            (���� 2345678.4567 �϶� round(su, 2)�̶�����
                = �׷��� 2345678.46�̵ȴ�)
        - n2�� �����Ǹ� 0���� ���� (�Ҽ����� ���ְ� �����θ� ǥ����)
        - n2�� �����̸� �������� ����κп��� n2��°�ڸ����� �ݿø� �Ǵ� ����
            (���� 2345678.4567 �϶� round(su, -3)�̶�����.
                = �׷��ٸ� 23456���� �ݿø��� �Ͼ�� 2346�� �ȴ�.)
        
    ��뿹)
      (1) ������̺� ����� �޿��� ������ ǥ���� ���̴�. �� �������
          �� �޿��� ����Ͻÿ� ��, �Ҽ��� 2�ڸ����� �ݿø��Ͽ� ǥ��
          Alias�� �����ȣ, �����, ����(salary), �� �޿�
          
          SELECT  EMPLOYEE_ID AS �����ȣ,
                  EMP_NAME AS �����,
                  SALARY AS ����,
                  TRUNC(SALARY/12, 1) AS "�� �޿�",
                  ROUND(SALARY/12, 1) AS "�� �޿�"
            FROM  HR.EMPLOYEES;
          
      (2) ��ǰ���̺��� �з��ڵ� 'P100'~'P199'�� ���� ��ǰ�� �ΰ���ġ������ ����Ϸ��Ѵ�.
          ���������� ����� �ΰ������� ����Ͽ� ����Ͻÿ�.
          Alias�� ��ǰ�ڵ�, ��ǰ��, ���԰���, ���Ⱑ��
          ��, �ΰ�����=(���Ⱑ��-���԰���)*7%
          SELECT PROD_ID AS ��ǰ�ڵ�, 
                 PROD_NAME AS ��ǰ��,
                 PROD_COST AS ���԰���,
                 PROD_PRICE AS ���Ⱑ��,
                 TRUNC((PROD_PRICE - PROD_COST) * 0.07) AS �ΰ���ġ����
          FROM PROD
          WHERE PROD_LGU BETWEEN 'P100' AND 'P199'
        
                 
    4) FLOOR(n), CEIL(n)
      - FLOOR : n�� ���ų�(n�� ������ ���) �����ʿ��� ���� ū ����
      - CEIL : n�� ���ų�(n�� ������ ���) ū�ʿ��� ���� ���� ����
      - �ݾ׿� ���õ� ��� ���� ����
      
    ��뿹)
      (1) SELECT FLOOR(12.456), FLOOR(12), FLOOR(-12.567),
                 CEIL(12.456), CEIL(12), CEIL(-12.567)
            FROM DUAL;
    5) MOD(n1, n2)
        -�־��� �ڷ� n1�� n2�� ���� ������ ��ȯ
        -java�� %�������� ���
    ��뿹)
    
      (1) 150��(SECOND)�� �а� �ʷ� ��Ÿ���ÿ�
          SELECT TRUNC(150/60) ||'�� ' ||MOD(150, 60)||'��'
          FROM DUAL;
      
      (2) Ű����� ������ �Է¹޾� �� ����
        90 -93 : A-
        94 -96 : A0,
        97 - 100 : A+
        80 - 83 : B-
        84 - 86 : B0,
        87 - 100 : B+
        79���ϸ� F�� ���
        
         ACCEPT P_SCORE  PROMPT '�����Է� : '
  DECLARE
    L_SCORE NUMBER:=TO_NUMBER('&P_SCORE');
    L_RES VARCHAR2(100);
  BEGIN
    IF TRUNC(L_SCORE/10)=10 THEN L_RES:=L_SCORE||'�� A+�����Դϴ�.';
    ELSIF TRUNC(L_SCORE/10)=9 THEN 
          L_RES:='A';
          CASE WHEN MOD(L_SCORE,10) IN(0,1,2,3) THEN
                    L_RES:=L_SCORE||'�� '||(L_RES||'-')||'�����Դϴ�';
               WHEN MOD(L_SCORE,10) IN(4,5,6) THEN
                    L_RES:=L_SCORE||'�� '||(L_RES||'0')||'�����Դϴ�';
               ELSE 
                    L_RES:=L_SCORE||'�� '||(L_RES||'+')||'�����Դϴ�';
          END CASE;
    ELSIF TRUNC(L_SCORE/10)=8 THEN 
          L_RES:='B';
          CASE WHEN MOD(L_SCORE,10) IN(0,1,2,3) THEN
                    L_RES:=L_SCORE||'�� '||(L_RES||'-')||'�����Դϴ�';
               WHEN MOD(L_SCORE,10) IN(4,5,6) THEN
                    L_RES:=L_SCORE||'�� '||(L_RES||'0')||'�����Դϴ�';
               ELSE 
                    L_RES:=L_SCORE||'�� '||(L_RES||'+')||'�����Դϴ�';
          END CASE;
    ELSE
          L_RES:=L_SCORE||'�� F�����Դϴ�';
    END IF;
    DBMS_OUTPUT.PUT_LINE(L_RES);   
                          
  END;