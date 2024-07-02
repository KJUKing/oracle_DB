2024-0610-01)
        
    
        CREATE TABLE CUSTOMER(
        CUST_ID NUMBER(3),
        CUST_NAME VARCHAR2(30),
        ADDRESS VARCHAR2(200),
        
        CONSTRAINTS pk_cust_id PRIMARY KEY(CUST_ID)
        );
        
        CREATE TABLE GOODS(
        GID CHAR(4),
        G_NAME VARCHAR2(50),
        PRICE NUMBER(7),
        
        CONSTRAINTS pk_gid PRIMARY KEY(GID)
        );
        
        SELECT * FROM GOODS;
        
    [주문]
        CREATE TABLE ORDERS(
        ORDER_NUM CHAR(11), --PK
        ORDER_DATE DATE,
        ORDER_AMT NUMBER(8),    --FK
        CUST_ID NUMBER(3),
        CONSTRAINTS pk_orders PRIMARY KEY(ORDER_NUM),
        CONSTRAINTS fk_orders_cust FOREIGN KEY(CUST_ID)
            REFERENCES CUSTOMER(CUST_ID)
        );
        
    [주문상품]
        CREATE TABLE ORDERS_GOODS(
        ORDER_NUM CHAR(11),
        GID CHAR(4),
        ORDER_QTY NUMBER(4),
        
        CONSTRAINTS pk_order_goods PRIMARY KEY(ORDER_NUM, GID),
        CONSTRAINTS fk_orgoods_orders FOREIGN KEY(ORDER_NUM)
            REFERENCES ORDERS(ORDER_NUM),
        CONSTRAINTS fk_orgoods_goods FOREIGN KEY(GID)
            REFERENCES GOODS(GID)
        );
        
        INSERT INTO CUSTOMER VALUES(101, '홍길동', '대전시 중구 계룡로  846');
        INSERT INTO CUSTOMER VALUES(102, '장지연', '충남 계룡시 장안로  46');
        INSERT INTO CUSTOMER VALUES(103, '이덕무', '대전시 유성구 산성동 501');
        INSERT INTO CUSTOMER VALUES(104, '박은식', '충북 청주시 서원구 모충동 10');
        
        SELECT * FROM CUSTOMER;
        
        INSERT INTO GOODS VALUES('P100', '신라면(용기)', 1000);
        INSERT INTO GOODS VALUES('P210', '코카콜라', 1200);
        INSERT INTO GOODS VALUES('P325', '매직마우스2', 120000);
        INSERT INTO GOODS VALUES('P400', '애플워치SE2', 540000);
        
        SELECT * FROM GOODS;
        
        INSERT INTO ORDERS(ORDER_NUM, ORDER_DATE, ORDER_AMT, CUST_ID)
            VALUES('20240610001',SYSDATE, 0, 101);
        SELECT * FROM ORDERS;
        
        INSERT INTO ORDERS_GOODS VALUES('20240610001','P100',3);
        INSERT INTO ORDERS_GOODS VALUES('20240610001','P210',1);
        INSERT INTO ORDERS_GOODS VALUES('20240610001','P325',1);
        
        SELECT * FROM ORDERS_GOODS;
        
        INSERT INTO ORDERS VALUES('20240610002',SYSDATE, 0, 103);
        INSERT INTO ORDERS_GOODS VALUES('20240610002','P325',3);
        
        SELECT B.ORDER_NUM AS "주문번호",
        SUM(A.PRICE*ORDER_QTY) AS "결재금액"
            FROM GOODS A, ORDERS_GOODS B
            WHERE B.ORDER_NUM ='20240610001'
            AND A.GID=B.GID
            GROUP BY B.ORDER_NUM
        