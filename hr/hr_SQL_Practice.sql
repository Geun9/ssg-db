-- ************************ --
-- ******** SELECT ******** --
-- ************************ --

-- [문제 0]
-- 사원정보(EMPLOYEE) 테이블에서 사원번호, 이름, 급여, 업무, 입사일, 상사의 사원번호를 출력 하시오.
-- 이때 이름은 성과 이름을 연결하여 Name 이라는 별칭으로 출력하시오
SELECT employee_id
     , CONCAT(first_name, ' ', last_name) AS Name
     , salary
     , job_id
     , DATE_FORMAT(hire_date, '%Y-%m-%d') AS hire_date
     , manager_id
FROM employees;

-- [문제 1]
-- 사원정보(EMPLOYEES) 테이블에서 사원의 성과 이름은 Name, 업무는 Job,
-- 급여는 Salary, 연 봉에 $100 보너스를 추가하여 계산한 값은 Increased Ann_Salary,
-- 급여에 $100 보너스를 추가하여 계산한 연봉은 Increased Salary라는 별칭으로 출력하시오
SELECT CONCAT(first_name, ' ', last_name) AS Name
     , job_id                             AS Job
     , salary                             AS Salary
     , (salary + 100)                     AS 'Increased Ann_Salary'
     , (salary + 100) * 12                AS 'Increased Salary'
FROM employees;


-- [문제 2]
-- 사원정보(EMPLOYEE) 테이블에서 모든 사원의 이름(last_name)과
-- 연봉을 “이름: 1 Year Salary = $연봉” 형식으로 출력하고, 1 Year Salary라는 별칭을 붙여 출력하시오
SELECT CONCAT(last_name, ': 1 Year Salary = $', (salary * 12)) AS '1 Year Salary'
FROM employees;


-- [문제 3] 부서별로 담당하는 업무를 한 번씩만 출력하시오
SELECT DISTINCT d.department_name AS '부서명'
              , j.job_id          AS '업무'
FROM departments d
         LEFT JOIN employees e ON e.department_id = d.department_id
         LEFT JOIN jobs j ON j.job_id = e.job_id;

-- *********************** --
-- *** WHERE, ORDER BY *** --
-- *********************** --

-- [문제 0]
-- HR 부서에서 예산 편성 문제로 급여 정보 보고서를 작성하려고 한다.
-- 사원정보(EMPLOYEES) 테이블에서 급여가 $7,000~$10,000 범위 이외인
-- 사람의 성과 이름(Name으로 별칭) 및 급여를 급여가 작은 순서로 출력하시오(75행).
SELECT CONCAT(first_name, ' ', last_name) AS Name
     , salary
FROM employees
WHERE NOT salary BETWEEN 7000 AND 10000
ORDER BY salary;


-- [문제 1]
-- 사원의 이름(last_name) 중에 ‘e’ 및 ‘o’ 글자가 포함된 사원을 출력하시오.
-- 이때 머리글은 ‘e and o Name’라고 출력하시오
SELECT last_name AS 'e and o Name'
FROM employees
WHERE last_name LIKE '%e%'
   OR last_name LIKE '%o%';


-- [문제 2]
-- 현재 날짜 타입을 날짜 함수를 통해 확인하고,
-- 2006년 05월 20일부터 2007년 05월 20일 사이에 고용된 사원들의 성과 이름(Name으로 별칭),
-- 사원번호, 고용일자를 출력하시오. 단, 입사일이 빠른 순으로 정렬하시오
SELECT CONCAT(first_name, ' ', last_name) AS Name
     , employee_id
     , hire_date
FROM employees
WHERE hire_date BETWEEN DATE('2006-05-20') AND DATE('2007-05-20')
ORDER BY hire_date;

-- [문제 3]
-- HR 부서에서는 급여(salary)와 수당율(commission_pct)에 대한 지출 보고서를 작성하려고 한다.
-- 이에 수당을 받는 모든 사원의 성과 이름(Name으로 별칭), 급여, 업무, 수당율을 출력하시오.
-- 이때 급여가 큰 순서대로 정렬하되, 급여가 같으면 수당율이 큰 순서대로 정렬하시오
SELECT CONCAT(first_name, ' ', last_name) AS Name
     , salary
     , job_id
     , commission_pct
FROM employees
ORDER BY salary DESC, commission_pct DESC;

-- *************************** --
-- *** 단일 행 함수 및 변환 함수 *** --
-- *************************** --

-- [문제 0]
-- 이번 분기에 60번 IT 부서에서는 신규 프로그램을 개발하고 보급하여 회사에 공헌하였다.
-- 이에 해당 부서의 사원 급여를 12.3% 인상하기로 하였다.
-- 60번 IT 부서 사원의 급여를 12.3% 인상하여 정수만 (반올림) 표시하는 보고서를 작성하시오.
-- 출력 형식은 사번, 이름과 성(Name으로 별칭), 급여, 인상된 급여(Increased Salary로 별칭)순으로 출력한다
SELECT employee_id
     , CONCAT(first_name, ' ', last_name) AS Name
     , salary
     , ROUND(salary * 1.123)              AS 'Increased Salary'
