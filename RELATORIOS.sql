-- ==========================================
-- SISTEMA DE GESTÃO DE LAN HOUSE
-- SCRIPTS DA SEMANA 2: Relatórios e Consultas Avançadas
-- Aluno: Abelardo Vanzoff
-- ==========================================

USE LanHouse_DB;

-- ==========================================
-- 1. REFATORAÇÃO (Preparação de Dados)
-- ==========================================

-- Inserindo clientes "fantasmas" (sem sessão) para o Relatório 2 não retornar vazio
INSERT INTO Clientes (nome_cliente, cpf, data_nasc, num_telefone) VALUES 
('Diego Alves', '444.555.666-77', '2000-05-10', '81900000000'),
('Flávia Ramos', '888.999.000-11', '1998-11-20', '81900000000');

-- Inserindo sessões extras para os clientes atingirem a regra do Relatório 1 (mais de 1 sessão)
INSERT INTO Sessoes (id_cliente, id_pc) VALUES 
(1, 2), -- Abelardo jogando de novo no PC 2
(1, 3), -- Abelardo jogando mais uma vez no PC 3
(2, 4), -- Ludmila jogando de novo no PC 4
(3, 5); -- Carlos jogando de novo no PC 5

-- ==========================================
-- 2. RELATÓRIO 1: Ranking de clientes por faturamento
-- Regra: Top 5 clientes que mais gastaram, exibindo apenas quem tem > 1 sessão
-- ==========================================

SELECT 
    c.nome_cliente, 
    c.num_telefone, 
    COUNT(s.id_sessao) AS total_sessoes, 
    SUM(pc.valor_hora) AS total_gasto
FROM Clientes c
JOIN Sessoes s ON s.id_cliente = c.id_cliente
JOIN Computadores pc ON s.id_pc = pc.id_pc
GROUP BY c.id_cliente, c.nome_cliente, c.num_telefone
HAVING COUNT(s.id_sessao) > 1
ORDER BY total_gasto DESC
LIMIT 5;

-- ==========================================
-- 3. RELATÓRIO 2: Clientes cadastrados sem nenhuma sessão
-- Regra: Padrão LEFT JOIN + IS NULL para encontrar registros órfãos
-- ==========================================

SELECT 
    c.nome_cliente, 
    c.num_telefone, 
    c.data_nasc
FROM Clientes c
LEFT JOIN Sessoes s ON s.id_cliente = c.id_cliente
WHERE s.id_sessao IS NULL;