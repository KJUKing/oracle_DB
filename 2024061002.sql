2024-0610-01)UPDATE
    -데이터 내용을 변경할때 사용
    (사용형식)
    UPDATE TABLE 테이블명
        SET 컬럼명=값 | 서브쿼리
                .
                .
        WHERE 조건;
        
        -변경할 자료를 선별하는 조건. 생략하면 모든 자료가 변경됨
        
    사용예) HR계정에서 30번 부서에 속한 사원의 급여를 0으로 변경하시오
    UPDATE HR.EMPLOYEES
        SET SALARY = 10
        WHERE DEPARTMENT_ID=30;
        
        
    SELECT FIRST_NAME, DEPARTMENT_ID, SALARY
    FROM HR.EMPLOYEES
    ORDER BY 2;

    UPDATE ORDERS
    SET ORDER_AMT = (SELECT SUM(A.PRICE*B.ORDER_QTY)
        FORM GOODS A, ORDER_GOODS B
        WHERE B.ORDER_NUM ='20240610001'
        AND A.GID = B.GID)
        
    WHERE CUST_ID =101;

사용예) HR계정의 사원테이블에 EMP_NAME VARCHAR2(60)컬럼을 삽입시키시오
사용예) HR계정의 사원테이블 EMP_NAME컬럼에 FIRST_NAME과  LAST_NAME의 값을 연결하여 저장하시오.
       단 두 이름 사이의 한칸 공백 삽입
    UPDATE HR.EMPLOYEES
        SET EMP_NAME=FIRST_NAME||' '||LAST_NAME;
        


