
CREATE DATABASE sistema_escolar;
USE sistema_escolar;

CREATE USER 'study_user'@'localhost' IDENTIFIED BY '6767';

GRANT ALL PRIVILEGES
ON sistema_escolar.*
TO 'study_user'@'localhost';
FLUSH PRIVILEGES;

CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    tipo_usuario ENUM('ALUNO', 'PROFESSOR', 'ADMIN') NOT NULL,
    ativo BOOLEAN DEFAULT TRUE
);


CREATE TABLE permissoes (
    id_permissao INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE,
    descricao VARCHAR(255)
);

CREATE TABLE usuario_permissao (
    id_usuario INT NOT NULL,
    id_permissao INT NOT NULL,

    PRIMARY KEY (id_usuario, id_permissao),

    FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario),

    FOREIGN KEY (id_permissao)
        REFERENCES permissoes(id_permissao)
);
CREATE TABLE alunos (
    id_aluno INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL UNIQUE,
    numero_chamada INT,
    turma VARCHAR(50),
    data_nascimento DATE,

    FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario)
);


CREATE TABLE professores (
    id_professor INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL UNIQUE,
    especialidade VARCHAR(100),

    FOREIGN KEY (id_usuario)
        REFERENCES usuarios(id_usuario)
);


CREATE TABLE disciplinas (
    id_disciplina INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT
);


CREATE TABLE turmas (
    id_turma INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    ano INT NOT NULL
);


CREATE TABLE aluno_turma (
    id_aluno INT NOT NULL,
    id_turma INT NOT NULL,

    PRIMARY KEY (id_aluno, id_turma),

    FOREIGN KEY (id_aluno)
        REFERENCES alunos(id_aluno),

    FOREIGN KEY (id_turma)
        REFERENCES turmas(id_turma)
);


CREATE TABLE professor_disciplina (
id_professor_disciplina INT AUTO_INCREMENT PRIMARY KEY,
  id_professor INT NOT NULL,
    id_disciplina INT NOT NULL,

    FOREIGN KEY (id_professor)
        REFERENCES professores(id_professor),

    FOREIGN KEY (id_disciplina)
        REFERENCES disciplinas(id_disciplina)
);

CREATE TABLE notas (
    id_nota INT AUTO_INCREMENT PRIMARY KEY,
    id_aluno INT NOT NULL,
    id_disciplina INT NOT NULL,
    bimestre INT NOT NULL,
    nota DECIMAL(4,2) NOT NULL,

    FOREIGN KEY (id_aluno)
        REFERENCES alunos(id_aluno),

    FOREIGN KEY (id_disciplina)
        REFERENCES disciplinas(id_disciplina)
);


CREATE TABLE frequencia (
    id_frequencia INT AUTO_INCREMENT PRIMARY KEY,
    id_aluno INT NOT NULL,
    id_disciplina INT NOT NULL,
    data_aula DATE NOT NULL,
    presente BOOLEAN NOT NULL,

    FOREIGN KEY (id_aluno)
        REFERENCES alunos(id_aluno),

    FOREIGN KEY (id_disciplina)
        REFERENCES disciplinas(id_disciplina)
);


CREATE TABLE materiais (
    id_material INT AUTO_INCREMENT PRIMARY KEY,
    id_disciplina INT NOT NULL,
    id_professor INT,
    titulo VARCHAR(150) NOT NULL,
    descricao TEXT,
    tipo VARCHAR(50),
    link VARCHAR(500),
    data_publicacao DATE,

    FOREIGN KEY (id_disciplina)
        REFERENCES disciplinas(id_disciplina),

    FOREIGN KEY (id_professor)
        REFERENCES professores(id_professor)
);


