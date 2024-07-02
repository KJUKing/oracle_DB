
--SET TERMOUT OFF
SET ECHO OFF


DROP TABLE cart;
DROP TABLE member;
DROP TABLE buyprod;
DROP TABLE prod;
DROP TABLE buyer;
DROP TABLE lprod;


-- 객체이름 30자 이내, 무조건 알파벳시작, 알파벳, 숫자, _,$ 
-- 객체이름은 무조건 대문자로 저장됨. 
CREATE TABLE lprod
(
  lprod_id  NUMBER(7)   NOT NULL,
  lprod_gu  CHAR(4)     NOT NULL,
  lprod_nm  VARCHAR2(40) NOT NULL,
  CONSTRAINT pk_lprod PRIMARY KEY (lprod_gu)
);


INSERT INTO lprod(lprod_id,lprod_gu,lprod_nm) VALUES(1,'P101','컴퓨터제품');
INSERT INTO lprod(lprod_id,lprod_gu,lprod_nm) VALUES(2,'P102','전자제품');
INSERT INTO lprod(lprod_id,lprod_gu,lprod_nm) VALUES(3,'P201','여성캐주얼');
INSERT INTO lprod(lprod_id,lprod_gu,lprod_nm) VALUES(4,'P202','남성캐주얼');
INSERT INTO lprod(lprod_id,lprod_gu,lprod_nm) VALUES(5,'P301','피혁잡화');
INSERT INTO lprod(lprod_id,lprod_gu,lprod_nm) VALUES(6,'P302','화장품');
INSERT INTO lprod(lprod_id,lprod_gu,lprod_nm) VALUES(7,'P401','음반/CD');
INSERT INTO lprod(lprod_id,lprod_gu,lprod_nm) VALUES(8,'P402','도서');
INSERT INTO lprod(lprod_id,lprod_gu,lprod_nm) VALUES(9,'P403','문구류');



-- DROP TABLE buyer
 
CREATE TABLE buyer
(  buyer_id           CHAR(6)       NOT NULL,   --거래처코드 
   buyer_name         VARCHAR2(50)  NOT NULL,   --거래처명
   buyer_lgu          CHAR(4)       NOT NULL,   --취급상품대분류
   buyer_bank         VARCHAR2(40),            --은행
   buyer_bankno       VARCHAR2(40),             --계좌번호
   buyer_bankname     VARCHAR2(15),             --예금주
   buyer_zip          CHAR(7),                  --우편번호
   buyer_add1         VARCHAR2(100),             --주소1
   buyer_add2         VARCHAR2(80),             --주소2
   buyer_comtel       VARCHAR2(14)  NOT NULL,   --전화번호 
   buyer_fax          VARCHAR2(20)  NOT NULL    --fax번호 
);

 ALTER TABLE buyer add ( buyer_mail VARCHAR2(40) NOT NULL,
                         buyer_charger VARCHAR2(10),
                              buyer_telext VARCHAR2(2));


 ALTER TABLE buyer
   modify( buyer_name VARCHAR2(40));
 
 ALTER TABLE buyer
   add ( CONSTRAINT pk_buyer PRIMARY KEY(buyer_id),
           CONSTRAINT fr_buyer_lgu  foreign key(buyer_lgu) 
                               references lprod(lprod_gu) ); 

 
--INSERT INTO buyer (buyer_id, buyer_name, buyer_lgu, buyer_bank, 
--                   buyer_bankno, buyer_bankname, buyer_zip,
--                   buyer_add1, buyer_add2, buyer_comtel, buyer_fax,
--                   buyer_mail, buyer_charger)


INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger)
  VALUES ('P10101','삼성컴퓨터','P101','주택은행','123-456-7890','이건상','135-972','서울 강남구 도곡2동현대비젼21','1125호','02-522-7890','02-522-7891','samcom@samsung.co.kr','송동구');
INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger)  
  VALUES ('P10102','삼보컴퓨터','P101','제일은행','732-702-195670','김현우','142-726','서울 강북구 미아6동 행전빌딩','2712호','02-632-5690','02-632-5699','sambo@sambo.co.kr','김서구');
INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger)
  VALUES ('P10103','현주컴퓨터','P101','국민은행','112-650-397811','심현주','404-260','인천 서구 마전동','157-899번지','032-233-7832','032-233-7833','hyunju@hyunju.com','강남구') ;
INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger)
  VALUES ('P10201','대우전자','P102','농협','222-333-567890','강대우','702-864','대구 북구 태전동','232번지','053-780-2356','053-780-2357','daewoo@daewoo.co.kr','성대우') ;
INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger)
  VALUES ('P10202','삼성전자','P102','외환은행','989-323-567898','박삼성','614-728','부산 부산진구 부전1동 동아빌딩','1708호','051-567-5312','051-567-5313','samsung@samsung.com','김인우');
INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger) 
  VALUES ('P20101','대현','P201','국민은행','688-323-567898','신대현','306-785','대전 대덕구 오정동 운암빌딩','508호','042-332-5123','042-332-5125','daehyun@daehyun.com','진대영');
INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger) 
  VALUES ('P20102','마르죠','P201','주택은행','123-777-7890','이마루','135-972','서울 강남구 도곡2동 현대비젼21','1211호','02-533-7890','02-533-5699','mar@marjo.co.kr','조현상')  ;
INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger)
  VALUES ('P20201','LG패션','P202','제일은행','732-702-556677','김애지','142-726','서울 강북구 미아6동 행전빌딩','5011호','02-332-5690','02-332-5699','lgfashion.co.kr','남지수');
INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger) 
  VALUES ('P20202','캠브리지','P202','국민은행','112-888-397811','안불이주','404-260','인천 서구 마전동','535-899번지','032-255-7832','032-255-7833','cambrige@cambrige.com','신일수');
INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger) 
  VALUES ('P30101','가파치','P301','농협','211-333-511890','김선아','702-864','대구 북구 태전동','555-66호','053-535-2356','053-535-2357','gapachi@gapachi.co.kr','이수나')  ;
INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger)
   VALUES ('P30201','한국화장품','P302','외환은행','333-355-568898','박한국','614-728','부산 부산진구 부전1동 동아빌딩','309호','051-212-5312','051-212-5313','hangook@hangook.com','김사우');
INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger)
  VALUES ('P30202','피리어스','P302','국민은행','677-888-569998','신상우','306-785','대전대덕구 오정동 운암빌딩','612호','042-222-5123','042-222-5125','pieoris@pieoris.com','이진영');
INSERT INTO buyer (buyer_id,buyer_name,buyer_lgu,buyer_bank,buyer_bankno,buyer_bankname,buyer_zip,buyer_add1,buyer_add2,buyer_comtel,buyer_fax,buyer_mail,buyer_charger)
  VALUES ('P30203','참존','P302','주택은행','555-777-567778','오참존','306-785','대전대덕구 오정동 운암빌딩','1007호','042-622-5123','042-622-5125','chamjon@chamjon.com','성애란');


