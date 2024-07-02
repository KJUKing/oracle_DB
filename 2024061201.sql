2024-0612-01)�Լ�(Function)
    - �Լ��� �̸� ����� ���� ���� ���α׷����� ȥ�ڼ� ������� �ʰ�
      �ٸ� �Լ��� ���ؼ� ȣ���� �޾ƾ߸� ����Ǵ� ���α׷�
    - �÷��� ���̳� ������ Ÿ���� ������ ���
    - ���� �Ǵ� ��¥ �������� ��������� ������ ���
    - �ϳ� �̻��� �࿡ ���� ���踦 �����ϴ� ��� ���ȴ�
    - SQL �Լ� �������δ�
     . ������(Single-row) �Լ�
       - ���̺� ����Ǿ��ִ� ���� ���� ������� �Լ��� �����Ͽ� �ϳ��� ����� ��ȯ�Ѵ�.
       - ����, ����, ��¥ ���� ó���Լ�
       - ������ Ÿ���� ��ȯ�ϱ� ���� ��ȯ�Լ�
       - SELECT, WHERE, ORDER BY ������ ���
       - �Լ��� ��ø(nested) ����� �� �ִ�.
     . ������(Multiple-row) �Լ�
      - ���� ���� �׷�ȭ�Ͽ� �׷캰�� ����� ó���Ͽ� �ϳ��� ��� ��ȯ
      - �׷�ȭ�ϰ��� �ϴ� ��� GROUP BY ���� ����ϴ� �Լ��� �����ȴ�
      
1. �����Լ�
 . ���ڿ� ������ : '||'                    -- CONCAT�� ����(||)�� �ǹ�
 . CONCAT(c1,c2),CHR(n), ASCII(c1)  -- c�� ���� ���ڿ� , n�̳�m�� ���ڿ��� �ǹ�
                -- CHR(n) ���ڿ��� �ش��ϴ� ���� ��ȯ ASCII �ƽ�Ű�ڵ尪
 . LOWER(c1), UPPER(c1), INITCAP(c1)
   --LOWER��繮�ڿ��� �ҹ��ڷ� / UPPER ��繮�ڿ��� �빮�ڷ� / INITCAP�� �ܾ� ù���ڸ� �빮�ڷ�
 . LPAD(c1,n [,c2]),PPAD(c1,n [,c2]) -- L ���� / R ������ / PAD ��ҿ� Ư���ѹ��ڿ��� �ݺ��ؼ�ä�ﶧ
 . LTRIM(c1 [,c2]), RTRIM(c1 [,c2]), TRIM(c1) --TRIM ����°� c1���� c2���� ����� / c2�� �����Ǹ� ������ ����
   -- LTRIM ���ʿ��� c1���� c2�� ã�Ƽ� ����� / �ܾ���ʿ��ִ� ������ ������� / TRIM�� ���ʵ��� ��� ��������� *�ܾ�Ȱ�����������
 . SUBSTR(c1,n1[,n2]), REPLACE(c1, c2 [,c3]), INSTR(c1, c2[m [,n]])
 -- REPLACE c1���� c2�� ã�Ƽ� c3�� �ٲ۴� ex) �ŷ�ó�̸�(c1)���� ���(c2)��°��� ã�Ƽ� ����(c3)�� �ٲ�� �ٵ� c3�� �����̸� ����°͸� �����
 . LENGTH(c1), LENGTHB(c1)
 
  1) ���ڿ� ������ '||'
   - �� ���ڿ��� �����Ͽ� �ϳ��� ���ڿ��� ��ȯ
 ��뿹)
  (1)ȸ�����̺��� ������ �����ϴ� ȸ����ȣ,ȸ����,�ֹε�� ��ȣ�� ����Ͻÿ�
    ��, �ֹε�Ϲ�ȣ�� XXXXXX-XXXXXXX�������� ����Ͻÿ�
 2) CONCAT(c1,c2)   -- �ΰ��� ��ȯ
  - �� ���ڿ� c1�� c2�� �����Ͽ� ����� ��ȯ
    SELECT MEM_ID AS ȸ����ȣ,
           MEM_NAME AS ȸ����,
        -- MEM_REGNO1||'-'||MEM_REGNO2 AS "�ֹε�� ��ȣ"   --��Ī�� ������ ������ " "�� ��� �Ҽ� �ִ�
           CONCAT(CONCAT(MEM_REGNO1,'-'),MEM_REGNO2) AS "�ֹε�� ��ȣ" -- �ʹ� ��� ������ // �׳� ���Ѱ� �����ϴ°� ����
    FROM MEMBER             -- �����Լ��� �Ϲ��Լ��� ���� ������ �� �ִµ� �����Լ����� ������ �� ����
    WHERE MEM_ADD1 LIKE '����%'               
   
 3) CHR(n), ASCII(c1)
   - ������ ���ڿ���(CHR), ���ڿ��� �ش� �ƽ�Ű �ڵ尪���� ���
    -- ���ڿ��� ���ٸ� ù���ڸ� �߰��� ex('ABC'�� A��)
   SELECT CHR(65), ASCII('A'), ASCII('��') 
   FROM SYS.DUAL; --DUAL;���ᵵ��

 4) LOWER(c1), UPPER(c1), INITCAP(c1)
   - �Ű������� �����Ǵ� ���ڿ��� �ҹ��ڴ� �빮�ڷ� (UPPER), �빮�ڴ� �ҹ��ڷ�(LOWER)
     �� �ܾ��� ù ���ڸ� �빮�ڷ�(INITCAP)���� ��ȯ
     -- ' '�� ���̸� �ƽ�Ű�ڵ尪���� ��ȯ�Ǳ⿡ �빮�ڿ� �ҹ��ڰ� ������ �ȴ�
 ��뿹)
  (1) SELECT LOWER('BOYGOOD'), UPPER('Il Postino'), initcap('donald trumph')
      FROM DUAL;
  (2) ��ǰ���̺��� �з��ڵ� 'p202'�� ���� ��ǰ�� ��ǰ�ڵ�,��ǰ��,�з��ڵ�,���Դܰ��� ��ȸ�Ͻÿ�
      SELECT PROD_ID AS ��ǰ�ڵ�,
             PROD_NAME AS ��ǰ��,
             PROD_LGU AS �з��ڵ�,
             PROD_COST AS ���Դܰ�
        FROM PROD
        WHERE LOWER(PROD_LGU)='p202';
      
  (3) ȸ�����̺��� ȸ����ȣ�� 'D001'ȸ���� ��� ������ ��ȸ�Ͻÿ�
      SELECT *
      
      FROM MEMBER
      WHERE UPPER(MEM_ID)='D001'
      
 5) LPAD(c1,n [,c2]),PPAD(c1,n [,c2])
   - �־��� ���ڿ� c1�� ���ǵ� n ����Ʈ�� �������� ���ʺ���(RPAD) �����ϰ�
     ���� ������ ������'c2'���ڿ��� Ȯ���Ͽ� ����
   - c2�� �����Ǹ� ������ ä����
   
