-- -----------------------------------------------------
-- Table `northwind`.`privileges`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `northwind`.`privileges` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `privilege_name` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `northwind`.`inventory_transaction_types`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `northwind`.`inventory_transaction_types` (
  `id` TINYINT(4) NOT NULL,
  `type_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `northwind`.`orders_tax_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `northwind`.`orders_tax_status` (
  `id` TINYINT(4) NOT NULL,
  `tax_status_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `northwind`.`orders_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `northwind`.`orders_status` (
  `id` TINYINT(4) NOT NULL,
  `status_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `northwind`.`purchase_order_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `northwind`.`purchase_order_status` (
  `id` INT(11) NOT NULL,
  `status` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `northwind`.`order_details_status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `northwind`.`order_details_status` (
  `id` INT(11) NOT NULL,
  `status_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `northwind`.`strings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `northwind`.`strings` (
  `string_id` INT(11) NOT NULL AUTO_INCREMENT,
  `string_data` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`string_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;
