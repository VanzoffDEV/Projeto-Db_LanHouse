CREATE DATABASE IF NOT EXISTS LanHouse_DB;
USE LanHouse_DB;

-- ==========================================
-- 1. ESTRUTURA (DDL)
-- ==========================================

CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome_cliente VARCHAR(100) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    data_nasc DATE,
    num_telefone VARCHAR(20)
);

CREATE TABLE Computadores (
    id_pc INT PRIMARY KEY AUTO_INCREMENT,
    valor_hora DECIMAL(10, 2) NOT NULL,
    componentes TEXT
);

CREATE TABLE Torneios (
    id_torneio INT PRIMARY KEY AUTO_INCREMENT,
    nome_torneio VARCHAR(100),
    data_torneio DATE NOT NULL,
    hora_torneio TIME NOT NULL
);

CREATE TABLE Compras_avulsas (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome_produto VARCHAR(100) NOT NULL,
    valor_produto DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Sessoes (
    id_sessao INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    id_pc INT,
    data_uso DATE DEFAULT (CURRENT_DATE),
    CONSTRAINT fk_sessoes_cliente FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    CONSTRAINT fk_sessoes_pc FOREIGN KEY (id_pc) REFERENCES Computadores(id_pc)
);

CREATE TABLE Inscricoes (
    id_inscricao INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    id_torneio INT,
    data_inscricao DATE DEFAULT (CURRENT_DATE),
    CONSTRAINT fk_inscricoes_cliente FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    CONSTRAINT fk_inscricoes_torneio FOREIGN KEY (id_torneio) REFERENCES Torneios(id_torneio)
);

CREATE TABLE Consumo (
    id_consumo INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    id_produto INT,
    quantidade INT NOT NULL,
    CONSTRAINT fk_consumo_cliente FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    CONSTRAINT fk_consumo_produto FOREIGN KEY (id_produto) REFERENCES Compras_avulsas(id_produto)
);

-- ==========================================
-- 2. DADOS INICIAIS (15 LINHAS POR TABELA)
-- ==========================================

-- Clientes
INSERT INTO Clientes (nome_cliente, cpf, data_nasc, num_telefone) VALUES 
('Abelardo Vanzoff', '111.111.111-11', '2001-01-01', '81900001111'),
('Ludmila Silva', '222.222.222-22', '1998-05-15', '81900002222'),
('Carlos Alberto', '333.333.333-33', '1995-10-20', '81900003333'),
('Mariana Souza', '444.444.444-44', '2000-03-12', '81900004444'),
('Ricardo Santos', '555.555.555-55', '1992-07-30', '81900005555'),
('Juliana Paes', '666.666.666-66', '1999-12-25', '81900006666'),
('Fernando Lima', '777.777.777-77', '1988-04-05', '81900007777'),
('Beatriz Costa', '888.888.888-88', '2002-08-14', '81900008888'),
('Tiago Oliveira', '999.999.999-99', '1997-02-28', '81900009999'),
('Renata Melo', '101.101.101-10', '1994-06-18', '81900001010'),
('Lucas Pereira', '202.202.202-20', '2003-11-09', '81900002020'),
('Fernanda Rocha', '303.303.303-30', '1996-09-22', '81900003030'),
('Gabriel Dantas', '404.404.404-40', '1991-01-11', '81900004040'),
('Aline Martins', '505.505.505-50', '1993-05-07', '81900005050'),
('Hugo Vasconcelos', '606.606.606-60', '1990-10-31', '81900006060');

-- Computadores
INSERT INTO Computadores (valor_hora, componentes) VALUES 
(8.00, 'i5, 8GB RAM, GTX 1650'), (8.00, 'i5, 8GB RAM, GTX 1650'),
(8.00, 'i5, 8GB RAM, GTX 1650'), (8.00, 'i5, 8GB RAM, GTX 1650'),
(8.00, 'i5, 8GB RAM, GTX 1650'), (10.00, 'i7, 16GB RAM, RTX 3060'),
(10.00, 'i7, 16GB RAM, RTX 3060'), (10.00, 'i7, 16GB RAM, RTX 3060'),
(10.00, 'i7, 16GB RAM, RTX 3060'), (10.00, 'i7, 16GB RAM, RTX 3060'),
(12.00, 'i9, 32GB RAM, RTX 4070'), (12.00, 'i9, 32GB RAM, RTX 4070'),
(12.00, 'i9, 32GB RAM, RTX 4070'), (15.00, 'PS5 - Console'), (15.00, 'PS5 - Console');

-- Torneios
INSERT INTO Torneios (nome_torneio, data_torneio, hora_torneio) VALUES 
('League of Legends Open', '2026-06-01', '14:00:00'), ('Counter-Strike Cup', '2026-06-02', '15:00:00'),
('Valorant Masters', '2026-06-03', '13:00:00'), ('Dota 2 Championship', '2026-06-04', '16:00:00'),
('Clash Royale Night', '2026-06-05', '19:00:00'), ('FIFA 26 Tournament', '2026-06-06', '10:00:00'),
('Free Fire Battle', '2026-06-07', '14:00:00'), ('Tekken 8 Brawl', '2026-06-08', '18:00:00'),
('Street Fighter VI', '2026-06-09', '19:30:00'), ('Rocket League 2x2', '2026-06-10', '15:00:00'),
('PUBG Survival', '2026-06-11', '20:00:00'), ('Minecraft Creative', '2026-06-12', '14:00:00'),
('Roblox Race', '2026-06-13', '09:00:00'), ('Stardew Valley Coop', '2026-06-14', '11:00:00'),
('Fortnite Solo', '2026-06-15', '13:00:00');

-- Compras_avulsas
INSERT INTO Compras_avulsas (nome_produto, valor_produto) VALUES 
('Coca-Cola 350ml', 5.00), ('Coxinha', 6.00), ('Pastel', 6.50), ('Energético Monster', 12.00),
('Água Mineral', 3.00), ('Chocolate KitKat', 4.50), ('Batata Lays', 7.00), ('Café Expresso', 4.00),
('Headset Simples', 15.00), ('Mousepad Personalizado', 25.00), ('Pão de Queijo', 3.50),
('Suco Del Valle', 5.50), ('Fini Dentadura', 6.00), ('Halls Preta', 2.00), ('Cerveja Heineken', 10.00);

-- Sessoes
INSERT INTO Sessoes (id_cliente, id_pc) VALUES 
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 6), (7, 7), (8, 8), (9, 9), (10, 10), (11, 11), (12, 12), (13, 13), (14, 14), (15, 15);

-- Inscricoes
INSERT INTO Inscricoes (id_cliente, id_torneio) VALUES 
(1, 1), (2, 1), (3, 2), (4, 2), (5, 3), (6, 3), (7, 4), (8, 5), (9, 6), (10, 7), (11, 8), (12, 9), (13, 10), (14, 11), (15, 12);

-- Consumo
INSERT INTO Consumo (id_cliente, id_produto, quantidade) VALUES 
(1, 1, 2), (2, 4, 1), (3, 2, 2), (4, 3, 1), (5, 5, 3), (6, 7, 1), (7, 1, 1), (8, 13, 2), (9, 14, 5), (10, 12, 1), (11, 11, 3), (12, 10, 1), (13, 9, 1), (14, 8, 2), (15, 6, 4);