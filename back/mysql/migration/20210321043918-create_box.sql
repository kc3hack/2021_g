
-- +migrate Up
CREATE TABLE IF NOT EXISTS `box` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `note` TEXT NULL,
  `icon` MEDIUMBLOB NULL,
  `code` MEDIUMBLOB NULL,
  `created_by` VARCHAR(255) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` VARCHAR(255) NOT NULL,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `index` (`name` ASC) VISIBLE)
ENGINE = InnoDB;

-- +migrate Down
DROP TABLE IF EXISTS `box`;
