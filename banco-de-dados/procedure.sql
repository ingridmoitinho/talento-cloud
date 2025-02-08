-- Criando Procedure que retorna o total de vendas diárias

DELIMITER $$

CREATE OR REPLACE FUNCTION relatorio_vendas_diario()
RETURNS TABLE (
    data_compra DATE,
    produto_id INT,
    total_comprado INT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        DATE(data_venda) AS data_compra,
        produto_id,
        SUM(quantidade) AS total_comprado
    FROM vendas
    WHERE DATE(data_venda) = CURRENT_DATE  -- Filtra apenas vendas do dia atual
    GROUP BY DATE(data_venda), produto_id
    ORDER BY data_compra, produto_id;
END;
$$ LANGUAGE plpgsql;

DELIMITER ;
