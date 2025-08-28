create database db_revenda_helena;

CREATE TABLE clientes( 
    id serial PRIMARY KEY,
    nome varchar(100),
    sobrenome varchar(100),
    email varchar(100),
    cpf varchar(11),
    celular varchar(20)
);


CREATE TABLE endereco(
    id serial PRIMARY KEY,
    rua varchar(100),
    bairro varchar(50),
    cidade varchar(50),
    estado varchar(50),
    cep varchar(8)  
);

ALTER TABLE endereco
ALTER COLUMN cep TYPE varchar(8);

CREATE TABLE produtos(
    id serial PRIMARY KEY,
    titulo varchar(100),
    estoque int,
    preco numeric(10,2),
    frete numeric(10,2),
    descricao text
);

CREATE TABLE cliente_endereco (
    id_cliente int NOT NULL,
    id_endereco int NOT NULL,
    PRIMARY KEY (id_cliente, id_endereco),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id),
    FOREIGN KEY (id_endereco) REFERENCES endereco(id)
);


CREATE TYPE metodo_pagamento_enum AS ENUM ('cartao', 'boleto', 'pix', 'dinheiro');
CREATE TYPE status_pagamento_enum AS ENUM ('confirmado', 'pendente', 'cancelado');

CREATE TABLE pagamento(
    id serial PRIMARY KEY,
    id_venda int NOT NULL,
    data_pagamento date,
    valor_pagamento numeric(10,2),
    metodo_pagamento metodo_pagamento_enum NOT NULL,
    status_pagamento status_pagamento_enum DEFAULT 'pendente'
);

CREATE TABLE categorias (
    id serial PRIMARY KEY,
    nome_categoria varchar(50),
    descricao text,
    ativo boolean DEFAULT TRUE,
    data_criacao date
);


CREATE TYPE status_venda_enum AS ENUM ('confirmada', 'pendente', 'cancelada');

CREATE TABLE vendas (
    id serial PRIMARY KEY,
    id_cliente int NOT NULL,
    valor_total numeric(10,2),
    status status_venda_enum,
    data_venda date DEFAULT CURRENT_DATE,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id)
);


INSERT INTO clientes (nome, sobrenome, email, cpf, celular) VALUES
('Lucas', 'Silva', 'lucas.silva@email.com', '12345678901', '11999990000'),
('Maria', 'Oliveira', 'maria.oliveira@email.com', '23456789012', '21988880000'),
('João', 'Souza', 'joao.souza@email.com', '34567890123', '31977770000'),
('Ana', 'Costa', 'ana.costa@email.com', '45678901234', '41966660000'),
('Pedro', 'Almeida', 'pedro.almeida@email.com', '56789012345', '51955550000'),
('Carla', 'Lima', 'carla.lima@email.com', '67890123456', '61944440000'),
('Rafael', 'Pereira', 'rafael.pereira@email.com', '78901234567', '71933330000'),
('Fernanda', 'Martins', 'fernanda.martins@email.com', '89012345678', '81922220000'),
('Gabriel', 'Rocha', 'gabriel.rocha@email.com', '90123456789', '91911110000'),
('Patrícia', 'Melo', 'patricia.melo@email.com', '01234567890', '11900001111');

INSERT INTO endereco (rua, bairro, cidade, estado, cep) VALUES
('Rua Teresa', 'Centro', 'Petrópolis', 'RJ', '25670000'),
('Rua 16 de Março', 'Centro', 'Petrópolis', 'RJ', '25670010'),
('Rua do Imperador', 'Centro', 'Petrópolis', 'RJ', '25670100'),
('Rua Paulo Barbosa', 'Valparaíso', 'Petrópolis', 'RJ', '25685000'),
('Rua Montecaseros', 'Itaipava', 'Petrópolis', 'RJ', '25725000'),
('Rua Dr. Sá Earp', 'Centro', 'Petrópolis', 'RJ', '25670020'),
('Rua Marechal Deodoro', 'Centro', 'Petrópolis', 'RJ', '25670030'),
('Rua do Imperador', 'Centro', 'Petrópolis', 'RJ', '25670101'),
('Rua Dom Pedro II', 'Centro', 'Petrópolis', 'RJ', '25670200'),
('Rua Santa Catarina', 'Itaipava', 'Petrópolis', 'RJ', '25725100');

INSERT INTO produtos (titulo, estoque, preco, frete, descricao) VALUES
('Base Líquida', 50, 79.90, 10.00, 'Base líquida com alta cobertura e acabamento matte.'),
('Batom Vermelho', 100, 29.90, 5.00, 'Batom vermelho intenso, alta fixação.'),
('Máscara de Cílios', 75, 39.90, 7.00, 'Máscara para cílios que alonga e dá volume.'),
('Paleta de Sombras', 40, 99.90, 15.00, 'Paleta com 12 cores vibrantes e pigmentadas.'),
('Delineador Líquido', 60, 49.90, 8.00, 'Delineador com ponta fina e alta durabilidade.'),
('Pó Compacto', 80, 34.90, 6.00, 'Pó compacto para acabamento natural e controle de oleosidade.'),
('Blush em Pó', 45, 39.90, 7.00, 'Blush com cores naturais para diversas tonalidades de pele.'),
('Iluminador', 30, 59.90, 9.00, 'Iluminador em pó para efeito radiante.'),
('Primer Facial', 55, 69.90, 10.00, 'Primer que prepara a pele para maquiagem.'),
('Corretivo', 65, 44.90, 6.00, 'Corretivo para cobrir imperfeições e olheiras.');

