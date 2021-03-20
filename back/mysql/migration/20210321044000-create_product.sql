
-- +migrate Up
CREATE TABLE IF NOT EXISTS `product` (
  `jan` VARCHAR(13) NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  `icon` MEDIUMBLOB NULL,
  PRIMARY KEY (`jan`))
ENGINE = InnoDB;

-- +migrate Down
DROP TABLE IF EXISTS `product`;
