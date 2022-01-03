SET @focus_date = '2000-01-01';
SET @company_average := (SELECT ROUND(AVG(`salary_amount`),2) FROM `salary`
WHERE 1=1 
AND @focus_date BETWEEN `salary`.`from_date` AND IFNULL(`salary`.`to_date`, '2002-08-01')
); 

 SELECT
	DATE_FORMAT(`salary`.`from_date`, '%d/%Y') AS 'year_month', 
	`department_id`, name AS 'department_name',     
CASE 
	WHEN ROUND(AVG(`salary`.`salary_amount`), 2) > @company_average THEN 'higher'
    WHEN ROUND(AVG(`salary`.`salary_amount`), 2) < @company_average THEN 'lower'
    ELSE 'same'
END AS 'department_avg vs company_avg' 
FROM `salary`

INNER JOIN  `department_employee_rel` ON 1=1
	AND `department_employee_rel`.`employee_id` = `salary`.`employee_id`
	AND @focus_date BETWEEN `department_employee_rel`.`from_date` AND IFNULL(`department_employee_rel`.`to_date`, '2002-08-01')
	AND `salary`.`deleted_flag` = 0

INNER JOIN department ON 1=1
	AND `department`.`id` = `department_employee_rel`.`department_id`
WHERE 1=1
	AND @focus_date BETWEEN `salary`.`from_date` AND IFNULL(`salary`.`to_date`, '2002-08-01')

GROUP BY 
	`department_id`,
    `department`.`name`;







 