INSERT INTO cliente_endereco (id_cliente, id_endereco) VALUES
(1,1),(2,2),(3,3),(4,4),(5,5),
(6,6),(7,7),(8,8),(9,9),(10,10);

INSERT INTO vendas (id_cliente, valor_total, status, data_venda) VALUES
(1, 2600.00, 'confirmada', '2025-08-01'),
(2, 1500.00, 'confirmada', '2025-08-02'),
(3, 1020.00, 'pendente', NULL),
(4, 750.00, 'confirmada', '2025-08-03'),
(5, 470.00, 'cancelada', NULL),
(6, 1700.00, 'confirmada', '2025-08-04'),
(7, 1300.00, 'pendente', NULL),
(8, 1800.00, 'confirmada', '2025-08-05'),
(9, 520.00, 'confirmada', '2025-08-06'),
(10, 600.00, 'pendente', NULL);

INSERT INTO pagamento (id_venda, data_pagamento, valor_pagamento, metodo_pagamento, status_pagamento) VALUES
(1, '2025-08-01', 2600.00, 'cartao', 'confirmado'),
(2, '2025-08-02', 1500.00, 'boleto', 'confirmado'),
(3, NULL, 1020.00, 'pix', 'pendente'),
(4, '2025-08-03', 750.00, 'dinheiro', 'confirmado'),
(5, NULL, 470.00, 'boleto', 'cancelado'),
(6, '2025-08-04', 1700.00, 'pix', 'confirmado'),
(7, NULL, 1300.00, 'cartao', 'pendente'),
(8, '2025-08-05', 1800.00, 'dinheiro', 'confirmado'),
(9, '2025-08-06', 520.00, 'cartao', 'confirmado'),
(10, NULL, 600.00, 'pix', 'pendente');

-- Views

CREATE VIEW vw_cliente_endereco AS
SELECT 
    c.id AS cliente_id,
    c.nome,
    c.sobrenome,
    c.email,
    e.rua,
    e.bairro,
    e.cidade,
    e.estado,
    e.cep
FROM clientes c
JOIN cliente_endereco ce ON c.id = ce.id_cliente
JOIN endereco e ON e.id = ce.id_endereco;

CREATE VIEW vw_vendas_pagamento AS
SELECT 
    v.id AS venda_id,
    c.nome || ' ' || c.sobrenome AS cliente_nome,
    v.data_venda,
    v.valor_total,
    v.status AS status_venda,
    p.metodo_pagamento,
    p.status_pagamento
FROM vendas v
JOIN clientes c ON v.id_cliente = c.id
LEFT JOIN pagamento p ON p.id_venda = v.id;

SELECT * FROM clientes WHERE nome LIKE '%a%';

EXPLAIN SELECT * FROM clientes WHERE nome LIKE '%a%';

CREATE INDEX idx_clientes_nome ON clientes(nome);

EXPLAIN SELECT * FROM clientes WHERE nome LIKE '%a%';

ALTER TABLE clientes ALTER COLUMN cpf TYPE int USING cpf::int;

ALTER TABLE produtos ALTER COLUMN estoque TYPE varchar(10) USING estoque::varchar;

CREATE USER helena WITH PASSWORD 'heleninha';

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO helena;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO helena;

CREATE USER helena WITH PASSWORD 'heleninhaa';

GRANT SELECT ON TABLE clientes TO helena;


SELECT * FROM clientes WHERE nome ILIKE '%a%';

INSERT INTO clientes (nome, sobrenome, email, cpf, celular) VALUES ('Teste', 'Teste', 'teste@email.com', '00000000000', '0000000000');

ALTER TABLE clientes ALTER COLUMN nome TYPE varchar(200);

SELECT c.nome, e.rua FROM clientes c INNER JOIN cliente_endereco ce ON c.id = ce.id_cliente INNER JOIN endereco e ON ce.id_endereco = e.id;

SELECT c.nome, e.rua FROM clientes c LEFT JOIN cliente_endereco ce ON c.id = ce.id_cliente LEFT JOIN endereco e ON ce.id_endereco = e.id;

SELECT c.nome, e.rua FROM clientes c RIGHT JOIN cliente_endereco ce ON c.id = ce.id_cliente RIGHT JOIN endereco e ON ce.id_endereco = e.id;

SELECT c.nome, v.valor_total FROM clientes c INNER JOIN vendas v ON c.id = v.id_cliente;

SELECT c.nome, v.valor_total FROM clientes c LEFT JOIN vendas v ON c.id = v.id_cliente;

SELECT c.nome, v.valor_total FROM clientes c RIGHT JOIN vendas v ON c.id = v.id_cliente;

UPDATE vendas SET data_venda = CURRENT_DATE WHERE data_venda IS NULL;
SELECT c.nome, v.valor_total FROM clientes c LEFT JOIN vendas v ON c.id = v.id_cliente;






