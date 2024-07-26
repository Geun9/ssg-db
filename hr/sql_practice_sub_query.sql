-- [문제 1]
-- HR 부서의 어떤 사원은 급여정보를 조회하는 업무를 맡고 있다.
-- Tucker(last_name) 사원보다 급여를 많이 받고 있는 사원의 성과 이름(Name으로 별칭), 업무, 급여를 출력하시오
SELECT CONCAT(e.first_name, ' ', e.last_name) AS Name
     , e.job_id
     , e.salary
FROM employees e
WHERE e.salary > (SELECT salary
                  FROM employees
                  WHERE last_name = 'Tucker');


-- [문제 2]
-- 사원의 급여 정보 중 업무별 최소 급여를 받고 있는
-- 사원의 성과 이름(Name으로 별칭), 업무, 급여, 입사일을 출력하시오.
SELECT CONCAT(e.first_name, ' ', e.last_name) AS Name
     , e.job_id
     , e.salary
     , e.hire_date
FROM employees e
         JOIN (SELECT MIN(salary) salary
                    , job_id
               FROM employees
               GROUP BY job_id) AS j ON e.job_id = j.job_id
    AND e.salary = j.salary;


-- [문제 3]
-- 소속 부서의 평균 급여보다 많은 급여를 받는 사원에 대하여
-- 사원의 성과 이름(Name으로 별칭), 급여, 부서번호, 업무를 출력하시오
SELECT CONCAT(e.first_name, ' ', e.last_name) AS Name
     , e.salary
     , e.department_id
     , e.job_id
FROM employees e
WHERE e.salary > ANY (SELECT AVG(salary) salaryAvg
                      FROM employees
                      GROUP BY department_id);


-- [문제 4]
-- 사원들의 지역별 근무 현황을 조회하고자 한다.
-- 도시 이름이 영문 'O' 로 시작하는 지역에서 일하고 있는 사원의 사번, 이름, 업무, 입사일을 출력하시오
-- 도시 이름 대소문자 구분을 위해 BINARY 사용
SELECT e.employee_id
     , CONCAT(e.first_name, ' ', e.last_name) AS Name
     , e.job_id
     , e.hire_date
     , l.city
FROM employees e
         JOIN departments d ON e.department_id = d.department_id
         JOIN locations l ON l.location_id = d.location_id
WHERE BINARY (l.city) LIKE 'O%';


SELECT e.employee_id
     , CONCAT(e.first_name, ' ', e.last_name) AS Name
     , e.job_id
     , e.hire_date
     , l.city
     , d.department_id
FROM employees e
         JOIN departments d ON e.department_id = d.department_id
         JOIN locations l ON l.location_id = d.location_id
WHERE e.department_id = (SELECT d2.department_id
                         FROM departments d2
                         WHERE d2.location_id = (SELECT l2.location_id
                                                 FROM locations l2
                                                 WHERE BINARY (l2.city) LIKE 'O%'));


-- [문제 5]
-- 모든 사원의 소속부서 평균연봉을 계산하여 사원별로
-- 성과 이름(Name으로 별칭), 업무, 급여, 부 서번호, 부서 평균연봉(Department Avg Salary로 별칭)을 출력하시오
SELECT CONCAT(e.first_name, ' ', e.last_name) AS Name
     , e.job_id
     , e.salary
     , e.department_id
     , sa.salary                              AS 'Department Avg Salary'
FROM employees e
         JOIN (SELECT AVG(salary) salary
                    , department_id
               FROM employees
               GROUP BY department_id) AS sa ON e.department_id = sa.department_id;


-- [문제 6]
-- ‘Kochhar’의 급여보다 많은 사원의 정보를 사원번호,이름,담당업무,급여를 출력하시오.
SELECT e.employee_id
     , CONCAT(e.first_name, ' ', e.last_name) AS Name
     , e.job_id
     , e.salary
FROM employees e
WHERE salary > (SELECT salary
                FROM employees
                WHERE last_name = 'Kochhar');


-- [문제 7]
-- 급여의 평균보다 적은 사원의 사원번호,이름,담당업무,급여,부서번호를 출력하시오
SELECT e.employee_id
     , CONCAT(e.first_name, ' ', e.last_name) AS Name
     , e.job_id
     , e.salary
     , e.department_id
