2024-0604-01) CREATE TABLE ���
    - ���̺� ����
    -(�������)
    CREATE TABLE ���̺��(
        �÷��� ������Ÿ��[ũ��] [NOT NULL] [DEFAULT ��] [,]
                        :
        �÷��� ������Ÿ��[ũ��] [NOT NULL] [DEFAULT ��] [,] 
        
        CONSTRAINT �⺻Ű����� PRIMARY KEY(�÷���[,�÷���,...]) [,]
        CONSTRAINT �ܷ�Ű����� FOREIGN KEY(�÷���)
            REFERENCES ���̺��(�÷���) [,]
                .
                .
        CONSTRAINT �ܷ�Ű�����n FOREIGN KEY(�÷���)
            REFERENCES ���̺��(�÷���)

��뿹)
 . �μ� ���̺�� ������̺� ����
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

