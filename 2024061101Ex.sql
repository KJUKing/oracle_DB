2024-0611-EX)
���� 1] ȸ�����̺��� ���� ���ϸ����� 2000~4000�� ���ϸ� ������ �ֺ��� ȸ������ ��ȸ �Ͻÿ�.
    SELECT * FROM MEMBER
    WHERE   (MEM_MILEAGE>=2000 AND MEM_MILEAGE<=4000)
            AND MEM_JOB = '�ֺ�';

����2] HR������ ��� ���̺��� �޿��� 3000 �̻��� ����� �����ȣ, �̸�, ��å�ڵ�, �� ���� ��ȸ �Ͻÿ�.
    SELECT EMPLOYEE_ID AS �����ȣ,
           EMP_NAME AS �̸�,
           JOB_ID AS ��å�ڵ�,
           SALARY AS �޿�
    
    FROM HR.EMPLOYEES
    WHERE SALARY >= 3000;

����3] HR������ ��� ���̺��� �޿��� 1500 �̻��̰� �μ���ȣ�� 10 �Ǵ� 30�� ����� �̸��� �޿��� ��ȸ �Ͻÿ�
    SELECT EMP_NAME AS ����̸�,
           SALARY AS �޿�,
           DEPARTMENT_ID AS �μ���ȣ
           
    FROM HR.EMPLOYEES
    WHERE SALARY >=1500
            AND (DEPARTMENT_ID =10 OR DEPARTMENT_ID =30);
            
����4] HR������ ��� ���̺��� �ߺ����� �ʴ� �μ���ȣ�� ����Ͻÿ�
    SELECT DISTINCT DEPARTMENT_ID AS �μ���ȣ
    FROM HR.EMPLOYEES;
    
����5] HR������ ��� ���̺��� 30�� �μ� ���� ��� ��å ���� �ߺ����� �ʰ� ��ȸ�Ͻÿ�
    SELECT DISTINCT JOB_ID
    FROM HR.EMPLOYEES
    WHERE DEPARTMENT_ID = 30;
    