2024-0627-02) 반복문
    - 개발언어의 반복문과 동일기능
    - LOOP, WHILE, FOR문이 제공
    1. LOOP문
        - 반복문의 기본형
        - 무한루프 제공
        (사용형식)
        LOOP
            반복명령(들);
            [EXIT WEHN 조건];
                :
        END LOOP;
        
        --반복문을 왜쓸까??
        -- 바로 커서때문이다.
        
    사용예) 구구단의 7단을 출력하시오
    DECLARE
        L_CNT NUMBER :=0;
    BEGIN
        LOOP
            L_CNT:=L_CNT+1;
            EXIT WHEN L_CNT>9;
            DBMS_OUTPUT.PUT_LINE('7 *'||L_CNT||'='||7*L_CNT);
        END LOOP;
    END;
    
    사용예) 대전에 거주하는 회원 중 여성회원의 회원번호, 회원명, 주소, 직업을 조회하는 익명블록을 조회하시오
    
    DECLARE
        L_MID MEMBER.MEM_ID%TYPE;
        L_NAME MEMBER.MEM_NAME%TYPE;
        L_ADDR VARCHAR2(500);
        L_JOB MEMBER.MEM_JOB%TYPE;
        CURSOR CUR_MEMBER IS
            SELECT MEM_ID, MEM_NAME, MEM_ADD1 ||' '||MEM_ADD2, MEM_JOB
            INTO L_MID, L_NAME, L_ADDR, L_JOB
            FROM MEMBER
            WHERE MEM_ADD1 LIKE '대전%'
                AND SUBSTR(MEM_REGNO2,1,1) IN('2','4');
    BEGIN
        OPEN CUR_MEMBER;
        LOOP
            FETCH CUR_MEMBER INTO L_MID, L_NAME, L_ADDR, L_JOB;
            DBMS_OUTPUT.PUT_LINE('번호       이름           직업          주소 ');
            DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');
            EXIT WHEN CUR_MEMBER%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(L_MID||' '||L_NAME||' '||RPAD(L_JOB,5) ||' '||L_ADDR);
            DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('회원 수 : '||CUR_MEMBER%ROWCOUNT);
    END;
    
    사용예) 키보드로 부서번호(10-110)를 하나 입력 받아 해당부서에 속한 사원정보를 조회하시오
           출력사항은 사원번호, 사원명, 부서명이다.
           
    ACCEPT P_DEPT PROMPT '부서번호(10~110) : '
    DECLARE
        L_EMP_ID HR.EMPLOYEES.EMPLOYEE_ID%TYPE;
        L_EMP_NAME VARCHAR2(200);
        L_DEPT_NAME VARCHAR2(200);
        L_DEPT HR.DEPARTMENTS.DEPARTMENT_ID%TYPE:=TO_NUMBER('&P_DEPT');
        
        CURSOR CUR_EMP01(P_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE) IS
            SELECT EMPLOYEE_ID, EMP_NAME
            FROM HR.EMPLOYEES
            WHERE DEPARTMENT_ID = P_DID;
    BEGIN
        OPEN CUR_EMP01(L_DEPT);
        DBMS_OUTPUT.PUT_LINE('사원번호     사원명            부서명');
        DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------');
        LOOP
            FETCH CUR_EMP01 INTO L_EMP_ID,  L_EMP_NAME;
            EXIT WHEN CUR_EMP01%NOTFOUND;
            
            SELECT DEPARTMENT_NAME INTO L_DEPT_NAME
            FROM HR.DEPARTMENTS
            WHERE DEPARTMENT_ID = L_DEPT;
        
        DBMS_OUTPUT.PUT_LINE('  '||RPAD(L_EMP_ID,5)||' '||RPAD(L_EMP_NAME, 15)||
                             L_DEPT_NAME);
        END LOOP;
        CLOSE CUR_EMP01;
    END;

    2. WHILE문
        - 개발언어의 WHILE과 같은 기능
        (사용형식)
        WHILE 조건 LOOP
            반복명령(들);
        END LOOP;
            - 조건이 참이면 반복 수행, 조건이 거짓이면 WHILE을 벗어남
    
    사용예) 구구단의 7단을 출력하시오
    
    DECLARE
        L_CNT NUMBER := 1;
    BEGIN
        LOOP
            WHILE L_CNT <=9 LOOP
            DBMS_OUTPUT.PUT_LINE('7 * '||L_CNT||'='||7*L_CNT);
            L_CNT:=L_CNT+1;
            END LOOP;
            EXIT;
        END LOOP;
    END;
    
    사용예) 대전에 거주하는 회원 중 여성회원의 회원번호, 회원명, 주소, 직업을 조회하는
            익명블록을 만드시오
    DECLARE
        L_MID MEMBER.MEM_ID%TYPE;
        L_NAME MEMBER.MEM_NAME%TYPE;
        L_ADDR VARCHAR2(500);
        L_JOB MEMBER.MEM_JOB%TYPE;
        CURSOR CUR_MEMBER IS
            SELECT MEM_ID, MEM_NAME, MEM_ADD1||' '||MEM_ADD2, MEM_JOB
            INTO L_MID, L_NAME, L_ADDR, L_JOB
            FROM MEMBER
            WHERE MEM_ADD1 LIKE '대전%'
                AND SUBSTR(MEM_REGNO2,1,1) IN('2','4');
    BEGIN
        OPEN CUR_MEMBER;
        FETCH CUR_MEMBER INTO L_MID, L_NAME, L_ADDR, L_JOB;
        DBMS_OUTPUT.PUT_LINE('번호       이름           직업          주소 ');
        DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');
        WHILE CUR_MEMBER%FOUND LOOP
            EXIT WHEN CUR_MEMBER%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(L_MID||' '||L_NAME||' '||RPAD(L_JOB,5) ||' '||L_ADDR);
            DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');
            FETCH CUR_MEMBER INTO L_MID, L_NAME, L_ADDR, L_JOB;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('회원 수 : '||CUR_MEMBER%ROWCOUNT);
    END;      
    
    (일반 FOR문 사용형식)
    FOR 인덱스 IN [REVERSE] 초기값..최종값 LOOP
        반복명령문(들);
    END LOOP;
        - '인덱스'에 '초기값' 부터 '최종값'까지 차례대로 배정한 후 '반복명령문(들)'들을 수행
        - '인덱스'는 1씩 증가 또는 감소(REVERSE)하며 시스템에서 생성
        - 역순으로 반복 시킬때에는 'REVERSE'만 추가하면됨
        
    (커서용 FOR문 사용형식)
    FOR 레코드 IN 커서명 | 인라인 서브쿼리 LOOP
        반복명령문(들);
        - '레코드'가 커서 내의 데이터를 행단위로 지칭함
        - 커서 대신 커서를 구성하는 SELECT문을 직접 IN다음에 기술할 수 있음
        - 커서내의 행을 참조하는 방법
          레코드.컬럼명
        - 이 FOR문을 사용하면 OPEN, FETCH, CLOSE문이 생략됨
        
    사용예) 구구단의 7단을 출력하시오
    
    DECLARE
    
    BEGIN
        FOR L_CNT IN 1..9
            LOOP
                DBMS_OUTPUT.PUT_LINE('7 * '||L_CNT||'='||7*L_CNT);
            END LOOP;
    END;
        
    사용예) 대전에 거주하는 회원 중 여성회원의 회원번호, 회원명, 주소, 직업을 조회하는
            익명블록을 만드시오
            
    DECLARE
        L_CNT NUMBER :=0;
            
    BEGIN
        DBMS_OUTPUT.PUT_LINE('번호       이름           직업          주소 ');
        DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');
        FOR REC IN (SELECT MEM_ID, MEM_NAME, MEM_ADD1||' '||MEM_ADD2 AS ADDR, MEM_JOB
                    FROM MEMBER
                    WHERE MEM_ADD1 LIKE '대전%'
                        AND SUBSTR(MEM_REGNO2,1,1) IN('2','4'))
        LOOP
            L_CNT := L_CNT+1;
            DBMS_OUTPUT.PUT_LINE(REC.MEM_ID||' '||REC.MEM_NAME||' '||RPAD(REC.MEM_JOB,8) ||' '||REC.ADDR);
            DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('인원수 : ' || L_CNT);
    END;      