CREATE TABLE  prod
(  prod_id             VARCHAR2(10)     NOT NULL,     -- 상품코드
   prod_name           VARCHAR2(40)     NOT NULL,     -- 상품명
   prod_lgu            CHAR(4 )         NOT NULL,     -- 상품분류
   prod_buyer          CHAR(6)          NOT NULL,     -- 공급업체(코드)
   prod_cost           NUMBER(10)       NOT NULL,     -- 매입가
   prod_price          NUMBER(10)       NOT NULL,     -- 소비자가
   prod_sale           NUMBER(10)       NOT NULL,     -- 판매가
   prod_outline        VARCHAR2(100)     NOT NULL,     -- 상품개략설명
   prod_detail         CLOB,                          -- 상품상세설명
   prod_img            VARCHAR2(40)     NOT NULL,     -- 이미지(소)
   prod_totalstock     NUMBER(10)       NOT NULL,     -- 재고수량
   prod_insdate        DATE,                          -- 신규일자(등록일)
   prod_properstock    NUMBER(10)       NOT NULL,     -- 안전재고수량
   prod_size           VARCHAR2(20),                  -- 크기
   prod_color          VARCHAR2(20),                  -- 색상
   prod_delivery       VARCHAR2(255),                 -- 배달특기사항
   prod_unit           VARCHAR2(6),                   -- 단위(수량)
   prod_qtyin          NUMBER(10),                    -- 총입고수량
   prod_qtysale        NUMBER(10),                    -- 총판매수량
   prod_mileage        NUMBER(10),                    -- 개당 마일리지 점수
   CONSTRAINT pk_prod_id PRIMARY KEY (prod_id),
   CONSTRAINT fr_prod_lgu FOREIGN KEY (prod_lgu) REFERENCES lprod(lprod_gu),
   CONSTRAINT fr_prod_buyer FOREIGN KEY (prod_buyer) REFERENCES buyer(buyer_id)  
);

