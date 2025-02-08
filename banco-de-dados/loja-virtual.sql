-- Criar o banco de dados
CREATE DATABASE loja_virtual;

USE loja_virtual;

-- Criar a tabela de usuários
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    data_criacao TIMESTAMP DEFAULT NOW()
);

-- Criar a tabela de pedidos
CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY,
    usuario_id INT NOT NULL,
    valor_total DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) CHECK (status IN ('pendente', 'processando', 'enviado', 'entregue', 'cancelado')) NOT NULL,
    data_pedido TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
);

-- Criar a tabela de log para registrar alterações nos pedidos
CREATE TABLE log_pedidos (
    id SERIAL PRIMARY KEY,
    pedido_id INT NOT NULL,
    status_anterior VARCHAR(20),
    status_novo VARCHAR(20),
    data_modificacao TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE
);

-- Criar a função para o trigger
CREATE OR REPLACE FUNCTION registrar_alteracao_pedido()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO log_pedidos (pedido_id, status_anterior, status_novo)
    VALUES (NEW.id, OLD.status, NEW.status);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Criar o trigger que dispara a função ao atualizar um pedido
CREATE TRIGGER trigger_registra_pedido
AFTER UPDATE ON pedidos
FOR EACH ROW
WHEN (OLD.status IS DISTINCT FROM NEW.status)
EXECUTE FUNCTION registrar_alteracao_pedido();

-- Testando o banco de dados e o trigger
INSERT INTO usuarios (nome, email) VALUES ('Maria Silva', 'maria@email.com');

INSERT INTO pedidos (usuario_id, valor_total, status) 
VALUES (1, 150.00, 'pendente');

UPDATE pedidos SET status = 'processando' WHERE id = 1;

SELECT * FROM pedidos;

SELECT * FROM log_pedidos;
