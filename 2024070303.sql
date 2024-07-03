2024-0703-03)동의어(SYNONYM)
    - 오라클 객체에 붙여지는 또 다른 이름
    - 컬럼의 별칭이나 테이블 별칭이 해당 SQL안에서만 사용 가능하나
      동의어는 언제나 사용가능
    - 별도의 객체가 생성되는 것이 아니라 이름만 하나더 생성되는 것임
    - 객체의 스키마가 복잡하거나 긴 경우 간단하고 사용하기 쉬운 이름이 필요한 경우
    (사용형식)
    CREATE [OR REPLACE] [PUBLIC|PRIVATE] SYNONYM 동의어 FOR 객체명;
        - 'PUBLIC|PRIVATE' : 객체의 접근 범위 설정. 기본은 PUBLIC
        
    사용예) HR계정의 DEPARTMENTS 테이블을 DEPT라는 동의어를 부여하고 이를 사용하여
           2023년 입사한 사원들의 사원번호, 사원명, 입사일, 부서명을 출력하시오
        
    CREATE OR REPLACE SYNONYM DEPT FOR HR.DEPARTMENTS;
    CREATE OR REPLACE SYNONYM EMP FOR HR.EMPLOYEES;
    
    DROP SYNONYM EMP;
    
    SELECT A.EMPLOYEE_ID AS 사원번호,
           A.EMP_NAME AS 사원명,
           A.HIRE_DATE AS 입사일,
           B.DEPARTMENT_NAME AS 부서명
    FROM EMP A, DEPT B
    WHERE EXTRACT(YEAR FROM A.HIRE_DATE)=2023
        AND A.DEPARTMENT_ID=B.DEPARTMENT_ID;