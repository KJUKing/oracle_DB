2024-0617-01)형변환 함수

    - 자료의 형을 함수가 사용된 위치에서 일시적으로 변환
    - 자바의 CAST 연산자 '( )'동일
    - CAST(expr AS 타입), TO_CHAR(expr [,'fmt']),
        TO_DATE(expr [,'fmt']), TO_NUMBER(expr [,'fmt']) 가 제공
    1) CAST(expr AS 타입)
        - 정의된 'expr'의 값을 '타입'의 값으로 변환
        - 다양한 타입으로 변환 기능하나 형식을 지정한 형태로 변환이 불가능
    사용예)
        SELECT '['||CAST('Hello' AS CHAR(10))||']'
        FROM DUAL;
        
        SELECT CAST(PROD_PRICE AS VARCHAR2(50)),
                LPAD(CAST(PROD_PRICE AS VARCHAR2(55)),50,'*')
                --LPAD는 특정 문자열을 왼쪾에서부터 몰아넣음
        FROM PROD
        WHERE PROD_LGU='P101';
        
    2) TO_CHAR(expr [,'fmt'])
        - 숫자, 날짜, 문자열을 표현한 expr을 'fmt' 형식의 문자열로 변환
        - 'expr'이 문자열인 경우 CHAR, CLOB 타입을 VARCHAR2형식으로 변환만 가능
        - 날짜 형식 문자열
        ------------------------------------------------------
        FORMAT 문자열        의미            사용예
        ------------------------------------------------------
        AD, BC              서기            SELECT TO_CHAR(SYSDATE, 'BC CC')||'세기' FROM DUAL;  
        CC                  세기
        YYYY,YYY,YY,Y       년도            SELECT TO_CHAR(SYSDATE, 'YYYY YYY'),
                                                TO_CHAR(SYSDATE, 'YY Y') FROM DUAL;
        MM, RM              월              SELECT TO_CHAR(SYSDATE, 'MM RM') FROM DUAL;
        MONTH, MON          월              SELECT TO_CHAR(SYSDATE, 'MONTH MON') FROM DUAL;
        Q                   분기            SELECT TO_CHAR(SYSDATE, 'Q') FROM DUAL;
        W, WW               주차            SELECT TO_CHAR(SYSDATE, 'W WW') FROM DUAL;
        DD, DDD             날              SELECT TO_CHAR(SYSDATE, 'D DD DDD') FROM DUAL;
        DAY, DY, D          요일            SELECT TO_CHAR(SYSDATE, 'D DY DAY') FROM DUAL;
        AM, PM,             오전/오후        SELECT TO_CHAR(SYSDATE, 'AM PM') FROM DUAL;
        A.M., P.M.
        HH,HH12, HH24       시간            SELECT TO_CHAR(SYSDATE, 'HH HH12 HH24') FROM DUAL;
        MI                  분              SELECT TO_CHAR(SYSDATE, 'MI') FROM DUAL;
        SS, SSSSS           초              SELECT TO_CHAR(SYSDATE, 'SS SSSSS') FROM DUAL;
        "문자열"             사용자 정의      SELECT TO_CHAR(SYSDATE, 'HH24"시간" MI"분" SS"초" SSSSS') FROM DUAL;
        -------------------------------------------------------
        
        - 숫자 형식 문자열
        -------------------------------------------------------
        FORMAT 문자열     의미                               사용예
        -------------------------------------------------------
            0          사용된 숫자와 대응
                       대응되는 숫자가 무효의 0이면 0을 출력
                       대응되는 숫자가 유효숫자이면 해당 숫자 출력
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
            9          사용된 숫자와 대응
                       대응되는 숫자가 무효의 0이면 공백을 출력
                       대응되는 숫자가 유효숫자이면 해당 숫자 출력
            $,L        숫자 왼쪽에 '$'나 화폐기호를 출력
                       SELECT PROD_NAME AS 상품명,
                              TO_CHAR(PROD_COST, 'L9,999,999') AS 매입단가,
                              TO_CHAR(PROD_PRICE, 'L9,999,999')매출단가,
                              PROD_BUYER AS 매입거래처
                        FROM PROD
                        WHERE PROD_COST>=100000;
                        
                       SELECT EMP_NAME AS 사원명,
                              DEPARTMENT_ID AS 부서번호,
                              JOB_ID AS 직무코드,
                              TO_CHAR(SALARY, '$99,999') AS 급여
                       FROM HR.EMPLOYEES
                       WHERE SALARY >= 5000;
            PR         음수인 경우 '-'부호 대신 '<>'로 묶어 출력 오른쪽 끝에 기술
                       SELECT TO_CHAR(12345, '99,999PR'),
                              TO_CHAR(12345)+10,
                              TO_CHAR(-12345, '99,999PR')
                        FROM  DUAL;
            MI         음수인 경우 '-'부호를 숫자 오른쪽에 출력
                        SELECT TO_CHAR(12345, '99,999MI'),
                               TO_CHAR(-12345, '99,999MI')
                         FROM  DUAL;
            ,  .       ',' : 3자리마다의 자리점
                       '.' : 소숫점
        -------------------------------------------------------
        2) TO_DATE(expr [, 'fmt'])
            - expr로 표현된 문자열(숫자)를 날짜 형식으로 변환
            - 'fmt'는 변환하려는 날짜 타입이 아니라 기술된 expr에 적용도니 형식ㅇ지정
              문자열을 사용해야하며 결과는 표준 날짜형을 반환
            SELECT TO_DATE('서기 2010-06-18','BC YYYY-MM-DD')+25,
                    SYSDATE+25
            FROM DUAL;
              
            SELECT SUBSTR(CART_NO,1,8),
                   TO_DATE(SUBSTR(CART_NO,1,8)),
                   TO_NUMBER(SUBSTR(CART_NO,1,8)), --날짜형식을 문자열에서 숫자로도 바꿀수있다
                   TO_DATE(TO_NUMBER(SUBSTR(CART_NO,1,8)))
            FROM    CART
            WHERE CART_NO LIKE '202007%';
            
        3) TO_NUMBER(expr [, 'fmt'])
            - expr로 표현된 문자열을 숫자 형식으로 변환
            - 'fmt'는 변환하려는 숫자 타입이 아니라 기술된 expr에 적용된 형식지정
              문자열을 사용해야하며 결과는 표준 숫자형을 반환
              
           SELECT TO_NUMBER ('2,345','9,999'), -- 오른쪽에 포메팅 모델을 만들어주면 가능해짐
                  TO_NUMBER ('<12,345>','99,999PR'),
                  TO_NUMBER ('￦12,345.67', 'L99,999.99')
            FROM DUAL;
        사용예)
          (1) 매입테이블에서 2020년 3월 입입정보를 조회하시오.
                Alias는 날짜, 상품번호, 수량, 금액이며 날짜는 'YYYY-MM-DD'형식으로,
                금액은