CREATE TABLE recomendacoes (
    id_recomendacao INT AUTO_INCREMENT PRIMARY KEY,
    id_aluno INT NOT NULL,
    id_material INT NOT NULL,
    motivo VARCHAR(255),
    data_recomendacao DATE,

    FOREIGN KEY (id_aluno)
        REFERENCES alunos(id_aluno),

    FOREIGN KEY (id_material)
        REFERENCES materiais(id_material)
);

USE sistema_escolar;

CREATE TABLE atividades (
    id_atividade INT AUTO_INCREMENT PRIMARY KEY,
    id_aluno INT NOT NULL,
    id_disciplina INT NOT NULL,
    titulo VARCHAR(150) NOT NULL,
    descricao TEXT,
    data_entrega DATE NOT NULL,
    status ENUM('PENDENTE', 'CONCLUIDA')
        DEFAULT 'PENDENTE',
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (id_aluno)
        REFERENCES alunos(id_aluno),

    FOREIGN KEY (id_disciplina)
        REFERENCES disciplinas(id_disciplina)
);




CREATE TABLE IF NOT EXISTS atividades (
   id_atividade INT AUTO_INCREMENT PRIMARY KEY,
   id_aluno INT NOT NULL,
   id_disciplina INT NOT NULL,
   titulo VARCHAR(150) NOT NULL,
   descricao TEXT,
   data_entrega DATE NOT NULL,
   status ENUM('PENDENTE', 'CONCLUIDA') NOT NULL DEFAULT 'PENDENTE',
   data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   FOREIGN KEY (id_aluno) REFERENCES alunos(id_aluno),
   FOREIGN KEY (id_disciplina) REFERENCES disciplinas(id_disciplina)
);



INSERT INTO usuarios
(nome, email, senha, tipo_usuario)
VALUES
('Nicolas', 'nicolas@escola.com', '123456', 'ADMIN'),
('Maria Eduarda', 'maria@escola.com', '123456', 'ADMIN'),
('Jakson', 'jakson@escola.com', '123456', 'ADMIN'),
('Pedro Henrique', 'pedro@escola.com', '123456', 'ADMIN'),
('Kaua', 'kaua@escola.com', '123456', 'ADMIN'),

('Joao Silva', 'joao@aluno.com', '123456', 'ALUNO'),
('Ana Souza', 'ana@aluno.com', '123456', 'ALUNO'),
('Carlos Oliveira', 'carlos@aluno.com', '123456', 'ALUNO'),

('Professor Marcos', 'marcos@escola.com', '123456', 'PROFESSOR'),
('Professora Juliana', 'juliana@escola.com', '123456', 'PROFESSOR');



INSERT INTO permissoes
(nome, descricao)
VALUES
('VISUALIZAR_NOTAS', 'Permite visualizar notas dos alunos'),
('CADASTRAR_NOTAS', 'Permite cadastrar notas'),
('ALTERAR_NOTAS', 'Permite alterar notas'),
('EXCLUIR_NOTAS', 'Permite excluir notas'),

('VISUALIZAR_FREQUENCIA', 'Permite visualizar frequência'),
('CADASTRAR_FREQUENCIA', 'Permite cadastrar frequência'),
('ALTERAR_FREQUENCIA', 'Permite alterar frequência'),

('VISUALIZAR_MATERIAIS', 'Permite visualizar materiais de estudo'),
('CADASTRAR_MATERIAIS', 'Permite cadastrar materiais'),
('ALTERAR_MATERIAIS', 'Permite alterar materiais'),
('EXCLUIR_MATERIAIS', 'Permite excluir materiais'),

('GERENCIAR_USUARIOS', 'Permite cadastrar e gerenciar usuários'),
('GERENCIAR_PERMISSOES', 'Permite gerenciar permissões');


-- Nicolas - administrador
INSERT INTO usuario_permissao
(id_usuario, id_permissao)
SELECT 1, id_permissao
FROM permissoes;

