2024-0604-01) CREATE TABLE 명령
    - 테이블 생성
    -(사용형식)
    CREATE TABLE 테이블명(
        컬럼명 데이터타입[크기] [NOT NULL] [DEFAULT 값] [,]
                        :
        컬럼명 데이터타입[크기] [NOT NULL] [DEFAULT 값] [,] 
        
        CONSTRAINT 기본키제약명 PRIMARY KEY(컬럼명[,컬럼명,...]) [,]
        CONSTRAINT 외래키제약명 FOREIGN KEY(컬럼명)
            REFERENCES 테이블명(컬럼명) [,]
                .
                .
        CONSTRAINT 외래키제약명n FOREIGN KEY(컬럼명)
            REFERENCES 테이블명(컬럼명)

사용예)
 . 부서 테이블과 사원테이블 생성
 CREATE TABLE DEPT(
    DEPT_ID VARCHAR2(5),
    DEPT_NAME VARCHAR2(50),
    
    CONSTRAINT pk_dept PRIMARY KEY(DEPT_ID)
);

CREATE TABLE EMP(
    EMP_ID NUMBER(3),
    EMP_NAME VARCHAR2(50) NOT NULL,
    DEPT_ID VARCHAR2(50),
    
    CONSTRAINT pk_emp PRIMARY KEY(EMP_ID),
    
    CONSTRAINT fk_emp_dept FOREIGN KEY(DEPT_ID)
        REFERENCES DEPT(DEPT_ID)
);

