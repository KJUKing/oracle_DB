2024-0611-01)
    1)ȸ�����̺��� ��� ȸ�������� ��ȸ�Ͻÿ�.    -- ������̴ϱ� WHERE ���� -- ����̴ϱ� *
    SELECT * FROM MEMBER;
    
    2)�з����̺��� ��� �з� ������ ��ȸ�Ͻʽÿ� -- LPROD �з�����
    SELECT * FROM LPROD;
    
    3)ȸ�����̺��� ���ϸ����� 3000�̻��� ȸ���� ȸ����ȣ, ȸ����, �ּ�, ���ϸ����� ��ȸ�Ͻÿ�.
    -- ���� ���Ǵ� ������ ���� SELECT FROM WHERE ��
    -- AS �� ���� ��� ����
    SELECT MEM_ID AS ȸ����ȣ, 
           MEM_NAME AS ȸ����, 
           MEM_ADD1||' '||MEM_ADD2 AS �ּ�,
           MEM_MILEAGE AS ���ϸ���
        FROM MEMBER
        WHERE MEM_MILEAGE >= 3000;            -- �۾��� ���� �����Ҷ� WHERE�� ���
        
    4)HR������ ������̺��� 50�� �μ��� ���� ����� �����ȣ, �����, ��å�ڵ�, �޿��� ����ϵ� �޿��� ���� ������� ����Ͻÿ�
    DESCENDING�� �̿��� ��������
    SELECT EMPLOYEE_ID AS �����ȣ,
           EMP_NAME AS �����,    -- F_NAME, L_NMAE ���ĳ��� ���� EMP_NAME
           JOB_ID AS ��å�ڵ�,
           SALARY AS �޿�
           FROM HR.EMPLOYEES
           WHERE DEPARTMENT_ID=50
           ORDER BY 4 DESC;     --SALARY�� �Ⱦ��� SELECT�� 4��°�� ��⿡ 4��� �ᵵ��
        
        
    