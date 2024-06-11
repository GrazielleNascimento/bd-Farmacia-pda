USE projeto_final;


-- Inserir dados em estado
INSERT INTO `estado` (`nome`, `sigla`) VALUES 
('Acre', 'AC'), -- 1
('Alagoas', 'AL'), -- 2
('Amapá', 'AP'), -- 3
('Amazonas', 'AM'), -- 4
('Bahia', 'BA'), -- 5
('Ceará', 'CE'), -- 6
('Distrito Federal', 'DF'), -- 7
('Espírito Santo', 'ES'), -- 8
('Goiás', 'GO'), -- 9
('Maranhão', 'MA'), -- 10
('Mato Grosso', 'MT'), -- 11
('Mato Grosso do Sul', 'MS'), -- 12
('Minas Gerais', 'MG'), -- 13
('Pará', 'PA'), -- 14
('Paraíba', 'PB'), -- 15
('Paraná', 'PR'), -- 16
('Pernambuco', 'PE'), -- 17
('Piauí', 'PI'), -- 18
('Rio de Janeiro', 'RJ'), -- 19
('Rio Grande do Norte', 'RN'), -- 20
('Rio Grande do Sul', 'RS'), -- 21
('Rondônia', 'RO'), -- 22
('Roraima', 'RR'), -- 23
('Santa Catarina', 'SC'), -- 24
('São Paulo', 'SP'), -- 25
('Sergipe', 'SE'), -- 26
('Tocantins', 'TO'); -- 27

-- Inserir dados em cidade
INSERT INTO `cidade` (`nome`, `id_estado`) VALUES 
('São Paulo', 25), 
('Rio de Janeiro', 19), 
('Belo Horizonte', 13), 
('Salvador', 5),
('Brasília', 7),
('Assis', 25 ),
('Alto Alegre', 25)
;

-- Inserir dados em pessoa
INSERT INTO `pessoa` (`nome`, `sobrenome`, `data_de_nascimento`, `genero`, `tel_contato`, `email`) VALUES 
('João', 'Silva', '1990-05-15', 'M', '11223344', 'joao.silva@example.com'), 
('Maria', 'Santos', '1985-09-20', 'F', '99887766', 'maria.santos@example.com'), 
('Pedro', 'Ferreira', '1978-03-10', 'M', '99887766', 'pedro.ferreira@example.com'),
('Jorge', 'Aragão', '1985-09-25', 'M', '11235685', 'jorge.aragao@gmail.com'),
('Marta', 'Aparecida de Souza', '1977-07-14', 'F', '115585685', 'marta.aparecida@gmail.com'),
('Lúcia', 'Santos Silva', '1984-01-26', 'F', '1156235685', 'lucia.santossilva@gmail.com'),
('Carlos Henrique', 'Santana', '1983-02-02', 'M', '11444135685', 'carlos.santana@gmail.com'),
('Julio', 'Oliveira', '1977-04-26', 'M', '111235685', 'julio.oliveira@gmail.com'),
('Carmen', 'Almeida', '1965-03-18', 'F', '11535685', 'carmen.almeida@gmail.com')
;

-- Inserir dados em documento
INSERT INTO `documento` (`nome`, `sigla`, `numero`, `id_uf`, `data_emissao`) VALUES 
('CRM', 'CRM', 123456, 1, '2020-01-01'), 
('COREN', 'COREN', 654321, 2, '2019-05-10'), 
('Registro Geral', 'RG', 96524, 4, '1999-04-19'),
('Carteira Nacional de Habilitação', 'CNH', 9822335, 3, '2010-08-20'),
('Registro Geral', 'RG', 78514, 7, '1985-03-20'),
('Cadastro Pessoa Física', 'CPF', 9874424, 5, '1984-03-15'),
('CRM', 'CRM', 177746, 1, '2020-01-01'), 
('Cadastro Pessoa Física', 'CPF', 98755254, 6, '1985-07-16'),
('Cadastro Pessoa Física', 'CPF', 982364, 7, '1991-04-15'),
('RQE', 'RQE', 5628, 6, '2023-05-02'),
('RQE', 'RQE', 5623, 6, '2023-04-29')
;

-- Inserir dados em pessoa_endereco
INSERT INTO `pessoa_endereco` (`id_pessoa`, `logradouro`, `numero`, `bairro`, `cep`, `complemento`, `id_cidade`) VALUES 
(1, 'Rua do Limoeiro', '123', 'Centro', 12345678, 'Apto 101', 1), 
(2, 'Rua do Abacaxi', '456', 'Jardim Floresta', 87654321, 'Casa 02', 2), 
(3, 'Rua da Feira', '789', 'Presidencial', 13579246, 'Sala 03', 3),
(4, 'Rua das Flores', '100', 'Centro', 12345678, 'Apto 101', 1),
(5, 'Avenida Paulista', '2000', 'Bela Vista', 98765432, 'Bloco B', 1),
(6, 'Rua dos Alfeneiros', '4', 'Privet Drive', 54321678, 'Casa', 2)
;

