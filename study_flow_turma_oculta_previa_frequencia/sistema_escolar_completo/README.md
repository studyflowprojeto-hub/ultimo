# Study Flow — Sistema de Gestão Escolar

Projeto acadêmico feito com Python, Flask, MySQL, HTML e CSS. A interface usa uma paleta roxa e possui uma tela de login.

## Recursos
- Tela de login e tela de cadastro de conta com e-mail, senha e confirmação.
- Novas contas públicas são criadas como ALUNO; não é possível escolher perfil de administrador no cadastro.
- Área interna protegida por sessão.
- Painel inicial simplificado, com nomes claros e atalhos para as áreas principais.
- Abas de Usuários e Permissões ocultas da navegação; as tabelas continuam no banco para login e relacionamentos.
- Campos e relacionamentos apresentados com rótulos mais fáceis de entender, mostrando nomes de alunos e professores em vez de IDs quando possível.
- Frequência em modo de consulta por calendário, sem opção de fazer chamada.
- Layout adaptável para computador e celular.
- Listagem com busca e ações de cadastro, edição e exclusão quando a tabela possui uma chave primária simples.
- Formulários criados a partir das colunas do banco, incluindo campos de relacionamento (chaves estrangeiras).
- Tabelas com chave primária composta podem ser consultadas e receber novos registros, mas não têm edição/exclusão nesta versão.

## Como configurar e executar
1. Instale Python e MySQL.
2. Crie o banco usando o arquivo SQL do projeto.
3. Abra `config.py` e preencha usuário, senha e nome do banco.
4. Instale as dependências e inicie a aplicação:

   ```bash
   pip install -r requirements.txt
   python app.py
   ```

5. Acesse `http://127.0.0.1:5000` no navegador.
6. Acesse `http://127.0.0.1:5000/cadastro` para criar uma conta de aluno, ou entre com um usuário já cadastrado na tabela `usuarios`.

## Criar um primeiro usuário para testar
Para testar a área administrativa, se a tabela `usuarios` estiver vazia, execute no MySQL um comando como este (altere o e-mail e a senha):

```sql
INSERT INTO usuarios (nome, email, senha, tipo_usuario, ativo)
VALUES ('Administrador', 'admin@studyflow.com', '123456', 'ADMIN', TRUE);
```

Depois, entre com `admin@studyflow.com` e a senha `123456`.

> **Importante para este projeto escolar:** a senha é comparada em texto simples porque esta versão foi solicitada sem hash. Isso não é seguro para um sistema real. Em produção, use hash de senha, HTTPS, uma chave secreta forte e validações adicionais. Troque também `app.secret_key` no arquivo `app.py` por uma chave aleatória privada.

As telas de Usuários e Permissões ficam ocultas e não podem ser abertas pelas rotas comuns de cadastro. O cadastro e o login continuam funcionando normalmente por trás da interface.

A aplicação precisa que o MySQL esteja ligado e que o usuário configurado tenha permissões no banco.
