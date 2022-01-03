CREATE TABLE IF NOT EXISTS `invoice_partitioned`(
id int,  
employee_id int,  
invoiced_date date,  
paid_flag tinyint, 
insert_dt datetime ,
insert_user_id int, 
insert_process_code varchar(255), 
update_dt timestamp, 
update_user_id int, 
update_process_code varchar(255), 
deleted_flag tinyint,
department_code varchar(35) ); 

ALTER TABLE `invoice_partitioned` REMOVE PARTITIONING;

ALTER TABLE `invoice_partitioned` 
	PARTITION BY LIST(department.id) (
		PARTITION pCS VALUES IN (1),
        PARTITION pDEV VALUES IN (2),
        PARTITION pFIN VALUES IN (3),
        PARTITION pHR VALUES IN (4),
        PARTITION pMKT VALUES IN (5),
        PARTITION pPROD VALUES IN (6),
        PARTITION pQA VALUES IN (7),
        PARTITION pRES VALUES IN (8),
        PARTITION pSAL VALUES IN (9)        
        );
        
INSERT INTO `invoice_partitioned`
SELECT `invoice`.*, `department`.`code` AS `department_code` 
FROM `invoice`
INNER JOIN `department_employee_rel` ON 1=1
AND `invoice`.`employee_id` = `department_employee_rel`.`employee_id`
AND `invoice`.`invoiced_date` BETWEEN `department_employee_rel`.`from_date` AND IFNULL(`department_employee_rel`.`to_date`, '2002-08-01')
AND `department_employee_rel`.`deleted_flag` = 0
INNER JOIN `department` ON 1=1
AND `department_employee_rel`.`department_id` = `department`.`id`
;






