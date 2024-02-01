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
