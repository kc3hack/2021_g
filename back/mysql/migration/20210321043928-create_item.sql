
-- +migrate Up
CREATE TABLE IF NOT EXISTS `item` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `box_id` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `note` TEXT NULL,
  `icon` MEDIUMBLOB NULL,
  `created_by` VARCHAR(255) NOT NULL,
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` VARCHAR(255) NOT NULL,
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `index` (`name` ASC) VISIBLE,
  INDEX `fk_item_box_idx` (`box_id` ASC) VISIBLE,
  CONSTRAINT `fk_item_box`
    FOREIGN KEY (`box_id`)
    REFERENCES `box` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- +migrate Down
DROP TABLE IF EXISTS `item`;
