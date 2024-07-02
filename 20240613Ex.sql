회원테이블에서 회원들의 나이를 구하고 연령대를 출력하시오.
ALIAS 회원이름, 주민번호, 회원나이, 연령대

SELECT MEM_NAME AS 회원이름,
       MEM_REGNO1||'-'||MEM_REGNO2 AS 주민번호,
       EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR) AS 회원나이,
       DECODE(
        TRUNC((EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM MEM_BIR)) / 10),
        1, '10대',
        2, '20대',
        3, '30대',
        4, '40대',
        5, '50대',
        6, '60대',
        7, '70대',
        8, '80대',
        9, '90대',
        '기타'
       ) AS 연령대

       FROM MEMBER;
       
       
SELECT MEM_NAME,
          MEM_REGNO1||'-'||MEM_REGNO2,
          CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('3','4') THEN
               EXTRACT(YEAR FROM SYSDATE) -
                 TO_NUMBER('20'||SUBSTR(MEM_REGNO1,1,2))
          ELSE
               EXTRACT(YEAR FROM SYSDATE) -
                 TO_NUMBER('19'||SUBSTR(MEM_REGNO1,1,2))
          END AS 나이,
          
          CASE WHEN SUBSTR(MEM_REGNO2,1,1) IN('3','4') THEN
               TRUNC((EXTRACT(YEAR FROM SYSDATE) -
                   TO_NUMBER('20'||SUBSTR(MEM_REGNO1,1,2)))/10)*10 ||'대'
          ELSE
               TRUNC((EXTRACT(YEAR FROM SYSDATE) -
                   TO_NUMBER('19'||SUBSTR(MEM_REGNO1,1,2)))/10)*10 ||'대' 
          END AS 년령대
          
     FROM MEMBER;   

