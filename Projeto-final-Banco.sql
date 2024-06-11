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

CREATE TABLE acompanhante (
  id int PRIMARY KEY AUTO_INCREMENT,
  id_pessoa int,
  id_paciente int,
  parentesco varchar(50),
  FOREIGN KEY (id_pessoa) REFERENCES pessoa(id),
  FOREIGN KEY (id_paciente) REFERENCES paciente(id)
);

CREATE TABLE medicamento (
  id int PRIMARY KEY AUTO_INCREMENT,
  nome varchar(100),
  dosagem varchar(50)
);

CREATE TABLE paciente_medicacao (
  id int PRIMARY KEY AUTO_INCREMENT,
  id_paciente int NOT NULL,
  id_medicamento int,
  frequencia varchar(50),
  data_inicio date,
  data_fim date,
  horario_administracao time,
  id_responsavel_administracao int,
  observacoes text,
  data_registro datetime,
  FOREIGN KEY (id_paciente) REFERENCES paciente(id),
  FOREIGN KEY (id_medicamento) REFERENCES medicamento(id),
  FOREIGN KEY (id_responsavel_administracao) REFERENCES profissional(id)
);

-- Inserir dados em pessoa_endereco
INSERT INTO pessoa_endereco (id_pessoa, logradouro, numero, bairro, cep, complemento, id_cidade) VALUES 
(1, 'Rua do Limoeiro', '123', 'Centro', 12345678, 'Apto 101', 1), 
(2, 'Rua do Abacaxi', '456', 'Jardim Floresta', 87654321, 'Casa 02', 2), 
(3, 'Rua da Feira', '789', 'Presidencial', 13579246, 'Sala 03', 3),
(4, 'Rua das Flores', '100', 'Centro', 12345678, 'Apto 101', 1),
(5, 'Avenida Paulista', '2000', 'Bela Vista', 98765432, 'Bloco B', 1),
(6, 'Rua dos Alfeneiros', '4', 'Privet Drive', 54321678, 'Casa', 2),
(7, 'Rua das Acácias', '555', 'Jardim Primavera', 13579246, 'Casa 01', 3),
(8, 'Avenida Atlântica', '1000', 'Copacabana', 24681357, 'Apartamento 301', 2),
(9, 'Rua do Sol', '789', 'Praia Grande', 98765432, 'Casa 10', 1),
(10, 'Rua dos Girassóis', '888', 'Vila Nova', 36925814, 'Casa 05', 3),
(11, 'Avenida da Liberdade', '200', 'Centro', 58291734, 'Apartamento 502', 2),
(12, 'Rua das Palmeiras', '1234', 'Jardim Botânico', 74921683, 'Casa 20', 1),
(13, 'Rua das Árvores', '100', 'Cidade Verde', 12345678, 'Casa 101', 1),
(14, 'Avenida das Américas', '2000', 'América', 98765432, 'Bloco B', 1),
(15, 'Rua dos Coqueiros', '4', 'Coqueiral', 54321678, 'Casa', 2),
(16, 'Rua dos Jasmins', '555', 'Jardim das Flores', 13579246, 'Casa 01', 3),
(17, 'Avenida Paulista', '1000', 'Bela Vista', 24681357, 'Apartamento 301', 2),
(18, 'Rua da Praia', '789', 'Beira Mar', 98765432, 'Casa 10', 1),
(19, 'Rua das Orquídeas', '888', 'Orquidário', 36925814, 'Casa 05', 3),
(20, 'Avenida São Paulo', '200', 'Centro', 58291734, 'Apartamento 502', 2),
(21, 'Rua das Margaridas', '1234', 'Jardim das Flores', 74921683, 'Casa 20', 1),
(22, 'Rua das Violetas', '555', 'Vila das Flores', 13579246, 'Casa 01', 3),
(23, 'Avenida do Sol', '1000', 'Sol Nascente', 24681357, 'Apartamento 301', 2),
(24, 'Rua do Mar', '789', 'Praia Azul', 98765432, 'Casa 10', 1),
(25, 'Rua dos Lírios', '888', 'Lirium', 36925814, 'Casa 05', 3),
(26, 'Avenida dos Ipês', '200', 'Jardim das Flores', 58291734, 'Apartamento 502', 2),
(27, 'Rua das Rosas', '1234', 'Jardim das Rosas', 74921683, 'Casa 20', 1),
(28, 'Rua das Acácias', '555', 'Vila Acácia', 13579246, 'Casa 01', 3),
(29, 'Avenida dos Girassóis', '1000', 'Girasolândia', 24681357, 'Apartamento 301', 2),
(30, 'Rua das Flores', '500', 'Vila Bela', 12345678, 'Casa 05', 1), 
(31, 'Avenida Brasil', '1500', 'Centro', 87654321, 'Apartamento 301', 2), 
(32, 'Rua dos Passarinhos', '789', 'Jardim das Aves', 13579246, 'Sala 03', 3)
;
