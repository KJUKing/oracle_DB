2024-0703-02)SEQUENCE
    - 연속적으로 자동 증가[감소]하는 값을 생성하는 객체
    - 테이블과 독립적으로 생성
    - CACHE를 사용할 수 있어 시퀀스의 엑세스 효율이 증가
    - PRIMARY로 사용할 적당한 컬럼이 없는 경우 PK로 사용
    (사용형식)
    CREATE SEQUENCE 시퀀스명
        [START WITH n] --시퀀스 시작 값 설정, 생략하면 증가일때는 MINVALUE,
                         감소일때는 MAXVALUE
        [INCREMENT BY n]  --증가[감소] 값 설정, 생략하면 1
        [MAXVALUE n|NOMAXVALUE] -- 최대값 설정, 기본은 NOMAXVALUE, 10^27
        [MINVALUE n|NOMINVALUE] -- 최대값 설정, 기본은 NOMINVALUE, 1
        [CYCLE | NOCYCLE] -- 최대[최소]값에 도달한 후 다시 시퀀스 생성여부
                             기본은 NOCYCLE
        [CACHE n | NOCACHE] --캐쉬메모리 사용여부, 기본은 CHCHE 16
    - 시퀀스 의사 컬럼
    --------------------------------------------------------------------
        의사컬럼            설명
    --------------------------------------------------------------------
    시퀀스명.NEXTVAL        현재 시퀀스 다음 값 반환
    시퀀스명.CURRVAL        현재 시퀀스 값 반환
    --------------------------------------------------------------------
    ***시퀀스 생성 후 첫 번째 명령은 반드시 '시퀀스명.NEXTVAL'이어야 함
    
    사용예) 다음 자료를 LPROD에 저장하시오
    -----------------------------------------------------
    LPROD_ID        LPROD_GU        LPROD_NM
    -----------------------------------------------------
    10              P501            농산물
    11              P502            수산물
    *단, LPROD_ID 시퀀스를 이용하시오
    
    CREATE SEQUENCE SEQ_LPROD
        START WITH 10;
    
    INSERT INTO LPROD VALUES(SEQ_LPROD.NEXTVAL, 'P501', '농산물')
        INSERT INTO LPROD VALUES(SEQ_LPROD.NEXTVAL, 'P502', '수산물')
    SELECT * FROM LPROD
    SELECT SEQ_LPROD.CURRVAL FROM DUAL
        