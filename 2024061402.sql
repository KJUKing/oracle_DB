2024-0614-02) ��¥�Լ�
    - SYSDATE, SYSTIMESTAMP
    - ADD MONTHS(d ,n), NEXT_DAY(d, c), LAST_DAY(d)
    - MONTH_BETWEEN(d1, d2)
    - EXTRACT(fmt FROM d)
    
    1) SYSDATE, SYSTIMESTAMP
        . SYSDATE : �⺻ ��¥������(����� �ú���) ��ȯ
          - '+' '-' ���� ����
        . SYSTIMESTAMP : TIMESTAMP Ÿ���� ��¥ �ڷ� ��ȯ
    
    2) ADD_MONTHS(d, n), NEXT_DAY(d,c), LAST_DAY(d)
        . ADD_MONTHS: �־��� ��¥ d�� b������ ���� ��¥ ��ȯ
        . NEXT_DAY : �־��� ��¥ d ���Ŀ� �� ó�� ������ c������ ��¥ ��ȯ
                      c�� '������', '��', ~'�Ͽ���', '��'�� ���
        . LAST_DAY : �־��� ��¥ d�� ���Ե� ���� ������ ��¥ ��ȯ
                     ���� �������� ���� �Է� �޾� �ش� ���� ���� �۾��� �ʿ��� ��� ���� ����
    
    ��뿹)
        (1) ������̺��� �Ի� �� 3������ ������ ���� �߷��� �޴´ٰ� �Ѵ�
            �� ����� ���� �߷����� ��ȸ�Ͻÿ�.
            
            SELECT EMPLOYEE_ID AS �����ȣ,
                   EMP_NAME AS �����,
                   HIRE_DATE AS �Ի���,
                   ADD_MONTHS(HIRE_DATE, 3) AS �߷���
                   FROM HR.EMPLOYEES;
    
        (2) SELECT NEXT_DAY (SYSDATE, '������'), --������ �������̿��ٸ� ������ �����ϰ� ���� ������
                   NEXT_DAY (SYSDATE, '��')
                FROM DUAL;
                
        (3) �������̺��� 2020�� 2�� ��ǰ�� ���Լ����� ���Աݾ��� ��ȸ
        
            SELECT BUY_PROD AS ��ǰ�ڵ�,
                   SUM(BUY_QTY) AS ���Լ���,
                   SUM(BUY_QTY*BUY_COST) AS ���Աݾ�
                FROM BUYPROD
               WHERE BUY_DATE BETWEEN TO_DATE('20200201')
                                -- 20200201�̶�� ���ڿ��� DATE�������� ���� ����ȯ�Ѵ�.
                     AND LAST_DAY (TO_DATE('20200201')) --2���̶�� ������ �����ֱ⶧����
                                    --LAST_DAY�Ἥ 2�� ù������ 2���� ������������ ���
               GROUP BY BUY_PROD
               ORDER BY 1;
               
        (4) Ű����� 4-7���� �Է� �޾� �ش� ���� �߻��� ������Ȳ�� ��ȸ�Ͻÿ�
            ACCEPT P_MONTH PROMPT '�Ǹ� ��(04~07) : '
            DECLARE
                L_DAY DATE;
                L_PROD PROD.PROD_ID%TYPE;
                L_MONTH DATE := TO_DATE('2020'||'&P_MONTH'||'01');
                L_QTR NUMBER :=0;
                CURSOR CUR_CART IS

                SELECT DISTINCT CART_PROD
                FROM CART
                WHERE SUBSTR(CART_NO,1,8) BETWEEN L_MONTH
                    AND LAST_DAY(L_MONTH)
            BEGIN
                OPEN CUR_CART;
                LOOP
                    FETCH CUR_CART INTO L_PROD;
                    EXIT WHEN CUR_CART%NOTFOUND;
                    SELECT TO_DATE(SUBSTR(CART_NO,1,8)), CART_PROD, CART_QTY
                    INTO L_DAY, L_PROD, L_QTY
                    FROM CART
                    WHERE CART_PROD=L_PROD;
                    
                    DBMS_OUTPUT.PUT_LINE(L_DAY||' '|| L_PROD||' '||L_QTY);
                    DBMS_OUTPUT.PUT_LINE('--------------------------------');
            END LOOP;
            CLOSE CUR_CART;
            END;
            
    3) MONTHS_BETWEEN(d1, d2)
        -�� ��¥ �ڷ� ������ �� ���� ���ڷ� ��ȯ
        ��뿹)
            SELECT MONTH_BETWEEN(SYSDATE, '19880210')
                FROM DUAL;
        
        ��뿹) ������̺��� 50�� �μ��� ���� ������� �����Ⱓ�� ���������� ��ȸ�Ͻÿ�.
            Alias �����ȣ, �����, �Ի���, �����Ⱓ
            
            SELECT EMPLOYEE_ID AS �����ȣ,
                   EMP_NAME AS �����,
                   HIRE_DATE AS �Ի���,
                   TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) AS ����,
                   TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)/12) || '��'|| ' '||
                   MOD(TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)),12) || '����' AS �����Ⱓ
            FROM EMPLOYEES
            WHERE DEPARTMENT_ID = 50
            
        4) EXTRACT(fmt FROM d)
            - �־��� ��¥ �ڷ� d���� 'fmt'�� ���ǵ� ���� ���ڷ� ��ȯ
            - 'fmt'�� ���Ĺ��ڿ��� 'YEAR', 'MONTH', 'DAY', 'HOUR', 'MINUTE', 'SECOND'
                �� �ϳ��̾����
                
        ��뿹) ��ٱ��� ���̺��� 7���� �Ǹŵ� ��ǰ ������ ��ȸ�Ͻÿ�
                Alias�� ����ȸ����ȣ, ��ǰ�ڵ�, ����
            SELECT CART_MEMBER AS ����ȸ����ȣ,
                   CART_NO AS ��ٱ��Ϲ�ȣ,
                   CART_PROD AS ��ǰ�ڵ�,
                   CART_QTY AS ����
            FROM CART
            WHERE EXTRACT(YEAR FROM TO_DATE (SUBSTR(CART_NO,1,8)))=2020
                AND EXTRACT(MONTH FROM TO_DATE (SUBSTR(CART_NO,1,8)))=7
            ORDER BY SUBSTR(CART_NO,1,8);