FROM employees e
WHERE salary < (SELECT AVG(salary)
                FROM employees);

-- [문제 8]
-- 100번 부서의 최소 급여보다 최소 급여가 많은 다른 모든 부서를 출력하시오
SELECT DISTINCT d.department_name, d.department_id
FROM employees e
         JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_id
HAVING MIN(e.salary) > ANY (SELECT MIN(salary)
                            FROM employees
                            WHERE department_id = 100);


-- [문제 9]
-- 업무별로 최소 급여를 받는 사원의 정보를 사원번호,이름,업무,부서번호를 출력하시오 출력시 업무별로 정렬하시오
SELECT e.employee_id
     , CONCAT(e.first_name, ' ', e.last_name) AS Name
     , e.job_id
     , e.department_id
FROM employees e
         JOIN (SELECT MIN(salary) AS salary
                    , job_id
               FROM employees
               GROUP BY job_id) AS ms ON e.job_id = ms.job_id
    AND e.salary = ms.salary;


-- [문제 10]
-- 100번 부서의 최소 급여보다 최소 급여가 많은 다른 모든 부서를 출력하시오
SELECT DISTINCT d.department_name, d.department_id
FROM employees e
         JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_id
HAVING MIN(e.salary) > ANY (SELECT MIN(salary)
                            FROM employees
                            WHERE department_id = 100);

-- [문제 11]
-- 업무가 SA_MAN 사원의 정보를 이름,업무,부서명,근무지를 출력하시오.
SELECT CONCAT(e.first_name, ' ', e.last_name) AS Name
     , e.job_id
     , d.department_name
     , l.city
FROM (SELECT first_name, last_name, job_id, department_id
      FROM employees
      WHERE job_id = 'SA_MAN') e,
     (SELECT department_id, department_name, location_id
      FROM departments) d,
     (SELECT location_id, city
      FROM locations) l
WHERE e.department_id = d.department_id
  AND d.location_id = l.location_id;


-- [문제 12]
-- 가장 많은 부하직원을 갖는 MANAGER의 사원번호와 이름을 출력하시오
SELECT e.employee_id
     , CONCAT(e.first_name, ' ', e.last_name) AS Name
FROM employees e
WHERE e.employee_id = (SELECT manager_id
                       FROM employees
                       GROUP BY manager_id
                       ORDER BY COUNT(manager_id) DESC
                       LIMIT 1);

-- [문제 13]
-- 사원번호가 123인 사원의 업무가 같고 사원번호가 192인 사원의 급여(SAL))보다 많은 사원의 사원번호,이름,직업,급여를 출력하시오
SELECT e.employee_id
     , CONCAT(e.first_name, ' ', e.last_name) AS Name
     , e.job_id
     , e.salary
FROM employees e
WHERE e.job_id = (SELECT job_id
                  FROM employees
                  WHERE employee_id = 123)
  AND e.salary > (SELECT salary
                  FROM employees
                  WHERE employee_id = 192);


-- [문제 14]
-- 50번 부서에서 최소 급여를 받는 사원보다 많은 급여를 받는
-- 사원의 사원번호,이름,업무,입사 일자,급여,부서 번호를 출력하시오.
-- 단 50번 부서의 사원은 제외합니다.
SELECT e.employee_id
     , CONCAT(e.first_name, ' ', e.last_name) AS Name
     , e.job_id
     , e.hire_date
     , e.salary
     , e.department_id
FROM employees e
WHERE salary > ANY (SELECT salary
                    FROM employees
                    WHERE department_id = 50)
  AND e.department_id != 50;


-- [문제 15]
-- (50번 부서의 최고 급여)를 받는 사원 보다 많은 급여를 받는
-- 사원의 사원번호,이름,업무,입사일자,급여,부서번호를 출력하시오.
-- 단 50번 부서의 사원은 제외합니다.

SELECT e.employee_id
     , CONCAT(e.first_name, ' ', e.last_name) AS Name
     , e.job_id
     , e.hire_date
     , e.salary
     , e.department_id
FROM employees e
WHERE salary > ALL (SELECT salary
                    FROM employees
                    WHERE department_id = 50);