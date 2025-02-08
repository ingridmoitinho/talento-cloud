CREATE DATABASE BibliotecaDigital;

USE BibliotecaDigital;

-- Tabela Autores
CREATE TABLE Autores (
    id_autor SERIAL PRIMARY KEY,
    nome_autor VARCHAR(100) NOT NULL
);

-- Tabela Categorias
CREATE TABLE Categorias (
    id_categoria SERIAL PRIMARY KEY,
    nome_categoria VARCHAR(50) NOT NULL
);

-- Tabela Livros
CREATE TABLE Livros (
    id_livro SERIAL PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    id_autor INT NOT NULL,
    id_categoria INT NOT NULL,
    ano_publicacao INT,
    FOREIGN KEY (id_autor) REFERENCES Autores(id_autor) ON DELETE CASCADE,
    FOREIGN KEY (id_categoria) REFERENCES Categorias(id_categoria) ON DELETE CASCADE
);

-- Tabela Usuarios
CREATE TABLE Usuarios (
    id_usuario SERIAL PRIMARY KEY,
    nome_usuario VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Tabela Emprestimos
CREATE TABLE Emprestimos (
    id_emprestimo SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_livro INT NOT NULL,
    data_emprestimo DATE DEFAULT CURRENT_DATE,
    data_devolucao DATE,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario) ON DELETE CASCADE,
    FOREIGN KEY (id_livro) REFERENCES Livros(id_livro) ON DELETE CASCADE
);

-- Inserindo Autores
INSERT INTO Autores (nome_autor) VALUES 
('Machado de Assis'),
('Clarice Lispector'),
('George Orwell');

-- Inserindo Categorias
INSERT INTO Categorias (nome_categoria) VALUES 
('Romance'),
('Ficção Científica'),
('Filosofia');

-- Inserindo Livros
INSERT INTO Livros (titulo, id_autor, id_categoria, ano_publicacao) VALUES 
('Dom Casmurro', 1, 1, 1899),
('A Hora da Estrela', 2, 1, 1977),
('1984', 3, 2, 1949);

-- Inserindo Usuários
INSERT INTO Usuarios (nome_usuario, email) VALUES 
('Alice Souza', 'alice@email.com'),
('Bruno Lima', 'bruno@email.com'),
('Carla Mendes', 'carla@email.com');

-- Inserindo Empréstimos
INSERT INTO Emprestimos (id_usuario, id_livro, data_emprestimo, data_devolucao) VALUES 
(1, 1, '2024-02-01', '2024-02-10'),
(2, 2, '2024-02-03', NULL), -- Ainda não devolveu
(3, 3, '2024-02-05', '2024-02-15');

-- Lista de todos os empréstimos com nome do usuário e título do livro
SELECT U.nome_usuario, L.titulo, E.data_emprestimo, E.data_devolucao
FROM Emprestimos E
JOIN Usuarios U ON E.id_usuario = U.id_usuario
JOIN Livros L ON E.id_livro = L.id_livro;

-- Contar quantos livros cada usuário pegou emprestado
SELECT U.nome_usuario, COUNT(E.id_emprestimo) AS total_emprestimos
FROM Emprestimos E
JOIN Usuarios U ON E.id_usuario = U.id_usuario
GROUP BY U.nome_usuario;

-- Exibir os livros mais emprestados
SELECT L.titulo, COUNT(E.id_emprestimo) AS total_emprestimos
FROM Emprestimos E
JOIN Livros L ON E.id_livro = L.id_livro
GROUP BY L.titulo
ORDER BY total_emprestimos DESC;

-- Listar os livros disponíveis 
SELECT L.titulo 
FROM Livros L
LEFT JOIN Emprestimos E ON L.id_livro = E.id_livro AND E.data_devolucao IS NULL
WHERE E.id_livro IS NULL;
