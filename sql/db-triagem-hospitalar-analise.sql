
USE triagem_hospitalar;

-- Selecionando os estados e siglas
SELECT nome, sigla FROM estado;



-- Selecionando pessoas que moram numa cidade específica
SELECT pessoa.nome, pessoa.sobrenome 
FROM pessoa 
INNER JOIN pessoa_endereco ON pessoa.id = pessoa_endereco.id_pessoa 
INNER JOIN cidade ON pessoa_endereco.id_cidade = cidade.id 
WHERE cidade.nome = 'São Paulo';



-- Consultando profissionais e suas especialidades
SELECT pessoa.nome, pessoa.sobrenome, profissional_especialidade.nome AS especialidade 
FROM profissional 
INNER JOIN pessoa ON profissional.id_pessoa = pessoa.id 
INNER JOIN profissional_especialidade ON profissional.id_profissional_especialidade = profissional_especialidade.id;



-- Consultando pacientes e suas doenças
SELECT pessoa.nome, pessoa.sobrenome, paciente.diagnóstico 
FROM paciente 
INNER JOIN pessoa ON paciente.id_pessoa = pessoa.id;



-- Consultando todos os leitos ocupados por pacientes
SELECT paciente_leito.numero_do_quarto, paciente_leito.andar, paciente_leito.disponibilidade 
FROM paciente_leito 
WHERE paciente_leito.disponibilidade = FALSE;



-- Consultando dados vitais de um pacientes
SELECT paciente_dados_vitais.temperatura, paciente_dados_vitais.frequencia_cardiaca, paciente_dados_vitais.frequencia_respiratoria, paciente_dados_vitais.pressao_arterial 
FROM paciente_dados_vitais 
WHERE paciente_dados_vitais.id_paciente = 3;



-- Consultando o endereço de uma pessoa específica
SELECT pessoa_endereco.logradouro, pessoa_endereco.numero, pessoa_endereco.bairro, pessoa_endereco.cep, cidade.nome AS cidade, estado.nome AS estado 
FROM pessoa_endereco 
INNER JOIN pessoa ON pessoa_endereco.id_pessoa = pessoa.id 
INNER JOIN cidade ON pessoa_endereco.id_cidade = cidade.id 
INNER JOIN estado ON cidade.id_estado = estado.id 
WHERE pessoa.nome = 'João' AND pessoa.sobrenome = 'Silva';



-- Consultando todos os documentos emitidos em uma data especifica
SELECT documento.nome, documento.numero 
FROM documento 
WHERE documento.data_emissao = '2020-01-01';



-- Consultando pessoas com um gênero específico
SELECT pessoa.nome, pessoa.sobrenome 
FROM pessoa 
WHERE pessoa.genero = 'F';



-- Consultando médicos com CRM registrado
SELECT pessoa.nome, pessoa.sobrenome, documento.numero AS CRM 
FROM profissional 
INNER JOIN pessoa ON profissional.id_pessoa = pessoa.id 
INNER JOIN documento ON profissional.id_crm_doc = documento.id 
WHERE profissional.categoria = 'Médico';



-- Consultando pacientes que utilizam um medicamento específico
SELECT pessoa.nome, pessoa.sobrenome 
FROM paciente 
INNER JOIN pessoa ON paciente.id_pessoa = pessoa.id 
WHERE paciente.medicamentos_usados LIKE '%Atenolol%';



-- Consulta pacientes que estão com uma temperatura maior que 37
SELECT * FROM paciente_dados_vitais WHERE temperatura > 37.0;



-- Consultando pacientes que usam determinado medicamento administrado por um responsavel especifico
SELECT * FROM paciente_medicacao WHERE id_medicamento = 1 AND id_responsavel_administracao = 4;



-- Consultando pacientes que possuem diagnostico começando com uma letra específica
SELECT * FROM paciente WHERE diagnóstico LIKE 'D%';



-- Consultando pessoas que moram em uma determinada cidade
SELECT * FROM pessoa INNER JOIN pessoa_endereco ON pessoa.id = pessoa_endereco.id_pessoa WHERE pessoa_endereco.id_cidade = 1;



-- Consultando pacientes diagnosticados com determinada doença
SELECT * FROM paciente WHERE diagnóstico = 'Diabetes';



-- Consultando nome, sobrenome, documentos de todos os pacientes
SELECT pessoa.nome, pessoa.sobrenome, documento.sigla, documento.numero
FROM paciente
JOIN pessoa ON paciente.id_pessoa = pessoa.id
JOIN pessoa_documentos ON pessoa.id = pessoa_documentos.id_pessoa
JOIN documento ON pessoa_documentos.id_doc = documento.id;



-- Consultando os pacientes que foram atendidos por um enfermeiro
SELECT * FROM paciente WHERE id_profissional_responsável IN (SELECT id_pessoa FROM profissional WHERE categoria = 'Enfermeiro');


