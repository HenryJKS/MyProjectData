--Usando as Functions AVG e SUM
SELECT round(AVG(salary),2), MAX(salary),
       MIN(salary), SUM(salary)
FROM   employees
WHERE  department_id in (90, 100, 110);

--Usando as Functions MIN e MAX
SELECT MIN(hire_date), MAX(hire_date)
FROM	  employees;

--Usando a Function COUNT
SELECT COUNT(*)
FROM employees
WHERE  department_id = 50;

SELECT COUNT(commission_pct)
FROM   employees
WHERE  department_id = 80;


--Usando a Palavra-Chave DISTINCT
SELECT COUNT(DISTINCT department_id)
FROM   employees;

select department_id from employees;

--Functions de Grupo e Valores Nulos
SELECT AVG(commission_pct)
FROM   employees;

SELECT round(AVG(NVL(commission_pct, 0)),2)
FROM   employees;

SELECT (commission_pct),(NVL(commission_pct, 0))
FROM   employees;

--Usando a Cláusula GROUP BY 
SELECT   department_id, 
round(AVG(salary),2) avg_sal,
         sum(salary) sum_sal,
         max(salary) max_sal,
         count(*) qtd_emp
FROM     employees
GROUP BY department_id
order by department_id;

SELECT   AVG(salary)
FROM     employees
GROUP BY department_id ;

--Usando a Cláusula GROUP BY em Várias Colunas
SELECT   department_id dept_id, job_id, SUM(salary)
FROM     employees
GROUP BY department_id, job_id 
order by dept_id;

--Consultas Inválidas Usando Functions de Grupo
SELECT department_id, COUNT(last_name)
FROM   employees;

SELECT   department_id, AVG(salary)
FROM     employees
GROUP BY department_id
having AVG(salary) > 7000
order by 2;

--Usando a Cláusula HAVING
SELECT   department_id, MAX(salary) salario
FROM     employees
GROUP BY department_id
HAVING   MAX(salary)>10000 ;

SELECT   job_id, SUM(salary) PAYROLL
FROM employees
WHERE    job_id NOT LIKE '%REP%'
GROUP BY job_id
HAVING   SUM(salary) > 13000
ORDER BY SUM(salary);   

--Aninhando Functions de Grupo
SELECT   max(AVG(salary)) 
FROM     employees
GROUP BY department_id;