-- Maria Eduarda - documentação
INSERT INTO usuario_permissao
(id_usuario, id_permissao)
SELECT id_usuario, id_permissao
FROM usuarios
CROSS JOIN permissoes
WHERE usuarios.id_usuario = 2
AND permissoes.nome IN (
    'VISUALIZAR_NOTAS',
    'VISUALIZAR_FREQUENCIA',
    'VISUALIZAR_MATERIAIS'
);

-- Jakson - analista de dados
INSERT INTO usuario_permissao
(id_usuario, id_permissao)
SELECT id_usuario, id_permissao
FROM usuarios
CROSS JOIN permissoes
WHERE usuarios.id_usuario = 3
AND permissoes.nome IN (
    'VISUALIZAR_NOTAS',
    'VISUALIZAR_FREQUENCIA',
    'VISUALIZAR_MATERIAIS'
);

-- Pedro Henrique - frontend
INSERT INTO usuario_permissao
(id_usuario, id_permissao)
SELECT id_usuario, id_permissao
FROM usuarios
CROSS JOIN permissoes
WHERE usuarios.id_usuario = 4
AND permissoes.nome IN (
    'VISUALIZAR_NOTAS',
    'VISUALIZAR_FREQUENCIA',
    'VISUALIZAR_MATERIAIS'
);

-- Kaua - backend
INSERT INTO usuario_permissao
(id_usuario, id_permissao)
SELECT id_usuario, id_permissao
FROM usuarios
CROSS JOIN permissoes
WHERE usuarios.id_usuario = 5
AND permissoes.nome IN (
    'VISUALIZAR_NOTAS',
    'CADASTRAR_NOTAS',
    'ALTERAR_NOTAS',
    'VISUALIZAR_FREQUENCIA',
    'CADASTRAR_FREQUENCIA',
    'ALTERAR_FREQUENCIA',
    'VISUALIZAR_MATERIAIS',
    'CADASTRAR_MATERIAIS',
    'ALTERAR_MATERIAIS'
);


INSERT INTO alunos
(id_usuario, numero_chamada, turma, data_nascimento)
VALUES
(6, 1, '2A', '2009-03-15'),
(7, 2, '2A', '2009-06-20'),
(8, 3, '2A', '2009-09-10');


INSERT INTO professores
(id_usuario, especialidade)
VALUES
(9, 'Matemática'),
(10, 'Português');

INSERT INTO disciplinas
(nome, descricao)
VALUES
('Matemática', 'Conteúdos de matemática'),
('Português', 'Língua portuguesa e literatura'),
('História', 'História geral e do Brasil'),
('Ciências', 'Ciências da natureza'),
('Inglês', 'Língua inglesa');

INSERT INTO turmas
(nome, ano)
VALUES
('2A', 2026),
('2B', 2026);


INSERT INTO aluno_turma
(id_aluno, id_turma)
VALUES
(1, 1),
(2, 1),
(3, 1);


INSERT INTO professor_disciplina
(id_professor, id_disciplina)
VALUES
(1, 1),
(2, 2);

INSERT INTO notas
(id_aluno, id_disciplina, bimestre, nota)
VALUES
(1, 1, 1, 7.50),
(1, 2, 1, 8.00),
(1, 3, 1, 6.50),
(1, 4, 1, 9.00),
(1, 5, 1, 7.00),

(2, 1, 1, 5.50),
(2, 2, 1, 8.50),
(2, 3, 1, 7.00),
(2, 4, 1, 8.00),
(2, 5, 1, 6.00),

(3, 1, 1, 9.00),
(3, 2, 1, 7.50),
(3, 3, 1, 8.00),
(3, 4, 1, 9.50),
(3, 5, 1, 8.00);


INSERT INTO frequencia
(id_aluno, id_disciplina, data_aula, presente)
VALUES
(1, 1, '2026-09-01', TRUE),
(1, 1, '2026-09-02', TRUE),
(1, 1, '2026-09-03', TRUE),
(1, 1, '2026-09-04', FALSE),