-- Consultando pacientes que foram atendidos em um quarto do segundo andar
SELECT paciente.*
FROM paciente
JOIN paciente_leito ON paciente.id = paciente_leito.id_paciente
WHERE paciente_leito.andar = 2;

-- Fazendo uma junção entre pessoa_endereco e cidade, renomeando as tabelas:
SELECT pessoa_endereco_002.*, cidade_003.nome AS nome_cidade
FROM pessoa_endereco AS pessoa_endereco_002
JOIN cidade AS cidade_003 ON pessoa_endereco_002.id_cidade = cidade_003.id;


-- Fazendo uma junção entre paciente, pessoa, profissional, e documento, renomeando as tabelas:
SELECT paciente_004.*, pessoa_005.nome AS nome_paciente, profissional_006.categoria AS categoria_profissional, documento_007.numero AS numero_documento
FROM paciente AS paciente_004
JOIN pessoa AS pessoa_005 ON paciente_004.id_pessoa = pessoa_005.id
JOIN profissional AS profissional_006 ON paciente_004.id_profissional_responsável = profissional_006.id
JOIN documento AS documento_007 ON profissional_006.id_crm_doc = documento_007.id;

-- Selecionando os profissionais de uma determinada especialidade, renomeando as tabelas:
SELECT profissional_008.*
FROM profissional AS profissional_008
WHERE profissional_008.id_profissional_especialidade = (SELECT id FROM profissional_especialidade AS profissional_especialidade_009 WHERE profissional_especialidade_009.nome = 'Cardiologia');

-- Contando o número de pacientes por cidade, renomeando as tabelas:
SELECT cidade_010.nome AS nome_cidade, COUNT(paciente_011.id) AS total_pacientes
FROM paciente AS paciente_011
JOIN pessoa_endereco AS pessoa_endereco_012 ON paciente_011.id_pessoa = pessoa_endereco_012.id_pessoa
JOIN cidade AS cidade_010 ON pessoa_endereco_012.id_cidade = cidade_010.id
GROUP BY cidade_010.nome;


-- Contando o número de leitos disponíveis por andar e obtendo informações detalhadas dos pacientes, renomeando as tabelas:
SELECT paciente_leito_019.andar, COUNT(paciente_leito_019.id) AS leitos_disponiveis, paciente_020.*, pessoa_021.nome AS nome_paciente
FROM paciente_leito AS paciente_leito_019
JOIN paciente AS paciente_020 ON paciente_leito_019.id_paciente = paciente_020.id
JOIN pessoa AS pessoa_021 ON paciente_020.id_pessoa = pessoa_021.id
WHERE paciente_leito_019.disponibilidade = true
GROUP BY paciente_leito_019.andar, paciente_020.id, pessoa_021.nome;

SELECT 'Profissional' AS tipo, pessoa_003.nome, pessoa_003.sobrenome, profissional_004.categoria
FROM profissional AS profissional_004
JOIN pessoa AS pessoa_003 ON profissional_004.id_pessoa = pessoa_003.id
UNION ALL
SELECT 'Paciente' AS tipo, pessoa_005.nome, pessoa_005.sobrenome, paciente_006.diagnóstico
FROM paciente AS paciente_006
JOIN pessoa AS pessoa_005 ON paciente_006.id_pessoa = pessoa_005.id;

-- Selecionando dados vitais coletados em um determinado período, renomeando as tabelas:

SELECT paciente_dados_vitais_007.*, paciente_008.id AS id_paciente, pessoa_009.nome AS nome_paciente
FROM paciente_dados_vitais AS paciente_dados_vitais_007
JOIN paciente AS paciente_008 ON paciente_dados_vitais_007.id_paciente = paciente_008.id
JOIN pessoa AS pessoa_009 ON paciente_008.id_pessoa = pessoa_009.id
WHERE paciente_dados_vitais_007.data_e_horario BETWEEN '2024-01-01' AND '2024-12-31';

-- Selecionando a média de temperatura dos pacientes por profissional responsável, renomeando as tabelas
SELECT profissional_019.id AS id_profissional, pessoa_020.nome AS nome_profissional, AVG(paciente_dados_vitais_021.temperatura) AS media_temperatura
FROM paciente_dados_vitais AS paciente_dados_vitais_021
JOIN profissional AS profissional_019 ON paciente_dados_vitais_021.id_responsavel_coleta = profissional_019.id
JOIN pessoa AS pessoa_020 ON profissional_019.id_pessoa = pessoa_020.id;

-- Selecionando informações sobre acompanhantes de cada paciente, renomeando as tabelas:
SELECT paciente_022.id AS id_paciente, pessoa_paciente_023.nome AS nome_paciente, pessoa_acompanhante_024.nome AS nome_acompanhante, acompanhante_025.parentesco
FROM acompanhante AS acompanhante_025
JOIN paciente AS paciente_022 ON acompanhante_025.id_paciente = paciente_022.id
JOIN pessoa AS pessoa_paciente_023 ON paciente_022.id_pessoa = pessoa_paciente_023.id
JOIN pessoa AS pessoa_acompanhante_024 ON acompanhante_025.id_pessoa = pessoa_acompanhante_024.id;