FROM employees;


-- [문제 1]
-- 각 사원의 성(last_name)이 ‘s’로 끝나는 사원의 이름과 업무를 아래의 예와 같이 출력하고자 한다.
-- 출력 시 성과 이름은 첫 글자가 대문자, 업무는 모두 대문자로 출력하고 머리글은 Employee JOBs로 표시하시오(18행).
-- EX> James Landry is a ST_CLERK
-- INITCAP() 함수 사용: 첫 글자를 대문자
SELECT CONCAT(UPPER(SUBSTRING(first_name, 1, 1))
           , LOWER(SUBSTRING(first_name, 2))
           , ' '
           , UPPER(SUBSTRING(last_name, 1, 1))
           , LOWER(SUBSTRING(last_name, 2))
           , ' is a '
           , UPPER(job_id)) AS 'Employee JOBs'
FROM employees
WHERE first_name LIKE '%s';


-- [문제 2]
-- 모든 사원의 연봉을 표시하는 보고서를 작성하려고 한다.
-- 보고서에 사원의 성과 이름(Name으로 별칭), 급여, 수당여부에 따른 연봉을 포함하여 출력하시오.
-- 수당여부는 수당이 있으면 “Salary + Commission”, 수당이 없으면 “Salary only”라고 표시하고, 별칭은 적절히 붙인다.
-- 또한 출력 시 연봉이 높은 순으로 정렬한다(107행).
SELECT CONCAT(first_name, ' ', last_name) AS Name
     , salary
     , (CASE
            WHEN commission_pct IS NOT NULL
                THEN salary + (salary * commission_pct)
            ELSE 'Salary only'
    END)                                  AS 'Annual Compensation'
FROM employees
ORDER BY salary DESC;


SELECT CONCAT(first_name, ' ', last_name)                                                AS Name
     , salary
     , IF(commission_pct IS NOT NULL, salary + (salary * commission_pct), 'Salary only') AS 'Annual Compensation'
FROM employees
ORDER BY salary DESC;

-- [문제 3]
-- 모든 사원들 성과 이름(Name으로 별칭), 입사일 그리고 입사일이 어떤 요일이였는지 출력하시오.
-- 이때 주(week)의 시작인 일요일부터 출력되도록 정렬하시오(107행).
SELECT CONCAT(first_name, ' ', last_name) AS Name
     , hire_date
     , DAYNAME(hire_date)                 AS hire_day
     , DAYOFWEEK(hire_date)               AS hire_week
FROM employees
ORDER BY hire_week;

-- *************************** --
-- ********* 집계 함수 ********* --
-- *************************** --

-- [문제 0]
-- 모든 사원은 직속 상사 및 직속 직원을 갖는다.
-- 단, 최상위 또는 최하위 직원은 직속 상사 및 직원이 없다.
-- 소속된 사원들 중 어떤 사원의 상사로 근무 중인 사원의 총 수를 출력하시오.
SELECT COUNT(DISTINCT manager_id) AS managerCnt
FROM employees;


-- [문제 1]
-- 각 사원이 소속된 부서별로 급여 합계, 급여 평균, 급여 최대값, 급여 최소값을 집계하고자 한다.
-- 계산된 출력값은 6자리와 세 자리 구분기호, $ 표시와 함께 출력하고 부서번호의 오름차순 정렬하시오.
-- 단, 부서에 소속되지 않은 사원에 대한 정보는 제외하고 출력시 머리글은 아래 예시처럼 별칭(alias) 처리 하시오.
SELECT department_id
     , concat('$', LPAD(format(SUM(salary), 2), 10, ' ')) AS sumSalary
     , concat('$', LPAD(format(AVG(salary), 2), 10, ' ')) AS avgSalary
     , concat('$', LPAD(format(MAX(salary), 2), 10, ' ')) AS maxSalary
     , concat('$', LPAD(format(MIN(salary), 2), 10, ' ')) AS minSalary
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id
ORDER BY department_id;


-- [문제 2]
-- 사원들의 업무별 전체 급여 평균이 $10,000보다 큰 경우를 조회하여 업무, 급여 평균을 출력하시오.
-- 단 업무에 사원(CLERK)이 포함된 경우는 제외하고 전체 급여 평균이 높은 순서대로 출력하시오.
SELECT job_id
, AVG(salary) AS avgSalary
FROM employees
WHERE NOT job_id LIKE '%CLERK%'
GROUP BY job_id
HAVING AVG(salary) > 10000
ORDER BY avgSalary;