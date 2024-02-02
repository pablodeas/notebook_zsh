#!/bin/zsh

# An Notebook

# Script Name:  notebook.zsh
# Author:       Pablo Andrade
# Created:      01/02/2024
# Version:      0.1

# Util variables
data=$(date +%d-%m-%y)

func logo () {
	echo "--------------------"
	echo "----- NOTEBOOK -----"
	echo "--------------------"
}

func menu () {
	clear
	logo
	echo ""
	echo "##### - MENU PRINCIPAL - #####"
	echo ""
	echo "-> Opções:"
	echo ""
	echo "1. Adicionar uma nova nota."
	echo "2. Verificar todas as notas."
	echo "3. Editar uma nota existente."
	echo "4. Excluir uma nota existente."
	echo "0. Sair."
	echo ""
	echo "-> Digite a opção desejada."
	read option
}

func new_note () {
	clear
	logo
	echo ""
	echo "-> Digite o Título da Nota."
	read title
	
	echo ""
	echo "-> Digite o Corpo da Nota."
	read note_body

	note_title=$title" - "$data

	echo ""
	sqlite3 notes.db "
	insert into Title (Nome)
	values ('$note_title');

	insert into Notes (TitleId, Nome)
	select Id, '$note_body' from Title where Nome = '$note_title';
	"

	menu
	option_case
}

func all_notes () {
	clear
	logo
	echo ""

	echo "-> Todas as notas disponíveis."
	echo "-> Título | Corpo da Nota"

	echo ""
	sqlite3 notes.db "
	select 
		a.Nome as Título, 
		b.Nome as Corpo
	from Title a
	join Notes b on a.Id = b.TitleId;
	"

	sleep 5

	echo ""
	echo "-> Deseja voltar ao MENU PRINCIPAL ?"
	echo "---"
	echo "-> Digite 1 para ir."
	echo "-> Digite 0 para fechar o programa."
	read all_notes_var01

	case $all_notes_var01 in
		1)
			menu
			option_case
			;;
		0)
			clear
			exit
			;;
		*)
			echo ""
			echo "-> Opção errada, tente novamente."
			;;
	esac
	
	echo ""
	menu
	option_case
}

func edit_note () {
	clear
	logo
	echo ""

	echo "-> Todas as notas disponíveis para edição."
	echo "-> Título | Corpo da Nota"

	echo ""
	sqlite3 notes.db "
	select 
		a.Nome as Título, 
		b.Nome as Corpo
	from Title a
	join Notes b on a.Id = b.TitleId;
	"
	sleep 3

	echo ""
	echo "-> Digite o Título da Nota que deseje alterar."
	read title_change

	# Verifique se o título da nota existe na tabela Title
	exists=$(sqlite3 notes.db "
	select exists(select 1 from Title where Nome = '$title_change');
	")

	if [[ $exists == 0 ]]; then
		echo ""
		echo "-> Você digitou o Título errado, tente novamente."
		sleep 5
		edit_note
	fi

	echo ""
	echo "-> Digite o novo Corpo da nota desejada."
	read new_body

	echo ""
	sqlite3 notes.db "
	update Notes set Nome = '$new_body'
	where TitleId = (select Id from Title where Nome = '$title_change');
	"
	echo ""
	menu
	option_case
}

func delete_note () {
	clear
	logo
	echo ""

	echo "-> Todas as notas disponíveis para deleção."
	echo "-> Título | Corpo da Nota"

	echo ""
	sqlite3 notes.db "
	select 
		a.Nome as Título, 
		b.Nome as Corpo
	from Title a
	join Notes b on a.Id = b.TitleId;
	"
	sleep 3

	echo ""
	echo "-> Digite o Título da Nota que deseje APAGAR."
	read title_delete

	# Verifique se o título da nota existe na tabela Title
	exists=$(sqlite3 notes.db "
	select exists(select 1 from Title where Nome = '$title_delete');
	")

	if [[ $exists == 0 ]]; then
		echo ""
		echo "-> Você digitou o Título errado, tente novamente."
		sleep 5
		edit_note
	fi

	echo ""
	echo "-> Deseja realmente APAGAR a nota?"
	echo "-> Caso SIM, digite 1 --- Caso NÃO, digite 0"
	read delete_var01

	case $delete_var01 in
		1)
			sqlite3 notes.db "
			delete from Notes where TitleId = (select Id from Title where Nome = '$title_delete');
			delete from Title where Nome = '$title_delete';
			"
			;;
		0)
			clear
			logo
			menu
			option_case
			;;
		*)
			echo ""
			echo "-> Opção errada, tente novamente."
			;;
	esac
	
	echo ""
	menu
	option_case
}

func option_case () {
	case $option in
		1)
			new_note
			;;
		2)
			all_notes
			;;
		3)
			edit_note
			;;
		4)
			delete_note
			;;
		0)
			echo ""
			echo "-> Saindo..."
			exit
			;;
		*)
			echo ""
			echo "-> Opção inválida, tente novamente."
			menu
			option_case
			;;
	esac
}

# Executions
menu
option_case