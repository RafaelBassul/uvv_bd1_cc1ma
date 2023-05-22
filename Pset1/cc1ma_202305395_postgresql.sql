--CRIANDO O MEU USUARIO

CREATE USER rafaelbassul WITH SUPERUSER CREATEDB CREATEROLE LOGIN ENCRYPTED PASSWORD 'rafaelbassul';

--CRIANDO O BANCO DE DADOS DA UVV

CREATE DATABASE uvv with
OWNER rafaelbassul
TEMPLATE='template0'
ENCODING='UTF8'
LC_COLLATE='pt_BR.UTF-8'
LC_CTYPE='pt_BR.UTF-8'
ALLOW_CONNECTIONS='true'
;

--COMENTANDO O BANCO DE DADOS
COMMENT ON DATABASE uvv IS 'Banco de dados usado para atividades de PSETs';


--SELECIONANDO O BANCO DE DADOS DA UVV

\c uvv

--CRIANDO O ESQUEMA

CREATE SCHEMA lojas;

--"SETANDO" O ESQUEMA COMO PADRÃO

set search_path to lojas, "$user", public;

--"SETANDO" O ESQUEMA COMO PADRÃO PARA O USUARIO RAFAELBASSUL 

ALTER USER rafaelbassul
SET SEARCH_PATH TO lojas, "$user", public;


--CRIANDO A TABELA CLIENTES E ATRIBUINDO PRIMARY KEY

CREATE TABLE lojas.clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone1 VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT clientes_pk PRIMARY KEY (cliente_id)
);

--COMENTANDO AS COLUNAS DA TABELA CLIENTE 

COMMENT ON TABLE lojas.clientes IS 'Esta tabela armazenará os dados dos clientes';
COMMENT ON COLUMN lojas.clientes.cliente_id IS 'identifcação do cliente';
COMMENT ON COLUMN lojas.clientes.email IS 'email atual do cliente';
COMMENT ON COLUMN lojas.clientes.nome IS 'nome completo do cliente';
COMMENT ON COLUMN lojas.clientes.telefone1 IS 'telefone 1 do cliente';
COMMENT ON COLUMN lojas.clientes.telefone2 IS 'telefone numero 2 do cliente';
COMMENT ON COLUMN lojas.clientes.telefone3 IS 'telefone numero 3 do cliente';

--CRIANDO A TABELA PRODUTOS E ATRIBUINDO PRIMARY KEY

CREATE TABLE lojas.produtos (
                produto_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                preco_unitario NUMERIC(10,2),
                detalhes BYTEA,
                imagem BYTEA,
                imagem_mime_type VARCHAR(512),
                imagem_arquivo VARCHAR(512),
                imagem_charset VARCHAR(512),
                imagem_ultima_atualizacao DATE,
                CONSTRAINT produtos_pk PRIMARY KEY (produto_id)
);

--COMENTANDO AS COLUNAS DA TABELA PRODUTOS

COMMENT ON TABLE lojas.produtos IS 'Tabela que irá armazenar os dados de todos os produtos das lojas';
COMMENT ON COLUMN lojas.produtos.produto_id IS 'identificação atribuida a um produto';
COMMENT ON COLUMN lojas.produtos.nome IS 'nome do produto';
COMMENT ON COLUMN lojas.produtos.preco_unitario IS 'preço unitário do produto';
COMMENT ON COLUMN lojas.produtos.detalhes IS 'detalhes do produto';
COMMENT ON COLUMN lojas.produtos.imagem IS 'uma imagem atualizada do produto';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type IS 'MIME type da imagem';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo IS 'arquivo imagem do produto';
COMMENT ON COLUMN lojas.produtos.imagem_charset IS 'charset da imagem do produto';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS 'última atualização da imagem do produto';

--CRIANDO A TABELA LOJAS E ATRIBUINDO PRIMARY KEY

CREATE TABLE lojas.lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereco_web VARCHAR(100),
                endereco_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT lojas_pk PRIMARY KEY (loja_id)
);

--COMENTANDO AS COLUNAS DA TABELA LOJAS

