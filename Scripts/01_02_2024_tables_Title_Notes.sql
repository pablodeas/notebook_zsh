#!/bin/sqlite3

create table Title (
	Id integer primary key autoincrement,
	Nome text not null
);

create table Notes (
	Id integer primary key autoincrement,
	TitleId int not null,
	Nome text not null,
	foreign key(TitleId) references title(Id)
);

--insert into Title (Nome)
--values ('Teste');

--insert into Notes (TitleId, Nome)
--values (1, 'Teste Nota');

--select 
--	a.Nome as Título, 
--	b.Nome as Corpo
--from Title a
--join Notes b on a.Id = b.TitleId;

--delete from Notes
--where (select Id from Title where Nome = '$title_delete')
