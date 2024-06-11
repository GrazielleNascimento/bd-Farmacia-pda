USE projeto_final;

-- Inserir dados em estado
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
('Salvador', 5);

-- Inserir dados em pessoa
INSERT INTO `pessoa` (`nome`, `sobrenome`, `data_de_nascimento`, `genero`, `tel_contato`, `email`) VALUES 
('João', 'Silva', '1990-05-15', 'M', '11223344', 'joao.silva@example.com'), 
('Maria', 'Santos', '1985-09-20', 'F', '99887766', 'maria.santos@example.com'), 
('Pedro', 'Ferreira', '1978-03-10', 'M', '99887766', 'pedro.ferreira@example.com');

-- Inserir dados em documento
INSERT INTO `documento` (`nome`, `sigla`, `numero`, `id_uf`, `data_emissao`) VALUES 
('CRM', 'CRM', 123456, 1, '2020-01-01'), 
('COREN', 'COREN', 654321, 2, '2019-05-10'), 
('RQE', 'RQE', 987654, 3, '2018-03-20');

-- Inserir dados em pessoa_endereco
INSERT INTO `pessoa_endereco` (`id_pessoa`, `logradouro`, `numero`, `bairro`, `cep`, `complemento`, `id_cidade`) VALUES 
(1, 'Rua A', '123', 'Centro', 12345678, 'Apto 101', 1), 
(2, 'Rua B', '456', 'Bairro X', 87654321, 'Casa 02', 2), 
(3, 'Rua C', '789', 'Bairro Y', 13579246, 'Sala 03', 3);

-- Inserir dados em pessoa_documentos
INSERT INTO `pessoa_documentos` (`id_pessoa`, `id_doc`) VALUES 
(1, 1), 
(2, 2), 
(3, 3);

-- Inserir dados em pessoa_contato_emergencial
INSERT INTO `pessoa_contato_emergencial` (`id_pessoa`, `id_pessoa_contato`) VALUES 
(1, 2), 
(2, 3), 
(3, 1);

-- Inserir dados em profissional_especialidade
INSERT INTO `profissional_especialidade` (`nome`) VALUES 
('Cardiologia'), 
('Pediatria'), 
('Cirurgia');

-- Inserir dados em profissional
INSERT INTO `profissional` (`id_pessoa`, `categoria`, `id_profissional_especialidade`, `id_crm_doc`, `id_coren_doc`) VALUES 
(1, 'Médico', 1, 1, NULL), 
(2, 'Enfermeiro', 2, NULL, 2), 
(3, 'Cirurgião', 3, 1, NULL);

-- Atualizar a tabela profissional_especialidade
UPDATE `profissional_especialidade` SET `id_profissional` = 1, `id_rqe_doc` = 3 WHERE `id` = 1;

-- Inserir dados em paciente
INSERT INTO `paciente` (`id_pessoa`, `id_profissional_responsável`, `diagnóstico`, `medicamentos_usados`, `horario_entrada`, `horario_saida`) VALUES 
(1, 1, 'Hipertensão', 'Atenolol', '2024-06-01 10:00:00', '2024-06-02 10:00:00'), 
(2, 2, 'Diabetes', 'Metformina', '2024-06-02 11:00:00', '2024-06-03 11:00:00'), 
(3, 3, 'Pneumonia', 'Azitromicina', '2024-06-03 12:00:00', '2024-06-04 12:00:00');

-- Inserir dados em paciente_leito
INSERT INTO `paciente_leito` (`id_paciente`, `numero_do_quarto`, `andar`, `disponibilidade`) VALUES 
(1, 101, 1, FALSE), 
(2, 102, 1, FALSE), 
(3, 103, 2, FALSE);

-- Inserir dados em paciente_dados_vitais
INSERT INTO `paciente_dados_vitais` (`id_paciente`, `id_responsavel_coleta`, `data_e_horario`, `temperatura`, `frequencia_cardiaca`, `frequencia_respiratoria`, `pressao_arterial`, `glicemia`) VALUES 
(1, 2, '2024-06-01 11:00:00', 36.5, 80, 20, '120/80', 90), 
(2, 3, '2024-06-02 12:00:00', 37.0, 85, 22, '130/85', 95), 
(3, 1, '2024-06-03 13:00:00', 38.0, 90, 24, '140/90', 100);

-- Inserir dados em acompanhante
INSERT INTO `acompanhante` (`id_pessoa`, `id_paciente`, `parentesco`) VALUES 
(2, 1, 'Esposa'), 
(3, 2, 'Marido'), 
(1, 3, 'Filho');

-- Inserir dados em medicamento
INSERT INTO `medicamento` (`nome`, `dosagem`) VALUES 
('Atenolol', '50mg'), 
('Metformina', '500mg'), 
('Azitromicina', '500mg');

-- Inserir dados em paciente_medicacao
INSERT INTO `paciente_medicacao` (`id_paciente`, `id_medicamento`, `frequencia`, `data_inicio`, `data_fim`, `horario_administracao`, `id_responsavel_administracao`, `observacoes`, `data_registro`) VALUES 
(1, 1, 'Diário', '2024-06-01', '2024-06-07', '08:00:00', 1, 'Tomar em jejum', '2024-06-01 09:00:00'), 
(2, 2, 'Diário', '2024-06-02', '2024-06-08', '09:00:00', 2, 'Tomar após o café', '2024-06-02 10:00:00'), 
(3, 3, 'Diário', '2024-06-03', '2024-06-09', '10:00:00', 3, 'Tomar com água', '2024-06-03 11:00:00');
