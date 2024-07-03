2024-0703-01)INDEX
    - 인덱스는 검색을 최적화하기위한 객체
    - DBMS의 부하를 줄여서 시스템 전체 성능을 향상
    - 별도의 공간과 시스템 자원이 필요
    - 인덱스의 생성과 관리에 많은 시간이 소요됨
    - 인덱스가 필요한 컬럼
        . 검색의 조건에 자주 사용되는 컬럼
        . 정렬의 기준이 되는 컬럼
        . 기본키나 외래키로 사용되는 컬럼
    - 인덱스가 불필요한 컬럼
        . 부정성(NOT, !등) 연산자가 사용된 컬럼
        . NULL을 비교할때 사용되는 컬럼
        . 비교되기전 변형이 적용되는 컬럼
    - 인덱스 구성 구조
        . 트리기반 인덱스/ HASH기반 인덱스/ BITMAP INDEX/ FUNCTION BASED INDEX 등으로 구분
    (사용형식)
    CREATE [REVERSE] [UNIQUE|BITMAP] INDEX 인덱스명
        ON 테이블명(컬럼명[ASC|DESC] [,컬럼명[ASC|DESC],...]);
        
    사용예) MEMBER 테이블에서 회원이름으로 인덱스를 구성하시오
    '정은실'회원의 회원번호, 주소, 직업, 마일리지를 조회하시오
    SELECT MEM_ID AS 회원번호,
           MEM_ADD1||'  '||MEM_ADD2 AS 주소,
           MEM_JOB AS 직업,
           MEM_MILEAGE AS 마일리지
    FROM MEMBER
    WHERE MEM_NAME='정은실'
    
    CREATE INDEX IDX_MEM_NAME ON MEMBER(MEM_NAME);
    ** INDEX 삭제
    DROP INDEX 인덱스명;
    
    DROP INDEX IDX_MEM_NAME;
    
    ** 인덱스 재구성
        - 테이블이 다른 테이블스페이스로 이동한 경우
        - 자료의 변경이 많이 발생된 경우
        ALTER INDEX 인덱스명 REBUILD;