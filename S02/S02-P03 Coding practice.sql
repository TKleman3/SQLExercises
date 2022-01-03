INSERT INTO `bi_data`.`valid_offers` (`offer_id`, `hotel_id`, `price_usd`, `original_price`, `original_currency_code`,
      `checkin_date`, `checkout_date`, `breakfast_included_flag`, `valid_from_date`, `valid_to_date`)
      
SELECT 
	`enterprise_data`.`offer_cleanse_date_fix`.`id`, 
	`enterprise_data`.`offer_cleanse_date_fix`.`hotel_id`, 
	`enterprise_data`.`offer_cleanse_date_fix`.`sellings_price` AS price_usd, 
	`enterprise_data`.`offer_cleanse_date_fix`.`sellings_price` AS original_price,
    `primary_data.lst_currency`.`code` AS original_currency_code, 
    `enterprise_data`.`offer_cleanse_date_fix`.`checkin_date`, 
    `enterprise_data`.`offer_cleanse_date_fix`.`checkout_date`, 
    `enterprise_data`.`offer_cleanse_date_fix`.`breakfast_included_flag`,
    `enterprise_data`.`offer_cleanse_date_fix`.`offer_valid_from`, 
    `enterprise_data`.`offer_cleanse_date_fix`.`offer_valid_to`
FROM  `enterprise_data`.`offer_cleanse_date_fix`, `primary_data.lst_currency` 
WHERE 1=1 
	AND `enterprise_data.offer_cleanse_date_fix`.`currency_id`= 1 
    AND `primary_data.lst_currency`.`id`= 1;