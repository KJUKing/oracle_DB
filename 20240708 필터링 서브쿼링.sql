INSERT INTO TIME_TABLE
SELECT B.TIME_NUM,B.TIME_TITLE, B.STATE,
                                        (SELECT A.T_NUM
                                         FROM TEACHER A
                                         WHERE SUBSTR(B.TEACHER_NAME,1,1) = SUBSTR(A.NAME,1,1))
                                         T_NUM, B.DAY
FROM  TIME_TABLE_ B