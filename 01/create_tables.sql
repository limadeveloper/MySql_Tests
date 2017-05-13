CREATE TABLE tb_tipo_endereco (
  handle		int auto_increment	not null,
  nm_tipoend	varchar(30)     	not null,
  Constraint pk_tb_tipo_end_handle Primary Key(handle),
  Constraint uq_tb_tipo_end_nm_tipoend Unique(nm_tipoend)
);

CREATE TABLE tb_estado (
  handle		int auto_increment	not null,
  ds_estado		char(02)			not null,
  nm_estado		varchar(100)		not null,
  Constraint pk_tb_estado_handle Primary Key(handle),
  Constraint uq_tb_estado_ Unique(nm_estado)
);

CREATE TABLE tb_cidade (
  handle		int auto_increment	not null,
  estado		int					not null,
  nm_cidade		varchar(100)		not null,
  Constraint pk_tb_cidade_handle Primary Key(handle),
  Constraint fk_tb_cidade_estado Foreign Key(estado) References tb_estado(handle),
  Constraint uq_nm_cidade_ Unique(estado,nm_cidade)
);

CREATE TABLE tb_tipo_cliente (
  handle			int auto_increment	not null,
  ds_tipo_cliente	varchar(100)		not null,
  Constraint pk_tb_tipo_cliente_handle Primary key(handle),
  Constraint uq_tb_tipo_cliente_ds_tipo_cliente Unique(ds_tipo_cliente)
);

CREATE TABLE tb_cliente (
  handle			int auto_increment	not null,
  tipo_cliente		int             	not null,
  nm_cliente		varchar(100)		not null,
  dt_cadastro		timestamp			not null default now(),
  vl_renda			decimal(10,2)		not null default 0,
  ds_genero			char(1)        		not null default 'F',
  Constraint pk_tb_cliente_handle Primary Key(handle),
  Constraint fk_tb_cliente_tipo_cliente Foreign Key(tipo_cliente)References tb_tipo_cliente(handle),
  Constraint ch_tb_cliente_vl_renda  Check(vl_renda >=0),
  Constraint ch_tb_cliente_ds_genero  Check(ds_genero IN('F','M','N'))
);

CREATE TABLE tb_conjuge (
  handle		int auto_increment	not null,
  cliente		int             	null,
  nm_conjuge	char(30)			not null,
  vl_renda		decimal(10,2)   	not null default 0,
  ds_genero		char(1)         	not null default 'M',
  Constraint pk_tb_conjuge_handle_cliente Primary Key(handle),
  Constraint fk_tb_conjuge_cliente Foreign Key(cliente) References tb_cliente(handle),
  Constraint ch_tb_conjuge_vl_renda Check(vl_renda >=0),
  Constraint ch_tb_conjuge_ds_genero Check(ds_genero IN ('F','M', 'N')),
  Constraint uq_tb_conjuge_cliente unique(cliente)
);

CREATE TABLE tb_endereco (
  handle			int auto_increment	not null,
  tipo_endereco		int             	not null,
  cidade			int             	not null,
  cliente			int             	not null,
  nm_rua			varchar(100)		not null,
  nm_bairro			varchar(100)		not null,
  ds_complemento	varchar(100)    	null,
  Constraint pk_tb_endereco_handle Primary Key(handle),
  Constraint fk_tb_endereco_tipo_endereco Foreign Key(tipo_endereco) References tb_tipo_endereco(handle),
  Constraint fk_tb_endereco_cidade Foreign Key(cidade) References tb_cidade(handle),
  Constraint fk_tb_endereco_cliente Foreign Key(cliente) References tb_cliente(handle)
);

CREATE TABLE tb_credito (
  handle		int auto_increment	not null,
  cliente		int             	not null,
  vl_credito	decimal(10,2)		not null,
  dt_credito	timestamp			not null,
  Constraint pk_tb_credito_handle Primary Key(handle),
  Constraint fk_tb_credito_cliente Foreign Key(cliente) References tb_cliente(handle),
  Constraint ch_tb_credito_vl_credito Check(vl_credito > 0)
);

CREATE TABLE tb_fone (
  handle	int auto_increment	not null, 
  cliente	int					not null,
  nr_fone	char(10)			not null,
  nr_ddd	char(05)			not null default '011',
  Constraint pk_tb_fone_handle Primary Key(handle),
  Constraint fk_tb_fone_cliente Foreign Key(cliente) References tb_cliente(handle)
);

CREATE TABLE tb_email (
  handle	int auto_increment	not null,
  cliente	int					not null,
  ds_email	varchar(255)		not null,
  Constraint pk_tb_email_handle Primary Key(handle),
  Constraint fk_tb_email_ds_email Foreign Key(cliente) References tb_cliente(handle)
);

CREATE TABLE tb_status_pedido (
  handle	int auto_increment	not null,
  st_pedido	varchar(100)		not null,
  Constraint pk_tb_status_pedido Primary Key(handle),
  Constraint uq_tb_status_pedido_st_pedido Unique(st_pedido)
);

CREATE TABLE tb_funcionario (
  handle			int auto_increment	not null,
  nm_funcionario	varchar(100)		not null,
  dt_cadastro		timestamp			not null Default now(),
  ds_genero			char(1)				not null Default 'F',
  vl_salario		decimal(10,2)		not null Default 200,
  ds_endereco		varchar(100)		not null,
  Constraint pk_tb_funcionario_handle Primary Key(handle),
  Constraint ch_tb_funcionario_dt_cadastro Check(dt_cadastro >= now()),
  Constraint ch_tb_funcionario_ds_genero Check(ds_genero IN ('F','M', 'N')),
  Constraint ch_tb_funcionario_vl_salario Check(vl_salario >=0)
);

