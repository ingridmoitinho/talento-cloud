-- Supondo que a tabela clientes tenha a seguinte estrutura:
CREATE TABLE clientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Criando a função
CREATE OR REPLACE FUNCTION total_clientes_por_dia(data_desejada DATE)
RETURNS INTEGER AS $$
DECLARE
    total_clientes INTEGER;
BEGIN
    SELECT COUNT(*) INTO total_clientes
    FROM clientes
    WHERE DATE(data_cadastro) = data_desejada;
    
    RETURN total_clientes;
END;
$$ LANGUAGE plpgsql;

-- Testando a função
SELECT total_clientes_por_dia('2024-02-08');
