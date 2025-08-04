-- Tabela: acesso
CREATE TABLE IF NOT EXISTS public.acesso (
     id         BIGINT        NOT NULL PRIMARY KEY,
     descricao  VARCHAR(255)  NOT NULL
);
ALTER TABLE public.acesso OWNER TO docker;

-- Tabela: categoria_produto
CREATE TABLE IF NOT EXISTS public.categoria_produto (
    id         BIGINT        NOT NULL PRIMARY KEY,
    nome_desc  VARCHAR(255)  NOT NULL
);
ALTER TABLE public.categoria_produto OWNER TO docker;

-- Tabela: cup_desc
CREATE TABLE IF NOT EXISTS public.cup_desc (
   id                   BIGINT        NOT NULL PRIMARY KEY,
   cod_desc             VARCHAR(255)  NOT NULL,
   data_validade_cupom  DATE          NOT NULL,
   valor_porcent_desc   NUMERIC(38,2),
   valor_real_desc      NUMERIC(38,2)
);
ALTER TABLE public.cup_desc OWNER TO docker;

-- Tabela: forma_pagamento
CREATE TABLE IF NOT EXISTS public.forma_pagamento (
    id         BIGINT        NOT NULL PRIMARY KEY,
    descricao  VARCHAR(255)  NOT NULL
);
ALTER TABLE public.forma_pagamento OWNER TO docker;

-- Tabela: marca_produto
CREATE TABLE IF NOT EXISTS public.marca_produto (
    id         BIGINT        NOT NULL PRIMARY KEY,
    nome_desc  VARCHAR(255)  NOT NULL
);
ALTER TABLE public.marca_produto OWNER TO docker;

-- Tabela: nota_fiscal_venda
CREATE TABLE IF NOT EXISTS public.nota_fiscal_venda (
    id                            BIGINT        NOT NULL PRIMARY KEY,
    numero                        VARCHAR(255)  NOT NULL,
    pdf                           TEXT          NOT NULL,
    serie                         VARCHAR(255)  NOT NULL,
    tipo                          VARCHAR(255)  NOT NULL,
    xml                           TEXT          NOT NULL,
    venda_compra_loja_virtual_id BIGINT        NOT NULL UNIQUE
);
ALTER TABLE public.nota_fiscal_venda OWNER TO docker;

-- Tabela: pessoa
CREATE TABLE IF NOT EXISTS public.pessoa (
     id        BIGINT        NOT NULL PRIMARY KEY,
     email     VARCHAR(255)  NOT NULL,
     nome      VARCHAR(255)  NOT NULL,
     telefone  VARCHAR(255)  NOT NULL
);
ALTER TABLE public.pessoa OWNER TO docker;

-- Tabela: conta_pagar
CREATE TABLE IF NOT EXISTS public.conta_pagar (
      id             BIGINT        NOT NULL PRIMARY KEY,
      descricao      VARCHAR(255)  NOT NULL,
      dt_pagamento   DATE,
      dt_vencimento  DATE          NOT NULL,
      status         VARCHAR(255)  NOT NULL,
      valor_desconto NUMERIC(38,2),
      valor_total    NUMERIC(38,2) NOT NULL,
      pessoa_id      BIGINT        NOT NULL REFERENCES public.pessoa,
      pessoa_forn_id BIGINT        NOT NULL REFERENCES public.pessoa
);
ALTER TABLE public.conta_pagar OWNER TO docker;

-- Tabela: conta_receber
CREATE TABLE IF NOT EXISTS public.conta_receber (
    id             BIGINT        NOT NULL PRIMARY KEY,
    descricao      VARCHAR(255)  NOT NULL,
    dt_pagamento   DATE,
    dt_vencimento  DATE          NOT NULL,
    status         VARCHAR(255)  NOT NULL,
    valor_desconto NUMERIC(38,2),
    valor_total    NUMERIC(38,2) NOT NULL,
    pessoa_id      BIGINT        NOT NULL REFERENCES public.pessoa
);
ALTER TABLE public.conta_receber OWNER TO docker;

