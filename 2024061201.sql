2024-0612-01)함수(Function)
    - 함수란 미리 만들어 놓은 작은 프로그램으로 혼자서 실행되지 않고
      다른 함수에 의해서 호출을 받아야만 실행되는 프로그램
    - 컬럼의 값이나 데이터 타입을 변경할 경우
    - 숫자 또는 날짜 데이터의 출력형식을 변경할 경우
    - 하나 이상의 행에 대한 집계를 수행하는 경우 사용된다
    - SQL 함수 유형으로는
     . 단일행(Single-row) 함수
       - 테이블에 저장되어있는 개별 행을 대상으로 함수를 적용하여 하나의 결과를 반환한다.
       - 문자, 숫자, 날짜 등의 처리함수
       - 데이터 타입을 변환하기 위한 변환함수
       - SELECT, WHERE, ORDER BY 절에서 사용
       - 함수를 중첩(nested) 사용할 수 있다.
     . 복수행(Multiple-row) 함수
      - 여러 행을 그룹화하여 그룹별로 결과를 처리하여 하나의 결과 반환
      - 그룹화하고자 하는 경우 GROUP BY 절을 사용하는 함수로 구성된다
      
1. 문자함수
 . 문자열 연산자 : '||'                    -- CONCAT은 결합(||)을 의미
 . CONCAT(c1,c2),CHR(n), ASCII(c1)  -- c를 쓰면 문자열 , n이나m은 숫자열을 의미
                -- CHR(n) 문자열에 해당하는 값을 반환 ASCII 아스키코드값
 . LOWER(c1), UPPER(c1), INITCAP(c1)
   --LOWER모든문자열을 소문자로 / UPPER 모든문자열을 대문자로 / INITCAP은 단어 첫글자만 대문자로
 . LPAD(c1,n [,c2]),PPAD(c1,n [,c2]) -- L 왼쪽 / R 오른쪽 / PAD 장소에 특정한문자열을 반복해서채울때
 . LTRIM(c1 [,c2]), RTRIM(c1 [,c2]), TRIM(c1) --TRIM 지우는것 c1부터 c2까지 지우고 / c2가 생략되면 공백을 지움
   -- LTRIM 왼쪽에서 c1에서 c2를 찾아서 지운다 / 단어안쪽에있는 공백은 못지운다 / TRIM은 앞쪽뒤쪽 모든 공백다지움 *단어안공백은못지움
 . SUBSTR(c1,n1[,n2]), REPLACE(c1, c2 [,c3]), INSTR(c1, c2[m [,n]])
 -- REPLACE c1에서 c2를 찾아서 c3로 바꾼다 ex) 거래처이름(c1)에서 대우(c2)라는것을 찾아서 애플(c3)로 바꿔라 근데 c3이 공백이면 대우라는것만 지운다
 . LENGTH(c1), LENGTHB(c1)
 
  1) 문자열 연산자 '||'
   - 두 문자열을 결합하여 하나의 문자열을 반환
 사용예)
  (1)회원테이블에서 대전에 거주하는 회원번호,회원명,주민등록 번호를 출력하시오
    단, 주민등록번호는 XXXXXX-XXXXXXX형식으로 출력하시오
 2) CONCAT(c1,c2)   -- 두개만 반환
  - 두 문자열 c1과 c2를 결합하여 결과를 반환
    SELECT MEM_ID AS 회원번호,
           MEM_NAME AS 회원명,
        -- MEM_REGNO1||'-'||MEM_REGNO2 AS "주민등록 번호"   --별칭에 공백이 있을땐 " "로 묶어서 할수 있다
           CONCAT(CONCAT(MEM_REGNO1,'-'),MEM_REGNO2) AS "주민등록 번호" -- 너무 길고 불편함 // 그냥 편한거 선택하는게 맞음
    FROM MEMBER             -- 집계함수와 일반함수는 서로 포함할 수 있는데 집계함수끼리 포함할 수 없다
    WHERE MEM_ADD1 LIKE '대전%'               
   
 3) CHR(n), ASCII(c1)
   - 정수를 문자열로(CHR), 문자열을 해당 아스키 코드값으로 출력
    -- 문자열이 많다면 첫글자만 추가됨 ex('ABC'면 A만)
   SELECT CHR(65), ASCII('A'), ASCII('가') 
   FROM SYS.DUAL; --DUAL;만써도됨

 4) LOWER(c1), UPPER(c1), INITCAP(c1)
   - 매개변수로 제공되는 문자열을 소문자는 대문자로 (UPPER), 대문자는 소문자로(LOWER)
     각 단어의 첫 글자만 대문자로(INITCAP)으로 변환
     -- ' '로 묶이면 아스키코드값으로 변환되기에 대문자와 소문자가 구분이 된다
 사용예)
  (1) SELECT LOWER('BOYGOOD'), UPPER('Il Postino'), initcap('donald trumph')
      FROM DUAL;
  (2) 상품테이블에서 분류코드 'p202'에 속한 상품의 상품코드,상품명,분류코드,매입단가를 조회하시오
      SELECT PROD_ID AS 상품코드,
             PROD_NAME AS 상품명,
             PROD_LGU AS 분류코드,
             PROD_COST AS 매입단가
        FROM PROD
        WHERE LOWER(PROD_LGU)='p202';
      
  (3) 회원테이블에서 회원번호가 'D001'회원의 모든 정보를 조회하시오
      SELECT *
      
      FROM MEMBER
      WHERE UPPER(MEM_ID)='D001'
      
 5) LPAD(c1,n [,c2]),PPAD(c1,n [,c2])
   - 주어진 문자열 c1을 정의된 n 바이트의 기억공간에 왼쪽부터(RPAD) 저장하고
     남는 오른쪽 공간에'c2'문자열을 확장하여 저장
   - c2가 생략되면 공백이 채워짐
   