Insert into PROD values ('P101000001','모니터 삼성전자15인치칼라','P101','P10101',210000,290000,230000,'평면모니터의 기적',null,'P101000001.gif',0,to_date('2020/01/10','YYYY/MM/DD'),33,'15인치',null,'파손 주의','EA',0,0,null);
Insert into PROD values ('P101000002','모니터 삼성전자17인치칼라','P101','P10101',310000,390000,330000,'평면모니터의 기적',null,'P101000002.gif',0,to_date('2020/01/10','YYYY/MM/DD'),23,'17인치',null,'파손 주의','EA',0,0,null);
Insert into PROD values ('P101000003','모니터 삼성전자19인치칼라','P101','P10101',410000,490000,430000,'평면모니터의 기적',null,'P101000003.gif',0,to_date('2020/01/10','YYYY/MM/DD'),15,'19인치',null,'파손 주의','EA',0,0,null);
Insert into PROD values ('P101000004','삼보컴퓨터 P-III 600Mhz','P101','P10102',1150000,1780000,1330000,'쉬운 인터넷을.....',null,'P101000004.gif',0,to_date('2020/02/08','YYYY/MM/DD'),22,null,null,'파손 주의','EA',0,0,null);
Insert into PROD values ('P101000005','삼보컴퓨터 P-III 700Mhz','P101','P10102',2150000,2780000,2330000,'쉬운 인터넷을.....',null,'P101000005.gif',0,to_date('2020/02/08','YYYY/MM/DD'),31,null,null,'파손 주의','EA',0,0,null);
Insert into PROD values ('P101000006','삼보컴퓨터 P-III 800Mhz','P101','P10102',3150000,3780000,3330000,'쉬운 인터넷을.....',null,'P101000006.gif',0,to_date('2020/02/08','YYYY/MM/DD'),17,null,null,'파손 주의','EA',0,0,null);
Insert into PROD values ('P102000001','대우 칼라 TV 25인치','P102','P10201',690000,820000,720000,'집안에 영화관을.....',null,'P102000001.gif',0,to_date('2020/02/22','YYYY/MM/DD'),53,'25인치','흑색','파손 주의','EA',0,0,null);
Insert into PROD values ('P102000002','대우 칼라 TV 29인치','P102','P10201',890000,1020000,920000,'집안에 영화관을.....',null,'P102000002.gif',0,to_date('2020/02/22','YYYY/MM/DD'),21,'29인치','흑색','파손 주의','EA',0,0,null);
Insert into PROD values ('P102000003','삼성 칼라 TV 21인치','P102','P10202',590000,720000,620000,'집안에 영화관을.....',null,'P102000003.gif',0,to_date('2020/01/22','YYYY/MM/DD'),11,'21인치','은색','파손 주의','EA',0,0,null);
Insert into PROD values ('P102000004','삼성 칼라 TV 29인치','P102','P10202',990000,1120000,1020000,'집안에 영화관을.....',null,'P102000004.gif',0,to_date('2020/01/22','YYYY/MM/DD'),19,'29인치','은색','파손 주의','EA',0,0,null);
Insert into PROD values ('P102000005','삼성 칼라 TV 53인치','P102','P10202',1990000,2120000,2020000,'집안에 영화관을.....',null,'P102000005.gif',0,to_date('2020/01/22','YYYY/MM/DD'),8,'53인치','은색','파손 주의','EA',0,0,null);
Insert into PROD values ('P102000006','삼성 캠코더','P102','P10202',660000,880000,770000,'가족과 영화촬영을.....',null,'P102000006.gif',0,to_date('2020/02/23','YYYY/MM/DD'),17,null,null,'파손 주의','EA',0,0,null);
Insert into PROD values ('P102000007','대우 VTR 6헤드','P102','P10201',550000,760000,610000,'선명한 화질',null,'P102000007.gif',0,to_date('2020/01/23','YYYY/MM/DD'),36,null,null,'파손 주의','EA',0,0,null);
Insert into PROD values ('P201000001','여성 봄 셔츠 1','P201','P20101',21000,42000,27000,'파릇한 봄을 위한',null,'P201000001.gif',0,to_date('2020/01/09','YYYY/MM/DD'),9,'s','청색','세탁 주의','EA',0,0,null);
Insert into PROD values ('P201000002','여성 봄 셔츠 2','P201','P20101',22000,43000,28000,'파릇한 봄을 위한',null,'P201000002.gif',0,to_date('2020/01/09','YYYY/MM/DD'),9,'M','흰색','세탁 주의','EA',0,0,null);
Insert into PROD values ('P201000003','여성 봄 셔츠 3','P201','P20101',23000,44000,29000,'파릇한 봄을 위한',null,'P201000003.gif',0,to_date('2020/01/09','YYYY/MM/DD'),9,'L','감색','세탁 주의','EA',0,0,null);
Insert into PROD values ('P201000004','여성 여름 셔츠 1','P201','P20101',12000,21000,25000,'시원한 여름을 위한',null,'P201000004.gif',0,to_date('2020/01/11','YYYY/MM/DD'),9,'s','청색','세탁 주의','EA',0,0,null);
Insert into PROD values ('P201000005','여성 여름 셔츠 2','P201','P20101',13000,22000,26000,'시원한 여름을 위한',null,'P201000005.gif',0,to_date('2020/01/11','YYYY/MM/DD'),9,'M','흰색','세탁 주의','EA',0,0,null);
Insert into PROD values ('P201000006','여성 여름 셔츠 3','P201','P20101',14000,23000,27000,'시원한 여름을 위한',null,'P201000006.gif',0,to_date('2020/01/11','YYYY/MM/DD'),9,'L','감색','세탁 주의','EA',0,0,null);
Insert into PROD values ('P201000007','여성 겨울 라운드 셔츠 1','P201','P20101',31000,45000,33000,'따뜻한 겨울을 위한',null,'P201000007.gif',0,to_date('2020/01/25','YYYY/MM/DD'),9,'s','청색','세탁 주의','EA',0,0,null);
Insert into PROD values ('P201000008','여성 겨울 라운드 셔츠 2','P201','P20101',32000,46000,34000,'따뜻한 겨울을 위한',null,'P201000008.gif',0,to_date('2020/01/25','YYYY/MM/DD'),9,'M','흰색','세탁 주의','EA',0,0,null);
Insert into PROD values ('P201000009','여성 겨울 라운드 셔츠 3','P201','P20101',33000,47000,35000,'따뜻한 겨울을 위한',null,'P201000009.gif',0,to_date('2020/01/25','YYYY/MM/DD'),9,'L','감색','세탁 주의','EA',0,0,null);
Insert into PROD values ('P201000010','여성 청바지 1','P201','P20102',55000,66000,57000,'편리한 활동파를 위한',null,'P201000010.gif',0,to_date('2020/01/31','YYYY/MM/DD'),38,'30',null,'세탁 주의','EA',0,0,null);
INSERT INTO prod values ('P201000011','여성 청바지 2','P201','P20102',56000,67000,58000,'편리한 활동파를 위한',null,'P201000011.gif',0,to_date('2020/01/31','YYYY/MM/DD'),35,'32','','세탁 주의','EA',0,0,null) ;
Insert into PROD values ('P201000012','여성 청바지 3','P201','P20102',57000,68000,59000,'편리한 활동파를 위한',null,'P201000012.gif',0,to_date('2020/01/31','YYYY/MM/DD'),33,'34',null,'세탁 주의','EA',0,0,null);
Insert into PROD values ('P201000013','여성 봄 자켓 1','P201','P20101',110000,210000,170000,'편리한 활동파의 봄을 위한',null,'P201000013.gif',0,to_date('2020/02/18','YYYY/MM/DD'),16,'66','청색','세탁 주의','EA',0,0,null);
Insert into PROD values ('P201000014','여성 봄 자켓 2','P201','P20101',120000,220000,180000,'편리한 활동파의 봄을 위한',null,'P201000014.gif',0,to_date('2020/02/18','YYYY/MM/DD'),18,'77','흰색','세탁 주의','EA',0,0,null);
Insert into PROD values ('P201000015','여성 봄 자켓 3','P201','P20101',130000,230000,190000,'편리한 활동파의 봄을 위한',null,'P201000015.gif',0,to_date('2020/02/18','YYYY/MM/DD'),17,'88','감색','세탁 주의','EA',0,0,null);
Insert into PROD values ('P201000016','여성 여름 자켓 1','P201','P20102',100000,160000,130000,'편리한 활동파의 여름을 위한',null,'P201000016.gif',0,to_date('2020/02/21','YYYY/MM/DD'),12,'66','청색','세탁 주의','EA',0,0,null);
Insert into PROD values ('P201000017','여성 여름 자켓 2','P201','P20102',110000,170000,140000,'편리한 활동파의 여름을 위한',null,'P201000017.gif',0,to_date('2020/02/21','YYYY/MM/DD'),21,'77','흰색','세탁 주의','EA',0,0,null);
Insert into PROD values ('P201000018','여성 여름 자켓 3','P201','P20102',120000,180000,150000,'편리한 활동파의 여름을 위한',null,'P201000018.gif',0,to_date('2020/02/21','YYYY/MM/DD'),11,'77','감색','세탁 주의','EA',0,0,null);
Insert into PROD values ('P201000019','여성 겨울 자켓 1','P201','P20102',210000,270000,240000,'편리한 활동파의 따뜻한 겨울을 위한',null,'P201000019.gif',0,to_date('2020/02/29','YYYY/MM/DD'),22,'66','청색','세탁 주의','EA',0,0,null);
Insert into PROD values ('P201000020','여성 겨울 자켓 2','P201','P20102',220000,280000,250000,'편리한 활동파의 따뜻한 겨울을 위한',null,'P201000020.gif',0,to_date('2020/02/29','YYYY/MM/DD'),29,'77','흰색','세탁 주의','EA',0,0,null);
Insert into PROD values ('P201000021','여성 겨울 자켓 3','P201','P20102',230000,290000,260000,'편리한 활동파의 따뜻한 겨울을 위한',null,'P201000021.gif',0,to_date('2020/02/29','YYYY/MM/DD'),19,'88','감색','세탁 주의','EA',0,0,null);
Insert into PROD values ('P202000001','남성 봄 셔츠 1','P202','P20201',10000,19000,15000,'파릇한 봄을 위한',null,'P202000001.gif',0,to_date('2020/01/05','YYYY/MM/DD'),9,'M','청색','세탁 주의','EA',0,0,null);
Insert into PROD values ('P202000002','남성 봄 셔츠 2','P202','P20201',13000,22000,18000,'파릇한 봄을 위한',null,'P202000002.gif',0,to_date('2020/01/05','YYYY/MM/DD'),9,'L','흰색','세탁 주의','EA',0,0,null);
Insert into PROD values ('P202000003','남성 봄 셔츠 3','P202','P20201',15000,24000,20000,'파릇한 봄을 위한',null,'P202000003.gif',0,to_date('2020/01/05','YYYY/MM/DD'),9,'XL','감색','세탁 주의','EA',0,0,null);
Insert into PROD values ('P202000004','남성 여름 셔츠 1','P202','P20201',18000,28000,23000,'시원한 여름을 위한',null,'P202000004.gif',0,to_date('2020/02/05','YYYY/MM/DD'),9,'M','청색','세탁 주의','EA',0,0,null);
Insert into PROD values ('P202000005','남성 여름 셔츠 2','P202','P20201',23000,33000,28000,'시원한 여름을 위한',null,'P202000005.gif',0,to_date('2020/02/05','YYYY/MM/DD'),9,'L','흰색','세탁 주의','EA',0,0,null);
Insert into PROD values ('P202000006','남성 여름 셔츠 3','P202','P20201',28000,38000,33000,'시원한 여름을 위한',null,'P202000006.gif',0,to_date('2020/02/05','YYYY/MM/DD'),9,'XL','감색','세탁 주의','EA',0,0,null);
Insert into PROD values ('P202000007','남성 겨울 라운드 셔츠 1','P202','P20201',25000,42000,31000,'따뜻한 겨울을 위한',null,'P202000007.gif',0,to_date('2020/01/13','YYYY/MM/DD'),9,'M','청색','세탁 주의','EA',0,0,null);
Insert into PROD values ('P202000008','남성 겨울 라운드 셔츠 2','P202','P20201',27000,43000,33000,'따뜻한 겨울을 위한',null,'P202000008.gif',0,to_date('2020/01/13','YYYY/MM/DD'),9,'L','흰색','세탁 주의','EA',0,0,null);
Insert into PROD values ('P202000009','남성 겨울 라운드 셔츠 3','P202','P20201',28500,44000,35000,'따뜻한 겨울을 위한',null,'P202000009.gif',0,to_date('2020/01/13','YYYY/MM/DD'),9,'XL','감색','세탁 주의','EA',0,0,null);
Insert into PROD values ('P202000010','남성 청바지 1','P202','P20202',55000,66000,58000,'편리한 활동파를 위한',null,'P202000010.gif',0,to_date('2020/01/16','YYYY/MM/DD'),38,'30',null,'세탁 주의','EA',0,0,null);
Insert into PROD values ('P202000011','남성 청바지 2','P202','P20202',55000,66000,58000,'편리한 활동파를 위한',null,'P202000011.gif',0,to_date('2020/01/16','YYYY/MM/DD'),35,'32',null,'세탁 주의','EA',0,0,null);
Insert into PROD values ('P202000012','남성 청바지 3','P202','P20202',55000,66000,58000,'편리한 활동파를 위한',null,'P202000012.gif',0,to_date('2020/01/16','YYYY/MM/DD'),33,'34',null,'세탁 주의','EA',0,0,null);
Insert into PROD values ('P202000013','남성 봄 자켓 1','P202','P20201',110000,230000,150000,'편리한 활동파의 봄을 위한',null,'P202000013.gif',0,to_date('2020/02/17','YYYY/MM/DD'),16,'M','청색','세탁 주의','EA',0,0,null);
Insert into PROD values ('P202000014','남성 봄 자켓 2','P202','P20201',120000,230000,160000,'편리한 활동파의 봄을 위한',null,'P202000014.gif',0,to_date('2020/02/17','YYYY/MM/DD'),18,'L','흰색','세탁 주의','EA',0,0,null);
Insert into PROD values ('P202000015','남성 봄 자켓 3','P202','P20201',130000,230000,170000,'편리한 활동파의 봄을 위한',null,'P202000015.gif',0,to_date('2020/02/17','YYYY/MM/DD'),17,'XL','감색','세탁 주의','EA',0,0,null);
Insert into PROD values ('P202000016','남성 여름 자켓 1','P202','P20202',99000,160000,130000,'편리한 활동파의 여름을 위한',null,'P202000016.gif',0,to_date('2020/02/06','YYYY/MM/DD'),12,'M','청색','세탁 주의','EA',0,0,null);
Insert into PROD values ('P202000017','남성 여름 자켓 2','P202','P20202',109000,170000,150000,'편리한 활동파의 여름을 위한',null,'P202000017.gif',0,to_date('2020/02/06','YYYY/MM/DD'),21,'L','흰색','세탁 주의','EA',0,0,null);
Insert into PROD values ('P202000018','남성 여름 자켓 3','P202','P20202',159000,190000,170000,'편리한 활동파의 여름을 위한',null,'P202000018.gif',0,to_date('2020/02/06','YYYY/MM/DD'),11,'XL','감색','세탁 주의','EA',0,0,null);
Insert into PROD values ('P202000019','남성 겨울 자켓 1','P202','P20202',210000,370000,280000,'편리한 활동파의 따뜻한 겨울을 위한',null,'P202000019.gif',0,to_date('2020/02/20','YYYY/MM/DD'),22,'M','청색','세탁 주의','EA',0,0,null);
Insert into PROD values ('P202000020','남성 겨울 자켓 2','P202','P20202',220000,370000,290000,'편리한 활동파의 따뜻한 겨울을 위한',null,'P202000020.gif',0,to_date('2020/02/20','YYYY/MM/DD'),29,'L','흰색','세탁 주의','EA',0,0,null);
Insert into PROD values ('P202000021','남성 겨울 자켓 3','P202','P20202',230000,370000,300000,'편리한 활동파의 따뜻한 겨울을 위한',null,'P202000021.gif',0,to_date('2020/02/20','YYYY/MM/DD'),19,'XL','감색','세탁 주의','EA',0,0,null);
Insert into PROD values ('P301000001','악어 가죽 혁대','P301','P30101',21000,41000,33000,'멋진 혁대를 선물로.....',null,'P301000001.gif',0,to_date('2020/01/15','YYYY/MM/DD'),32,null,null,null,'EA',0,0,null);
Insert into PROD values ('P301000002','물소 가죽 장지갑','P301','P30101',17000,37000,29000,'멋진 지갑을 선물로.....',null,'P301000002.gif',0,to_date('2020/01/15','YYYY/MM/DD'),52,null,null,null,'EA',0,0,null);
Insert into PROD values ('P301000003','여성용 손지갑','P301','P30101',22000,33000,26000,'멋진 지갑을 선물로.....',null,'P301000003.gif',0,to_date('2020/02/15','YYYY/MM/DD'),22,null,null,null,'EA',0,0,null);
Insert into PROD values ('P301000004','여성용 캐쥬얼 벨트','P301','P30101',27000,37000,29000,'멋진 벨트를 선물로.....',null,'P301000004.gif',0,to_date('2020/02/15','YYYY/MM/DD'),21,null,null,null,'EA',0,0,null);
Insert into PROD values ('P302000001','향수 NO 5','P302','P30201',89000,110000,93000,'향기를 동반한.....',null,'P302000001.gif',0,to_date('2020/01/24','YYYY/MM/DD'),11,null,null,null,'EA',0,0,null);
Insert into PROD values ('P302000002','샤넬 NO 7','P302','P30201',99000,120000,103000,'향기를 동반한.....',null,'P302000002.gif',0,to_date('2020/01/24','YYYY/MM/DD'),17,null,null,null,'EA',0,0,null);
Insert into PROD values ('P302000003','남성용 스킨','P302','P30201',19000,32000,21000,'세안후 바르는.....',null,'P302000003.gif',0,to_date('2020/01/24','YYYY/MM/DD'),21,null,null,null,'EA',0,0,null);
Insert into PROD values ('P302000004','남성용 로숀','P302','P30201',21000,33000,23000,'세안후 바르는.....',null,'P302000004.gif',0,to_date('2020/02/12','YYYY/MM/DD'),19,null,null,null,'EA',0,0,null);
Insert into PROD values ('P302000005','여성용 스킨','P302','P30201',18000,31000,20000,'세안후 바르는.....',null,'P302000005.gif',0,to_date('2020/02/12','YYYY/MM/DD'),21,null,null,null,'EA',0,0,null);
Insert into PROD values ('P302000006','여성용 로숀','P302','P30201',20000,32000,22000,'세안후 바르는.....',null,'P302000006.gif',0,to_date('2020/02/12','YYYY/MM/DD'),19,null,null,null,'EA',0,0,null);
Insert into PROD values ('P302000011','남성 향수','P302','P30202',59000,70000,63000,'좋은 향기를 동반한.....',null,'P302000011.gif',0,to_date('2020/01/13','YYYY/MM/DD'),21,null,null,null,'EA',0,0,null);
Insert into PROD values ('P302000012','여성 향수','P302','P30202',89000,110000,93000,'좋은향기를 동반한.....',null,'P302000012.gif',0,to_date('2020/01/13','YYYY/MM/DD'),27,null,null,null,'EA',0,0,null);
Insert into PROD values ('P302000013','립스틱','P302','P30202',17000,27000,23000,'세안후 바르는 좋은.....',null,'P302000013.gif',0,to_date('2020/01/13','YYYY/MM/DD'),11,null,null,null,'EA',0,0,null);
Insert into PROD values ('P302000014','면도크림','P302','P30202',25000,32000,26000,'세안후 바르는 좋은.....',null,'P302000014.gif',0,to_date('2020/01/14','YYYY/MM/DD'),29,null,null,null,'EA',0,0,null);
Insert into PROD values ('P302000015','화운데이션','P302','P30202',22000,32000,23000,'세안후 바르는 좋은.....',null,'P302000015.gif',0,to_date('2020/01/14','YYYY/MM/DD'),15,null,null,null,'EA',0,0,null);
Insert into PROD values ('P302000016','머드팩','P302','P30202',120000,220000,172000,'세안후 바르는 좋은.....',null,'P302000016.gif',0,to_date('2020/01/14','YYYY/MM/DD'),32,null,null,null,'EA',0,0,null);
Insert into PROD values ('P302000021','참존 기초화장품','P302','P30203',23500,37500,26000,'피부를 산뜻하게.....',null,'P302000021.gif',0,to_date('2020/01/28','YYYY/MM/DD'),25,null,null,null,'EA',0,0,null);
Insert into PROD values ('P302000022','참존 여성 향수','P302','P30203',78500,98500,83000,'좋은향기와 피부를 산뜻하게.....',null,'P302000022.gif',0,to_date('2020/01/28','YYYY/MM/DD'),53,null,null,null,'EA',0,0,null);
Insert into PROD values ('P302000023','참존 립스틱','P302','P30203',21500,26500,22500,'좋은 피부를 산뜻하게.....',null,'P302000023.gif',0,to_date('2020/01/28','YYYY/MM/DD'),17,null,null,null,'EA',0,0,null);

