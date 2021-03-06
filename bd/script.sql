-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema calidad_v1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema calidad_v1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `calidad_v1` DEFAULT CHARACTER SET utf8 ;
USE `calidad_v1` ;

-- -----------------------------------------------------
-- Table `calidad_v1`.`archivo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calidad_v1`.`archivo` (
  `id_archivo` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(200) NULL DEFAULT NULL,
  `url` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`id_archivo`))
ENGINE = InnoDB
AUTO_INCREMENT = 335
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `calidad_v1`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calidad_v1`.`usuario` (
  `id_usuario` INT(11) NOT NULL AUTO_INCREMENT,
  `correo` VARCHAR(60) NULL DEFAULT NULL,
  `passwd` VARCHAR(32) NULL DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE INDEX `correo_UNIQUE` (`correo` ASC))
ENGINE = InnoDB
AUTO_INCREMENT = 4
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `calidad_v1`.`sesion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calidad_v1`.`sesion` (
  `id_sesion` INT(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` INT(11) NULL DEFAULT NULL,
  `fecha` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id_sesion`),
  INDEX `sesion_fk1_idx` (`id_usuario` ASC),
  CONSTRAINT `sesion_fk1`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `calidad_v1`.`usuario` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 128
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `calidad_v1`.`resultados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calidad_v1`.`resultados` (
  `id_sesion` INT(11) NOT NULL,
  `informe_csv` INT(11) NULL DEFAULT NULL,
  `tiempo_total` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_sesion`),
  CONSTRAINT `resultados_fk1`
    FOREIGN KEY (`id_sesion`)
    REFERENCES `calidad_v1`.`sesion` (`id_sesion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `calidad_v1`.`sesion_entrada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calidad_v1`.`sesion_entrada` (
  `id_sesion` INT(11) NOT NULL,
  `id_archivo` INT(11) NOT NULL,
  PRIMARY KEY (`id_sesion`, `id_archivo`),
  INDEX `sesion_entrada_fk2_idx` (`id_archivo` ASC),
  CONSTRAINT `sesion_entrada_fk1`
    FOREIGN KEY (`id_sesion`)
    REFERENCES `calidad_v1`.`sesion` (`id_sesion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sesion_entrada_fk2`
    FOREIGN KEY (`id_archivo`)
    REFERENCES `calidad_v1`.`archivo` (`id_archivo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `calidad_v1`.`sesion_salida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `calidad_v1`.`sesion_salida` (
  `id_sesion` INT(11) NOT NULL,
  `id_archivo` INT(11) NOT NULL,
  `tiempo_ejecucion` INT(11) NULL DEFAULT NULL,
  `precision` FLOAT NULL DEFAULT NULL,
  `id_gt` INT(11) NULL DEFAULT NULL,
  `id_informe` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_sesion`, `id_archivo`),
  INDEX `sesion_salida_fk1_idx` (`id_archivo` ASC),
  INDEX `gt_fk` (`id_gt` ASC),
  INDEX `informe_fk` (`id_informe` ASC),
  CONSTRAINT `sesion_salida_fk1`
    FOREIGN KEY (`id_archivo`)
    REFERENCES `calidad_v1`.`archivo` (`id_archivo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sesion_salida_fk2`
    FOREIGN KEY (`id_sesion`)
    REFERENCES `calidad_v1`.`sesion` (`id_sesion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `sesion_salida_ibfk_1`
    FOREIGN KEY (`id_gt`)
    REFERENCES `calidad_v1`.`archivo` (`id_archivo`)
    ON DELETE CASCADE,
  CONSTRAINT `sesion_salida_ibfk_2`
    FOREIGN KEY (`id_informe`)
    REFERENCES `calidad_v1`.`archivo` (`id_archivo`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