사용예)  -- LPAD는 c1을 오른쪽에 채우고 c2를 남는 공간을 왼쪽에 채움 / 
        -- RPAD는 c1을 왼쪽에 채우고 c2는 남는 공간을 오른쪽에 채움
    SELECT MEM_NAME AS 회원명,
           LPAD(MEM_NAME,10,'#') AS "LPAD회원명",
           RPAD(MEM_NAME,10,'#') AS "RPAD회원명",
           LPAD(MEM_NAME,10) AS "LPAD",
           RPAD(MEM_NAME,10) AS "RPAD"
   FROM MEMBER;
   
 . 상품테이블에서 매출가가 10만원 이하인 상품의 정보를 다음 조건에 맞추어 출력하시오
   ALIAS는 상품코드,상품명,크기,색상,판매가격
   단, 크기와 색상의 값이 없으면(NULL값) '크기정보 없음', '색상정보 없음'을 출력하여
   크기정보와 색상정보는 컬럼의 중앙에 출력할 것
   -- NVL(c1,c2)는 c1값이 NULL값이면 c2값을 출력한다
   -- 함수는 함수를 포함할 수 있다 
   SELECT PROD_ID AS 상품코드,
          PROD_NAME AS 상품명,
          NVL(LPAD(PROD_SIZE,6),'크기정보 없음') AS 크기,
          NVL(LPAD(PROD_COLOR,8),'색상정보 없음') AS 색상,
          PROD_PRICE AS 판매가격
   FROM PROD
   WHERE PROD_PRICE <= 100000;

 6) LTRIM(c1 [,c2]), RTRIM(c1 [,c2]), TRIM(c1)
  - 주어진 자료 c1의 왼쪽부터(LTRIM) 또는 오른쪽부터(RTRIM) c2와 동일한 문자열을 찾아 삭제함
  - 일치하지 않는 문자를 만나면 삭제동작 중지
  - c2가 생략되면 공백을 제거함
  - TRIM : 주어진 c1의 앞과 뒤에 존재하는 공백제거 -- 이게 주로 사용됨 공백삭제를 위해
  
 사용예)
    SELECT LTRIM('AABBACDDEFG','AB'),
           LTRIM('AABBACDDEFG','AABB'),
           RTRIM('ABACADAD','AD'),
           LTRIM('    EFG'),
           RTRIM('AA      '),
           TRIM('   AABB   ')
    FROM DUAL;   
    
    
    SELECT EMP_NAME,
           DEPARTMENT_ID,
           SALARY
     FROM HR.EMPLOYEES
    WHERE FIRST_NAME='DEN';
 -- WHERE TRIM(FIRST_NAME)=TRIM('DEN   ');
    -- VARCHAR2는 값을 입력하고 남은 빈공간을 반납해서 ex)den만입력하면 뒤에 공백은 반납해 den만남고
    -- CHAR, 20 이라고했으면 ex)den          뒤에 공백이렇게가하나에 문자열인 상태인데
    -- VARCHAR2에서 CHAR로 바꿔서 'DEN'뒤에 공백이 있어서 출력이 안되어야하는데
    -- 비교할때 오라클이 알아서 TRIM을 알아서 붙혀서 처리해서 공백이 사라짐
    -- 내가 직접 TRIM을 써줘도 되고 안써줘도 됨
    
 사용예) 장바구니 테이블에서 2020년 4월 5일 장바구니번호를 생성하시오.
    SELECT SUBSTR(MAX(CART_NO),1,8)||
           TRIM(TO_CHAR(TO_NUMBER(SUBSTR(MAX(CART_NO),9))+1,'00000')) AS 장바구니번호
      FROM CART
     WHERE CART_NO LIKE '20200405%';
     
     -- 저위를 간단하게 하면
     -- CATR_NO문자열을+1를 하면 1은 숫자열이니까 문자열이 숫자열로 변경 그러고 다시 문자열로 출력
    SELECT MAX(CART_NO)+1 AS 장바구니번호
      FROM CART
     WHERE CART_NO LIKE '20200405%';
     -- MAX(c1) = c1값중 제일 높은값을 출력
     -- SUBSTR(c1,n,n1) c1값에서 n자리에서부터 n1자리까지 출력 / n1을 공백으로하면 n뒤로 모두출력
     -- TO_NUMBER() 문자열을 숫자로바꿈
     -- TO_CHAR() 숫자를 문자열로 바꿈
     -- TRIM 공백을 삭제
     -- TO_CHAR를 통해 문자열로 변경시 크기때문에 공백이생길수도있고 안생길수도있다
     
 7) SUBSTR(c1,n1[,n2]) - *****
   - 문자열 함수 중 가장 많이 사용
   - 부분 문자열을 추출
   - 주어진 문자열 c1에서 n1자리에서 n2글자수 만큼 추출하여 반환
   - n2가 생략되면 n1이후 모든 문자열을 추출하여 반환
   - n1은 1부터 시작
   - n1이 음수이면 문자열의 맨 끝부터 시작
 
 사용예)
    SELECT SUBSTR('대한민국 대전시 중구',2,5) AS COL1,
           SUBSTR('대한민국 대전시 중구',2,15) AS COL2,
           SUBSTR('대한민국 대전시 중구',2) AS COL3,
           SUBSTR('대한민국 대전시 중구',-2,5) AS COL4
    FROM DUAL;
    -- n2가 데이터값보다 크다면 n2를 공백으로 쓴거나 똑같다
 
