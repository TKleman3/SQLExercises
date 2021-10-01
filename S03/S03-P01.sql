#CREATE INDEX idx_employee_personal_code2 ON `sample_staff`.`employee`(personal_code(2));

#EXPLAIN SELECT *
#FROM `sample_staff`.`employee` 
#WHERE 1=1
#	AND `employee`.`personal_code` = "AA-751492";
    
-- It's good to run ANALYZE TABLE before checking index or table size
#ANALYZE TABLE `sample_staff`.`employee`;



 SELECT /* Select all indexes from table 'employee' and their size  */
sum(`stat_value`) AS pages,
`index_name` AS index_name,
sum(`stat_value`) * @@innodb_page_size / 1024 / 1024 AS size_mb
FROM `mysql`.`innodb_index_stats`
WHERE 1=1
AND `table_name` = 'employee'
AND `database_name` = 'sample_staff'
AND `stat_description` = 'Number of pages in the index'
GROUP BY
`index_name`; 