(2, 1, '2026-09-01', TRUE),
(2, 1, '2026-09-02', FALSE),
(2, 1, '2026-09-03', TRUE),
(2, 1, '2026-09-04', TRUE),

(3, 1, '2026-09-01', TRUE),
(3, 1, '2026-09-02', TRUE),
(3, 1, '2026-09-03', TRUE),
(3, 1, '2026-09-04', TRUE);


INSERT INTO materiais
(id_disciplina, id_professor, titulo, descricao, tipo, link, data_publicacao)
VALUES
(1, 1, 'Equações do 2º Grau',
 'Material para estudo de equações do segundo grau',
 'PDF',
 'https://exemplo.com/equacoes.pdf',
 '2026-09-01'),

(1, 1, 'Exercícios de Matemática',
 'Lista de exercícios de matemática',
 'EXERCICIO',
 'https://exemplo.com/exercicios-matematica',
 '2026-09-02'),

(2, 2, 'Interpretação de Texto',
 'Material sobre interpretação de textos',
 'PDF',
 'https://exemplo.com/interpretacao.pdf',
 '2026-09-03'),

(3, NULL, 'História do Brasil',
 'Resumo sobre História do Brasil',
 'PDF',
 'https://exemplo.com/historia.pdf',
 '2026-09-04'),

(4, NULL, 'Introdução às Ciências',
 'Material introdutório de ciências',
 'VIDEO',
 'https://exemplo.com/ciencias',
 '2026-09-05'),

(5, NULL, 'Basic English',
 'Material básico para estudo de inglês',
 'VIDEO',
 'https://exemplo.com/ingles',
 '2026-09-06');

INSERT INTO recomendacoes
(id_aluno, id_material, motivo, data_recomendacao)
VALUES
(2, 1, 'Nota abaixo da média em Matemática', '2026-09-10'),
(2, 2, 'Reforço recomendado em Matemática', '2026-09-10'),
(2, 6, 'Reforço recomendado em Inglês', '2026-09-10'),
(1, 4, 'Material complementar de História', '2026-09-10');


-- Ver todos os usuários
SELECT * FROM usuarios;

-- Ver todas as permissões
SELECT * FROM permissoes;

-- Ver usuários e suas permissões
SELECT
    u.nome AS usuario,
    u.tipo_usuario,
    p.nome AS permissao
FROM usuarios u
JOIN usuario_permissao up
    ON u.id_usuario = up.id_usuario
JOIN permissoes p
    ON up.id_permissao = p.id_permissao
ORDER BY u.nome;

SELECT
    u.nome AS aluno,
    d.nome AS disciplina,
    n.bimestre,
    n.nota
FROM notas n
JOIN alunos a
    ON n.id_aluno = a.id_aluno
JOIN usuarios u
    ON a.id_usuario = u.id_usuario
JOIN disciplinas d
    ON n.id_disciplina = d.id_disciplina
ORDER BY u.nome, d.nome;

SELECT
    u.nome AS aluno,
    d.nome AS disciplina,
    f.data_aula,
    f.presente
FROM frequencia f
JOIN alunos a
    ON f.id_aluno = a.id_aluno
JOIN usuarios u
    ON a.id_usuario = u.id_usuario
JOIN disciplinas d
    ON f.id_disciplina = d.id_disciplina;

SELECT
    m.titulo,
    d.nome AS disciplina,
    m.tipo,
    m.link
FROM materiais m
JOIN disciplinas d
    ON m.id_disciplina = d.id_disciplina;

SELECT
    u.nome AS aluno,
    m.titulo AS material,
    d.nome AS disciplina,
    r.motivo
FROM recomendacoes r
JOIN alunos a
    ON r.id_aluno = a.id_aluno
JOIN usuarios u
    ON a.id_usuario = u.id_usuario
JOIN materiais m
    ON r.id_material = m.id_material
JOIN disciplinas d
    ON m.id_disciplina = d.id_disciplina;
