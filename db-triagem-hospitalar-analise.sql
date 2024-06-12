
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