** 표현식
  - sql에서 IF문이나 다중 분기의 기능을 제공
  - SELECT 절에서만 사용 가능**
  - CASE ~ WHEN THEN, DECODE 제공 -- 명령문이 아니라 표현식임
  - 반드시 END로 마무리 -- JAVA에 SWICH 문과 비슷
  (1) CASE ~ WHEN THEN
   (사용형식-1)
    CASE WHEN 조건식 THEN 값1
        [WHEN 조건식 THEN 값2
                :
        ELSE 값n
    END
   (사용형식-2)
    CASE 조건식 WHEN 값1 THEN 명령1
              [WHEN 값2 THEN 명령2
                :
               ELSE 명령n
    END
    
    -- trunc는 버려라 ex)사용형식-2 경우 조건식에 trunc(scor/10)을 한다면 9~9.9는 다 9가되기에
    -- 값에 9면 명령A학점 이런식으로 대입가능
    


  (2) DECODE
   (사용형식)
    DECODE(컬럼명,조건1,결과1,조건2,결과2,...,조건n,결과n)
    DECODE(trunc(score/10),9,'A',8,'B'....
    
    
사용예) 회원테이블에서 주민등록 번호를 이용하여 성별을 구하고 출력하는 쿼리 작성
        ALIAS는 회원번호, 회원명, 주민번호, 성별
         -- 조건이 없어서 WHERE이 필요없다
        -1번식-
        SELECT MEM_ID AS 회원번호,
               MEM_NAME AS 회원명,
               MEM_REGNO1||'-'||MEM_REGNO2 AS 주민번호,
               CASE WHEN ((SUBSTR(MEM_REGNO2,1,1) IN('2','4')) THEN '여자'
                                                               ELSE '여자'
                                                               END AS 성별
        FROM MEMBER
        
        
        -2번식
        SELECT MEM_ID AS 회원번호,
               MEM_NAME AS 회원명,
               MEM_REGNO1||'-'||MEM_REGNO2 AS 주민번호,
                 CASE (SUBSTR(MEM_REGNO2,1,1)) WHEN '1' THEN '남자'
                                               WHEN '3' THEN '남자'
                                               ELSE '여자'
                                               END AS 성별
        FROM MEMBER
        
        -3번식-
        SELECT MEM_ID AS 회원번호,
               MEM_NAME AS 회원명,
               MEM_REGNO1||'-'||MEM_REGNO2 AS 주민번호,
               DECODE (SUBSTR(MEM_REGNO2,1,1),'2','여성','4','여성','남성') AS 성별
        FROM MEMBER;
    
 8) REPLACE(c1, c2 [,c3]) **
    - 주어진 문자열 c1에서 c2문자열을 찾아 c3문자열로 대치시킴
    - c3가 생략되면 c2를 찾아 삭제
     (c3를 생략하고 c2를 공백으로 정의하면 문자열 내부의 공백을 제거할 수 있음
     
 사용예) 거래처 테이블의 주소에서 '서울 '을 찾아 '서울특별시 '로 바꾸어 출력하시오.
    ALIAS는 거래처코드,거래처명,원래주소,바뀐주소
    SELECT BUYER_ID AS 거래처코드,
           BUYER_NAME AS 거래처명,
           BUYER_ADD1 AS 원래주소,
           REPLACE(BUYER_ADD1,'서울 ','서울특별시 ') AS 바뀐주소,
           REPLACE(BUYER_ADD1,' ') 
           
    FROM BUYER;
    -- 공백을 제거할때 c2자리에 ' ' 공백은 꼭 작성해줘야함

 9) INSTR(c1, c2[m [,n]]) - *
   - 주어진 문자열 c1에서 c2가 처음 나온 위치를 반환
   - m은 검색 시작위치를 지정하는 경우 기술
   - n은 검색할 c2의 반복횟수 -- ex)2라면 2번째나온위치
 사용예)
    SELECT INSTR('CANADABANANA', 'NA') AS COL1,
           INSTR('CANADABANANA', 'NA',4) AS COL2,
           INSTR('CANADABANANA', 'NA',2,2) AS COL3
    FROM DUAL;
    
 10) LENGTH(c1), LENGTHB(c1) - **
    - c1 문자열의 크기를 BYTE로(LENGTHB) 또는 글자수(LENGTH)로 반환
    
    사용예)
        SELECT PROD_NAME AS 상품명,
               LENGTHB(PROD_NAME) AS "기억공간의 크기", --한글은3BYTE, 공백,숫자,영어는 1BYTE
               LENGTH(PROD_NAME) AS "글자 수"
        FROM PROD;