-- Inserir dados em pessoa_documentos
INSERT INTO `pessoa_documentos` (`id_pessoa`, `id_doc`) VALUES 
(1, 7), 
(2, 8), 
(3, 26),
(4, 9),
(5, 11),
(6, 12),
(7, 27),
(8, 28),
(9, 10)
;

-- Inserir dados em pessoa_contato_emergencial
INSERT INTO `pessoa_contato_emergencial` (`id_pessoa`, `id_pessoa_contato`) VALUES 
(1, 2), 
(2, 3), 
(3, 1),
(4, 7),
(5, 8),
(6, 9)
;

-- Inserir dados em profissional_especialidade
INSERT INTO `profissional_especialidade` (`nome`) VALUES 
('Cardiologia'), 
('Enfermeiro'), 
('Cirurgia');

-- Inserir dados em profissional
INSERT INTO `profissional` (`id_pessoa`, `categoria`, `id_profissional_especialidade`, `id_crm_doc`, `id_coren_doc`) VALUES 
(1, 'Médico', 1, 7, NULL), 
(2, 'Enfermeiro', 2, NULL, 8), 
(3, 'Cirurgião', 3, 9, NULL);

-- Atualizar a tabela profissional_especialidade
UPDATE `profissional_especialidade` SET `id_profissional` = 1, `id_rqe_doc` = 3 WHERE `id` = 1;

-- Inserir dados em paciente
INSERT INTO `paciente` (`id_pessoa`, `id_profissional_responsável`, `diagnóstico`, `medicamentos_usados`, `horario_entrada`, `horario_saida`) VALUES 
(4, 13, 'Hipertensão', 'Atenolol', '2024-06-01 10:00:00', '2024-06-02 10:00:00'), 
(5, 14, 'Diabetes', 'Metformina', '2024-06-02 11:00:00', '2024-06-03 11:00:00'), 
(6, 15, 'Pneumonia', 'Azitromicina', '2024-06-03 12:00:00', '2024-06-04 12:00:00');

-- Inserir dados em paciente_leito
INSERT INTO `paciente_leito` (`id_paciente`, `numero_do_quarto`, `andar`, `disponibilidade`) VALUES 
(25, 101, 1, FALSE), 
(26, 102, 1, FALSE), 
(27, 103, 2, FALSE);

-- Inserir dados em paciente_dados_vitais
INSERT INTO `paciente_dados_vitais` (`id_paciente`, `id_responsavel_coleta`, `data_e_horario`, `temperatura`, `frequencia_cardiaca`, `frequencia_respiratoria`, `pressao_arterial`, `glicemia`) VALUES 
(25, 14, '2024-06-01 11:00:00', 36.5, 80, 20, '120/80', 90), 
(26, 14, '2024-06-02 12:00:00', 37.0, 85, 22, '130/85', 95), 
(27, 14, '2024-06-03 13:00:00', 38.0, 90, 24, '140/90', 100);

-- Inserir dados em acompanhante
INSERT INTO `acompanhante` (`id_pessoa`, `id_paciente`, `parentesco`) VALUES 
(7, 25, 'Esposo'), 
(8, 26, 'Marido'), 
(9, 27, 'Tia');

-- Inserir dados em medicamento
INSERT INTO `medicamento` (`nome`, `dosagem`) VALUES 
('Atenolol', '50mg'), 
('Metformina', '500mg'), 
('Azitromicina', '500mg');

-- Inserir dados em paciente_medicacao
INSERT INTO `paciente_medicacao` (`id_paciente`, `id_medicamento`, `frequencia`, `data_inicio`, `data_fim`, `horario_administracao`, `id_responsavel_administracao`, `observacoes`, `data_registro`) VALUES 
(25, 1, 'Diário', '2024-06-01', '2024-06-07', '08:00:00', 14, 'Tomar em jejum', '2024-06-01 09:00:00'), 
(26, 2, 'Diário', '2024-06-02', '2024-06-08', '09:00:00', 14, 'Tomar após o café', '2024-06-02 10:00:00'), 
(27, 3, 'Diário', '2024-06-03', '2024-06-09', '10:00:00', 14, 'Tomar com água', '2024-06-03 11:00:00');
