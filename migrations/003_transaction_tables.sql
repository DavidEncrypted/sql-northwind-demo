-- -----------------------------------------------------
-- Table `northwind`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `northwind`.`orders` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `employee_id` INT(11) NULL DEFAULT NULL,
  `customer_id` INT(11) NULL DEFAULT NULL,
  `order_date` DATETIME NULL DEFAULT NULL,
  `shipped_date` DATETIME NULL DEFAULT NULL,
  `shipper_id` INT(11) NULL DEFAULT NULL,
  `ship_name` VARCHAR(50) NULL DEFAULT NULL,
  `ship_address` LONGTEXT NULL DEFAULT NULL,
  `ship_city` VARCHAR(50) NULL DEFAULT NULL,
  `ship_state_province` VARCHAR(50) NULL DEFAULT NULL,
  `ship_zip_postal_code` VARCHAR(50) NULL DEFAULT NULL,
  `ship_country_region` VARCHAR(50) NULL DEFAULT NULL,
  `shipping_fee` DECIMAL(19,4) NULL DEFAULT '0.0000',
  `taxes` DECIMAL(19,4) NULL DEFAULT '0.0000',
  `payment_type` VARCHAR(50) NULL DEFAULT NULL,
  `paid_date` DATETIME NULL DEFAULT NULL,
  `notes` LONGTEXT NULL DEFAULT NULL,
  `tax_rate` DOUBLE NULL DEFAULT '0',
  `tax_status_id` TINYINT(4) NULL DEFAULT NULL,
  `status_id` TINYINT(4) NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  INDEX `customer_id` (`customer_id` ASC),
  INDEX `customer_id_2` (`customer_id` ASC),
  INDEX `employee_id` (`employee_id` ASC),
  INDEX `employee_id_2` (`employee_id` ASC),
  INDEX `id` (`id` ASC),
  INDEX `id_2` (`id` ASC),
  INDEX `shipper_id` (`shipper_id` ASC),
  INDEX `shipper_id_2` (`shipper_id` ASC),
  INDEX `id_3` (`id` ASC),
  INDEX `tax_status` (`tax_status_id` ASC),
  INDEX `ship_zip_postal_code` (`ship_zip_postal_code` ASC),
  CONSTRAINT `fk_orders_customers`
    FOREIGN KEY (`customer_id`)
    REFERENCES `northwind`.`customers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_employees1`
    FOREIGN KEY (`employee_id`)
    REFERENCES `northwind`.`employees` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_shippers1`
    FOREIGN KEY (`shipper_id`)
    REFERENCES `northwind`.`shippers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_orders_tax_status1`
    FOREIGN KEY (`tax_status_id`)
    REFERENCES `northwind`.`orders_tax_status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orders_orders_status1`
    FOREIGN KEY (`status_id`)
    REFERENCES `northwind`.`orders_status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `northwind`.`purchase_orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `northwind`.`purchase_orders` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `supplier_id` INT(11) NULL DEFAULT NULL,
  `created_by` INT(11) NULL DEFAULT NULL,
  `submitted_date` DATETIME NULL DEFAULT NULL,
  `creation_date` DATETIME NULL DEFAULT NULL,
  `status_id` INT(11) NULL DEFAULT '0',
  `expected_date` DATETIME NULL DEFAULT NULL,
  `shipping_fee` DECIMAL(19,4) NOT NULL DEFAULT '0.0000',
  `taxes` DECIMAL(19,4) NOT NULL DEFAULT '0.0000',
  `payment_date` DATETIME NULL DEFAULT NULL,
  `payment_amount` DECIMAL(19,4) NULL DEFAULT '0.0000',
  `payment_method` VARCHAR(50) NULL DEFAULT NULL,
  `notes` LONGTEXT NULL DEFAULT NULL,
  `approved_by` INT(11) NULL DEFAULT NULL,
  `approved_date` DATETIME NULL DEFAULT NULL,
  `submitted_by` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id` (`id` ASC),
  INDEX `created_by` (`created_by` ASC),
  INDEX `status_id` (`status_id` ASC),
  INDEX `id_2` (`id` ASC),
  INDEX `supplier_id` (`supplier_id` ASC),
  INDEX `supplier_id_2` (`supplier_id` ASC),
  CONSTRAINT `fk_purchase_orders_employees1`
    FOREIGN KEY (`created_by`)
    REFERENCES `northwind`.`employees` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_purchase_orders_purchase_order_status1`
    FOREIGN KEY (`status_id`)
    REFERENCES `northwind`.`purchase_order_status` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_purchase_orders_suppliers1`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `northwind`.`suppliers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `northwind`.`inventory_transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `northwind`.`inventory_transactions` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `transaction_type` TINYINT(4) NOT NULL,
  `transaction_created_date` DATETIME NULL DEFAULT NULL,
  `transaction_modified_date` DATETIME NULL DEFAULT NULL,
  `product_id` INT(11) NOT NULL,
  `quantity` INT(11) NOT NULL,
  `purchase_order_id` INT(11) NULL DEFAULT NULL,
  `customer_order_id` INT(11) NULL DEFAULT NULL,
  `comments` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `customer_order_id` (`customer_order_id` ASC),
  INDEX `customer_order_id_2` (`customer_order_id` ASC),
  INDEX `product_id` (`product_id` ASC),
  INDEX `product_id_2` (`product_id` ASC),
  INDEX `purchase_order_id` (`purchase_order_id` ASC),
  INDEX `purchase_order_id_2` (`purchase_order_id` ASC),
  INDEX `transaction_type` (`transaction_type` ASC),
  CONSTRAINT `fk_inventory_transactions_orders1`
    FOREIGN KEY (`customer_order_id`)
    REFERENCES `northwind`.`orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inventory_transactions_products1`
    FOREIGN KEY (`product_id`)
    REFERENCES `northwind`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inventory_transactions_purchase_orders1`
    FOREIGN KEY (`purchase_order_id`)
    REFERENCES `northwind`.`purchase_orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inventory_transactions_inventory_transaction_types1`
    FOREIGN KEY (`transaction_type`)
    REFERENCES `northwind`.`inventory_transaction_types` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `northwind`.`invoices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `northwind`.`invoices` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `order_id` INT(11) NULL DEFAULT NULL,
  `invoice_date` DATETIME NULL DEFAULT NULL,
  `due_date` DATETIME NULL DEFAULT NULL,
  `tax` DECIMAL(19,4) NULL DEFAULT '0.0000',
  `shipping` DECIMAL(19,4) NULL DEFAULT '0.0000',
  `amount_due` DECIMAL(19,4) NULL DEFAULT '0.0000',
  PRIMARY KEY (`id`),
  INDEX `id` (`id` ASC),
  INDEX `id_2` (`id` ASC),
  INDEX `fk_invoices_orders1_idx` (`order_id` ASC),
  CONSTRAINT `fk_invoices_orders1`
    FOREIGN KEY (`order_id`)
    REFERENCES `northwind`.`orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
