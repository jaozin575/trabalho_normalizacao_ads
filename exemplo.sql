-- Trabalho de ADS: Normalização de Banco de Dados
-- SGBD de referência: PostgreSQL 18
-- Todos os dados abaixo são fictícios.

-- 1) Criação das tabelas normalizadas
CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL
);

CREATE TABLE pedidos (
    id_pedido INTEGER PRIMARY KEY,
    id_cliente INTEGER NOT NULL REFERENCES clientes(id_cliente),
    data_pedido DATE NOT NULL,
    valor_total NUMERIC(10,2) NOT NULL CHECK (valor_total >= 0)
);

-- 2) Inserção de dados de exemplo
INSERT INTO clientes VALUES
(1, 'Ana Souza', 'ana@example.com'),
(2, 'Bruno Lima', 'bruno@example.com');

INSERT INTO pedidos VALUES
(101, 1, '2026-09-10', 150.00),
(102, 1, '2026-09-12', 89.90),
(103, 2, '2026-09-13', 210.00);

-- 3) Consulta que relaciona pedidos e clientes
SELECT
    p.id_pedido,
    c.nome,
    p.data_pedido,
    p.valor_total
FROM pedidos p
JOIN clientes c ON c.id_cliente = p.id_cliente
ORDER BY p.data_pedido;

-- Observação:
-- Os dados de cada cliente ficam na tabela clientes.
-- A tabela pedidos guarda apenas a chave estrangeira id_cliente
-- para relacionar cada pedido ao seu cliente.
-- Esse modelo reduz a repetição de nome e e-mail nos pedidos.