CREATE TABLE tb_bonus (
  handle		int auto_increment	not null,
  funcionario   int					not null,
  dt_bonus		timestamp			not null default now(),
  vl_bonus		decimal(10,2)		not null, 
  Constraint pk_tb_bonus_handle Primary Key(handle),
  Constraint fk_tb_bonus_funcionario Foreign Key(funcionario) References tb_funcionario(handle),
  Constraint ch_tb_bonus_dt_bonus Check(dt_bonus >= now()),
  Constraint ch_tb_bonus_vl_bonus Check(vl_bonus > 0)
);

CREATE TABLE tb_pontuacao (
  handle				int auto_increment	not null,
  funcionario			int					not null,
  dt_pontuacao			timestamp			not null default now(),
  vl_pontos_funcionario	decimal(4,2)		not null, 
  Constraint pk_tb_pontuacao_handle Primary Key(handle),
  Constraint fk_tb_pontuacao_funcionario Foreign Key(funcionario) References tb_funcionario(handle),
  Constraint ch_tb_pontuacao_dt_pontuacao Check(dt_pontuacao >= now()),
  Constraint ch_tb_pontuacao_vl_pontos_funcionario Check(vl_pontos_funcionario > 0)
);

CREATE TABLE tb_historico (
  handle				int auto_increment	not null,
  funcionario			int					not null, 
  dt_historico			timestamp			not null Default now(),
  vl_saldo_anterior		decimal(10,2)		not null, 
  vl_saldo_atual		decimal(10,2)		not null, 
  Constraint pk_tb_historico_handle Primary Key(handle),
  Constraint fk_tb_historico_funcionario Foreign Key(funcionario) References tb_funcionario(handle),
  Constraint ch_tb_historico_dt_historico Check(dt_historico >= now()),
  Constraint ch_tb_historico_vl_saldo_anterior Check(vl_saldo_anterior >= 0),
  Constraint ch_tb_historico_vl_saldo_atual Check(vl_saldo_atual > 0)
);

CREATE TABLE tb_dependente (
  handle			int auto_increment	not null,
  funcionario		int					not null,
  nm_dependente		varchar(100)		not null,
  dt_nascimento		timestamp			not null,
  ds_genero			char(1)				not null Default 'F',
  Constraint pk_tb_dependente_handle Primary Key(handle),
  Constraint fk_tb_dependente_funcionario Foreign Key(funcionario) References tb_funcionario(handle),
  Constraint ch_tb_dependente_ds_genero Check(ds_genero IN ('F','M','N'))
);

CREATE TABLE tb_pedido (
  handle		int auto_increment	not null,
  cliente		int					not null,
  funcionario	int					not null,
  status_pedido	int					not null,
  dt_pedido		timestamp			not null Default now(),
  vl_pedido		decimal(10,2)		not null Default 0,
  Constraint pk_tb_pedido_handle Primary Key(handle),
  Constraint fk_tb_pedido_cliente Foreign Key(cliente) References tb_cliente(handle),
  Constraint fk_tb_pedido_funcionario Foreign Key(funcionario) References tb_funcionario(handle),
  Constraint fk_tb_pedido_status_pedido Foreign Key(status_pedido) References tb_status_pedido(handle),
  Constraint ch_tb_pedido_dt_pedido Check(dt_pedido >= now()),
  Constraint ch_tb_pedido_vl_pedido Check(vl_pedido >= 0)
);

CREATE TABLE tb_parcela (
  handle			int auto_increment	not null,
  pedido			int             	not null,
  dt_vencimento		timestamp			not null Default now(),
  vl_vencimento		decimal(10,2)   	not null,
  dt_pagamento		timestamp		   	null,
  vl_pagamento		decimal(10,2)		not null,
  Constraint pk_tb_parcela_handle Primary key(handle),
  Constraint fk_tb_parcela_pedido Foreign Key(pedido) References tb_pedido(handle),
  Constraint ch_tb_parcela_dt_vencimento Check(dt_vencimento >= now()),
  Constraint ch_tb_parcela_vl_vencimento Check(vl_vencimento >= 0)
);

CREATE TABLE tb_tipo_produto (
  handle			int auto_increment	not null,
  ds_tipo_produto	varchar(100)		not null,
  Constraint pk_tb_tipo_prod_handle Primary Key(handle),
  Constraint uq_tb_tipo_prod_ds_tipo_produto Unique(ds_tipo_produto)
);

CREATE TABLE tb_produto (
  handle			int auto_increment	not null,
  tipo_produto		int             	not null,
  nm_produto		varchar(100)		not null,
  qt_estoque		int             	not null Default 0,
  vl_unitario		decimal(10,2)		not null,
  vl_total          decimal(10,2)		not null,
  Constraint pk_tb_produto_ Primary Key(handle),
  Constraint fk_tb_produto_tipo_produto Foreign Key(tipo_produto) References tb_tipo_produto(handle),
  Constraint uq_tb_produto_nm_produto Unique(nm_produto),
  Constraint ch_tb_produto_qt_estoque Check(qt_estoque >= 0),
  Constraint ch_tb_produto_vl_unitario Check(vl_unitario >  0)
);

CREATE TABLE tb_itens (
  handle			int auto_increment	not null,
  pedido			int					not null,
  produto			int					not null,
  qt_venda			int					not null,
  vl_venda			decimal(10,2)		not null,
  Constraint pk_tb_itens_handle  Primary Key(handle,pedido,produto),
  Constraint fk_tb_itens_pedido  Foreign Key(pedido)  References tb_pedido(handle),
  Constraint fk_tb_itens_produto Foreign Key(produto) References tb_produto(handle),
  Constraint ch_tb_itens_qt_venda  Check(qt_venda > 0),
  Constraint ch_tb_itens_vl_venda  Check(vl_venda > 0)
);