COMMENT ON TABLE lojas.lojas IS 'Tabela que irá armazenar os dados das lojas';
COMMENT ON COLUMN lojas.lojas.loja_id IS 'identificação atribuida à loja';
COMMENT ON COLUMN lojas.lojas.nome IS 'nome da loja';
COMMENT ON COLUMN lojas.lojas.endereco_web IS 'endereço web atribuido à loja';
COMMENT ON COLUMN lojas.lojas.endereco_fisico IS 'endereço fisico atribuido à loja';
COMMENT ON COLUMN lojas.lojas.latitude IS 'latitude demografica de onde fica a loja';
COMMENT ON COLUMN lojas.lojas.longitude IS 'longitude demográfica de onde fica a loja';
COMMENT ON COLUMN lojas.lojas.logo IS 'logo pertencente a loja';
COMMENT ON COLUMN lojas.lojas.logo_mime_type IS 'MIME type da logo';
COMMENT ON COLUMN lojas.lojas.logo_arquivo IS 'arquivo do logo da loja';
COMMENT ON COLUMN lojas.lojas.logo_charset IS 'charset da logo';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'ultima atualização realizada na logo';

--CRIANDO A TABELA ENVIOS E ATRIBUINDO PRIMARY KEY

CREATE TABLE lojas.envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT envios_pk PRIMARY KEY (envio_id)
);

--COMENTANDO AS COLUNAS DA TABELA ENVIOS

COMMENT ON TABLE lojas.envios IS 'Tabela que informará todos os dados/status de envios realizados';
COMMENT ON COLUMN lojas.envios.envio_id IS 'identificação do envio';
COMMENT ON COLUMN lojas.envios.loja_id IS 'identificação da loja';
COMMENT ON COLUMN lojas.envios.cliente_id IS 'identificação do cliente';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'endereço da entrega do produto';
COMMENT ON COLUMN lojas.envios.status IS 'status atual do envio do produto';

--CRIANDO A TABELA ESTOQUES E ATRIBUINDO PRIMARY KEY

CREATE TABLE lojas.estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT estoques_pk PRIMARY KEY (estoque_id)
);

--COMENTANDO AS COLUNAS DA TABELA ESTOQUES

COMMENT ON TABLE lojas.estoques IS 'Tabela que irá armazenar e informar as informações de estoques dos produtos de todas as lojas';
COMMENT ON COLUMN lojas.estoques.estoque_id IS 'identificação do estoque';
COMMENT ON COLUMN lojas.estoques.loja_id IS 'identificação atribuida à loja';
COMMENT ON COLUMN lojas.estoques.produto_id IS 'identificação atribuida ao produto';
COMMENT ON COLUMN lojas.estoques.quantidade IS 'quantidade disponível no estoque';

--CRIANDO A TABELA PEDIDOS E ATRIBUINDO PRIMARY KEY

CREATE TABLE lojas.pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedidos_pk PRIMARY KEY (pedido_id)
);

--COMENTANDO AS COLUNAS DA TABELA PEDIDOS

COMMENT ON TABLE lojas.pedidos IS 'Tabela que irá armazenar os dados de pedidos realizados';
COMMENT ON COLUMN lojas.pedidos.pedido_id IS 'identificação do pedido';
COMMENT ON COLUMN lojas.pedidos.data_hora IS 'data e hora dos pedidos realizados';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'identificação do cliente';
COMMENT ON COLUMN lojas.pedidos.status IS 'status atual do pedido';
COMMENT ON COLUMN lojas.pedidos.loja_id IS 'identificação da loja do pedido';

--CRIANDO A TABELA PEDIDOS ITENS E ATRIBUINDO PRIMARY KEY

CREATE TABLE lojas.pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38),
                CONSTRAINT pedidos_itens_pk PRIMARY KEY (pedido_id, produto_id)
);

--COMENTANDO AS COLUNAS DA TABELA PEDIDOS ITENS

COMMENT ON TABLE lojas.pedidos_itens IS 'Esta tabeça irá armazenar a listagem de itens que foram pedidos';
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id IS 'identificação do pedido';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id IS 'identificação do produto';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS 'numero da linha do pedido';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario IS 'preço unitário atual do produto';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade IS 'quantidade atual do item';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id IS 'identificação do envio';

