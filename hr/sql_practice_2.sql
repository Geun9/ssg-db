-- 1. 모든 사원의 이름, 부서번호, 부서 이름을 조회하세요
SELECT CONCAT(e.first_name, ' ', e.last_name) AS Name
     , e.department_id
     , d.department_name
FROM employees e
         LEFT JOIN departments d ON d.department_id = e.department_id;


-- 2. 부서번호 80 에 속하는 모든 업무의 고유 목록을 작성하고 출력결과에 부서의 위치를 출력하세요
SELECT DISTINCT d.department_id
              , e.job_id
              , l.street_address
FROM departments d
         LEFT JOIN employees e
                   ON e.department_id = d.department_id
         LEFT JOIN locations l ON l.location_id = d.location_id
WHERE d.department_id = 80;


-- 3. 커미션을 받는 사원의 이름, 부서 이름, 위치번호와 도시명을 조회하세요
SELECT CONCAT(first_name, ' ', last_name) AS Name
     , d.department_name
     , l.location_id
     , l.city
FROM employees e
         JOIN departments d ON e.department_id = d.department_id
         JOIN locations l ON l.location_id = d.location_id;


-- 4. 이름에 a(소문자)가 포함된 모든 사원의 이름과 부서명을 조회하세요
-- REGEXP_LIKE(컬럼명, pattern[, match_type])
-- c: 대소문자 구별. 디폴트 옵션
-- i: 대소문자 구별 안 함
SELECT DISTINCT e.first_name
FROM employees e,
     departments d
WHERE REGEXP_LIKE(e.first_name, 'A', 'c');


-- 5. 'Toronto'에서 근무하는 모든 사원의 이름, 업무, 부서 번호 와 부서명을 조회하세요
SELECT CONCAT(first_name, ' ', last_name) AS Name
     , e.job_id
     , e.department_id
     , d.department_name
FROM locations l
         JOIN departments d ON l.location_id = d.location_id
         JOIN employees e ON d.department_id = e.department_id
WHERE l.city = 'Toronto';


-- 6. 사원의 이름과 사원번호를 관리자의 이름과 관리자 아이디와 함께 표시하고 각각의 컬럼명을 Empl1oyee, Emp#, Manger, Mgr#으로 지정하세요
SELECT CONCAT(e.first_name, ' ', e.last_name) AS Employee
     , e.employee_id                          AS 'Emp#'
     , CONCAT(m.first_name, ' ', m.last_name) AS Manger
     , m.employee_id                          AS 'Mgr#'
FROM employees e
         LEFT JOIN employees m ON e.manager_id = m.employee_id;


-- 7. 사장인'King'을 포함하여 관리자가 없는 모든 사원을 조회하세요 (사원번호를 기준으로 정렬하세요)
SELECT *
FROM employees
WHERE manager_id IS NULL;


-- 8. 지정한 사원(specified_employee)의 이름, 부서 번호 와 지정한 사원과 동일한 부서(same_department_employee)에서 근무하는 모든 사원을 조회하세요
SELECT CONCAT(se.first_name, ' ', se.last_name)   AS se_name
     , se.department_id                           AS se_department_id
     , CONCAT(sde.first_name, ' ', sde.last_name) AS sde_name
FROM employees se
         LEFT JOIN employees sde ON se.department_id = sde.department_id
WHERE se.employee_id = ?;

-- 9. 모든 사원의 이름, 업무,부서이름, 급여 , 급여등급을 조회하세요
SELECT CONCAT(e.first_name, ' ', e.last_name) AS Name
     , e.job_id
     , d.department_name
     , e.salary
     , jg.grade_level
FROM employees e,
     job_grades jg,
     departments d
WHERE e.department_id = d.department_id AND e.salary BETWEEN jg.lowest_sal AND jg.highest_sal;