DELIMITER //

CREATE PROCEDURE sp_abrir_sessao(
    IN p_id_cliente INT,
    IN p_id_pc INT
)
BEGIN
    DECLARE v_erro BOOLEAN DEFAULT FALSE;

    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET v_erro = TRUE;

    START TRANSACTION;

    INSERT INTO Sessoes(id_cliente, id_pc, data_uso)
    VALUES(p_id_cliente, p_id_pc, CURDATE());

    IF v_erro THEN
        ROLLBACK;
    ELSE
        COMMIT;
    END IF;

END //

DELIMITER ;

ALTER TABLE Sessoes
ADD hora_inicio DATETIME,
ADD hora_fim DATETIME,
ADD valor_total DECIMAL(10,2);

DELIMITER //

CREATE PROCEDURE sp_fechar_sessao(
    IN p_id_sessao INT
)
BEGIN
    DECLARE v_horas DECIMAL(10,2);
    DECLARE v_valor_hora DECIMAL(10,2);
    DECLARE v_id_pc INT;
    DECLARE v_erro BOOLEAN DEFAULT FALSE;

    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    SET v_erro = TRUE;

    START TRANSACTION;

    SELECT id_pc
    INTO v_id_pc
    FROM Sessoes
    WHERE id_sessao = p_id_sessao;

    SELECT valor_hora
    INTO v_valor_hora
    FROM Computadores
    WHERE id_pc = v_id_pc;

    SET v_horas = TIMESTAMPDIFF(MINUTE,
                  (SELECT hora_inicio FROM Sessoes WHERE id_sessao = p_id_sessao),
                  NOW()) / 60;

    UPDATE Sessoes
    SET hora_fim = NOW(),
        valor_total = v_horas * v_valor_hora
    WHERE id_sessao = p_id_sessao;

    IF v_erro THEN
        ROLLBACK;
    ELSE
        COMMIT;
    END IF;

END //

DELIMITER ;

DELIMITER //

CREATE FUNCTION fn_valor_sessao(
    p_id_sessao INT
)
RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
    DECLARE v_valor DECIMAL(10,2);

    SELECT valor_total
    INTO v_valor
    FROM Sessoes
    WHERE id_sessao = p_id_sessao;

    RETURN v_valor;
END //

DELIMITER ;

SELECT id_sessao,
       fn_valor_sessao(id_sessao) AS valor_cobrado
FROM Sessoes;

DELIMITER //

CREATE FUNCTION fn_categoria_cliente(
    p_id_cliente INT
)
RETURNS VARCHAR(20)
READS SQL DATA
BEGIN
    DECLARE v_total DECIMAL(10,2);

    SELECT COALESCE(SUM(c.quantidade * p.valor_produto),0)
    INTO v_total
    FROM Consumo c
    JOIN Compras_avulsas p
      ON c.id_produto = p.id_produto
    WHERE c.id_cliente = p_id_cliente;

    IF v_total < 100 THEN
        RETURN 'Bronze';
    ELSEIF v_total < 300 THEN
        RETURN 'Prata';
    ELSE
        RETURN 'Ouro';
    END IF;

END //

DELIMITER ;

SELECT
    id_cliente,
    nome_cliente,
    fn_categoria_cliente(id_cliente) AS categoria
FROM Clientes;