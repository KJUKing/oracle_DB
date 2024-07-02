2024-0702-01) VIEW
    - View는 Table과 유사한 객체이다.
    - View는 기존의 테이블이나 다른 View 객체를 통하여 새로운 SELECT문의 결과를 테이블처럼 사용한다.(가상테이블)
    - View는 SELECT문에 귀속되는 것이 아니고, 독립적으로 테이블처럼 존재
    - View를 이용하는 경우
        . 필요한 정보가 한 개의 테이블에 있지 않고, 여러 개의 테이블에 분산되어 있는 경우
        . 테이블에 들어 있는 자료의 일부분만 필요하고 자료의 전체 row나 column이 필요하지 않은 경우
        . 특정 자료에 대한 접근을 제한하고자 할 경우(보안)
    (사용형식)
    CREATE [OR REPLACE] [FORCE|NOFORCE] VIEW view_name [(columnName_list ...)]
    AS
    select-statment
    [WITH CHECK OPTION]
    [WITH READ ONLY]
    - 'FORCE' : 기준테이블이 없어도 뷰 생성. 기본값은 NOFORCE
    - 'WITH CHECK OPTION' : 뷰를 생성하는 SELECT문의 WHERE문의 WHERE조건을 위배한 경우 오류
    - 'WITH READ ONLY' : 읽기 전용 뷰, WITH READ ONLY와 WITH CHECK OPTION는 동시 사용할 수 없음
    
    ** VIEW 사용시 주의할 점
        - View를 생성할 때 제약조건(WITH)이 있는 경우 ORDER BY 절 불가.
        - View 집계 함수, GROUP BY절, DISTINCT를 사용하여 만들어진 경우
          INSERT, UPDATE, DELETE 구문을 사용할 수 없다.
        - 어느 컬럼이 표현식, 일반 함수를 통하여 만들어진 경우 해당 컬럼의 추가 및 수정 불가능
        - CURRVAL, NEXTVAL 의사컬럼(pseudo column) 사용불가
        - ROWID, ROWNUM, LEVEL 의사컬럼을 사용할 경우 alias를 사용해야함
        
    CREATE OR REPLACE VIEW V_MEM_MILEAGE
    AS
        SELECT MEM_ID AS 회원번호, MEM_NAME AS 회원명, MEM_MILEAGE AS 마일리지
        FROM MEMBER
        WHERE MEM_MILEAGE >=3000;
        
    1) MEMBER 테이블의 'c001'회원의 마일리지를 1500으로 변경
    UPDATE MEMBER
    SET MEM_MILEAGE = 1500
    WHERE MEM_ID='c001'
    
    2)뷰 V_MEM_MILEAGE에서 오철희('k001')의 마일리지를 4000으로 변경시키기
    SELECT * FROM V_MEM_MILEAGE
    
    UPDATE V_MEM_MILEAGE
    SET 마일리지 = 4000
    WHERE 회원번호 = 'k001'
    
    SELECT MEM_ID, MEM_NAME, MEM_MILEAGE
    FROM MEMBER
    WHERE MEM_ID='k001'