2024-0617-01)����ȯ �Լ�

    - �ڷ��� ���� �Լ��� ���� ��ġ���� �Ͻ������� ��ȯ
    - �ڹ��� CAST ������ '( )'����
    - CAST(expr AS Ÿ��), TO_CHAR(expr [,'fmt']),
        TO_DATE(expr [,'fmt']), TO_NUMBER(expr [,'fmt']) �� ����
    1) CAST(expr AS Ÿ��)
        - ���ǵ� 'expr'�� ���� 'Ÿ��'�� ������ ��ȯ
        - �پ��� Ÿ������ ��ȯ ����ϳ� ������ ������ ���·� ��ȯ�� �Ұ���
    ��뿹)
        SELECT '['||CAST('Hello' AS CHAR(10))||']'
        FROM DUAL;
        
        SELECT CAST(PROD_PRICE AS VARCHAR2(50)),
                LPAD(CAST(PROD_PRICE AS VARCHAR2(55)),50,'*')
                --LPAD�� Ư�� ���ڿ��� �ަU�������� ���Ƴ���
        FROM PROD
        WHERE PROD_LGU='P101';
        
    2) TO_CHAR(expr [,'fmt'])
        - ����, ��¥, ���ڿ��� ǥ���� expr�� 'fmt' ������ ���ڿ��� ��ȯ
        - 'expr'�� ���ڿ��� ��� CHAR, CLOB Ÿ���� VARCHAR2�������� ��ȯ�� ����
        - ��¥ ���� ���ڿ�
        ------------------------------------------------------
        FORMAT ���ڿ�        �ǹ�            ��뿹
        ------------------------------------------------------
        AD, BC              ����            SELECT TO_CHAR(SYSDATE, 'BC CC')||'����' FROM DUAL;  
        CC                  ����
        YYYY,YYY,YY,Y       �⵵            SELECT TO_CHAR(SYSDATE, 'YYYY YYY'),
                                                TO_CHAR(SYSDATE, 'YY Y') FROM DUAL;
        MM, RM              ��              SELECT TO_CHAR(SYSDATE, 'MM RM') FROM DUAL;
        MONTH, MON          ��              SELECT TO_CHAR(SYSDATE, 'MONTH MON') FROM DUAL;
        Q                   �б�            SELECT TO_CHAR(SYSDATE, 'Q') FROM DUAL;
        W, WW               ����            SELECT TO_CHAR(SYSDATE, 'W WW') FROM DUAL;
        DD, DDD             ��              SELECT TO_CHAR(SYSDATE, 'D DD DDD') FROM DUAL;
        DAY, DY, D          ����            SELECT TO_CHAR(SYSDATE, 'D DY DAY') FROM DUAL;
        AM, PM,             ����/����        SELECT TO_CHAR(SYSDATE, 'AM PM') FROM DUAL;
        A.M., P.M.
        HH,HH12, HH24       �ð�            SELECT TO_CHAR(SYSDATE, 'HH HH12 HH24') FROM DUAL;
        MI                  ��              SELECT TO_CHAR(SYSDATE, 'MI') FROM DUAL;
        SS, SSSSS           ��              SELECT TO_CHAR(SYSDATE, 'SS SSSSS') FROM DUAL;
        "���ڿ�"             ����� ����      SELECT TO_CHAR(SYSDATE, 'HH24"�ð�" MI"��" SS"��" SSSSS') FROM DUAL;
        -------------------------------------------------------
        
        - ���� ���� ���ڿ�
        -------------------------------------------------------
        FORMAT ���ڿ�     �ǹ�                               ��뿹
        -------------------------------------------------------
            0          ���� ���ڿ� ����
                       �����Ǵ� ���ڰ� ��ȿ�� 0�̸� 0�� ���
                       �����Ǵ� ���ڰ� ��ȿ�����̸� �ش� ���� ���
                       SELECT SUBSTR(CART_NO, 9) COL1,
                            TO_CHAR(TO_NUMBER(SUBSTR(CART_NO, 9))+1, '00000') AS COL2,
                            TO_CHAR(TO_NUMBER(SUBSTR(CART_NO, 9))+1, '99999') AS COL3
                       FROM CART
                       WHERE CART_NO LIKE '20200728%';
                       
                       SELECT TO_CHAR(PROD_PRICE, '99,999,990') AS COL1,
                                PROD_PRICE/17,
                                TO_CHAR(PROD_PRICE/17, '99,999,999.99'),
                                TO_CHAR(PROD_PRICE/17, '99,999,999.00'),
                                TO_CHAR(PROD_PRICE/17, '99,999,999')
                       FROM PROD
            9          ���� ���ڿ� ����
                       �����Ǵ� ���ڰ� ��ȿ�� 0�̸� ������ ���
                       �����Ǵ� ���ڰ� ��ȿ�����̸� �ش� ���� ���
            $,L        ���� ���ʿ� '$'�� ȭ���ȣ�� ���
                       SELECT PROD_NAME AS ��ǰ��,
                              TO_CHAR(PROD_COST, 'L9,999,999') AS ���Դܰ�,
                              TO_CHAR(PROD_PRICE, 'L9,999,999')����ܰ�,
                              PROD_BUYER AS ���԰ŷ�ó
                        FROM PROD
                        WHERE PROD_COST>=100000;
                        
                       SELECT EMP_NAME AS �����,
                              DEPARTMENT_ID AS �μ���ȣ,
                              JOB_ID AS �����ڵ�,
                              TO_CHAR(SALARY, '$99,999') AS �޿�
                       FROM HR.EMPLOYEES
                       WHERE SALARY >= 5000;
            PR         ������ ��� '-'��ȣ ��� '<>'�� ���� ��� ������ ���� ���
                       SELECT TO_CHAR(12345, '99,999PR'),
                              TO_CHAR(12345)+10,
                              TO_CHAR(-12345, '99,999PR')
                        FROM  DUAL;
            MI         ������ ��� '-'��ȣ�� ���� �����ʿ� ���
                        SELECT TO_CHAR(12345, '99,999MI'),
                               TO_CHAR(-12345, '99,999MI')
                         FROM  DUAL;
            ,  .       ',' : 3�ڸ������� �ڸ���
                       '.' : �Ҽ���
        -------------------------------------------------------
        2) TO_DATE(expr [, 'fmt'])
            - expr�� ǥ���� ���ڿ�(����)�� ��¥ �������� ��ȯ
            - 'fmt'�� ��ȯ�Ϸ��� ��¥ Ÿ���� �ƴ϶� ����� expr�� ���뵵�� ���Ĥ�����
              ���ڿ��� ����ؾ��ϸ� ����� ǥ�� ��¥���� ��ȯ
            SELECT TO_DATE('���� 2010-06-18','BC YYYY-MM-DD')+25,
                    SYSDATE+25
            FROM DUAL;
              
            SELECT SUBSTR(CART_NO,1,8),
                   TO_DATE(SUBSTR(CART_NO,1,8)),
                   TO_NUMBER(SUBSTR(CART_NO,1,8)), --��¥������ ���ڿ����� ���ڷε� �ٲܼ��ִ�
                   TO_DATE(TO_NUMBER(SUBSTR(CART_NO,1,8)))
            FROM    CART
            WHERE CART_NO LIKE '202007%';
            
        3) TO_NUMBER(expr [, 'fmt'])
            - expr�� ǥ���� ���ڿ��� ���� �������� ��ȯ
            - 'fmt'�� ��ȯ�Ϸ��� ���� Ÿ���� �ƴ϶� ����� expr�� ����� ��������
              ���ڿ��� ����ؾ��ϸ� ����� ǥ�� �������� ��ȯ
              
           SELECT TO_NUMBER ('2,345','9,999'), -- �����ʿ� ������ ���� ������ָ� ��������
                  TO_NUMBER ('<12,345>','99,999PR'),
                  TO_NUMBER ('��12,345.67', 'L99,999.99')
            FROM DUAL;
        ��뿹)
          (1) �������̺��� 2020�� 3�� ���������� ��ȸ�Ͻÿ�.
                Alias�� ��¥, ��ǰ��ȣ, ����, �ݾ��̸� ��¥�� 'YYYY-MM-DD'��������,
                �ݾ���