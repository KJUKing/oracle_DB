  SELECT MEM_NAME AS �̸�,
        EXTRACT(YEAR FROM SYSDATE) - 
        CASE 
            WHEN SUBSTR(MEM_REGNO1, 8, 1) IN ('1', '2') THEN 
                    SUBSTR(MEM_REGNO1, 1, 2) + 1900
            WHEN SUBSTR(MEM_REGNO1, 8, 1) IN ('3', '4') THEN 
                    SUBSTR(MEM_REGNO1, 1, 2) + 2000
        END AS ����,
         (EXTRACT(YEAR FROM SYSDATE) - 
    CASE 
        WHEN SUBSTR(MEM_REGNO1, 8, 1) IN ('1', '2') THEN SUBSTR(MEM_REGNO1, 1, 2) + 1900
        WHEN SUBSTR(MEM_REGNO1, 8, 1) IN ('3', '4') THEN SUBSTR(MEM_REGNO1, 1, 2) + 2000
    END) - 
    CASE 
        WHEN TO_CHAR(SYSDATE, 'MMDD') < TO_CHAR(TO_DATE(
            CASE 
                WHEN SUBSTR(MEM_REGNO1, 8, 1) IN ('1', '2') THEN SUBSTR(MEM_REGNO1, 1, 2) + 1900
                WHEN SUBSTR(MEM_REGNO1, 8, 1) IN ('3', '4') THEN SUBSTR(MEM_REGNO1, 1, 2) + 2000
            END || SUBSTR(MEM_REGNO1, 3, 4), 'YYYYMMDD'), 'MMDD') THEN 1 
        ELSE 0 
    END AS ������
    FROM MEMBER;