USE bookDB;

SELECT phone
FROM customer
WHERE name = '김연아';


SELECT bookName
     , publisher
FROM book
WHERE price >= 10000;

-- ************************** --
-- ******** SELECT 문 ******** --
-- ************************** --

-- 3-1 모든 도서의 이름과 가격 조회
SELECT bookName, price
FROM book;


-- 3-1 모든 도서의 이름과 가격 조회 (별칭)
SELECT bookName AS BookName
     , price    AS Price
FROM book;


-- 3-2 모든 도서의 도서번호, 도서이름, 출판사, 가격을 조회
SELECT bookId, bookName, publisher, price
FROM book;


-- 3-3 도서 테이블에 있는 모든 출판사를 조회
SELECT publisher
FROM book;


-- 3-3 도서 테이블에 있는 모든 출판사를 조회 (중복 제거)
SELECT DISTINCT publisher
FROM book;

-- *********************** --
-- ******** WHERE ******** --
-- *********************** --

-- 3-4 가격이 20,000원 미만인 도서를 검색
SELECT *
FROM book
WHERE price < 20000;


-- 3-5 가격이 10,000원 이상 20,000 이하인 도서를 검색
SELECT *
FROM book
WHERE price BETWEEN 10000 AND 20000;


-- 3-6 출판사가 ‘굿스포츠’ 혹은 ‘대한미디어’인 도서를 검색
SELECT *
FROM book
WHERE publisher REGEXP ('굿스포츠|대한미디어');


-- 3-6 출판사가 ‘굿스포츠’ 혹은 ‘대한미디어’가 아닌 도서를 검색
SELECT *
FROM book
WHERE publisher NOT REGEXP ('굿스포츠|대한미디어');


-- 3-7 '축구의 역사’를 출간한 출판사를 검색하시오.
SELECT bookName, publisher
FROM book
WHERE bookName LIKE '축구의 역사';


-- 3-8 도서이름에 ‘축구’가 포함된 출판사를 검색하시오.
SELECT bookName, publisher
FROM book
WHERE bookName LIKE ('%축구%');


-- 3-9 도서이름의 왼쪽 두 번째 위치에 ‘구’라는 문자열을 갖는 도서를 검색하시오.
SELECT *
FROM book
WHERE bookName REGEXP ('.구');

-- 3-10 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색하시오.
SELECT *
FROM book
WHERE bookName LIKE ('%축구%')
  AND price >= 20000;


-- 3-11 출판사가 ‘굿스포츠’ 혹은 ‘대한미디어’인 도서를 검색하시오.
SELECT *
FROM book
WHERE publisher IN ('굿스포츠', '대한미디어');

-- ********************** --
-- ****** ORDER BY ****** --
-- ********************** --

-- 3-12 도서를 이름순으로 검색하시오.
SELECT *
FROM book
ORDER BY bookName;


-- 3-13 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색하시오.
SELECT *
FROM book
ORDER BY price, bookName;


-- 3-14 도서를 가격의 내림차순으로 검색하시오. 만약 가격이 같다면 출판사의 오름차순으로 검색하시오
SELECT *
FROM book
ORDER BY price DESC, publisher;

-- *********************** --
-- ********* 집계 ********* --
-- *********************** --

-- 3-15 고객이 주문한 도서의 총 판매액을 구하시오.
SELECT SUM(price) AS '총매출'
FROM book;


-- 3-16 김연아 고객이 주문한 도서의 총 판매액을 구하시오.
SELECT SUM(o.salePrice) AS '총매출'
FROM customer c
         JOIN orders o ON o.custId = c.custId
         JOIN book b ON b.bookId = o.bookId
WHERE c.name LIKE ('김연아');


-- 3-17 고객이 주문한 도서의 총 판매액, 평균값, 최저가, 최고가를 구하시오.
SELECT SUM(o.salePrice) AS TOTAL
     , AVG(o.salePrice) AS AVERAGE
     , MIN(o.salePrice) AS MINIMUM
     , MAX(o.salePrice) AS MAXIMUM