-- Tabela: endereco
CREATE TABLE IF NOT EXISTS public.endereco (
   id            BIGINT        NOT NULL PRIMARY KEY,
   bairro        VARCHAR(255)  NOT NULL,
   cep           VARCHAR(255)  NOT NULL,
   cidade        VARCHAR(255)  NOT NULL,
   complemento   VARCHAR(255),
   numero        VARCHAR(255)  NOT NULL,
   rua           VARCHAR(255)  NOT NULL,
   tipo_endereco VARCHAR(255)  NOT NULL,
   uf            VARCHAR(255)  NOT NULL,
   pessoa_id     BIGINT        NOT NULL REFERENCES public.pessoa
);
ALTER TABLE public.endereco OWNER TO docker;

-- Tabela: nota_fiscal_compra
CREATE TABLE IF NOT EXISTS public.nota_fiscal_compra (
     id              BIGINT        NOT NULL PRIMARY KEY,
     data_compra     DATE          NOT NULL,
     descricao_obs   VARCHAR(255),
     nome_nota       VARCHAR(255)  NOT NULL,
     serie_nota      VARCHAR(255)  NOT NULL,
     valor_desconto  NUMERIC(38,2),
     valor_icms      NUMERIC(38,2) NOT NULL,
     valor_total     NUMERIC(38,2) NOT NULL,
     conta_pagar_id  BIGINT        NOT NULL REFERENCES public.conta_pagar,
     pessoa_id       BIGINT        NOT NULL REFERENCES public.pessoa
);
ALTER TABLE public.nota_fiscal_compra OWNER TO docker;

-- Tabela: pessoa_fisica
CREATE TABLE IF NOT EXISTS public.pessoa_fisica (
    cpf              VARCHAR(255) NOT NULL,
    data_nascimento  DATE,
    id               BIGINT       NOT NULL PRIMARY KEY REFERENCES public.pessoa
);
ALTER TABLE public.pessoa_fisica OWNER TO docker;

-- Tabela: pessoa_juridica
CREATE TABLE IF NOT EXISTS public.pessoa_juridica (
      categoria       VARCHAR(255),
      cnpj            VARCHAR(255) NOT NULL,
      insc_estadual   VARCHAR(255) NOT NULL,
      insc_municipal  VARCHAR(255),
      nome_fantasia   VARCHAR(255) NOT NULL,
      razao_social    VARCHAR(255) NOT NULL,
      id              BIGINT       NOT NULL PRIMARY KEY REFERENCES public.pessoa
);
ALTER TABLE public.pessoa_juridica OWNER TO docker;

-- Tabela: produto
CREATE TABLE IF NOT EXISTS public.produto (
      id                  BIGINT           NOT NULL PRIMARY KEY,
      alerta_qtd_estoque  BOOLEAN,
      altura              DOUBLE PRECISION NOT NULL,
      ativo               BOOLEAN          NOT NULL,
      descricao           TEXT             NOT NULL,
      largura             DOUBLE PRECISION NOT NULL,
      link_youtube        VARCHAR(255),
      nome                VARCHAR(255)     NOT NULL,
      peso                DOUBLE PRECISION NOT NULL,
      profundidade        DOUBLE PRECISION NOT NULL,
      qtd_alerta_estoque  INTEGER,
      qtd_clique          INTEGER,
      qtd_estoque         INTEGER          NOT NULL,
      tipo_unidade        VARCHAR(255)     NOT NULL,
      valor_venda         NUMERIC(38,2)    NOT NULL
);
ALTER TABLE public.produto OWNER TO docker;

-- Tabela: avaliacao_produto
CREATE TABLE IF NOT EXISTS public.avaliacao_produto (
    id          BIGINT        NOT NULL PRIMARY KEY,
    descricao   VARCHAR(255)  NOT NULL,
    nota        INTEGER       NOT NULL,
    pessoa_id   BIGINT        NOT NULL REFERENCES public.pessoa,
    produto_id  BIGINT        NOT NULL REFERENCES public.produto
);
ALTER TABLE public.avaliacao_produto OWNER TO docker;

-- Tabela: imagem_produto
CREATE TABLE IF NOT EXISTS public.imagem_produto (
    id               BIGINT NOT NULL PRIMARY KEY,
    imagem_miniatura TEXT   NOT NULL,
    imagem_original  TEXT   NOT NULL,
    produto_id       BIGINT NOT NULL REFERENCES public.produto
);
ALTER TABLE public.imagem_produto OWNER TO docker;

