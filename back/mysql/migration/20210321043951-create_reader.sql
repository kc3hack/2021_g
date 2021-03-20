
-- +migrate Up
CREATE TABLE IF NOT EXISTS `reader` (
  `user_id` VARCHAR(255) NOT NULL,
  `box_id` INT NOT NULL,
  PRIMARY KEY (`user_id`, `box_id`),
  INDEX `fk_writer_box1_idx` (`box_id` ASC) VISIBLE,
  CONSTRAINT `fk_writer_box10`
    FOREIGN KEY (`box_id`)
    REFERENCES `box` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- +migrate Down
DROP TABLE IF EXISTS `reader`;
