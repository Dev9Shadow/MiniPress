-- Schema MiniPress (fige)
SET NAMES utf8mb4;
SET foreign_key_checks = 0;

DROP TABLE IF EXISTS `utilisateur`;
CREATE TABLE `utilisateur` (
  `id`       INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `email`    VARCHAR(255) NOT NULL,
  `password` VARCHAR(255) NOT NULL,
  `role`     ENUM('admin','auteur') NOT NULL DEFAULT 'auteur',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_utilisateur_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `categorie`;
CREATE TABLE `categorie` (
  `id`      INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `libelle` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_categorie_libelle` (`libelle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id`            INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `titre`         VARCHAR(255) NOT NULL,
  `resume`        TEXT DEFAULT NULL,
  `contenu`       TEXT NOT NULL,
  `image`         VARCHAR(2048) DEFAULT NULL,
  `date_creation` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `publie`        TINYINT(1) NOT NULL DEFAULT 0,
  `auteur_id`     INT UNSIGNED NOT NULL,
  `categorie_id`  INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_article_auteur`    FOREIGN KEY (`auteur_id`)    REFERENCES `utilisateur` (`id`),
  CONSTRAINT `fk_article_categorie` FOREIGN KEY (`categorie_id`) REFERENCES `categorie` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

SET foreign_key_checks = 1;