CREATE TABLE  buyprod
(  buy_date  DATE           NOT NULL,             -- 입고일자
   buy_prod  VARCHAR2(10)   NOT NULL,             -- 상품코드
   buy_qty   NUMBER(10)     NOT NULL,             -- 매입수량
   buy_cost  NUMBER(10)     NOT NULL,             -- 매입단가
   CONSTRAINT pk_buyprod PRIMARY KEY (buy_date,buy_prod), 
   CONSTRAINT fr_buy_prod FOREIGN KEY (buy_prod) REFERENCES prod(prod_id)
);

Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/08','YYYY/MM/DD'),'P202000001',18,10000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/08','YYYY/MM/DD'),'P202000002',19,13000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/08','YYYY/MM/DD'),'P202000003',11,15000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/12','YYYY/MM/DD'),'P201000001',21,21000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/12','YYYY/MM/DD'),'P201000002',13,22000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/12','YYYY/MM/DD'),'P201000003',15,23000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/13','YYYY/MM/DD'),'P101000001',22,210000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/13','YYYY/MM/DD'),'P101000002',23,310000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/13','YYYY/MM/DD'),'P101000003',21,410000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/14','YYYY/MM/DD'),'P201000004',15,12000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/14','YYYY/MM/DD'),'P201000005',32,13000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/14','YYYY/MM/DD'),'P201000006',11,14000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/16','YYYY/MM/DD'),'P202000007',22,25000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/16','YYYY/MM/DD'),'P202000008',33,27000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/16','YYYY/MM/DD'),'P202000009',14,28500);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/16','YYYY/MM/DD'),'P302000011',125,59000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/16','YYYY/MM/DD'),'P302000012',16,89000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/16','YYYY/MM/DD'),'P302000013',13,17000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/17','YYYY/MM/DD'),'P302000014',21,25000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/17','YYYY/MM/DD'),'P302000015',33,22000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/17','YYYY/MM/DD'),'P302000016',17,120000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/18','YYYY/MM/DD'),'P301000001',15,21000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/18','YYYY/MM/DD'),'P301000002',19,17000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/19','YYYY/MM/DD'),'P202000010',21,55000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/19','YYYY/MM/DD'),'P202000011',91,55000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/19','YYYY/MM/DD'),'P202000012',15,55000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/25','YYYY/MM/DD'),'P102000003',11,590000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/25','YYYY/MM/DD'),'P102000004',13,990000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/25','YYYY/MM/DD'),'P102000005',22,1990000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/26','YYYY/MM/DD'),'P102000007',52,550000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/27','YYYY/MM/DD'),'P302000001',253,89000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/27','YYYY/MM/DD'),'P302000002',31,99000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/27','YYYY/MM/DD'),'P302000003',197,19000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/28','YYYY/MM/DD'),'P201000007',19,31000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/28','YYYY/MM/DD'),'P201000008',22,32000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/28','YYYY/MM/DD'),'P201000009',26,33000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/31','YYYY/MM/DD'),'P302000021',23,23500);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/31','YYYY/MM/DD'),'P302000022',17,78500);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/01/31','YYYY/MM/DD'),'P302000023',15,21500);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/03','YYYY/MM/DD'),'P201000010',23,55000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/03','YYYY/MM/DD'),'P201000011',21,56000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/03','YYYY/MM/DD'),'P201000012',55,57000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/08','YYYY/MM/DD'),'P202000004',12,18000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/08','YYYY/MM/DD'),'P202000005',19,23000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/08','YYYY/MM/DD'),'P202000006',28,28000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/09','YYYY/MM/DD'),'P202000016',22,99000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/09','YYYY/MM/DD'),'P202000017',41,109000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/09','YYYY/MM/DD'),'P202000018',21,159000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/11','YYYY/MM/DD'),'P101000004',11,1150000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/11','YYYY/MM/DD'),'P101000005',10,2150000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/11','YYYY/MM/DD'),'P101000006',9,3150000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/15','YYYY/MM/DD'),'P302000004',33,21000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/15','YYYY/MM/DD'),'P302000005',191,18000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/15','YYYY/MM/DD'),'P302000006',39,20000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/18','YYYY/MM/DD'),'P301000003',46,22000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/18','YYYY/MM/DD'),'P301000004',41,27000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/20','YYYY/MM/DD'),'P202000013',16,110000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/20','YYYY/MM/DD'),'P202000014',18,120000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/20','YYYY/MM/DD'),'P202000015',13,130000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/21','YYYY/MM/DD'),'P201000013',16,110000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/21','YYYY/MM/DD'),'P201000014',28,120000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/21','YYYY/MM/DD'),'P201000015',25,130000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/23','YYYY/MM/DD'),'P202000019',22,210000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/23','YYYY/MM/DD'),'P202000020',19,220000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/23','YYYY/MM/DD'),'P202000021',13,230000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/25','YYYY/MM/DD'),'P102000001',15,690000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/25','YYYY/MM/DD'),'P102000002',12,890000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/02/26','YYYY/MM/DD'),'P102000006',13,660000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/03/02','YYYY/MM/DD'),'P201000016',725,100000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/03/02','YYYY/MM/DD'),'P201000017',341,110000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/03/02','YYYY/MM/DD'),'P201000018',111,120000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/03/03','YYYY/MM/DD'),'P201000019',16,210000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/03/03','YYYY/MM/DD'),'P201000020',39,220000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/03/03','YYYY/MM/DD'),'P201000021',32,230000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/16','YYYY/MM/DD'),'P202000001',12,10000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/16','YYYY/MM/DD'),'P202000002',13,13000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/16','YYYY/MM/DD'),'P202000003',5,15000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/20','YYYY/MM/DD'),'P201000001',15,21000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/20','YYYY/MM/DD'),'P201000002',7,22000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/20','YYYY/MM/DD'),'P201000003',9,23000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/21','YYYY/MM/DD'),'P101000001',16,210000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/21','YYYY/MM/DD'),'P101000002',17,310000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/21','YYYY/MM/DD'),'P101000003',15,410000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/22','YYYY/MM/DD'),'P201000004',9,12000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/22','YYYY/MM/DD'),'P201000005',26,13000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/22','YYYY/MM/DD'),'P201000006',5,14000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/24','YYYY/MM/DD'),'P202000007',16,25000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/24','YYYY/MM/DD'),'P202000008',27,27000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/24','YYYY/MM/DD'),'P202000009',8,28500);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/24','YYYY/MM/DD'),'P302000011',19,59000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/24','YYYY/MM/DD'),'P302000012',10,89000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/24','YYYY/MM/DD'),'P302000013',7,17000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/25','YYYY/MM/DD'),'P302000014',15,25000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/25','YYYY/MM/DD'),'P302000015',27,22000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/25','YYYY/MM/DD'),'P302000016',11,120000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/26','YYYY/MM/DD'),'P301000001',9,21000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/26','YYYY/MM/DD'),'P301000002',13,17000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/27','YYYY/MM/DD'),'P202000010',15,55000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/27','YYYY/MM/DD'),'P202000011',25,55000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/04/27','YYYY/MM/DD'),'P202000012',9,55000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/03','YYYY/MM/DD'),'P102000003',5,590000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/03','YYYY/MM/DD'),'P102000004',7,990000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/03','YYYY/MM/DD'),'P102000005',16,1990000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/04','YYYY/MM/DD'),'P102000007',46,550000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/05','YYYY/MM/DD'),'P302000001',17,89000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/05','YYYY/MM/DD'),'P302000002',25,99000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/05','YYYY/MM/DD'),'P302000003',11,19000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/06','YYYY/MM/DD'),'P201000007',13,31000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/06','YYYY/MM/DD'),'P201000008',16,32000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/06','YYYY/MM/DD'),'P201000009',20,33000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/09','YYYY/MM/DD'),'P302000021',17,23500);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/09','YYYY/MM/DD'),'P302000022',11,78500);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/09','YYYY/MM/DD'),'P302000023',9,21500);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/12','YYYY/MM/DD'),'P201000010',17,55000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/12','YYYY/MM/DD'),'P201000011',15,56000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/12','YYYY/MM/DD'),'P201000012',49,57000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/17','YYYY/MM/DD'),'P202000004',6,18000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/17','YYYY/MM/DD'),'P202000005',13,23000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/17','YYYY/MM/DD'),'P202000006',22,28000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/18','YYYY/MM/DD'),'P202000016',16,99000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/18','YYYY/MM/DD'),'P202000017',35,109000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/18','YYYY/MM/DD'),'P202000018',15,159000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/20','YYYY/MM/DD'),'P101000004',5,1150000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/20','YYYY/MM/DD'),'P101000005',4,2150000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/20','YYYY/MM/DD'),'P101000006',3,3150000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/24','YYYY/MM/DD'),'P302000004',27,21000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/24','YYYY/MM/DD'),'P302000005',25,18000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/24','YYYY/MM/DD'),'P302000006',33,20000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/27','YYYY/MM/DD'),'P301000003',40,22000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/27','YYYY/MM/DD'),'P301000004',35,27000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/29','YYYY/MM/DD'),'P202000013',10,110000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/29','YYYY/MM/DD'),'P202000014',12,120000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/29','YYYY/MM/DD'),'P202000015',7,130000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/30','YYYY/MM/DD'),'P201000013',10,110000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/30','YYYY/MM/DD'),'P201000014',22,120000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/05/30','YYYY/MM/DD'),'P201000015',19,130000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/06/01','YYYY/MM/DD'),'P202000019',16,210000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/06/01','YYYY/MM/DD'),'P202000020',13,220000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/06/01','YYYY/MM/DD'),'P202000021',7,230000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/06/03','YYYY/MM/DD'),'P102000001',9,690000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/06/03','YYYY/MM/DD'),'P102000002',6,890000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/06/04','YYYY/MM/DD'),'P102000006',7,660000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/06/09','YYYY/MM/DD'),'P201000016',19,100000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/06/09','YYYY/MM/DD'),'P201000017',35,110000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/06/09','YYYY/MM/DD'),'P201000018',25,120000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/06/10','YYYY/MM/DD'),'P201000019',10,210000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/06/10','YYYY/MM/DD'),'P201000020',33,220000);
Insert into BUYPROD (BUY_DATE,BUY_PROD,BUY_QTY,BUY_COST) values (to_date('2020/06/10','YYYY/MM/DD'),'P201000021',26,230000);

