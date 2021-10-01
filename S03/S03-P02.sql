ALTER TABLE contract ADD INDEX idx_contract_archive_code_sign_date(archive_code, sign_date);

EXPLAIN SELECT `contract`.`archive_code`
FROM `contract`
WHERE 1=1
 AND `contract`.`archive_code` = 'DA970'
 AND `contract`.`deleted_flag` = 0
 AND `contract`.`sign_date` >= '1990-01-01'
;
 
EXPLAIN SELECT `contract`.`archive_code`
FROM `contract`
WHERE 1=1
 AND `contract`.`archive_code` = 'DA970'
 AND `contract`.`deleted_flag` = 0
;