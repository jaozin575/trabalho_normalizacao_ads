-- Trabalho de ADS: Desnormalização de Banco de Dados
-- SGBD de referência: PostgreSQL 18
-- Todos os dados abaixo são fictícios.

-- 1) Estrutura normalizada
CREATE TABLE clientes (
    id_cliente INTEGER PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL
);

CREATE TABLE pedidos (
    id_pedido INTEGER PRIMARY KEY,
    id_cliente INTEGER NOT NULL REFERENCES clientes(id_cliente),
    data_pedido DATE NOT NULL,
    valor_total NUMERIC(10,2) NOT NULL
);

INSERT INTO clientes VALUES
(1, 'Ana Souza', 'ana@example.com'),
(2, 'Bruno Lima', 'bruno@example.com');

INSERT INTO pedidos VALUES
(101, 1, '2026-09-10', 150.00),
(102, 1, '2026-09-12', 89.90),
(103, 2, '2026-09-13', 210.00);

-- 2) Consulta normalizada: relaciona pedidos e clientes
SELECT p.id_pedido, c.nome, p.data_pedido, p.valor_total
FROM pedidos p
JOIN clientes c ON c.id_cliente = p.id_cliente
ORDER BY p.data_pedido;

-- 3) Tabela auxiliar desnormalizada para um relatório
CREATE TABLE pedidos_relatorio (
    id_pedido INTEGER PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    nome_cliente VARCHAR(100) NOT NULL,
    data_pedido DATE NOT NULL,
    valor_total NUMERIC(10,2) NOT NULL
);

-- Carga inicial dos dados para a tabela de relatório
INSERT INTO pedidos_relatorio
    (id_pedido, id_cliente, nome_cliente, data_pedido, valor_total)
SELECT p.id_pedido, c.id_cliente, c.nome, p.data_pedido, p.valor_total
FROM pedidos p
JOIN clientes c ON c.id_cliente = p.id_cliente;

-- 4) Consulta simplificada para o relatório
SELECT id_pedido, nome_cliente, data_pedido, valor_total
FROM pedidos_relatorio
ORDER BY data_pedido;

-- IMPORTANTE:
-- A carga acima é executada apenas uma vez.
-- Mudanças em clientes/pedidos não atualizam esta cópia automaticamente.
-- Em um sistema real, implemente e teste um processo de atualização.