FROM orders o
         JOIN book b ON b.bookId = o.bookId;


-- 3-18 서점의 도서 판매 건수를 구하시오.
SELECT COUNT(*)
FROM orders;


-- ********************** --
-- ****** GROUP BY ****** --
-- ********************** --

-- 3-19 고객별로 주문한 도서의 총 수량과 총 판매액을 구하시오.
SELECT c.custId         AS CUSTID
     , COUNT(*)         AS '도서 수량'
     , SUM(o.salePrice) AS '총액'
FROM customer c
         JOIN orders o ON o.custId = c.custId
GROUP BY c.custId;


-- 3-20 가격이 8,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총수량을구하시오. 단, 두 권 이상 구매한 고객만 구한다.
SELECT custId   AS CUSTID
     , COUNT(*) AS '도서수량'
FROM orders
WHERE salePrice >= 8000
GROUP BY custId
HAVING COUNT(*) >= 2;



-- 1번. 서점의 고객이 요구하는 다음 질문에 대해 SQL 문을 작성하시오.
-- 1-1) 도서번호가 1인 도서의 이름
SELECT bookId
     , bookName
FROM book
WHERE bookId = 1;


-- 1-2) 가격이 20,000원 이상인 도서의 이름
SELECT bookId
     , bookName
FROM book
WHERE price >= 20000;


-- 1-3) 박지성의 총 구매액(박지성의 고객번호는 1번으로 놓고 작성)
SELECT SUM(salePrice) AS '총 구매액'
FROM orders
WHERE custId = 1;


-- 1-4) 박지성이 구매한 도서의 수(박지성의 고객번호는 1번으로 놓고 작성)
SELECT COUNT(bookId)
FROM orders
WHERE custId = 1;


-- 2. 서점의 운영자와 경영자가 요구하는 다음 질문에 대해 SQL 문을 작성하시오.
-- 2-1) 마당서점 도서의 총 개수
SELECT COUNT(bookId) AS '도서의 총 수'
FROM book;


-- 2-2) 마당서점에 도서를 출고하는 출판사의 총 개수
SELECT COUNT(DISTINCT publisher) AS '출판사 수'
FROM book;

-- 2-3) 모든 고객의 이름, 주소
SELECT custId
     , name
     , address
FROM customer;

-- 2-4) 2024년 7월 4일~7월 7일 사이에 주문 받은 도서의 주문번호
SELECT orderId, orderDate
FROM orders
WHERE orderDate BETWEEN DATE('2024-07-04') AND DATE('2024-07-07');


-- 2-5) 2024년 7월 4일~7월 7일 사이에 주문 받은 도서를 제외한 도서의 주문번호
SELECT orderId, orderDate
FROM orders
WHERE orderDate NOT BETWEEN DATE('2024-07-04') AND DATE('2024-07-07');


-- 2-6) 성이 ‘김’ 씨인 고객의 이름과 주소
SELECT name, address
FROM customer
WHERE name LIKE '김%';

-- 2-7) 성이 ‘김’ 씨이고 이름이 ‘아’로 끝나는 고객의 이름과 주소
SELECT name, address
FROM customer
WHERE name LIKE '김%아';

SELECT name, address
FROM customer
WHERE name REGEXP '^김.*아$';


-- ******************************* --
-- ******** 2개 이상의 테이블 ******** --
-- ******************************* --


-- ********************** --
-- ******** JOIN ******** --
-- ********************** --

-- 3-21 고객과 고객의 주문에 관한 데이터를 모두 보이시오.
SELECT *
FROM customer c
         JOIN orders o ON o.custId = c.custId;


-- 3-22 고객과 고객의 주문에 관한 데이터를 고객번호 순으로 정렬하여 보이시오.
SELECT *
FROM customer c
         JOIN orders o ON o.custId = c.custId
ORDER BY c.custId;


-- 3-23 고객의 이름과 고객이 주문한 도서의 판매가격을 검색하시오.
SELECT c.name, o.salePrice
FROM customer c
         JOIN orders o ON o.custId = c.custId;