-- Selecionando a média de idade dos pacientes por gênero
SELECT genero, AVG(YEAR(CURRENT_DATE()) - YEAR(data_de_nascimento)) AS media_idade
FROM pessoa
GROUP BY genero;




-- Selecionando a contagem de pacientes por faixa etária:

SELECT 
    CASE
        WHEN YEAR(CURRENT_DATE()) - YEAR(data_de_nascimento) BETWEEN 0 AND 10 THEN '0-10 anos'
        WHEN YEAR(CURRENT_DATE()) - YEAR(data_de_nascimento) BETWEEN 11 AND 20 THEN '11-20 anos'
        WHEN YEAR(CURRENT_DATE()) - YEAR(data_de_nascimento) BETWEEN 21 AND 30 THEN '21-30 anos'
        WHEN YEAR(CURRENT_DATE()) - YEAR(data_de_nascimento) BETWEEN 31 AND 40 THEN '31-40 anos'
        WHEN YEAR(CURRENT_DATE()) - YEAR(data_de_nascimento) BETWEEN 41 AND 50 THEN '41-50 anos'
        WHEN YEAR(CURRENT_DATE()) - YEAR(data_de_nascimento) BETWEEN 51 AND 60 THEN '51-60 anos'
        WHEN YEAR(CURRENT_DATE()) - YEAR(data_de_nascimento) BETWEEN 61 AND 70 THEN '61-70 anos'
        WHEN YEAR(CURRENT_DATE()) - YEAR(data_de_nascimento) BETWEEN 71 AND 80 THEN '71-80 anos'
        ELSE 'Mais de 80 anos'
    END AS faixa_etaria,
    COUNT(*) AS numero_de_pacientes
FROM pessoa
JOIN paciente ON pessoa.id = paciente.id_pessoa
GROUP BY faixa_etaria;

SELECT 
    paciente.id AS id_paciente,
    pessoa.nome AS nome_paciente,
    pessoa.sobrenome AS sobrenome_paciente,
    GROUP_CONCAT(acomp.nome ORDER BY acomp.nome SEPARATOR ', ') AS acompanhantes
FROM paciente
JOIN pessoa ON paciente.id_pessoa = pessoa.id
LEFT JOIN acompanhante ON paciente.id = acompanhante.id_paciente
LEFT JOIN pessoa acomp ON acompanhante.id_pessoa = acomp.id
GROUP BY paciente.id;

-- Selecionando pacientes e a cidade em que residem:
SELECT 
    pessoa.nome AS nome_paciente, 
    pessoa.sobrenome AS sobrenome_paciente, 
    cidade.nome AS cidade_residencia
FROM paciente
JOIN pessoa ON paciente.id_pessoa = pessoa.id
JOIN pessoa_endereco ON pessoa.id = pessoa_endereco.id_pessoa
JOIN cidade ON pessoa_endereco.id_cidade = cidade.id;


-- Selecionando pacientes e seus documentos associados:

SELECT 
    paciente.id AS id_paciente,
    pessoa.nome AS nome_paciente,
    documento.nome AS nome_documento,
    documento.sigla AS sigla_documento,
    documento.numero
FROM paciente
JOIN pessoa ON paciente.id_pessoa = pessoa.id
JOIN pessoa_documentos ON pessoa.id = pessoa_documentos.id_pessoa
JOIN documento ON pessoa_documentos.id_doc = documento.id;


-- pacientes do sexo feminino e masculino estão na faixa etária de 41 a 50 anos
SELECT 
    genero,
    COUNT(*) AS total
FROM 
    (SELECT 
        CASE
            WHEN YEAR(CURRENT_DATE()) - YEAR(data_de_nascimento) BETWEEN 41 AND 50 THEN '41-50 anos'
        END AS faixa_etaria,
        genero
    FROM pessoa
    JOIN paciente ON pessoa.id = paciente.id_pessoa) AS faixa_etaria_genero
WHERE 
    faixa_etaria = '41-50 anos'
GROUP BY 
    genero;




-- pacientes do sexo feminino e masculino estão na faixa etária de 31 a 40 anos
SELECT 
    genero,
    COUNT(*) AS total
FROM 
    (SELECT 
        CASE
            WHEN YEAR(CURRENT_DATE()) - YEAR(data_de_nascimento) BETWEEN 31 AND 40 THEN '31-40 anos'
        END AS faixa_etaria,
        genero
    FROM pessoa
    JOIN paciente ON pessoa.id = paciente.id_pessoa) AS faixa_etaria_genero
WHERE 
    faixa_etaria = '31-40 anos'
GROUP BY 
    genero;