--CRIANDO FOREIGN KEY NA TABELA PEDIDOS E ATRIBUINDO RELAÇÃO COM A PRIMARY KEY DA TABELA CLIENTES

ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--CRIANDO FOREIGN KEY NA TABELA ENVIOS E ATRIBUINDO RELAÇÃO COM A PRIMARY KEY DA TABELA CLIENTES

ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--CRIANDO FOREIGN KEY NA TABELA ESTOQUES E ATRIBUINDO RELAÇÃO COM A PRIMARY KEY DA TABELA PRODUTOS

ALTER TABLE lojas.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--CRIANDO FOREIGN KEY NA TABELA PEDIDOS ITENS E ATRIBUINDO RELAÇÃO COM A PRIMARY KEY DA TABELA PRODUTOS

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--CRIANDO FOREIGN KEY NA TABELA PEDIDOS E ATRIBUINDO RELAÇÃO COM A PRIMARY KEY DA TABELA LOJAS

ALTER TABLE lojas.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--CRIANDO FOREIGN KEY NA TABELA ESTOQUES E ATRIBUINDO RELAÇÃO COM A PRIMARY KEY DA TABELA LOJAS

ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--CRIANDO FOREIGN KEY NA TABELA ENVIOS E ATRIBUINDO RELAÇÃO COM A PRIMARY KEY DA TABELA LOJAS

ALTER TABLE lojas.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--CRIANDO FOREIGN KEY NA TABELA PEDIDOS ITENS E ATRIBUINDO RELAÇÃO COM A PRIMARY KEY DA TABELA ENVIOS

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--CRIANDO FOREIGN KEY NA TABELA PEDIDOS ITENS E ATRIBUINDO RELAÇÃO COM A PRIMARY KEY DA TABELA PEDIDOS

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--CRIANDO REGRA QUE EM PEDIDOS, A COLUNA STATUS ACEITE SOMENTE: CANCELADO, COMPLETO, ABERTO, PAGO, REEMBOLSADO, ENVIADO

ALTER TABLE lojas.pedidos
ADD CONSTRAINT check_status
CHECK (status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));

--CRIANDO REGRA QUE EM ENVIOS, A COLUNA STATUS ACEITE SOMENTE: CRIADO, ENVIADO, TRANSITO, ENTREGUE

ALTER TABLE lojas.envios
ADD CONSTRAINT check_status_envios
CHECK (status IN ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));

--CRIANDO UMA REGRA QUE ME GARANTE QUE PELO MENOS UMAS DAS COLUNAS "ENDERECO_WEB" OU "ENDERECO_FISICO" ESTEJAM PREENCHIDAS

ALTER TABLE lojas.lojas
ADD CONSTRAINT pelo_menos_um_endereco
CHECK (endereco_web IS NOT NULL OR endereco_fisico IS NOT NULL);

--CRIANDO UMA REGRA QUE ME GARANTE QUE O PREÇO UNITÁRIO NÃO SEJA NEGATIVO

ALTER TABLE lojas.produtos
ADD CONSTRAINT preco_unitario_nao_negativo
CHECK (preco_unitario >= 0);

--CRIANDO UMA REGRA QUE ME GARANTE QUE O ESTOQUE NÃO SEJA NEGATIVO

ALTER TABLE lojas.estoques
ADD CONSTRAINT estoques_nao_negativos
CHECK (quantidade >= 0);


ALTER TABLE lojas.clientes
OWNER TO rafaelbassul;

ALTER TABLE lojas.produtos
OWNER TO rafaelbassul;

ALTER TABLE lojas.lojas
OWNER TO rafaelbassul;

ALTER TABLE lojas.envios
OWNER TO rafaelbassul;

ALTER TABLE lojas.estoques
OWNER TO rafaelbassul;

ALTER TABLE lojas.pedidos
OWNER TO rafaelbassul;

ALTER TABLE lojas.pedidos_itens
OWNER TO rafaelbassul;
