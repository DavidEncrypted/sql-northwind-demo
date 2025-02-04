-- -----------------------------------------------------
-- Table `northwind`.`order_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `northwind`.`order_details` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `order_id` INT(11) NOT NULL,
  `product_id` INT(11) NULL DEFAULT NULL,
  `quantity` DECIMAL(18,4) NOT NULL DEFAULT '0.0000',
  `unit_price` DECIMAL(19,4) NULL DEFAULT '0.0000',
  `discount` DOUBLE NOT NULL DEFAULT '0',
  `status_id` INT(11) NULL DEFAULT NULL,
  `date_allocated` DATETIME NULL DEFAULT NULL,
  `purchase_order_id` INT(11) NULL DEFAULT NULL,
  `inventory_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `id` (`id` ASC),
  INDEX `inventory_id` (`inventory_id` ASC),
  INDEX `id_2` (`id` ASC),
  INDEX `id_3` (`id` ASC),
  INDEX `id_4` (`id` ASC),
  INDEX `product_id` (`product_id` ASC),
  INDEX `product_id_2` (`product_id` ASC),
  INDEX `purchase_order_id` (`purchase_order_id` ASC),
  INDEX `id_5` (`id` ASC),
  INDEX `fk_order_details_orders1_idx` (`order_id` ASC),
  INDEX `fk_order_details_order_details_status1_idx` (`status_id` ASC),
  CONSTRAINT `fk_order_details_orders1`
    FOREIGN KEY (`order_id`)
    REFERENCES `northwind`.`orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_details_products1`
    FOREIGN KEY (`product_id`)
    REFERENCES `northwind`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_details_order_details_status1`
    FOREIGN KEY (`status_id`)
    REFERENCES `northwind`.`order_details_status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `northwind`.`purchase_order_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `northwind`.`purchase_order_details` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `purchase_order_id` INT(11) NOT NULL,
  `product_id` INT(11) NULL DEFAULT NULL,
  `quantity` DECIMAL(18,4) NOT NULL,
  `unit_cost` DECIMAL(19,4) NOT NULL,
  `date_received` DATETIME NULL DEFAULT NULL,
  `posted_to_inventory` TINYINT(1) NOT NULL DEFAULT '0',
  `inventory_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `id` (`id` ASC),
  INDEX `inventory_id` (`inventory_id` ASC),
  INDEX `inventory_id_2` (`inventory_id` ASC),
  INDEX `purchase_order_id` (`purchase_order_id` ASC),
  INDEX `product_id` (`product_id` ASC),
  INDEX `product_id_2` (`product_id` ASC),
  INDEX `purchase_order_id_2` (`purchase_order_id` ASC),
  CONSTRAINT `fk_purchase_order_details_inventory_transactions1`
    FOREIGN KEY (`inventory_id`)
    REFERENCES `northwind`.`inventory_transactions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_purchase_order_details_products1`
    FOREIGN KEY (`product_id`)
    REFERENCES `northwind`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_purchase_order_details_purchase_orders1`
    FOREIGN KEY (`purchase_order_id`)
    REFERENCES `northwind`.`purchase_orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `northwind`.`employee_privileges`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `northwind`.`employee_privileges` (
  `employee_id` INT(11) NOT NULL,
  `privilege_id` INT(11) NOT NULL,
  PRIMARY KEY (`employee_id`, `privilege_id`),
  INDEX `employee_id` (`employee_id` ASC),
  INDEX `privilege_id` (`privilege_id` ASC),
  INDEX `privilege_id_2` (`privilege_id` ASC),
  CONSTRAINT `fk_employee_privileges_employees1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `northwind`.`employees` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_privileges_privileges1`
    FOREIGN KEY (`privilege_id`)
    REFERENCES `northwind`.`privileges` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `northwind`.`sales_reports`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `northwind`.`sales_reports` (
  `group_by` VARCHAR(50) NOT NULL,
  `display` VARCHAR(50) NULL DEFAULT NULL,
  `title` VARCHAR(50) NULL DEFAULT NULL,
  `filter_row_source` LONGTEXT NULL DEFAULT NULL,
  `default` TINYINT(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`group_by`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
