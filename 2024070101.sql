2024-0701-01)User Defined Function
    - 반환값을 가지고 있는 모듈
    - 나머지 특징은 PROCEDURE과 동일
    (생성 사용 형식)
    CREATE [OR REPLACE[ FUNCTION 함수명[(
        변수명 [IN|OUT|INOUT] 데이터 타입 [:=default 값][,]
                    :
        변수명 [IN|OUT|INOUT] 데이터 타입 [:=default 값])]
    RETURN 타입명
    IS|AS
        선언블록
    BEGIN
        실행블록
        [EXCEPTION
            예외처리]
    END;
        - 'RETURN 타입명' : 반환할 데이터 타입을 기술(반환 값 기술이 아님)
        - 실행블록 안에 1개 이상의 'RETURN 값|expr' 문이 있어야함
        - 매개변수 타입에 OUT 모드가 허용되기는 하지만 사용할 수 없음
        
    사용예)
    
    (1) 회원 아이디를 입력 받아 마일리지를 반환하는 함수 작성
    
    CREATE OR REPLACE FUNCTION fn_mileage(
        PMID MEMBER.MEM_ID%TYPE)
        RETURN NUMBER
    IS
        L_MILEAGE MEMBER.MEM_MILEAGE%TYPE;
    BEGIN
        SELECT MEM_MILEAGE INTO L_MILEAGE
        FROM MEMBER
        WHERE MEM_ID=PMID;
        RETURN L_MILEAGE;
    END;
    
    [실행]
    SELECT  MEM_ID, MEM_NAME, fn_mileage(MEM_ID)
    FROM MEMBER
    ORDER BY 3 DESC;
    
    (2) 년과 월의 회원번호를 입력받아 구매금액합계를 반환하는 함수 작성
    CREATE OR REPLACE FUNCTION FN_SUM_CART(
        P_PERIOD CHAR, P_MID MEMBER.MEM_ID%TYPE) --MOD가없으면 IN으로간주
        RETURN NUMBER
    IS
        L_SUM NUMBER :=0;
    BEGIN
        SELECT SUM(A.CART_QTY * B.PROD_PRICE) INTO L_SUM
        FROM CART A, PROD B
        WHERE A.CART_PROD=B.PROD_ID
            AND A.CART_MEMBER = P_MID
            AND A.CART_NO LIKE P_PERIOD||'%';
        RETURN L_SUM;
        EXCEPTION WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('에러발생 : '||SQLERRM);
    END;
    
    [실행]
    SELECT MEM_ID AS 회원번호,
           MEM_NAME AS 회원명,
           FN_SUM_CART('202005', MEM_ID) AS 구매금액합계
    FROM MEMBER
    WHERE MEM_ADD1 LIKE '대전%';
    
    (3) 오늘 날짜를 입력받아 장바구니 번호를 생성하시오.
    CREATE OR REPLACE FUNCTION fn_cart_no(P_DATE IN DATE)
        RETURN VARCHAR2
    IS
        L_CNT NUMBER := 0;
        L_CART_NO CART.CART_NO%TYPE;
        L_NUM NUMBER(5) := 0;
        L_DATE CHAR(9) := TO_CHAR(P_DATE, 'YYYYMMDD')||'%';
    BEGIN
        SELECT COUNT(*) INTO L_CNT
        FROM CART
        WHERE CART_NO LIKE L_DATE;
        
        IF L_CNT=0 THEN
            L_CART_NO := TO_CHAR(P_DATE, 'YYYYMMDD')||TRIM('00001');
        ELSE
            SELECT MAX(CART_NO)+1 INTO L_CART_NO
            FROM CART
            WHERE CART_NO LIKE L_DATE;
        END IF;
        RETURN L_CART_NO;
    END;
    
    [실행]
    (1) 2020 년 4월 5일 이라하고 'a001'회원이 'P201000006'상품을 5개 구입
    INSERT INTO CART VALUES('a001', fn_cart_no(TO_DATE('20200405')),
                            'P201000006',5);
    (2) 오늘 날짜에 회원 'q001'회원이 'P302000016'을 15개 구입
    INSERT INTO CART VALUES('q001', fn_cart_no(SYSDATE), 'P302000016', 15)
    
    
    ----------------------------------------------------
    [좀더 정교한 펑션]
    CREATE OR REPLACE FUNCTION fn_cart_no_NEW(P_DATE IN DATE,
                                              P_MID IN MEMBER.MEM_ID%TYPE)
        RETURN VARCHAR2
    IS
        L_CNT NUMBER := 0;
        L_CART_NO CART.CART_NO%TYPE;
        L_MID MEMBER.MEM_ID%TYPE;
        L_DATE CHAR(9) := TO_CHAR(P_DATE, 'YYYYMMDD')||'%';
    BEGIN
        SELECT COUNT(*) INTO L_CNT
        FROM CART
        WHERE CART_NO LIKE L_DATE;
        
        IF L_CNT=0 THEN
            L_CART_NO := TO_CHAR(P_DATE, 'YYYYMMDD')||TRIM('00001');
        ELSE
            SELECT MAX(CART_NO) INTO L_CART_NO
            FROM CART
            WHERE CART_NO LIKE L_DATE;
            
            SELECT DISTINCT CART_MEMBER INTO L_MID
            FROM CART
            WHERE CART_NO = L_CART_NO;
            
            IF L_MID <> P_MID THEN 
                L_CART_NO:=L_CART_NO+1;
            END IF;
        END IF;
        RETURN L_CART_NO;
    END;
    
    [실행]
    (1) 2020 년 4월 15일 이라하고 'w001'회원이 'P201000006'상품을 5개 구입
    INSERT INTO CART VALUES('w001', fn_cart_no_NEW(TO_DATE('20200415'), 'w001'), 'P201000006', 5);
    (2) 2020SUS 4월 1일이라 하고 't001'회원이 'P201000006'을 15개 구입
    INSERT INTO CART VALUES('t001', fn_cart_no_NEW(TO_DATE('20200401'), 't001'), 'P302000016', 15);
                            
    사용예) 분류코드를 입력받아 2020년 상반기 분류별 판매실적을 조회하시오
            ALIAS 분류코드, 분류명, 판매수량합계, 판매금액합계
            
    [수량합계]
    CREATE OR REPLACE FUNCTION FN_AMT_QTY(P_LPROD_GU IN LPROD.LPROD_GU%TYPE)
        RETURN NUMBER
    IS
        L_AMT NUMBER := 0;
    BEGIN
        SELECT SUM(A.CART_QTY) INTO L_AMT
        FROM CART A, PROD B
        WHERE B.PROD_LGU= P_LPROD_GU
            AND B.PROD_ID = A.CART_PROD
            AND SUBSTR(A.CART_NO,1,6) BETWEEN '202001' AND '202006';
        RETURN L_AMT;
    END;
    
    [금액합계]
    CREATE OR REPLACE FUNCTION FN_AMT_SUM(P_LPROD_GU IN LPROD.LPROD_GU%TYPE)
        RETURN NUMBER
    IS
        L_SUM NUMBER := 0;
    BEGIN
        SELECT SUM(A.CART_QTY*B.PROD_PRICE) INTO L_SUM
        FROM CART A, PROD B
        WHERE B.PROD_LGU= P_LPROD_GU
            AND B.PROD_ID = A.CART_PROD
            AND SUBSTR(A.CART_NO,1,6) BETWEEN '202001' AND '202006';
        RETURN L_SUM;
    END;
    
    [실행결과]
    SELECT LPROD_GU AS 분류코드,
           LPROD_NM AS 분류명,
           NVL(FN_AMT_QTY(LPROD_GU),0) AS 판매수량합계,
           NVL(FN_AMT_SUM(LPROD_GU),0) AS 판매금액합계
    FROM LPROD;
    
[함수 없이 구현]


    SELECT LPROD_GU AS 분류코드,
           LPROD_NM AS 분류명,
           NVL(TA.BAMT,0) AS 판매수량합계,
           NVL(TA.CAMT,0) AS 판매금액합계
    FROM LPROD L,
         (SELECT B.PROD_LGU AS BPID,
                 SUM(A.CART_QTY) AS BAMT,
                 SUM(A.CART_QTY*B.PROD_PRICE) AS CAMT
          FROM CART A, PROD B
          WHERE B.PROD_ID = A.CART_PROD
            AND SUBSTR(A.CART_NO,1,6) BETWEEN '202001' AND '202006'
            GROUP BY B.PROD_LGU) TA
    WHERE L.LPROD_GU = TA.BPID(+)
        