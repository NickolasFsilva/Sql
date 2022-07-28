create database exemplojoin;

use exemplojoin;

create table tab_funcionarios(
	nome varchar(50) not null,
	codiog int not null,
);

create table tab_profissoes(
	nome varchar(50) not null,
	codigo int not null
);

insert into tab_funcionarios(nome, codigo)
values
('João',1), ('Maria',2),
('Katia',3), ('Maria',4);

alter table tab_funcionarios drop column codiog;

alter table tab_funcionarios add codigo int not null;

select * from tab_funcionarios

insert into tab_profissoes(nome, codigo)
values
('Programador',1), ('Designer',2),
('Analista',3), ('DBA',5);
-----------------------------------------------------------------------------
-- Inner join
-- Retorna dados apenas quando as dias tabelas tem 
-- chaves correspondentes na clasula ON do join

select tab_funcionarios.*,
       tab_profissoes.*
from tab_funcionarios
inner join tab_profissoes
on tab_funcionarios.codigo = tab_profissoes.codigo;

-----------------------------------------------------------------------------

-- LEFT JOIN
-- Retorna a tabelaA inteira e apenas os registros
-- que coincidirem com a igualdade do join na tabelaB
-- (ou campos nulos para os campos sem correspondencia)

select tab_funcionarios.*,
       tab_profissoes.*
from tab_funcionarios
left join tab_profissoes
on tab_funcionarios.codigo = tab_profissoes.codigo;

-----------------------------------------------------------------------------

-- Right join
-- Segue o mesmo raciocinio do left join,  mas se
-- aplicando a tabelaB em vez da TabelaA.

select tab_funcionarios.*,
       tab_profissoes.*
from tab_funcionarios
right join tab_profissoes
on tab_funcionarios.codigo = tab_profissoes.codigo;

-----------------------------------------------------------------------------

-- FULL OUTER JOIN (SQL Server)
-- Retorna todos os registros de ambas as tabelas.

select tab_funcionarios.*,
       tab_profissoes.*
from tab_funcionarios
full outer join tab_profissoes
on tab_funcionarios.codigo = tab_profissoes.codigo;

-----------------------------------------------------------------------------

-- CROSS JOIN 
-- Basicamente é o produto de cartesiano entre  as duas tabelas
-- Para cada linha de TabelaA, são  retornadas todas as
-- linhas da tabela 

select tab_funcionarios.*, tab_profissoes.*
from tab_funcionarios
cross join tab_profissoes;







-----------------------------------------------------------------------------

-- Criando Views
-- Composta por linhas e colunas de dados vindos de
-- tabelas relaciondas em uma query (um agrupamento
-- de select's, por exemplo). As linhas e colunas da
-- são geradas dinamicamente no momento em que
-- é feita uma referencia a ela.
-- As views ficam armazenadas em:

-- Seu Banco de Dados
-- Exibições

use escola;

-- Criando uma view pra mostrar o id, nome,
-- email e fone dos alunos

-- Nota: Colocar vw é uma boa pratica para saber que aquilo é uma view

create view vwAlunos
as
select id_aluno as 'Codigo',
		nome as Nome,
		email as [E-mail],
		fone as Celular
From tab_alunos;

-----------------------------------------------------------------------------

-- Executando a view

select* from vwAlunos;

select nome, celular from vwAlunos;

-- Removendo uma viwe

DROP VIEW vwAlunos;

-- Alterando uma view

ALTER VIEW vwAlunos
as
select id_aluno as 'Codigo',
	nome as Nome,
	email as [E-mail],
	fone as celular
From tab_alunos
where email like '%gmail.com';

-----------------------------------------------------------------------------

-- Criando uma view para mostrar o nome da turma,
-- do aluno, número da sala e nome do professor.
-- O nome da view sera vwTurmas

create view vwTurmas
as
select tab_turmas.nome as 'Turma',
		tab_alunos.nome as 'Alunos',
		tab_salas.numero as 'Sala',
		tab_professores.nome as 'Professor'
from tab_turmas
inner join tab_alunos
on tab_turmas.id_aluno = tab_alunos.id_aluno
inner join tab_salas
on tab_salas.id_sala = tab_turmas.id_sala
inner join tab_professores
on tab_professores.id_professor = tab_turmas.id_professor;

-----------------------------------------------------------------------------	   


drop view vwnomes

alter view 

-----------------------------------------------------------------------------	

-- Executando a view

select * from vwTurmas;

-- View especifica

select * from vwTurmas
where Sala = 2;

select Turma, Professor from vwTurmas;

-----------------------------------------------------------------------------

-- Exercicio 
-- Criar uma view para mostrar o nome do professor 
-- e os alunos de cada turma

create view vwNomesPA
as
select tab_professores.nome as 'Professores' , tab_alunos.nome as 'Alunos' , tab_turmas.id_turma as 'Turmas'
from tab_alunos
inner join tab_turmas
on tab_alunos.id_aluno = tab_turmas.id_aluno
inner join tab_professores
on tab_professores.id_professor = tab_turmas.id_professor
where tab_turmas.nome = 'SQL';

select * from vwNomesPA
drop view vwNomesPA

-----------------------------------------------------------------------------

-- Criar uma view para mostrar o nome do professor Fabio
-- e sua turma

create view  vwMostrarTurmaFabio as
select tab_alunos.nome as Aluno,
       tab_professores.nome as Professor,
	   tab_turmas.nome as Turmas
From tab_turmas
inner join tab_alunos
on tab_turmas.id_aluno = tab_alunos.id_aluno
inner join tab_professores
on tab_turmas.id_professor = tab_professores.id_professor
where tab_professores.nome = 'Fabio'

-----------------------------------------------------------------------------

-- Criando Store Procedure
-- Stored Procedure, que traduzido significa Procedimento
-- Armazenado, é um conjunto de comandos em SQL que podem
-- ser executados de uma so vez,  como em uma função
-- Ele armazena tarefas repetitivas e aceita parametros
-- de entradda para que a tarefa seja efetuada de acordo
-- com a necessidade individual.

-- As Stored Procedure ficam armazenadas em:

-- Seu Banco de Dados
-- Programação
-- Procedimentos armazenados

-- Criando uma Stored Procedure para buscar um email de um aluno
-- Declarando a producere

create procedure spBuscaEmailAluno

-- Declarando uma variavel - use o @ antes do nome da variavel

@busca varchar(50)
as

-- Consulta

select* from tab_alunos

-- Reutilizando a variavel como filtro da esquisa

where email like @busca;

-----------------------------------------------------------------------------

-- Executando a SP

execute spBuscaEmailAluno 'fatima@gmail.com';
execute spBuscaEmailAluno '%@gmail.com';

-- Excluindo uma SP

DROP PROCEDURE spBuscaEmailAluno;

-- Criando uma SP para mostrar fone e email de todos os alunos

create procedure spMostraFoneEmailAlunos
as
select fone, email from tab_alunos;

execute spMostraFoneEmailAlunos;

-----------------------------------------------------------------------------FIM
