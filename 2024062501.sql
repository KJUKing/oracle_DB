2024-0625-01)
2. UPDATE���� SUBQUERY
    - SET ���� '='������ �����ʿ� �������� ���
    (�������)
    UPDATE ���̺�� [��Ī]
        SET (�÷���1,...�÷���n)=(SELECT �÷���1,...�÷���n
                                    FROM~ )
                                    
    [WHERE ����]
        . SET ���� ����� �÷��� ������ ������ ���������� SELECT����
          �÷��� ������ ������ ��ġ�ؾ���
        

��뿹)
    (1) 2020�� 1��~3�� ���̿� �߻��� ���������� ����Ͽ� ������ ���̺���
        ������ �����Ͻÿ�
        
        [�������� : 2020�� 1-3�� ��ǰ�� ���Լ�������]
        SELECT B.BSUM
        FROM  (SELECT  BUY_PROD,
                       SUM(BUY_QTY) AS BSUM
               FROM BUYPROD
               WHERE BUY_DATE BETWEEN TO_DATE('20200101')
                              AND LAST_DAY(TO_DATE('20200331'))
               GROUP BY BUY_PROD) B
       
        
        [��������]
        UPDATE REMAIN A
        SET (A.REMAIN_I, REMAIN_J_99, A.REMAIN_DATE)=
            (SELECT A.REMAIN_I + B.BSUM, A.REMAIN_J_99 +B.BSUM,
                    LAST_DAY(TO_DATE('20200301'))
             FROM  (SELECT  BUY_PROD,
                            SUM(BUY_QTY) AS BSUM
                    FROM BUYPROD
                    WHERE BUY_DATE BETWEEN TO_DATE('20200301')
                                    AND LAST_DAY(TO_DATE('20200301'))
                    GROUP BY BUY_PROD) B
             WHERE A.PROD_ID = B.BUY_PROD) --���������̺��� ������ ��ǰ�� �����ϴ°� �ϳ���
        WHERE A.PROD_ID IN (SELECT DISTINCT BUY_PROD
                            FROM BUYPROD
                            WHERE BUY_DATE BETWEEN TO_DATE('20200301')
                                           AND LAST_DAY(TO_DATE('20200301')))
                                           
    (2) 2020�� 4��~7�� ���̿� �߻��� ����/���������� ����Ͽ�
        ���������̺��� ������ �����Ͻÿ�
            
            UPDATE REMAIN A
            SET (A.REMAIN_I, REMAIN_O, REMAIN_J_99, A.REMAIN_DATE)=
                (SELECT  B.BUY_PROD,
                         SUM(B.BUY_QTY) AS BSUM,
                         C.CART_PROD,
                         SUM(C.CART_QTY) AS CSUM
                 FROM BUYPROD B, CART C
                 WHERE B.BUY_PROD = C.CART_PROD
                    AND BUY_DATE BETWEEN TO_DATE('20200401')
                                 AND LAST_DAY(TO_DATE('20200701'))
                 GROUP BY BUY_PROD, CART_PROD) D
                 
                 [�������� : 2020�� 4��-7�� ���̿� �߻��� ����/��������
                 SELECT D.���Լ���, D.�������
                 FROM  (SELECT ��ǰ�ڵ�, ���Լ���, �������
                        FROM (��ǰ�� ���Լ���) A, (��ǰ�� �������) B, PROD C
                        WHERE C.PROD_ID=A.��ǰ��ȣ(+)
                        AND C.PROD_ID=B.��ǰ��ȣ(+))D
                 [��ǰ�� ���Լ���]
                 SELECT BUY_PROD,
                        SUM(BUY_QTY) AS BSUM
                 FROM BUYPROD
                 WHERE BUY_DATE BETWEEN TO_DATE('20200401')
                                 AND LAST_DAY(TO_DATE('20200701'))
                 GROUP BY BUY_PROD
                 [��ǰ�� �������]
                 SELECT CART_PROD,
                        SUM(CART_QTY) AS CSUM
                 FROM CART
                 WHERE SUBSTR(CART_NO, 1,6) BETWEEN '202004' AND '202007'
                 GROUP BY CART_PROD
                 
                 [����]
                 SELECT D.ABSUM,
                        D.BCSUM
                 FROM  (SELECT C.PROD_ID AS PID,
                               NVL(A.BSUM,0) AS ABSUM,
                               NVL(B.CSUM,0) AS BCSUM
                        FROM (SELECT BUY_PROD,
                                     SUM(BUY_QTY) AS BSUM
                              FROM BUYPROD
                              WHERE BUY_DATE BETWEEN TO_DATE('20200401')
                                             AND LAST_DAY(TO_DATE('20200701'))
                              GROUP BY BUY_PROD) A,
                             (SELECT CART_PROD,
                                     SUM(CART_QTY) AS CSUM
                              FROM CART
                              WHERE SUBSTR(CART_NO, 1,6) BETWEEN '202004' AND '202007'
                              GROUP BY CART_PROD) B,
                              PROD C
                        WHERE C.PROD_ID=A.BUY_PROD(+)
                        AND C.PROD_ID=B.CART_PROD(+)) D
                        
                [��������]
                UPDATE REMAIN R
                SET (R.REMAIN_I, R.REMAIN_O, R.REMAIN_J_99, R.REMAIN_DATE)=
                    (SELECT R.REMAIN_I + D.ABSUM, R.REMAIN_O + D.BCSUM,
                            R.REMAIN_J_99 + D.ABSUM - D.BCSUM, TO_DATE('20200731')
                     FROM  (SELECT C.PROD_ID AS PID,
                               NVL(A.BSUM,0) AS ABSUM,
                               NVL(B.CSUM,0) AS BCSUM
                            FROM  (SELECT BUY_PROD,
                                     SUM(BUY_QTY) AS BSUM
                                   FROM BUYPROD
                                   WHERE BUY_DATE BETWEEN TO_DATE('20200401')
                                                 AND TO_DATE('20200731')
                                   GROUP BY BUY_PROD) A,
                                  (SELECT CART_PROD,
                                          SUM(CART_QTY) AS CSUM
                                   FROM CART
                                   WHERE SUBSTR(CART_NO, 1,6) BETWEEN '202004' AND '202007'
                                   GROUP BY CART_PROD) B,
                                   PROD C
                            WHERE C.PROD_ID=A.BUY_PROD(+)
                                AND C.PROD_ID=B.CART_PROD(+))D
                            WHERE D.PID=R.PROD_ID)