��뿹)  -- LPAD�� c1�� �����ʿ� ä��� c2�� ���� ������ ���ʿ� ä�� / 
        -- RPAD�� c1�� ���ʿ� ä��� c2�� ���� ������ �����ʿ� ä��
    SELECT MEM_NAME AS ȸ����,
           LPAD(MEM_NAME,10,'#') AS "LPADȸ����",
           RPAD(MEM_NAME,10,'#') AS "RPADȸ����",
           LPAD(MEM_NAME,10) AS "LPAD",
           RPAD(MEM_NAME,10) AS "RPAD"
   FROM MEMBER;
   
 . ��ǰ���̺��� ���Ⱑ�� 10���� ������ ��ǰ�� ������ ���� ���ǿ� ���߾� ����Ͻÿ�
   ALIAS�� ��ǰ�ڵ�,��ǰ��,ũ��,����,�ǸŰ���
   ��, ũ��� ������ ���� ������(NULL��) 'ũ������ ����', '�������� ����'�� ����Ͽ�
   ũ�������� ���������� �÷��� �߾ӿ� ����� ��
   -- NVL(c1,c2)�� c1���� NULL���̸� c2���� ����Ѵ�
   -- �Լ��� �Լ��� ������ �� �ִ� 
   SELECT PROD_ID AS ��ǰ�ڵ�,
          PROD_NAME AS ��ǰ��,
          NVL(LPAD(PROD_SIZE,6),'ũ������ ����') AS ũ��,
          NVL(LPAD(PROD_COLOR,8),'�������� ����') AS ����,
          PROD_PRICE AS �ǸŰ���
   FROM PROD
   WHERE PROD_PRICE <= 100000;

 6) LTRIM(c1 [,c2]), RTRIM(c1 [,c2]), TRIM(c1)
  - �־��� �ڷ� c1�� ���ʺ���(LTRIM) �Ǵ� �����ʺ���(RTRIM) c2�� ������ ���ڿ��� ã�� ������
  - ��ġ���� �ʴ� ���ڸ� ������ �������� ����
  - c2�� �����Ǹ� ������ ������
  - TRIM : �־��� c1�� �հ� �ڿ� �����ϴ� �������� -- �̰� �ַ� ���� ��������� ����
  
 ��뿹)
    SELECT LTRIM('AABBACDDEFG','AB'),
           LTRIM('AABBACDDEFG','AABB'),
           RTRIM('ABACADAD','AD'),
           LTRIM('    EFG'),
           RTRIM('AA      '),
           TRIM('   AABB   ')
    FROM DUAL;   
    
    
    SELECT EMP_NAME,
           DEPARTMENT_ID,
           SALARY
     FROM HR.EMPLOYEES
    WHERE FIRST_NAME='DEN';
 -- WHERE TRIM(FIRST_NAME)=TRIM('DEN   ');
    -- VARCHAR2�� ���� �Է��ϰ� ���� ������� �ݳ��ؼ� ex)den���Է��ϸ� �ڿ� ������ �ݳ��� den������
    -- CHAR, 20 �̶�������� ex)den          �ڿ� �����̷��԰��ϳ��� ���ڿ��� �����ε�
    -- VARCHAR2���� CHAR�� �ٲ㼭 'DEN'�ڿ� ������ �־ ����� �ȵǾ���ϴµ�
    -- ���Ҷ� ����Ŭ�� �˾Ƽ� TRIM�� �˾Ƽ� ������ ó���ؼ� ������ �����
    -- ���� ���� TRIM�� ���൵ �ǰ� �Ƚ��൵ ��
    
 ��뿹) ��ٱ��� ���̺��� 2020�� 4�� 5�� ��ٱ��Ϲ�ȣ�� �����Ͻÿ�.
    SELECT SUBSTR(MAX(CART_NO),1,8)||
           TRIM(TO_CHAR(TO_NUMBER(SUBSTR(MAX(CART_NO),9))+1,'00000')) AS ��ٱ��Ϲ�ȣ
      FROM CART
     WHERE CART_NO LIKE '20200405%';
     
     -- ������ �����ϰ� �ϸ�
     -- CATR_NO���ڿ���+1�� �ϸ� 1�� ���ڿ��̴ϱ� ���ڿ��� ���ڿ��� ���� �׷��� �ٽ� ���ڿ��� ���
    SELECT MAX(CART_NO)+1 AS ��ٱ��Ϲ�ȣ
      FROM CART
     WHERE CART_NO LIKE '20200405%';
     -- MAX(c1) = c1���� ���� �������� ���
     -- SUBSTR(c1,n,n1) c1������ n�ڸ��������� n1�ڸ����� ��� / n1�� ���������ϸ� n�ڷ� ������
     -- TO_NUMBER() ���ڿ��� ���ڷιٲ�
     -- TO_CHAR() ���ڸ� ���ڿ��� �ٲ�
     -- TRIM ������ ����
     -- TO_CHAR�� ���� ���ڿ��� ����� ũ�⶧���� �����̻�������ְ� �Ȼ�������ִ�
     
 7) SUBSTR(c1,n1[,n2]) - *****
   - ���ڿ� �Լ� �� ���� ���� ���
   - �κ� ���ڿ��� ����
   - �־��� ���ڿ� c1���� n1�ڸ����� n2���ڼ� ��ŭ �����Ͽ� ��ȯ
   - n2�� �����Ǹ� n1���� ��� ���ڿ��� �����Ͽ� ��ȯ
   - n1�� 1���� ����
   - n1�� �����̸� ���ڿ��� �� ������ ����
 
 ��뿹)
    SELECT SUBSTR('���ѹα� ������ �߱�',2,5) AS COL1,
           SUBSTR('���ѹα� ������ �߱�',2,15) AS COL2,
           SUBSTR('���ѹα� ������ �߱�',2) AS COL3,
           SUBSTR('���ѹα� ������ �߱�',-2,5) AS COL4
    FROM DUAL;
    -- n2�� �����Ͱ����� ũ�ٸ� n2�� �������� ���ų� �Ȱ���
 
