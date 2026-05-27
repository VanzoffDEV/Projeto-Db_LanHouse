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

