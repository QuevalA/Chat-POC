-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema ycyw
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema ycyw
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `ycyw` DEFAULT CHARACTER SET utf8 ;
USE `ycyw` ;

-- -----------------------------------------------------
-- Table `ycyw`.`LANGUAGE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ycyw`.`LANGUAGE` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ycyw`.`CURRENCY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ycyw`.`CURRENCY` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `code` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`code` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ycyw`.`USERSTATUS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ycyw`.`USERSTATUS` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ycyw`.`USER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ycyw`.`USER` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `email` VARCHAR(80) NOT NULL,
  `password` VARCHAR(120) NOT NULL,
  `firstname` VARCHAR(50) NOT NULL,
  `lastname` VARCHAR(50) NOT NULL,
  `birthdate` DATE NULL,
  `user_id_card` VARCHAR(255) NULL,
  `driving_license` VARCHAR(255) NULL,
  `LANGUAGE_id` BIGINT NOT NULL,
  `CURRENCY_id` BIGINT NOT NULL,
  `USERSTATUS_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `iduser_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  INDEX `fk_USER_LANGUAGE_idx` (`LANGUAGE_id` ASC) VISIBLE,
  INDEX `fk_USER_CURRENCY1_idx` (`CURRENCY_id` ASC) VISIBLE,
  INDEX `fk_USER_USERSTATUS1_idx` (`USERSTATUS_id` ASC) VISIBLE,
  CONSTRAINT `fk_USER_LANGUAGE`
    FOREIGN KEY (`LANGUAGE_id`)
    REFERENCES `ycyw`.`LANGUAGE` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_USER_CURRENCY1`
    FOREIGN KEY (`CURRENCY_id`)
    REFERENCES `ycyw`.`CURRENCY` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_USER_USERSTATUS1`
    FOREIGN KEY (`USERSTATUS_id`)
    REFERENCES `ycyw`.`USERSTATUS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ycyw`.`VEHICULE_CATEGORY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ycyw`.`VEHICULE_CATEGORY` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `category` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`category` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ycyw`.`CITY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ycyw`.`CITY` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `longitude` DOUBLE NOT NULL,
  `latitude` DOUBLE NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ycyw`.`RENTAL_STATUS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ycyw`.`RENTAL_STATUS` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`status` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ycyw`.`RENTAL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ycyw`.`RENTAL` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `starting_datetime` DATETIME NOT NULL,
  `return_datetime` DATETIME NOT NULL,
  `final_price` DOUBLE NOT NULL,
  `USER_id` BIGINT NOT NULL,
  `VEHICULE_CATEGORY_id` BIGINT NOT NULL,
  `starting_city_id` BIGINT NOT NULL,
  `return_city_id` BIGINT NOT NULL,
  `RENTAL_STATUS_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_RENTAL_USER1_idx` (`USER_id` ASC) VISIBLE,
  INDEX `fk_RENTAL_VEHICULE_CATEGORY1_idx` (`VEHICULE_CATEGORY_id` ASC) VISIBLE,
  INDEX `fk_RENTAL_CITY1_idx` (`starting_city_id` ASC) VISIBLE,
  INDEX `fk_RENTAL_CITY2_idx` (`return_city_id` ASC) VISIBLE,
  INDEX `fk_RENTAL_RENTAL_STATUS1_idx` (`RENTAL_STATUS_id` ASC) VISIBLE,
  CONSTRAINT `fk_RENTAL_USER1`
    FOREIGN KEY (`USER_id`)
    REFERENCES `ycyw`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RENTAL_VEHICULE_CATEGORY1`
    FOREIGN KEY (`VEHICULE_CATEGORY_id`)
    REFERENCES `ycyw`.`VEHICULE_CATEGORY` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RENTAL_CITY1`
    FOREIGN KEY (`starting_city_id`)
    REFERENCES `ycyw`.`CITY` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RENTAL_CITY2`
    FOREIGN KEY (`return_city_id`)
    REFERENCES `ycyw`.`CITY` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RENTAL_RENTAL_STATUS1`
    FOREIGN KEY (`RENTAL_STATUS_id`)
    REFERENCES `ycyw`.`RENTAL_STATUS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ycyw`.`RENTAL_OFFER_STATUS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ycyw`.`RENTAL_OFFER_STATUS` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `status` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`status` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ycyw`.`AGENCY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ycyw`.`AGENCY` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `name_UNIQUE` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ycyw`.`RENTAL_OFFER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ycyw`.`RENTAL_OFFER` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `created_at` DATETIME NOT NULL,
  `updated_at` DATETIME NOT NULL,
  `description` TEXT NULL,
  `starting_datetime` DATETIME NOT NULL,
  `return_datetime` DATETIME NOT NULL,
  `pricing` DOUBLE NOT NULL,
  `VEHICULE_CATEGORY_id` BIGINT NOT NULL,
  `starting_city_id` BIGINT NOT NULL,
  `return_city_id` BIGINT NOT NULL,
  `RENTAL_OFFER_STATUS_id` BIGINT NOT NULL,
  `AGENCY_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_RENTAL_OFFER_VEHICULE_CATEGORY1_idx` (`VEHICULE_CATEGORY_id` ASC) VISIBLE,
  INDEX `fk_RENTAL_OFFER_CITY1_idx` (`starting_city_id` ASC) VISIBLE,
  INDEX `fk_RENTAL_OFFER_CITY2_idx` (`return_city_id` ASC) VISIBLE,
  INDEX `fk_RENTAL_OFFER_RENTAL_OFFER_STATUS1_idx` (`RENTAL_OFFER_STATUS_id` ASC) VISIBLE,
  INDEX `fk_RENTAL_OFFER_AGENCY1_idx` (`AGENCY_id` ASC) VISIBLE,
  CONSTRAINT `fk_RENTAL_OFFER_VEHICULE_CATEGORY1`
    FOREIGN KEY (`VEHICULE_CATEGORY_id`)
    REFERENCES `ycyw`.`VEHICULE_CATEGORY` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RENTAL_OFFER_CITY1`
    FOREIGN KEY (`starting_city_id`)
    REFERENCES `ycyw`.`CITY` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RENTAL_OFFER_CITY2`
    FOREIGN KEY (`return_city_id`)
    REFERENCES `ycyw`.`CITY` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RENTAL_OFFER_RENTAL_OFFER_STATUS1`
    FOREIGN KEY (`RENTAL_OFFER_STATUS_id`)
    REFERENCES `ycyw`.`RENTAL_OFFER_STATUS` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RENTAL_OFFER_AGENCY1`
    FOREIGN KEY (`AGENCY_id`)
    REFERENCES `ycyw`.`AGENCY` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ycyw`.`SAVED_SEARCH`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ycyw`.`SAVED_SEARCH` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `created_at` DATETIME NOT NULL,
  `starting_datetime` DATETIME NULL,
  `return_datetime` DATETIME NULL,
  `USER_id` BIGINT NOT NULL,
  `VEHICULE_CATEGORY_id` BIGINT NULL,
  `starting_city_id` BIGINT NULL,
  `return_city_id` BIGINT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_SAVED_SEARCH_USER1_idx` (`USER_id` ASC) VISIBLE,
  INDEX `fk_SAVED_SEARCH_VEHICULE_CATEGORY1_idx` (`VEHICULE_CATEGORY_id` ASC) VISIBLE,
  INDEX `fk_SAVED_SEARCH_CITY1_idx` (`starting_city_id` ASC) VISIBLE,
  INDEX `fk_SAVED_SEARCH_CITY2_idx` (`return_city_id` ASC) VISIBLE,
  CONSTRAINT `fk_SAVED_SEARCH_USER1`
    FOREIGN KEY (`USER_id`)
    REFERENCES `ycyw`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SAVED_SEARCH_VEHICULE_CATEGORY1`
    FOREIGN KEY (`VEHICULE_CATEGORY_id`)
    REFERENCES `ycyw`.`VEHICULE_CATEGORY` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SAVED_SEARCH_CITY1`
    FOREIGN KEY (`starting_city_id`)
    REFERENCES `ycyw`.`CITY` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SAVED_SEARCH_CITY2`
    FOREIGN KEY (`return_city_id`)
    REFERENCES `ycyw`.`CITY` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ycyw`.`USER_has_RENTAL_OFFER`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ycyw`.`USER_has_RENTAL_OFFER` (
  `USER_id` BIGINT NOT NULL,
  `RENTAL_OFFER_id` BIGINT NOT NULL,
  PRIMARY KEY (`USER_id`, `RENTAL_OFFER_id`),
  INDEX `fk_USER_has_RENTAL_OFFER_RENTAL_OFFER1_idx` (`RENTAL_OFFER_id` ASC) VISIBLE,
  INDEX `fk_USER_has_RENTAL_OFFER_USER1_idx` (`USER_id` ASC) VISIBLE,
  CONSTRAINT `fk_USER_has_RENTAL_OFFER_USER1`
    FOREIGN KEY (`USER_id`)
    REFERENCES `ycyw`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_USER_has_RENTAL_OFFER_RENTAL_OFFER1`
    FOREIGN KEY (`RENTAL_OFFER_id`)
    REFERENCES `ycyw`.`RENTAL_OFFER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ycyw`.`REVIEW`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ycyw`.`REVIEW` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `created_at` DATETIME NOT NULL,
  `rating` INT NOT NULL,
  `content` TEXT NULL,
  `USER_id` BIGINT NULL,
  `RENTAL_id` BIGINT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_REVIEW_USER1_idx` (`USER_id` ASC) VISIBLE,
  INDEX `fk_REVIEW_RENTAL1_idx` (`RENTAL_id` ASC) VISIBLE,
  CONSTRAINT `fk_REVIEW_USER1`
    FOREIGN KEY (`USER_id`)
    REFERENCES `ycyw`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_REVIEW_RENTAL1`
    FOREIGN KEY (`RENTAL_id`)
    REFERENCES `ycyw`.`RENTAL` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ycyw`.`CONVERSATION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ycyw`.`CONVERSATION` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `created_at` DATETIME NOT NULL,
  `is_active` TINYINT NOT NULL,
  `RENTAL_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_CONVERSATION_RENTAL1_idx` (`RENTAL_id` ASC) VISIBLE,
  CONSTRAINT `fk_CONVERSATION_RENTAL1`
    FOREIGN KEY (`RENTAL_id`)
    REFERENCES `ycyw`.`RENTAL` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `ycyw`.`MESSAGE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ycyw`.`MESSAGE` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `created_at` DATETIME NOT NULL,
  `content` VARCHAR(800) NOT NULL,
  `CONVERSATION_id` BIGINT NOT NULL,
  `USER_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_MESSAGE_CONVERSATION1_idx` (`CONVERSATION_id` ASC) VISIBLE,
  INDEX `fk_MESSAGE_USER1_idx` (`USER_id` ASC) VISIBLE,
  CONSTRAINT `fk_MESSAGE_CONVERSATION1`
    FOREIGN KEY (`CONVERSATION_id`)
    REFERENCES `ycyw`.`CONVERSATION` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MESSAGE_USER1`
    FOREIGN KEY (`USER_id`)
    REFERENCES `ycyw`.`USER` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
