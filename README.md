# Notebook.zsh

## Descrição

Notebook.zsh é um simples aplicativo de notas desenvolvido em shell script ZSH. Ele permite aos usuários adicionar, visualizar, editar e excluir notas. As notas são armazenadas em um banco de dados SQLite local chamado `notes.db`.

## Como Usar

1. Execute o script `notebook.zsh` em um terminal.
2. Uma lista de opções será exibida. Escolha uma opção digitando o número correspondente.
3. Siga as instruções na tela para adicionar, visualizar, editar ou excluir notas.

## Comandos Disponíveis

- `1. Adicionar uma nova nota.`: Permite adicionar uma nova nota ao notebook.
- `2. Verificar todas as notas.`: Mostra todas as notas existentes no notebook.
- `3. Editar uma nota existente.`: Permite editar o conteúdo de uma nota existente.
- `4. Excluir uma nota existente.`: Permite excluir uma nota existente.
- `0. Sair.`: Encerra o aplicativo.

## Dependências

- ZSH: Este script foi escrito para o shell ZSH e pode não funcionar corretamente em outros shells.
- SQLite3: Este script usa SQLite3 para armazenar e recuperar notas. Certifique-se de ter o SQLite3 instalado em seu sistema.

## Autor

Pablo Andrade