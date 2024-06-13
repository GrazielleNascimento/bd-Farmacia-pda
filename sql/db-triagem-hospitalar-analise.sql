
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



--Consultando pacientes que possuem diagnostico começando com uma letra específica
SELECT * FROM paciente WHERE diagnóstico LIKE 'D%';



-- Consultando pessoas que moram em uma determinada cidade
SELECT * FROM pessoa INNER JOIN pessoa_endereco ON pessoa.id = pessoa_endereco.id_pessoa WHERE pessoa_endereco.id_cidade = 1;



--Consultando pacientes diagnosticados com determinada doença
SELECT * FROM paciente WHERE diagnóstico = 'Diabetes';



--Consultando nome, sobrenome, documentos de todos os pacientes
SELECT pessoa.nome, pessoa.sobrenome, documento.sigla, documento.numero
FROM paciente
JOIN pessoa ON paciente.id_pessoa = pessoa.id
JOIN pessoa_documentos ON pessoa.id = pessoa_documentos.id_pessoa
JOIN documento ON pessoa_documentos.id_doc = documento.id;



--Consultando os pacientes que foram atendidos por um enfermeiro
SELECT * FROM paciente WHERE id_profissional_responsável IN (SELECT id_pessoa FROM profissional WHERE categoria = 'Enfermeiro');



--Consultando pacientes que foram atendidos em um quarto do segundo andar
SELECT paciente.*
FROM paciente
JOIN paciente_leito ON paciente.id = paciente_leito.id_paciente
WHERE paciente_leito.andar = 2;