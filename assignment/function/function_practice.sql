/*
 [1]
 */
SELECT CONCAT(Name, ' ', Continent, ' ', Population) AS info
FROM country;


/*
 [2]
 */
DESC country;
SELECT code
     , IFNULL(IndepYear, '데이터 없음') AS IndepYear
FROM country
WHERE IndepYear IS NULL;


/*
 [3]
 */
SELECT UPPER(Name) AS upperName
     , LOWER(Name) AS lowerName
FROM country;


/*
 [4]
 */
SELECT LTRIM(Name) AS ltrimName
     , RTRIM(Name) AS rtrimName
     , TRIM(Name)  AS trimName
FROM country;

/*
 [5]
 */
SELECT Name
     , LENGTH(Name) AS length
FROM country
WHERE LENGTH(Name) > 20
ORDER BY length DESC;


/*
 [6]
 */
SELECT TRUNCATE(SurfaceArea, 0) AS SurfaceArea
FROM country;


/*
 [7]
 */
SELECT SUBSTRING(Name, 2, 4) AS Name
FROM country;


/*
 [8]
 */
SELECT REPLACE(Code, 'A', 'Z') AS Code
FROM country;


/*
 [9]
 */
SELECT REPLACE(Code, 'A', REPEAT('Z', 10)) AS Code
FROM country;


/*
 [10]
 */
SELECT DATE_ADD(NOW(), INTERVAL 24 HOUR) AS date_add
FROM country;


/*
 [11]
 */
SELECT DATE_SUB(NOW(), INTERVAL 24 HOUR) AS date_sub
FROM country;


/*
 [13]
 */
SELECT COUNT(*)
FROM country;


/*
 [14]
 */
SELECT SUM(GNP) AS sum
     , AVG(GNP) AS avg
     , MAX(GNP) AS max
     , MIN(GNP) AS min
FROM country;


/*
 [15]
 */
SELECT ROUND(LifeExpectancy, 0) AS roundLifeExpectancy
FROM country;


/*
 [16]
 */
SELECT RANK() OVER (ORDER BY LifeExpectancy DESC, Code ASC) AS rankLifeExpectancy, Code, LifeExpectancy
FROM country;


/*
 [17]
 */
SELECT RANK() OVER (ORDER BY LifeExpectancy DESC) AS rankLifeExpectancy, Code, LifeExpectancy
FROM country;


/*
 [18]
 */
SELECT dense_rank() OVER (ORDER BY LifeExpectancy DESC) AS rankLifeExpectancy, Code, LifeExpectancy
FROM country;
