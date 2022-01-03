# Set the user defined variables
SET @focus_date = '2000-01-01';
SET @company_average_salary := (SELECT
	AVG(`salary`.`salary_amount`)
	FROM `sample_staff`.`salary`
    WHERE 1=1 
		AND @focus_date BETWEEN `salary`.`from_date` 
        AND IFNULL(`salary`.`to_date`, '2002-08-01'));
#Using the defined variables to make a query/case statement to evaluate department salary averages vs the company as a whole over a set date range. 
SELECT  `department_id` AS 'department_id', 
		`department_name` AS 'department_name', 
		`department_average_salary` AS 'department_average_salary', 
        ROUND(@company_average_salary,2) AS 'company_average', 
CASE
	WHEN `department_average_salary` > ROUND(@company_average_salary,2)
		THEN "higher"
	WHEN `department_average_salary` = ROUND(@company_average_salary,2)
		THEN "same"
	ELSE "lower"
END AS 'department_vs_company' 
FROM ( 
SELECT
`department`.`id` AS 'department_id',
`department`.`name` AS 'department_name',
ROUND(AVG(`salary`.`salary_amount`), 2) AS 'department_average_salary',
ROUND(@company_average_salary,2) AS 'company average'
FROM `sample_staff`.`salary`
 
LEFT JOIN `department_employee_rel` ON 1=1 
AND `department_employee_rel`.`employee_id` = `salary`.`employee_id`
AND @focus_date BETWEEN `department_employee_rel`.`from_date` AND
IFNULL(`department_employee_rel`.`to_date`, '2002-08-01')

LEFT JOIN `department` ON 1=1
AND `department`.`id` = `department_employee_rel`.`department_id`

WHERE 1=1 
AND @focus_date BETWEEN `salary`.`from_date` 
AND IFNULL(`salary`.`to_date`, '2002-08-01')

GROUP BY 
	`department`.`id`,
	`department`.`name`
ORDER BY 
	`department`.`id`) AS sub;    