CREATE TABLE  member
(  mem_id                VARCHAR2(15)   NOT NULL,   -- 회원ID  
   mem_pass              VARCHAR2(15)   NOT NULL,   -- 비밀번호
   mem_name              VARCHAR2(20)   NOT NULL,   -- 성명
   mem_regno1            CHAR(6)        NOT NULL,   -- 주민등록번호앞6자리
   mem_regno2            CHAR(7)        NOT NULL,   -- 주민등록번호뒤7자리
   mem_bir               DATE,                      -- 생일
   mem_zip               CHAR(7)        NOT NULL,   -- 우편번호
   mem_add1              VARCHAR2(100)  NOT NULL,   -- 주소1
   mem_add2              VARCHAR2(80)   NOT NULL,   -- 주소2
   mem_hometel           VARCHAR2(14)   NOT NULL,   -- 집전화번호                                
   mem_comtel            VARCHAR2(14)   NOT NULL,   -- 회사전화번호                              
   mem_hp                VARCHAR2(15),              -- 이동전화
   mem_mail              VARCHAR2(40)   NOT NULL,   -- E-mail주소
   mem_job               VARCHAR2(40),              -- 직업
   mem_like              VARCHAR2(40),              -- 취미
   mem_memorial          VARCHAR2(40),              -- 기념일명
   mem_memorialday       DATE,                      -- 기념일날짜
   mem_mileage           NUMBER(10),                -- 마일리지              
   mem_delete            VARCHAR2(1),               -- 삭제여부
   CONSTRAINT pk_mem_id PRIMARY KEY (mem_id) 
);

