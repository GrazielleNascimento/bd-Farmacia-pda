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

-- Tabelas com dependências de pessoa
CREATE TABLE pessoa_endereco (
  id int PRIMARY KEY AUTO_INCREMENT,
  id_pessoa int,
  logradouro varchar(100),
  numero varchar(50),
  bairro varchar(50),
  cep int,
  complemento varchar(100),
  id_cidade int,
  FOREIGN KEY (id_pessoa) REFERENCES pessoa(id),
  FOREIGN KEY (id_cidade) REFERENCES cidade(id)
);

CREATE TABLE pessoa_documentos (
  id int PRIMARY KEY AUTO_INCREMENT,
  id_pessoa int,
  id_doc int,
  FOREIGN KEY (id_pessoa) REFERENCES pessoa(id),
  FOREIGN KEY (id_doc) REFERENCES documento(id)
);

CREATE TABLE pessoa_contato_emergencial (
  id int PRIMARY KEY AUTO_INCREMENT,
  id_pessoa int,
  id_pessoa_contato int,
  FOREIGN KEY (id_pessoa) REFERENCES pessoa(id),
  FOREIGN KEY (id_pessoa_contato) REFERENCES pessoa(id)
);

-- Tabelas de profissional e especialidade
CREATE TABLE profissional_especialidade (
  id int PRIMARY KEY AUTO_INCREMENT,
  nome varchar(100)
);

CREATE TABLE profissional (
  id int PRIMARY KEY AUTO_INCREMENT,
  id_pessoa int,
  categoria varchar(50),
  id_profissional_especialidade int,
  id_crm_doc int,
  id_coren_doc int,
  FOREIGN KEY (id_pessoa) REFERENCES pessoa(id),
  FOREIGN KEY (id_profissional_especialidade) REFERENCES profissional_especialidade(id),
  FOREIGN KEY (id_crm_doc) REFERENCES documento(id),
  FOREIGN KEY (id_coren_doc) REFERENCES documento(id)
);

ALTER TABLE `profissional_especialidade`
  ADD COLUMN `id_profissional` int,
  ADD COLUMN `id_rqe_doc` int,
  ADD FOREIGN KEY (`id_profissional`) REFERENCES `profissional`(`id`),
  ADD FOREIGN KEY (`id_rqe_doc`) REFERENCES `documento`(`id`);

-- Tabelas de paciente e relacionados
CREATE TABLE `paciente` (
  `id` int PRIMARY KEY AUTO_INCREMENT,
  `id_pessoa` int,
  `id_profissional_responsável` int NOT NULL,
  `diagnóstico` text(500),
  `medicamentos_usados` varchar(200),
  `horario_entrada` datetime,
  `horario_saida` datetime,
  FOREIGN KEY (`id_pessoa`) REFERENCES `pessoa`(`id`),
  FOREIGN KEY (`id_profissional_responsável`) REFERENCES `profissional`(`id`)
);

CREATE TABLE paciente_leito (
  id int PRIMARY KEY AUTO_INCREMENT,
  id_paciente int,
  numero_do_quarto int,
  andar int,
  disponibilidade bool,
  FOREIGN KEY (id_paciente) REFERENCES paciente(id)
);

CREATE TABLE paciente_dados_vitais (
  id int PRIMARY KEY AUTO_INCREMENT,
  id_paciente int,
  id_responsavel_coleta int,
  data_e_horario datetime,
  temperatura float(50),
  frequencia_cardiaca int(50),
  frequencia_respiratoria int(50),
  pressao_arterial varchar(50),
  glicemia int(50),
  FOREIGN KEY (id_paciente) REFERENCES paciente(id),
  FOREIGN KEY (id_responsavel_coleta) REFERENCES profissional(id)
);