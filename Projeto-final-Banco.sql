CREATE DATABASE projeto_final;
USE projeto_final;

-- Tabelas primárias sem dependências
CREATE TABLE `estado` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(100),
  `sigla` varchar(5)
);

CREATE TABLE `cidade` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(100),
  `id_estado` int,
  FOREIGN KEY (`id_estado`) REFERENCES `estado`(`id`)
);

CREATE TABLE `pessoa` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(100),
  `sobrenome` varchar(100),
  `data_de_nascimento` date,
  `genero` char(1),
  `tel_contato` varchar(50),
  `email` varchar(50)
);

CREATE TABLE `documento` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `nome` varchar(50),
  `sigla` varchar(10),
  `numero` int,
  `id_uf` int,
  `data_emissao` date,
  FOREIGN KEY (`id_uf`) REFERENCES `estado`(`id`)
);

