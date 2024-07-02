2024-0607-03)DML(Date Manipulation Language)
    -데이터 조작 명령문
    -insert, update, delete, select, merge명령이 제공
    
    1. insert 명령
        - 신규 자료를 테이블에 저장하는 명령
        - 해당 테이블에 자료가 존재하지 말아야 함
        - 참조관계가 존재하는 경우 부모테이블부터 입력되어야 함(참조 무결성)
    사용형식)
        INSERT INTO 테이블명[(컬럼명 [, 컬럼명, ...])]
            VALUES(값1, 값2,...값n) | 서브쿼리;
            .  '(컬럼명 [, 컬럼명, ...])' 이 생략되면 테이블의 모든 컬럼에 값을 배정해야 함
            .  서브쿼리를 이용하여 값을삽입하는 경우 VALUES 단어 생략
    
    사용예) HR계정의 JOBS테이블에 다음 데이터를 삽입하시오
    -----------------------------------------------------------
     JOB_ID    JOB_TITLE    MIN_SALALY    MAX_SALALY
    -----------------------------------------------------------
    
    J_01        사원         2500000        3000000
    J_02        대리         
    J_03        팀장         4000000      
    
    INSERT INTO HR.JOBS VALUES('J_01', '사원', 250000,300000);
    INSERT INTO HR.JOBS VALUES('J_02', '대리');
    INSERT INTO HR.JOBS VALUES('J_03', '팀장', 400, NULL);
    SELECT * FROM HR.JO
    
    