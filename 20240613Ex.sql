ȸ�����̺��� ȸ������ ���̸� ���ϰ� ���ɴ븦 ����Ͻÿ�.
ALIAS ȸ���̸�, �ֹι�ȣ, ȸ������, ���ɴ�

SELECT MEM_NAME AS ȸ���̸�,
       MEM_REGNO1||'-'||MEM_REGNO2 AS �ֹι�ȣ,
       EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR) AS ȸ������,
       DECODE(
        TRUNC((EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR)) / 10),
        1, '10��',
        2, '20��',
        3, '30��',
        4, '40��',
        5, '50��',
        6, '60��',
        7, '70��',
        8, '80��',
        9, '90��',
        '��Ÿ'
       ) AS ���ɴ�

       FROM MEMBER;
       
       
SELECT MEM_NAME,
          MEM_REGNO1||'-'||MEM_REGNO2,
          CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('3','4') THEN
               EXTRACT(YEAR FROM SYSDATE) -
                 TO_NUMBER('20'||SUBSTR(MEM_REGNO1,1,2))
          ELSE
               EXTRACT(YEAR FROM SYSDATE) -
                 TO_NUMBER('19'||SUBSTR(MEM_REGNO1,1,2))
          END AS ����,
          
          CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('3','4') THEN
               TRUNC((EXTRACT(YEAR FROM SYSDATE) -
                   TO_NUMBER('20'||SUBSTR(MEM_REGNO1,1,2)))/10)*10 ||'��'
          ELSE
               TRUNC((EXTRACT(YEAR FROM SYSDATE) -
                   TO_NUMBER('19'||SUBSTR(MEM_REGNO1,1,2)))/10)*10 ||'��' 
          END AS ��ɴ�
          
     FROM MEMBER;   

