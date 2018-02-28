-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema bpdwa
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `bpdwa` ;

-- -----------------------------------------------------
-- Schema bpdwa
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bpdwa` DEFAULT CHARACTER SET utf8 ;
USE `bpdwa` ;

-- -----------------------------------------------------
-- Table `bpdwa`.`itinerario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bpdwa`.`itinerario` ;

CREATE TABLE IF NOT EXISTS `bpdwa`.`itinerario` (
  `iditinerario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NULL,
  `categoria` VARCHAR(45) NULL,
  `duracion` VARCHAR(15) NULL,
  `ubicacion` VARCHAR(45) NULL,
  PRIMARY KEY (`iditinerario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bpdwa`.`parada`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bpdwa`.`parada` ;

CREATE TABLE IF NOT EXISTS `bpdwa`.`parada` (
  `idparada` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NULL,
  `numeroParada` INT NULL,
  `ubicacion` VARCHAR(45) NULL,
  `historia` VARCHAR(200) NULL,
  `anecdotario` VARCHAR(200) NULL,
  `gastronomia` VARCHAR(200) NULL,
  `imagen` VARCHAR(45) NULL,
  `itinerario_iditinerario` INT NOT NULL,
  PRIMARY KEY (`idparada`),
  INDEX `fk_parada_itinerario_idx` (`itinerario_iditinerario` ASC),
  CONSTRAINT `fk_parada_itinerario`
    FOREIGN KEY (`itinerario_iditinerario`)
    REFERENCES `bpdwa`.`itinerario` (`iditinerario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bpdwa`.`actividad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bpdwa`.`actividad` ;

CREATE TABLE IF NOT EXISTS `bpdwa`.`actividad` (
  `idactividad` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NULL,
  `fechainicio` DATE NULL,
  `fechafin` DATE NULL,
  `ubicacion` VARCHAR(60) NULL,
  `numparticipantes` INT NULL,
  `precio` FLOAT NULL,
  `imagen` VARCHAR(60) NULL,
  `puntos` INT NULL,
  PRIMARY KEY (`idactividad`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bpdwa`.`pruebaCultural`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bpdwa`.`pruebaCultural` ;

CREATE TABLE IF NOT EXISTS `bpdwa`.`pruebaCultural` (
  `idpruebacultural` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NULL,
  `pregunta` VARCHAR(200) NULL,
  `respuesta` VARCHAR(45) NULL,
  `puntos` INT NULL,
  `parada_idparada` INT NOT NULL,
  PRIMARY KEY (`idpruebacultural`),
  INDEX `fk_pruebaCultural_parada1_idx` (`parada_idparada` ASC),
  CONSTRAINT `fk_pruebaCultural_parada1`
    FOREIGN KEY (`parada_idparada`)
    REFERENCES `bpdwa`.`parada` (`idparada`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bpdwa`.`pruebaDeportiva`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bpdwa`.`pruebaDeportiva` ;

CREATE TABLE IF NOT EXISTS `bpdwa`.`pruebaDeportiva` (
  `idpruebadeportiva` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NULL,
  `fechainicio` DATE NULL,
  `fechafin` DATE NULL,
  `explicacion` VARCHAR(200) NULL,
  `puntos` INT NULL,
  `parada_idparada` INT NOT NULL,
  PRIMARY KEY (`idpruebadeportiva`),
  INDEX `fk_pruebaDeportiva_parada1_idx` (`parada_idparada` ASC),
  CONSTRAINT `fk_pruebaDeportiva_parada1`
    FOREIGN KEY (`parada_idparada`)
    REFERENCES `bpdwa`.`parada` (`idparada`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bpdwa`.`rol`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bpdwa`.`rol` ;

CREATE TABLE IF NOT EXISTS `bpdwa`.`rol` (
  `idrol` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NULL,
  PRIMARY KEY (`idrol`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bpdwa`.`cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bpdwa`.`cliente` ;

CREATE TABLE IF NOT EXISTS `bpdwa`.`cliente` (
  `idcliente` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NULL,
  `apellidos` VARCHAR(60) NULL,
  `fechanacimiento` DATE NULL,
  `email` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  `direccion` VARCHAR(60) NULL,
  `codigopostal` VARCHAR(10) NULL,
  `avatar` VARCHAR(45) NULL,
  `puntosacumulados` INT NULL,
  `fecharegistro` DATE NULL,
  `rol_idrol` INT NOT NULL,
  PRIMARY KEY (`idcliente`),
  INDEX `fk_cliente_rol1_idx` (`rol_idrol` ASC),
  CONSTRAINT `fk_cliente_rol1`
    FOREIGN KEY (`rol_idrol`)
    REFERENCES `bpdwa`.`rol` (`idrol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bpdwa`.`cliente_has_actividad`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bpdwa`.`cliente_has_actividad` ;

CREATE TABLE IF NOT EXISTS `bpdwa`.`cliente_has_actividad` (
  `cliente_idcliente` INT NOT NULL,
  `actividad_idactividad` INT NOT NULL,
  PRIMARY KEY (`cliente_idcliente`, `actividad_idactividad`),
  INDEX `fk_cliente_has_actividad_actividad1_idx` (`actividad_idactividad` ASC),
  INDEX `fk_cliente_has_actividad_cliente1_idx` (`cliente_idcliente` ASC),
  CONSTRAINT `fk_cliente_has_actividad_cliente1`
    FOREIGN KEY (`cliente_idcliente`)
    REFERENCES `bpdwa`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_has_actividad_actividad1`
    FOREIGN KEY (`actividad_idactividad`)
    REFERENCES `bpdwa`.`actividad` (`idactividad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bpdwa`.`multimedia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bpdwa`.`multimedia` ;

CREATE TABLE IF NOT EXISTS `bpdwa`.`multimedia` (
  `idmultimedia` INT NOT NULL,
  `fecha` DATE NULL,
  `comentario` VARCHAR(60) NULL,
  `imagen` VARCHAR(60) NULL,
  `video` VARCHAR(60) NULL,
  `cliente_idcliente` INT NOT NULL,
  `pruebaDeportiva_idpruebadeportiva` INT NOT NULL,
  `puntosacumulados` INT NULL,
  PRIMARY KEY (`idmultimedia`),
  INDEX `fk_multimedia_cliente1_idx` (`cliente_idcliente` ASC),
  INDEX `fk_multimedia_pruebaDeportiva1_idx` (`pruebaDeportiva_idpruebadeportiva` ASC),
  CONSTRAINT `fk_multimedia_cliente1`
    FOREIGN KEY (`cliente_idcliente`)
    REFERENCES `bpdwa`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_multimedia_pruebaDeportiva1`
    FOREIGN KEY (`pruebaDeportiva_idpruebadeportiva`)
    REFERENCES `bpdwa`.`pruebaDeportiva` (`idpruebadeportiva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bpdwa`.`comentario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bpdwa`.`comentario` ;

CREATE TABLE IF NOT EXISTS `bpdwa`.`comentario` (
  `idcomentario` INT NOT NULL AUTO_INCREMENT,
  `texto` VARCHAR(200) NULL,
  `cliente_idcliente` INT NOT NULL,
  `multimedia_idmultimedia` INT NOT NULL,
  PRIMARY KEY (`idcomentario`),
  INDEX `fk_comentario_cliente1_idx` (`cliente_idcliente` ASC),
  INDEX `fk_comentario_multimedia1_idx` (`multimedia_idmultimedia` ASC),
  CONSTRAINT `fk_comentario_cliente1`
    FOREIGN KEY (`cliente_idcliente`)
    REFERENCES `bpdwa`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comentario_multimedia1`
    FOREIGN KEY (`multimedia_idmultimedia`)
    REFERENCES `bpdwa`.`multimedia` (`idmultimedia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bpdwa`.`voto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bpdwa`.`voto` ;

CREATE TABLE IF NOT EXISTS `bpdwa`.`voto` (
  `idvoto` INT NOT NULL AUTO_INCREMENT,
  `puntos` INT NULL,
  `cliente_idcliente` INT NOT NULL,
  `multimedia_idmultimedia` INT NOT NULL,
  PRIMARY KEY (`idvoto`),
  INDEX `fk_voto_cliente1_idx` (`cliente_idcliente` ASC),
  INDEX `fk_voto_multimedia1_idx` (`multimedia_idmultimedia` ASC),
  CONSTRAINT `fk_voto_cliente1`
    FOREIGN KEY (`cliente_idcliente`)
    REFERENCES `bpdwa`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_voto_multimedia1`
    FOREIGN KEY (`multimedia_idmultimedia`)
    REFERENCES `bpdwa`.`multimedia` (`idmultimedia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bpdwa`.`premio`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bpdwa`.`premio` ;

CREATE TABLE IF NOT EXISTS `bpdwa`.`premio` (
  `idpremio` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NULL,
  `descripcion` VARCHAR(200) NULL,
  `imagen` VARCHAR(45) NULL,
  `fechaactivacion` DATE NULL,
  `fechaconsumo` DATE NULL,
  `puntos` INT NULL,
  `cliente_idcliente` INT NOT NULL,
  PRIMARY KEY (`idpremio`),
  INDEX `fk_premio_cliente1_idx` (`cliente_idcliente` ASC),
  CONSTRAINT `fk_premio_cliente1`
    FOREIGN KEY (`cliente_idcliente`)
    REFERENCES `bpdwa`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bpdwa`.`noticia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bpdwa`.`noticia` ;

CREATE TABLE IF NOT EXISTS `bpdwa`.`noticia` (
  `idnoticia` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(60) NULL,
  `texto` VARCHAR(200) NULL,
  `fechaalta` DATE NULL,
  `fechacaducidad` DATE NULL,
  `imagen` VARCHAR(45) NULL,
  PRIMARY KEY (`idnoticia`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
