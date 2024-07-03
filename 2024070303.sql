2024-0703-03)���Ǿ�(SYNONYM)
    - ����Ŭ ��ü�� �ٿ����� �� �ٸ� �̸�
    - �÷��� ��Ī�̳� ���̺� ��Ī�� �ش� SQL�ȿ����� ��� �����ϳ�
      ���Ǿ�� ������ ��밡��
    - ������ ��ü�� �����Ǵ� ���� �ƴ϶� �̸��� �ϳ��� �����Ǵ� ����
    - ��ü�� ��Ű���� �����ϰų� �� ��� �����ϰ� ����ϱ� ���� �̸��� �ʿ��� ���
    (�������)
    CREATE [OR REPLACE] [PUBLIC|PRIVATE] SYNONYM ���Ǿ� FOR ��ü��;
        - 'PUBLIC|PRIVATE' : ��ü�� ���� ���� ����. �⺻�� PUBLIC
        
    ��뿹) HR������ DEPARTMENTS ���̺��� DEPT��� ���Ǿ �ο��ϰ� �̸� ����Ͽ�
           2023�� �Ի��� ������� �����ȣ, �����, �Ի���, �μ����� ����Ͻÿ�
        
    CREATE OR REPLACE SYNONYM DEPT FOR HR.DEPARTMENTS;
    CREATE OR REPLACE SYNONYM EMP FOR HR.EMPLOYEES;
    
    DROP SYNONYM EMP;
    
    SELECT A.EMPLOYEE_ID AS �����ȣ,
           A.EMP_NAME AS �����,
           A.HIRE_DATE AS �Ի���,
           B.DEPARTMENT_NAME AS �μ���
    FROM EMP A, DEPT B
    WHERE EXTRACT(YEAR FROM A.HIRE_DATE)=2023
        AND A.DEPARTMENT_ID=B.DEPARTMENT_ID;