Insert into MEMBER values ('a001','asdfasdf','김은대','000315','3406420',to_date('2000/03/15','YYYY/MM/DD'),'135-972','대전시 동구 용운동','222-2번지','042-621-4615','042-621-4615','010-6217-4615','pyoedab@lycos.co.kr','주부','수영','결혼기념일',null,1000,null);
Insert into MEMBER values ('b001','1004','이쁜이','981204','2900000',to_date('1998/12/04','YYYY/MM/DD'),'700-030','서울시 천사동 예쁜마을','1004-29','02-888-9999','02-888-9999','010-8886-9999','engelcd@pretty.net','회사원','수영','아버님생신',null,2300,null);
Insert into MEMBER values ('c001','7777','신용환','980324','1400716',to_date('1998/03/24','YYYY/MM/DD'),'407-817','대전광역시 중구 대흥동','477-9','042-123-5678','042-123-5678','010-1236-5678','kyh01e@hanmail.net','교사','독서','아내생일',null,3500,null);
Insert into MEMBER values ('d001','123joy','성윤미','700609','2000000',to_date('1970/06/09','YYYY/MM/DD'),'501-705','대전시 중구 하늘동 ','땅 3번지','042-222-8877','042-222-8877','010-2228-8877','dbs81f@hanmail.net','공무원','볼링','결혼기념일',null,1700,null);
Insert into MEMBER values ('e001','00000000','이혜나','990701','2406017',to_date('1999/07/01','YYYY/MM/DD'),'617-800','대전시 대덕구 읍내동','혜강아파트','042-432-8901','042-432-8901','010-4329-8901','bosiang@hanmail.net','농업','당구','아버님생신',null,6500,null);
Insert into MEMBER values ('f001','12345678','신영남','000228','3459919',to_date('2000/02/28','YYYY/MM/DD'),'140-706','대전광역시 대흥동','65-33 303호','042-253-2121','042-253-2121','010-2538-2121','SUPER-KHG@HANMAIL.NET','주부','볼링','아내생일',null,2700,null);
Insert into MEMBER values ('g001','1456','송경희','020111','4403414',to_date('2002/01/11','YYYY/MM/DD'),'339-841','충남금산군 제원면','심내리123-1','0412-356-3578','0412-356-3578','010-3565-3578','lim052@hanmail.net','주부','스키','결혼기념일',null,800,null);
Insert into MEMBER values ('h001','9999','라준호','980928','1455822',to_date('1998/09/28','YYYY/MM/DD'),'339-841','충남 논산시 양촌면','산직3구 345','042-522-1679','042-522-1679','010-5229-1679','wingl7@hanmail.net','회사원','독서','아내생일',null,1500,null);
Insert into MEMBER values ('i001','1111','최지현','990220','2384719',to_date('1999/02/20','YYYY/MM/DD'),'306-702','대전시 동구 가양1동','768-12','042-614-6914','042-614-6914','010-6145-6914','pan@orgio.net','공무원','등산','남편생일',null,900,null);
Insert into MEMBER values ('j001','6262','김윤희','991219','2448920',to_date('1999/12/19','YYYY/MM/DD'),'306-702','대전시 서구 삼천동','한신아파트305동309호','042-332-8976','042-332-8976','010-3321-8976','maxsys@hanmail.net','농업','개그','결혼기념일',null,1100,null);
Insert into MEMBER values ('k001','7227','오철희','860323','1449311',to_date('1986/03/23','YYYY/MM/DD'),'306-702','대전시 대덕구 대화동','34-567','042-157-8765','042-157-8765','010-1572-8765','equus@orgio.net','자영업','서예','아내생일',null,3700,null);
Insert into MEMBER values ('l001','12345678','구길동','030214','3234566',to_date('2003/02/14','YYYY/MM/DD'),'339-841','충남금산군 금산읍',' 하리35-322','0412-322-8865','0412-322-8865','010-3223-8865','email815@hanmail.co.kr','자영업','바둑','결혼기념일',null,5300,null);
Insert into MEMBER values ('m001','pass','박지은','990515','2555555',to_date('1999/05/15','YYYY/MM/DD'),'306-702','대전광역시 서구 갈마동','인성아파트 234동 907호','042-252-0675','042-252-0675','010-2521-0675','happy@hanmail.net','은행원','등산','아버님생신',null,1300,null);
Insert into MEMBER values ('n001','1111','탁원재','990523','1011014',to_date('1999/05/23','YYYY/MM/DD'),'306-702','대전시 동구 자양동','32-23','042-632-2176','042-632-2176','010-6322-2176','ping75@unitel.co.kr','축산업','낚시','결혼기념일',null,2700,null);
Insert into MEMBER values ('o001','0909','배인정','021130','4447619',to_date('2002/11/30','YYYY/MM/DD'),'306-702','대전시 서구 갈마동','경성아파트502동1101호','042-622-5971','042-622-5971','010-6221-5971','tar-song@hanmail.net','회사원','등산','어머님생신',null,2600,null);
Insert into MEMBER values ('p001','sahra3','오성순','971005','2458323',to_date('1997/10/05','YYYY/MM/DD'),'306-702','대전유성구송강동','한솔아파트 703동 407호','042-810-7658','042-810-7658','010-8103-7658','sahra235@intz.com','공무원','독서','남편생일',null,2200,null);
Insert into MEMBER values ('q001','0000','육평회','961220','1402722',to_date('1996/12/20','YYYY/MM/DD'),'306-702','대구광역시 대덕구 중리동','678-43','042-823-2359','042-823-2359','010-8232-2359','kph@hanmail.net','자영업','만화','결혼기념일',null,1500,null);
Insert into MEMBER values ('r001','park1005','정은실','010320','4382532',to_date('2001/03/20','YYYY/MM/DD'),'306-702','대전시 동구 용전동','321-25','042-533-8768','042-533-8768','010-5335-8768','econie@hanmail.net','학생','장기','어머님생신',null,700,null);
Insert into MEMBER values ('s001','0819','안은정','011019','4459927',to_date('2001/10/19','YYYY/MM/DD'),'306-702','대구광역시 서구 탄방동','산호아파트 107동 802호','042-222-8155','042-222-8155','010-2228-8155','songej@hanmail.net','공무원','바둑','결혼기념일',null,3200,null);
Insert into MEMBER values ('t001','0506','성원태','000706','3454731',to_date('2000/07/06','YYYY/MM/DD'),'306-702','대전광역시 중구 유천동','한사랑아파트 302동 504호','042-272-8657','042-272-8657','010-2725-8657','bob6@hanmail.net','학생','카레이싱','결혼기념일',null,2200,null);
Insert into MEMBER values ('u001','1000','김성욱','971210','1460111',to_date('1997/12/10','YYYY/MM/DD'),'306-702','대전시 동구 용전동','76-54','042-273-9056','042-273-9056','010-2734-9056','pss576@orgio.net','주부','영화감상','결혼기념일',null,2700,null);
Insert into MEMBER values ('v001','00001111','이진영','760331','2402712',to_date('1976/03/31','YYYY/MM/DD'),'306-702','대전시 동구 용전동','566-39번지','042-240-8766','042-240-8766','010-2406-8766','gagsong@orgio.net','자영업','낚시','남편생일',null,4300,null);
Insert into MEMBER values ('w001','12341234','김형모','880213','1111111',to_date('1988/02/13','YYYY/MM/DD'),'306-702','대전시 대덕구 연축동','23-43','02-345-9877','02-345-9877','010-3452-9877','songone@hanmail.net','학생','등산','결혼기념일',null,2700,null);
Insert into MEMBER values ('x001','0000','진현경','010519','4110222',to_date('2001/05/19','YYYY/MM/DD'),'306-702','대전광역시 동구 오정동','43-26','042-223-8767','042-223-8767','010-2238-8767','happysong@hanmail.net','주부','독서','결혼기념일',null,8700,null);

