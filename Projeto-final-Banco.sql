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

