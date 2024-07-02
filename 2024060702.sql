2024-0607-02)이진자료타입
  - RAW, LONG RAW, BFILE, BLOB 타입 제공
  - 오라클에서 2진자료를 해석하거나 변환하지 않음
    
    1. RAW
        - 비교적 작은 크기의 2진자료
        - 2000BYTE 까지 저장 가능
        - 인덱스 처리가능
        - 16진수와 2진수 형태로 저장
        (사용 형식)
            컬럼명 RAW(크기)
        (사용 예)
            CREATE TABLE TBL_RAW(
            COL1 RAW(2000)
            );
            INSERT INTO TBL_RAW VALUES('FFCD63A7'); --4BYTE
            INSERT INTO TBL_RAW VALUES(HEXTORAW('FFCD63A7'));
            INSERT INTO TBL_RAW VALUES('111111111100110101100011101000111');
            
            SELECT * FROM TBL_RAW;

    2. BFILE
        - 이진자료 저장
        - 4GB자료 저장 가능
        - 원본 파일을 특정 폴더에 저장하고 DATABASE에는 경로와 파일명만 저장
        - 자주 변경되는 원본파일 처리에 적합
        (사용형식)
            컬럼명 BFILE
            - 그림파일을 BFILE형식으로 저장하는 순서
                1)그림파일 준비 (보통 jpg파일)
                2)경로객체(DIRECTORY 객체) 생성
                    -경로명 : 30byte, 파일명 : 256byte까지 허용
                    (사용형식)
                    create or replace directory 디렉토리객체명 as '절대경로명'
                    
                    CREATE OR REPLACE DIRECTORY TEST_DIR AS 'D:\A_TeachingMaterial\02_Oracle\work';
                3)DB에 저장
                INSERT INTO TBL_BFILE VALUES (BFILENAME('TEST_DIR', 'sample.jpg'));
        (사용예)
            CREATE TABLE TBL_BFILE(
            COL1 BFILE);
    3. BLOB(Binary Large Object)
        - 이진자료 저장
        - 4GB자료 저장 가능
        - 원본 파일을 DATABASE 내에 저장
        - 변경이 발생되지 않는 자료처리에 적합
        (사용형식)
        컬럼명 BLOB 
            -자료저장 명령을 표준 SQL이 아닌 PL/SQL명령으로 처리해야함
            
        (사용예)
        CREATE TABLE TBL_BLOB(
            COL1 BLOB
        );
        
        데이터 입력 블록
        
        DECLARE
            L_DIR VARCHAR2(20) := 'TEST_DIR';
            L_FILE VARCHAR2(30) := 'sample.jpg';
            L_BFILE BFILE;
            L_BLOB BLOB;
            
        BEGIN
            INSERT INTO TBL_BLOB(COL1) VALUES(EMPTY_BLOB())
            RETURN COL1 INTO L_BLOB;
            L_BFILE := BFILENAME (L_DIR, L_FILE);
            DBMS_LOB.FILEOPEN(L_BFILE, DBMS_LOB.FILE_READONLY);
            DBMS_LOB.LOADFROMFILE(L_BLOB, L_BFILE, DBMS_LOB.GETLENGTH(L_BFILE));
            DBMS_LOB.FILECLOSE(L_BFILE);
            
            COMMIT;
            
        END;
        