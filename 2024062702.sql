2024-0627-02) �ݺ���
    - ���߾���� �ݺ����� ���ϱ��
    - LOOP, WHILE, FOR���� ����
    1. LOOP��
        - �ݺ����� �⺻��
        - ���ѷ��� ����
        (�������)
        LOOP
            �ݺ����(��);
            [EXIT WEHN ����];
                :
        END LOOP;
        
        --�ݺ����� �־���??
        -- �ٷ� Ŀ�������̴�.
        
    ��뿹) �������� 7���� ����Ͻÿ�
    DECLARE
        L_CNT NUMBER :=0;
    BEGIN
        LOOP
            L_CNT:=L_CNT+1;
            EXIT WHEN L_CNT>9;
            DBMS_OUTPUT.PUT_LINE('7 *'||L_CNT||'='||7*L_CNT);
        END LOOP;
    END;
    
    ��뿹) ������ �����ϴ� ȸ�� �� ����ȸ���� ȸ����ȣ, ȸ����, �ּ�, ������ ��ȸ�ϴ� �͸����� ��ȸ�Ͻÿ�
    
    DECLARE
        L_MID MEMBER.MEM_ID%TYPE;
        L_NAME MEMBER.MEM_NAME%TYPE;
        L_ADDR VARCHAR2(500);
        L_JOB MEMBER.MEM_JOB%TYPE;
        CURSOR CUR_MEMBER IS
            SELECT MEM_ID, MEM_NAME, MEM_ADD1 ||' '||MEM_ADD2, MEM_JOB
            INTO L_MID, L_NAME, L_ADDR, L_JOB
            FROM MEMBER
            WHERE MEM_ADD1 LIKE '����%'
                AND SUBSTR(MEM_REGNO2,1,1) IN('2','4');
    BEGIN
        OPEN CUR_MEMBER;
        LOOP
            FETCH CUR_MEMBER INTO L_MID, L_NAME, L_ADDR, L_JOB;
            DBMS_OUTPUT.PUT_LINE('��ȣ       �̸�           ����          �ּ� ');
            DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');
            EXIT WHEN CUR_MEMBER%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(L_MID||' '||L_NAME||' '||RPAD(L_JOB,5) ||' '||L_ADDR);
            DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('ȸ�� �� : '||CUR_MEMBER%ROWCOUNT);
    END;
    
    ��뿹) Ű����� �μ���ȣ(10-110)�� �ϳ� �Է� �޾� �ش�μ��� ���� ��������� ��ȸ�Ͻÿ�
           ��»����� �����ȣ, �����, �μ����̴�.
           
    ACCEPT P_DEPT PROMPT '�μ���ȣ(10~110) : '
    DECLARE
        L_EMP_ID HR.EMPLOYEES.EMPLOYEE_ID%TYPE;
        L_EMP_NAME VARCHAR2(200);
        L_DEPT_NAME VARCHAR2(200);
        L_DEPT HR.DEPARTMENTS.DEPARTMENT_ID%TYPE:=TO_NUMBER('&P_DEPT');
        
        CURSOR CUR_EMP01(P_DID HR.DEPARTMENTS.DEPARTMENT_ID%TYPE) IS
            SELECT EMPLOYEE_ID, EMP_NAME
            FROM HR.EMPLOYEES
            WHERE DEPARTMENT_ID = P_DID;
    BEGIN
        OPEN CUR_EMP01(L_DEPT);
        DBMS_OUTPUT.PUT_LINE('�����ȣ     �����            �μ���');
        DBMS_OUTPUT.PUT_LINE('-----------------------------------------------------------');
        LOOP
            FETCH CUR_EMP01 INTO L_EMP_ID,  L_EMP_NAME;
            EXIT WHEN CUR_EMP01%NOTFOUND;
            
            SELECT DEPARTMENT_NAME INTO L_DEPT_NAME
            FROM HR.DEPARTMENTS
            WHERE DEPARTMENT_ID = L_DEPT;
        
        DBMS_OUTPUT.PUT_LINE('  '||RPAD(L_EMP_ID,5)||' '||RPAD(L_EMP_NAME, 15)||
                             L_DEPT_NAME);
        END LOOP;
        CLOSE CUR_EMP01;
    END;

    2. WHILE��
        - ���߾���� WHILE�� ���� ���
        (�������)
        WHILE ���� LOOP
            �ݺ����(��);
        END LOOP;
            - ������ ���̸� �ݺ� ����, ������ �����̸� WHILE�� ���
    
    ��뿹) �������� 7���� ����Ͻÿ�
    
    DECLARE
        L_CNT NUMBER := 1;
    BEGIN
        LOOP
            WHILE L_CNT <=9 LOOP
            DBMS_OUTPUT.PUT_LINE('7 * '||L_CNT||'='||7*L_CNT);
            L_CNT:=L_CNT+1;
            END LOOP;
            EXIT;
        END LOOP;
    END;
    
    ��뿹) ������ �����ϴ� ȸ�� �� ����ȸ���� ȸ����ȣ, ȸ����, �ּ�, ������ ��ȸ�ϴ�
            �͸����� ����ÿ�
    DECLARE
        L_MID MEMBER.MEM_ID%TYPE;
        L_NAME MEMBER.MEM_NAME%TYPE;
        L_ADDR VARCHAR2(500);
        L_JOB MEMBER.MEM_JOB%TYPE;
        CURSOR CUR_MEMBER IS
            SELECT MEM_ID, MEM_NAME, MEM_ADD1||' '||MEM_ADD2, MEM_JOB
            INTO L_MID, L_NAME, L_ADDR, L_JOB
            FROM MEMBER
            WHERE MEM_ADD1 LIKE '����%'
                AND SUBSTR(MEM_REGNO2,1,1) IN('2','4');
    BEGIN
        OPEN CUR_MEMBER;
        FETCH CUR_MEMBER INTO L_MID, L_NAME, L_ADDR, L_JOB;
        DBMS_OUTPUT.PUT_LINE('��ȣ       �̸�           ����          �ּ� ');
        DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');
        WHILE CUR_MEMBER%FOUND LOOP
            EXIT WHEN CUR_MEMBER%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(L_MID||' '||L_NAME||' '||RPAD(L_JOB,5) ||' '||L_ADDR);
            DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');
            FETCH CUR_MEMBER INTO L_MID, L_NAME, L_ADDR, L_JOB;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('ȸ�� �� : '||CUR_MEMBER%ROWCOUNT);
    END;      
    
    (�Ϲ� FOR�� �������)
    FOR �ε��� IN [REVERSE] �ʱⰪ..������ LOOP
        �ݺ���ɹ�(��);
    END LOOP;
        - '�ε���'�� '�ʱⰪ' ���� '������'���� ���ʴ�� ������ �� '�ݺ���ɹ�(��)'���� ����
        - '�ε���'�� 1�� ���� �Ǵ� ����(REVERSE)�ϸ� �ý��ۿ��� ����
        - �������� �ݺ� ��ų������ 'REVERSE'�� �߰��ϸ��
        
    (Ŀ���� FOR�� �������)
    FOR ���ڵ� IN Ŀ���� | �ζ��� �������� LOOP
        �ݺ���ɹ�(��);
        - '���ڵ�'�� Ŀ�� ���� �����͸� ������� ��Ī��
        - Ŀ�� ��� Ŀ���� �����ϴ� SELECT���� ���� IN������ ����� �� ����
        - Ŀ������ ���� �����ϴ� ���
          ���ڵ�.�÷���
        - �� FOR���� ����ϸ� OPEN, FETCH, CLOSE���� ������
        
    ��뿹) �������� 7���� ����Ͻÿ�
    
    DECLARE
    
    BEGIN
        FOR L_CNT IN 1..9
            LOOP
                DBMS_OUTPUT.PUT_LINE('7 * '||L_CNT||'='||7*L_CNT);
            END LOOP;
    END;
        
    ��뿹) ������ �����ϴ� ȸ�� �� ����ȸ���� ȸ����ȣ, ȸ����, �ּ�, ������ ��ȸ�ϴ�
            �͸����� ����ÿ�
            
    DECLARE
        L_CNT NUMBER :=0;
            
    BEGIN
        DBMS_OUTPUT.PUT_LINE('��ȣ       �̸�           ����          �ּ� ');
        DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');
        FOR REC IN (SELECT MEM_ID, MEM_NAME, MEM_ADD1||' '||MEM_ADD2 AS ADDR, MEM_JOB
                    FROM MEMBER
                    WHERE MEM_ADD1 LIKE '����%'
                        AND SUBSTR(MEM_REGNO2,1,1) IN('2','4'))
        LOOP
            L_CNT := L_CNT+1;
            DBMS_OUTPUT.PUT_LINE(REC.MEM_ID||' '||REC.MEM_NAME||' '||RPAD(REC.MEM_JOB,8) ||' '||REC.ADDR);
            DBMS_OUTPUT.PUT_LINE('------------------------------------------------------');
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('�ο��� : ' || L_CNT);
    END;      