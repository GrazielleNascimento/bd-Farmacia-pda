
USE triagem_hospitalar;

-- Selecionando os estados e siglas
SELECT nome, sigla FROM estado;



-- Selecionando pessoas que moram numa cidade específica
SELECT pessoa.nome, pessoa.sobrenome 
FROM pessoa 
INNER JOIN pessoa_endereco ON pessoa.id = pessoa_endereco.id_pessoa 
INNER JOIN cidade ON pessoa_endereco.id_cidade = cidade.id 
WHERE cidade.nome = 'São Paulo';



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