-- 3-24 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬하시오.
SELECT c.name
     , SUM(o.salePrice) AS '총 판매액'
FROM customer c
         JOIN orders o ON o.custId = c.custId
GROUP BY c.custId;


-- 3-25 고객의 이름과 고객이 주문한 도서의 이름을 구하시오.
SELECT c.name, b.bookName
FROM customer c
         JOIN orders o ON o.custId = c.custId
         JOIN book b ON b.bookId = o.bookId;


-- 3-26 가격이 20,000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.
SELECT c.name     AS '고객 이름'
     , b.bookName AS '도서 이름'
FROM customer c
         JOIN orders o ON o.custId = c.custId
         JOIN book b ON b.bookId = o.bookId
WHERE b.price = 20000;

-- ********************** --
-- ***** OUTER JOIN ***** --
-- ********************** --

-- 3-27 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격을 구하시오.
SELECT c.name      AS '고객 이름'
     , o.salePrice AS '주문 도서 가격'
FROM customer c
         LEFT JOIN orders o ON o.custId = c.custId;


-- 3-28 가장 비싼 도서의 이름을 보이시오.
SELECT b.*
FROM book b
         JOIN (SELECT MAX(price) AS price
               FROM book) maxB ON maxB.price = b.price;


-- 3-29 도서를 구매한 적이 있는 고객의 이름을 검색하시오.
SELECT DISTINCT c.name AS '고객명', c.custId
FROM customer c
         JOIN orders o ON o.custId = c.custId;


-- 3-30 대한미디어에서 출판한 도서를 구매한 고객의 이름을 보이시오.
SELECT b.bookName, b.bookId, c.name
FROM book b
         JOIN orders o ON o.bookId = b.bookId
         JOIN customer c ON c.custId = o.custId
WHERE b.publisher = '대한미디어';


-- 3-31 출판사별로 출판사의 평균 도서 가격보다 비싼 도서를 구하시오.
SELECT b.*, avg.avgPrice AS '출판사 평균 도서 가격'
FROM book b
         LEFT JOIN (SELECT AVG(price) AS avgPrice
                         , publisher
                    FROM book
                    GROUP BY publisher) avg ON avg.publisher = b.publisher
WHERE b.price > avg.avgPrice;

-- 1. 서점의 고객이 요구하는 다음 질문에 대해 SQL 문을 작성하시오.
-- 1-5) 박지성이 구매한 도서의 출판사 수
SELECT COUNT(DISTINCT b.publisher) AS '박지성이 구한 도서의 출판사 수'
FROM customer c
         JOIN orders o ON o.custId = c.custId
         JOIN book b ON b.bookId = o.bookId
WHERE c.name = '박지성';

-- 1-6) 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이
SELECT b.bookName              AS '도서명'
     , b.price                 AS '도서 가격'
     , (b.price - o.salePrice) AS '정가와 판매가 차이'
FROM customer c
         JOIN orders o ON o.custId = c.custId
         JOIN book b ON b.bookId = o.bookId
WHERE c.name = '박지성';

-- 1-7) 박지성이 구매하지 않은 도서의 이름
SELECT bookName
FROM book
WHERE NOT bookName IN (SELECT DISTINCT b.bookName
                       FROM customer c
                                JOIN orders o ON o.custId = c.custId
                                JOIN book b ON b.bookId = o.bookId
                       WHERE c.name = '박지성');

-- 2. 서점의 운영자와 경영자가 요구하는 다음 질문에 대해 SQL 문을 작성하시오.
-- 2-8) 주문하지 않은 고객의 이름(부속질의 사용)


-- 2-9) 주문 금액의 총액과 주문의 평균 금액


-- 2-10) 고객의 이름과 고객별 구매액


-- 2-11) 고객의 이름과 고객이 구매한 도서 목록


-- 2-12) 도서의 가격(Book 테이블)과 판매가격(Orders 테이블)의 차이가 가장 많은 주문 (13) 도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름