CREATE TABLE  cart
(
   cart_member      VARCHAR2(15)    NOT NULL,       -- 회원ID
   cart_no          CHAR(13)        NOT NULL,       -- 주문번호
   cart_prod        VARCHAR2(10)    NOT NULL,       -- 상품코드
   cart_qty         NUMBER(8)       NOT NULL,       -- 수량
   CONSTRAINT pk_cart PRIMARY KEY (cart_no,cart_prod),
   CONSTRAINT fr_cart_member FOREIGN KEY (cart_member) REFERENCES member(mem_id),
   CONSTRAINT fr_cart_prod   FOREIGN KEY (cart_prod)   REFERENCES prod(prod_id)
);

COMMENT ON TABLE  CART             IS '장바구니 정보 테이블';
COMMENT ON COLUMN CART.CART_MEMBER IS '회원ID';
COMMENT ON COLUMN CART.CART_NO     IS '주문번호';
COMMENT ON COLUMN CART.CART_PROD   IS '상품코드';
COMMENT ON COLUMN CART.CART_QTY    IS '수량';

--DESC CART;

Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('a001','2020040100001','P101000001',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('a001','2020040100001','P201000018',16);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('a001','2020040100001','P302000003',7);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('t001','2020040100002','P302000004',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('t001','2020040100002','P101000002',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('w001','2020040100003','P201000019',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('w001','2020040100003','P302000005',9);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('w001','2020040100003','P201000020',21);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('w001','2020040100003','P101000003',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('r001','2020040500001','P302000006',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('r001','2020040500001','P101000004',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('r001','2020040500001','P201000021',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('q001','2020040500002','P302000011',11);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('q001','2020040500002','P202000001',12);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('q001','2020040500002','P101000005',4);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('p001','2020040600001','P101000006',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('p001','2020040600001','P202000002',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('o001','2020040600002','P302000013',9);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('o001','2020040600002','P202000003',9);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('o001','2020040600002','P102000001',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020040800001','P302000014',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020040800001','P102000002',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020040800001','P202000004',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('m001','2020040800002','P302000015',8);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('m001','2020040800002','P202000005',8);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('m001','2020040800002','P102000003',9);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('l001','2020041000001','P302000016',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('l001','2020041000001','P102000004',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('l001','2020041000001','P202000006',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020041000002','P202000007',7);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020041000002','P102000005',8);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020041000002','P302000021',7);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('j001','2020041200001','P302000022',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('j001','2020041200001','P202000008',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('j001','2020041200001','P102000006',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('j001','2020041200001','P202000009',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('m001','2020041200002','P102000007',7);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('m001','2020041200002','P302000023',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('m001','2020041200002','P202000010',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020041500001','P201000001',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020041500001','P302000001',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('j001','2020041500002','P202000011',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('j001','2020041500002','P201000002',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('j001','2020041500002','P302000002',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020041600001','P302000003',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020041600001','P201000003',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020041600001','P202000012',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('e001','2020041600002','P302000004',4);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('e001','2020041600002','P201000004',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('e001','2020041600002','P202000013',4);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('d001','2020041800001','P302000005',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('d001','2020041800001','P201000005',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('d001','2020041800001','P202000014',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020041800002','P302000006',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020041800002','P201000006',1);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020041800002','P202000015',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020042000001','P302000011',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020042000001','P201000007',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020042000001','P202000016',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020042000001','P202000017',1);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020042000001','P201000008',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020042000002','P202000018',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020042000002','P201000009',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020042000002','P202000019',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020042000002','P201000010',4);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020042000002','P202000020',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('x001','2020042400001','P201000011',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('x001','2020042400001','P202000021',4);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('x001','2020042400001','P201000012',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('e001','2020042400002','P301000001',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('e001','2020042400002','P201000013',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('e001','2020042400002','P301000002',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('e001','2020042400002','P201000014',13);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020042800001','P301000003',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020042800001','P201000015',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020042800002','P302000001',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020042800002','P201000016',15);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020042800002','P302000002',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020042800002','P201000017',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020050100001','P201000013',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020050100001','P301000002',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020050100002','P301000003',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020050100002','P201000014',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020050100002','P201000015',7);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('d001','2020050300001','P302000001',4);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('d001','2020050300001','P302000002',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('e001','2020050300002','P201000016',8);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('e001','2020050300002','P201000017',21);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('g001','2020050500001','P302000003',4);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('g001','2020050500001','P201000018',11);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('g001','2020050500001','P302000004',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('a001','2020050500002','P201000019',12);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('a001','2020050700001','P302000005',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('a001','2020050700001','P101000001',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('a001','2020050700001','P101000002',1);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020050700002','P201000020',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020050700002','P302000006',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020050700002','P302000011',7);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020051000001','P201000021',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020051000001','P101000003',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020051000001','P101000004',4);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('d001','2020051000002','P202000001',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('d001','2020051000002','P302000012',8);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('d001','2020051000002','P302000013',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('d001','2020051000002','P101000005',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('d001','2020051000002','P202000002',7);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020051200001','P101000006',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020051200001','P202000003',8);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020051200001','P302000014',4);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020051200001','P302000015',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020051200001','P102000001',1);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('g001','2020051300001','P202000004',9);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('g001','2020051300001','P102000002',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('g001','2020051300001','P202000005',11);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('g001','2020051300001','P302000016',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('g001','2020051300001','P302000021',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('i001','2020051500001','P102000003',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('i001','2020051500001','P202000006',12);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('j001','2020051600001','P102000004',4);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('j001','2020051600001','P202000007',17);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('j001','2020051600001','P302000022',1);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('k001','2020051600002','P302000023',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('k001','2020051600002','P102000005',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('k001','2020051600002','P202000008',21);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('k001','2020051600002','P102000006',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('k001','2020051600002','P202000009',13);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('l001','2020051800001','P302000001',4);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('l001','2020051800001','P302000002',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('m001','2020051800002','P102000007',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('m001','2020051800002','P202000010',23);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('m001','2020051800002','P201000001',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('m001','2020051800002','P202000011',25);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('m001','2020051800002','P302000003',7);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('m001','2020051800002','P302000004',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('o001','2020052100001','P201000002',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('o001','2020052100001','P202000012',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('o001','2020052100001','P201000003',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('p001','2020052100002','P202000013',7);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('p001','2020052100002','P302000005',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('p001','2020052100002','P302000006',1);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('p001','2020052100002','P201000004',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('p001','2020052100002','P202000014',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('r001','2020052400001','P201000005',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('r001','2020052400001','P202000015',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('r001','2020052400001','P302000011',4);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('s001','2020052500001','P302000012',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('s001','2020052500001','P201000006',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('s001','2020052500001','P202000016',4);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('t001','2020052500002','P201000007',1);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('t001','2020052500002','P202000017',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('t001','2020052500002','P201000008',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('t001','2020052500002','P202000018',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('v001','2020052800001','P201000009',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('v001','2020052800001','P202000019',1);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('w001','2020052900001','P201000010',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('w001','2020052900001','P202000020',9);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('w001','2020052900001','P201000011',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('x001','2020052900002','P202000021',8);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('x001','2020052900002','P201000012',4);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('x001','2020052900002','P301000001',7);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('a001','2020060500001','P302000013',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('a001','2020060500001','P302000014',11);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('a001','2020060500001','P302000015',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020060600001','P302000016',9);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020060600001','P302000021',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020060600001','P302000022',8);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020061200001','P302000023',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020061200001','P302000001',7);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('d001','2020061300001','P302000002',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('d001','2020061300001','P302000003',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('e001','2020061300002','P302000004',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('e001','2020061300002','P302000005',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('e001','2020062100001','P302000006',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('e001','2020062100001','P302000011',4);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020062100002','P302000012',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020062500001','P302000013',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020062500001','P302000014',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('f001','2020062500001','P302000015',1);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020070100001','P201000013',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020070100001','P301000002',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020070100002','P301000003',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020070100002','P201000014',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020070100002','P201000015',7);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('d001','2020070300001','P302000001',4);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('d001','2020070300001','P302000002',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('e001','2020070300002','P201000016',8);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('e001','2020070300002','P201000017',21);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('g001','2020070800001','P101000001',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('g001','2020070800001','P101000002',1);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('r001','2020070800002','P101000003',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('h001','2020071100001','P101000005',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('r001','2020071100002','P101000006',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('i001','2020071900001','P102000001',1);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('i001','2020071900001','P102000002',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('i001','2020071900001','P102000003',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('u001','2020071900002','P102000004',4);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('u001','2020071900002','P102000005',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('j001','2020072800001','P102000006',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('j001','2020072800001','P102000003',3);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('q001','2020072800002','P102000004',4);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('q001','2020072800002','P102000005',5);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020072800003','P301000003',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('c001','2020072800003','P201000015',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020072800004','P302000001',6);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020072800004','P201000016',15);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020072800004','P302000002',2);
Insert into CART (CART_MEMBER,CART_NO,CART_PROD,CART_QTY) values ('b001','2020072800004','P201000017',2);

commit;