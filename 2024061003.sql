2024-0610-03) DELETE문
    - 테이블에서 자료(행)를 삭제
    
    (사용형식)
    DELETE FROM 테이블명
    WHERE 조건;
    - ROLLBACK의 대상
    - WHERE절 안쓰면 모든 행 삭제
    사용예) 장바구니 테이블(CART)의 행들을 삭제하시오
    SELECT *FROM CART;
    
    DELETE FROM CART;
    
        