** ǥ����
  - sql���� IF���̳� ���� �б��� ����� ����
  - SELECT �������� ��� ����**
  - CASE ~ WHEN THEN, DECODE ���� -- ��ɹ��� �ƴ϶� ǥ������
  - �ݵ�� END�� ������ -- JAVA�� SWICH ���� ���
  (1) CASE ~ WHEN THEN
   (�������-1)
    CASE WHEN ���ǽ� THEN ��1
        [WHEN ���ǽ� THEN ��2
                :
        ELSE ��n
    END
   (�������-2)
    CASE ���ǽ� WHEN ��1 THEN ���1
              [WHEN ��2 THEN ���2
                :
               ELSE ���n
    END
    
    -- trunc�� ������ ex)�������-2 ��� ���ǽĿ� trunc(scor/10)�� �Ѵٸ� 9~9.9�� �� 9���Ǳ⿡
    -- ���� 9�� ���A���� �̷������� ���԰���
    


  (2) DECODE
   (�������)
    DECODE(�÷���,����1,���1,����2,���2,...,����n,���n)
    DECODE(trunc(score/10),9,'A',8,'B'....
    
    
��뿹) ȸ�����̺��� �ֹε�� ��ȣ�� �̿��Ͽ� ������ ���ϰ� ����ϴ� ���� �ۼ�
        ALIAS�� ȸ����ȣ, ȸ����, �ֹι�ȣ, ����
         -- ������ ��� WHERE�� �ʿ����
        -1����-
        SELECT MEM_ID AS ȸ����ȣ,
               MEM_NAME AS ȸ����,
               MEM_REGNO1||'-'||MEM_REGNO2 AS �ֹι�ȣ,
               CASE WHEN ((SUBSTR(MEM_REGNO2,1,1) IN('2','4')) THEN '����'
                                                               ELSE '����'
                                                               END AS ����
        FROM MEMBER
        
        
        -2����
        SELECT MEM_ID AS ȸ����ȣ,
               MEM_NAME AS ȸ����,
               MEM_REGNO1||'-'||MEM_REGNO2 AS �ֹι�ȣ,
                 CASE (SUBSTR(MEM_REGNO2,1,1)) WHEN '1' THEN '����'
                                               WHEN '3' THEN '����'
                                               ELSE '����'
                                               END AS ����
        FROM MEMBER
        
        -3����-
        SELECT MEM_ID AS ȸ����ȣ,
               MEM_NAME AS ȸ����,
               MEM_REGNO1||'-'||MEM_REGNO2 AS �ֹι�ȣ,
               DECODE (SUBSTR(MEM_REGNO2,1,1),'2','����','4','����','����') AS ����
        FROM MEMBER;
    
 8) REPLACE(c1, c2 [,c3]) **
    - �־��� ���ڿ� c1���� c2���ڿ��� ã�� c3���ڿ��� ��ġ��Ŵ
    - c3�� �����Ǹ� c2�� ã�� ����
     (c3�� �����ϰ� c2�� �������� �����ϸ� ���ڿ� ������ ������ ������ �� ����
     
 ��뿹) �ŷ�ó ���̺��� �ּҿ��� '���� '�� ã�� '����Ư���� '�� �ٲپ� ����Ͻÿ�.
    ALIAS�� �ŷ�ó�ڵ�,�ŷ�ó��,�����ּ�,�ٲ��ּ�
    SELECT BUYER_ID AS �ŷ�ó�ڵ�,
           BUYER_NAME AS �ŷ�ó��,
           BUYER_ADD1 AS �����ּ�,
           REPLACE(BUYER_ADD1,'���� ','����Ư���� ') AS �ٲ��ּ�,
           REPLACE(BUYER_ADD1,' ') 
           
    FROM BUYER;
    -- ������ �����Ҷ� c2�ڸ��� ' ' ������ �� �ۼ��������

 9) INSTR(c1, c2[m [,n]]) - *
   - �־��� ���ڿ� c1���� c2�� ó�� ���� ��ġ�� ��ȯ
   - m�� �˻� ������ġ�� �����ϴ� ��� ���
   - n�� �˻��� c2�� �ݺ�Ƚ�� -- ex)2��� 2��°������ġ
 ��뿹)
    SELECT INSTR('CANADABANANA', 'NA') AS COL1,
           INSTR('CANADABANANA', 'NA',4) AS COL2,
           INSTR('CANADABANANA', 'NA',2,2) AS COL3
    FROM DUAL;
    
 10) LENGTH(c1), LENGTHB(c1) - **
    - c1 ���ڿ��� ũ�⸦ BYTE��(LENGTHB) �Ǵ� ���ڼ�(LENGTH)�� ��ȯ
    
    ��뿹)
        SELECT PROD_NAME AS ��ǰ��,
               LENGTHB(PROD_NAME) AS "�������� ũ��", --�ѱ���3BYTE, ����,����,����� 1BYTE
               LENGTH(PROD_NAME) AS "���� ��"
        FROM PROD;