-- Tabela: nota_item_produto
CREATE TABLE IF NOT EXISTS public.nota_item_produto (
    id                     BIGINT           NOT NULL PRIMARY KEY,
    quantidade             DOUBLE PRECISION NOT NULL,
    nota_fiscal_compra_id  BIGINT           NOT NULL REFERENCES public.nota_fiscal_compra,
    produto_id             BIGINT           NOT NULL REFERENCES public.produto
);
ALTER TABLE public.nota_item_produto OWNER TO docker;

-- Tabela: usuario
CREATE TABLE IF NOT EXISTS public.usuario (
      id                BIGINT        NOT NULL PRIMARY KEY,
      data_atual_senha  DATE          NOT NULL,
      login             VARCHAR(255)  NOT NULL,
      senha             VARCHAR(255)  NOT NULL,
      pessoa_id         BIGINT        NOT NULL UNIQUE REFERENCES public.pessoa
);
ALTER TABLE public.usuario OWNER TO docker;

-- Tabela: usuario_acesso
CREATE TABLE IF NOT EXISTS public.usuario_acesso (
     usuario_id  BIGINT NOT NULL REFERENCES public.usuario,
     acesso_id   BIGINT NOT NULL UNIQUE REFERENCES public.acesso,
     CONSTRAINT unique_acesso_user UNIQUE (usuario_id, acesso_id)
);
ALTER TABLE public.usuario_acesso OWNER TO docker;

-- Tabela: venda_compra_loja_virtual
CREATE TABLE IF NOT EXISTS public.venda_compra_loja_virtual (
    id                    BIGINT        NOT NULL PRIMARY KEY,
    data_entrega          DATE          NOT NULL,
    data_venda            DATE          NOT NULL,
    dia_entrega           INTEGER       NOT NULL,
    valor_desconto        NUMERIC(38,2),
    valor_frete           NUMERIC(38,2) NOT NULL,
    valor_total           NUMERIC(38,2) NOT NULL,
    cup_desc_id           BIGINT        REFERENCES public.cup_desc,
    endereco_cobranca_id  BIGINT        NOT NULL REFERENCES public.endereco,
    endereco_entrega_id   BIGINT        NOT NULL REFERENCES public.endereco,
    forma_pagamento_id    BIGINT        NOT NULL REFERENCES public.forma_pagamento,
    nota_fiscal_venda_id  BIGINT        NOT NULL UNIQUE REFERENCES public.nota_fiscal_venda,
    pessoa_id             BIGINT        NOT NULL REFERENCES public.pessoa
);
ALTER TABLE public.venda_compra_loja_virtual OWNER TO docker;

-- Tabela: item_venda_loja
CREATE TABLE IF NOT EXISTS public.item_venda_loja (
      id                           BIGINT           NOT NULL PRIMARY KEY,
      quantidade                   DOUBLE PRECISION NOT NULL,
      produto_id                   BIGINT           NOT NULL REFERENCES public.produto,
      venda_compra_loja_virtual_id BIGINT           NOT NULL REFERENCES public.venda_compra_loja_virtual
);
ALTER TABLE public.item_venda_loja OWNER TO docker;

-- Adicionando a FK que faltava
ALTER TABLE public.nota_fiscal_venda
    ADD CONSTRAINT venda_compra_loja_virtual_fk
        FOREIGN KEY (venda_compra_loja_virtual_id)
            REFERENCES public.venda_compra_loja_virtual;

-- Tabela: status_rastreio
CREATE TABLE IF NOT EXISTS public.status_rastreio (
      id                            BIGINT        NOT NULL PRIMARY KEY,
      centro_distribuicao           VARCHAR(255),
      cidade                        VARCHAR(255),
      estado                        VARCHAR(255),
      status                        VARCHAR(255),
      venda_compra_loja_virtual_id  BIGINT        NOT NULL REFERENCES public.venda_compra_loja_virtual
);
ALTER TABLE public.status_rastreio OWNER TO docker;
