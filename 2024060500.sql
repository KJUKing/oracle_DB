2024-0605-01)문자열 자료
    - ' '로 묶인 문자자료
    - 데이터타입 : 가변길이(VARCHAR, VARCHAR2, NVARCHAR2, LONG, CLOB, NCLOB)와
                  고정길이 (CHAR)로 구성
    - (사용형식)
      컬럼명 CHAR|VARCHAR2 (크기[BYTE|CHAR])
      컬럼명 CLOB|LONG
      
사용예)
    CREATE TABLE TBL_CHAR(
        COL1 CHAR(20),
        COL2 CHAR(20 CHAR),
        COL3 VARCHAR2(4000),
        COL4 VARCHAR2(200 CHAR)
    );
    
** 데이터 삽입 명령
    INSERT INTO 테이블명[(컬럼명 [,컬럼명,...])]
      VALUES(값1, 값2, ...);
      - 테이블명 : 데이터를 삽입할 테이블명
      - [(컬럼명 [,컬럼명,...])] : 컬럼명이 생략되면 모든 컬럼에 저장될 데이터를
        VALUES절에 기술해야 함
      - '컬럼명 [,컬럼명,...]'을 기술하는 경우는 일부 컬럼에만 데이터를 입력하는 경우
      - INTO절에 사용될 컬럼명의 갯수와 순서는 VALUES절 값의 갯수, 순서와 일치해야 함
      
    INSERT INTO TBL_CHAR (COL1, COL2)
        VALUES ('대전시 중구', '대전시 중구');
        
    INSERT INTO TBL_CHAR (COL3, COL4)
        VALUES ('대전시 중구', '대전시 중구');
        
    SELECT * FROM TBL_CHAR;
    
    CREATE TABLE TBL_LONG(
    COL1 LONG,
    COL2 CLOB,
    COL3 CLOB
    );
    
    INSERT INTO TBL_LONG VALUES('대전시 중구 계룡로 846',
                                '대전시 중구 계룡로 846',
                                '대전시 중구 계룡로 846');
                                
    SELECT * FROM TBL_LONG;
    
    SELECT -- LENGTHB(COL1) AS "LONG의 길이",
           LENGTH(COL2) AS "CLOB의 길이",
           DBMS_LOB.GETLENGTH(COL2) AS "CLOB의 길이"
      FROM TBL_LONG;