2024-0604-01)����� ����
 - CREATE USER ���
 (�������)
 CREATE USER ������ IDENTIFIED BY ��ȣ;
 
 CREATE USER JU IDENTIFIED BY java;
 
 
 
 - GRANT ������ ���� ����
 (�������)
 GRANT ���Ѹ� [, ���Ѹ�, ...] TO ������;
 
 GRANT CONNECT, RESOURCE, DBA TO JU;
 
 
 - �����ڷ� ���
 
 ** HR���� Ȱ��ȭ
 (�������)
 ALTER USER ������ ACCOUNT UNLOCK;
 ALTER USER ������ IDENTIFIED BY ��ȣ;
 
 (HR ���� Ȱ��ȭ)
 ALTER USER HR ACCOUNT UNLOCK;
 
 ALTER USER HR IDENTIFIED BY java;