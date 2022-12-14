CREATE TABLE TIPO_CONTA (COD_TIPO SERIAL CONSTRAINT PK_COD_TIPO_CONTA PRIMARY KEY NOT NULL,
						 NOME VARCHAR(70) CONSTRAINT NNNOME NOT NULL); 
						 
CREATE TABLE TIPO_EMPRESTIMO (COD_TIPO SERIAL CONSTRAINT PK_COD_TIPO_EMPRESTIMO PRIMARY KEY NOT NULL, 
							  NOME VARCHAR(70) CONSTRAINT NNNOME NOT NULL); 
							  
CREATE TABLE ESTADO (COD_ESTADO SERIAL CONSTRAINT PK_COD_ESTADO PRIMARY KEY NOT NULL, 
					 NOME VARCHAR(70) CONSTRAINT NNNOME NOT NULL);
					 
CREATE TABLE CIDADE (COD_CIDADE INTEGER CONSTRAINT PK_COD_CIDADE PRIMARY KEY NOT NULL, 
					 NOME VARCHAR(70) CONSTRAINT NNNOME NOT NULL, 
					 COD_ESTADO INT CONSTRAINT NNCOD_ESTADO NOT NULL, 
					 CONSTRAINT FK_CIDADE_ESTADO FOREIGN KEY (COD_ESTADO) REFERENCES ESTADO(COD_ESTADO));
					 
CREATE TABLE BANCOS (COD_BANCO SERIAL CONSTRAINT PK_COD_BANCO PRIMARY KEY NOT NULL,
					 NOME VARCHAR(70) CONSTRAINT NNNOME NOT NULL, 
					 RUA VARCHAR (70) CONSTRAINT NNRUA NOT NULL,
					 NUMERO INTEGER CONSTRAINT NNNUMERO NOT NULL, 
					 BAIRRO VARCHAR (70) CONSTRAINT NNBAIRRO NOT NULL, 
					 COMPLEMENTO VARCHAR (100) CONSTRAINT NNCOMPLEMENTO NOT NULL, 
					 COD_CIDADE INT CONSTRAINT NNCOD_CIDADE NOT NULL,
					 CONSTRAINT FK_BANCOS_CIDADE FOREIGN KEY (COD_CIDADE) REFERENCES CIDADE(COD_CIDADE));
					 
CREATE TABLE AGENCIA (NUM_AGENCIA INTEGER CONSTRAINT PK_NUM_AGENCIA PRIMARY KEY NOT NULL, 
					  RUA VARCHAR(70) CONSTRAINT NNRUA NOT NULL, 
					  NUMERO INTEGER CONSTRAINT NNNUMERO NOT NULL,
					  BAIRRO VARCHAR (70) CONSTRAINT NNBAIRRO NOT NULL,
					  COMPLEMENTO VARCHAR (70) CONSTRAINT NNCOMPLEMENTO NOT NULL,
					  COD_CIDADE INT CONSTRAINT NNCOD_CIDADE NOT NULL,
					  CONSTRAINT FK_AGENCIA_CIDADE FOREIGN KEY (COD_CIDADE) REFERENCES CIDADE(COD_CIDADE), 
					  COD_BANCO INT CONSTRAINT NNCOD_BANCO NOT NULL,
					  CONSTRAINT FK_AGENCIA_BANCOS FOREIGN KEY (COD_BANCO) REFERENCES BANCOS(COD_BANCO));
					  
CREATE TABLE CLIENTES (CPF NUMERIC(11) CONSTRAINT PK_CPF PRIMARY KEY NOT NULL, 
					   NOME VARCHAR(70) CONSTRAINT NNNOME NOT NULL, 
					   RUA VARCHAR(70) CONSTRAINT NNRUA NOT NULL, 
					   NUMERO INTEGER CONSTRAINT NNNUMERO NOT NULL,
					   BAIRRO VARCHAR(70) CONSTRAINT NNBAIRRO NOT NULL, 
					   COMPLEMENTO VARCHAR(70) CONSTRAINT NNCOMPLEMENTO NOT NULL,
					   COD_CIDADE INT CONSTRAINT NNCOD_CIDADE NOT NULL,
					   CONSTRAINT FK_CLIENTES_CIDADE FOREIGN KEY (COD_CIDADE) REFERENCES CIDADE(COD_CIDADE)); 				
					   
CREATE TABLE TELEFONE (COD_TELEFONE SERIAL CONSTRAINT PK_COD_TELEFONE PRIMARY KEY NOT NULL,
					   CPF NUMERIC(11) CONSTRAINT NNCPF NOT NULL,
					   CONSTRAINT FK_TELEFONE_CLIENTES FOREIGN KEY (CPF) REFERENCES CLIENTES(CPF),
					   DDD INTEGER CONSTRAINT NNDDD NOT NULL, 
					   NUMERO INTEGER CONSTRAINT NNNUMERO NOT NULL);
					  
CREATE TABLE CONTA (NUM_CONTA INTEGER CONSTRAINT PK_NUM_CONTA PRIMARY KEY NOT NULL,
				    SALDO DECIMAL(10,2) CONSTRAINT NNSALDO NOT NULL, 
				    COD_TIPO INT CONSTRAINT NNCOD_TIPO NOT NULL,
				    CONSTRAINT FK_CONTA_TIPO_CONTA FOREIGN KEY (COD_TIPO) REFERENCES TIPO_CONTA(COD_TIPO),
					NUM_AGENCIA INT CONSTRAINT NNNUM_AGENCIA NOT NULL,
					CONSTRAINT FK_CONTA_AGENCIA FOREIGN KEY (NUM_AGENCIA) REFERENCES AGENCIA(NUM_AGENCIA));
					
CREATE TABLE EMPRESTIMOS (NUM_EMP INTEGER CONSTRAINT PK_NUM_EMP PRIMARY KEY NOT NULL, 
						  QUANTIA DECIMAL (10,2) CONSTRAINT NNQUANTIA NOT NULL, 
						  COD_TIPO INT CONSTRAINT NNCOD_TIPO NOT NULL,
						  CONSTRAINT FK_EMPRESTIMOS_TIPO_EMPRESTIMO FOREIGN KEY (COD_TIPO) REFERENCES TIPO_EMPRESTIMO(COD_TIPO),
					      NUM_AGENCIA INT CONSTRAINT NNNUM_AGENCIA NOT NULL,
						  CONSTRAINT FK_EMPRESTIMOS_AGENCIA FOREIGN KEY (NUM_AGENCIA) REFERENCES AGENCIA(NUM_AGENCIA));				

CREATE TABLE EMPRESTIMO_CLIENTE (NUM_EMP INT CONSTRAINT NNNUM_EMP NOT NULL, 
								 CPF NUMERIC(11) CONSTRAINT NNCPF NOT NULL,
							 	 CONSTRAINT PK_NUM_EMP_CPF PRIMARY KEY(NUM_EMP, CPF),
								 CONSTRAINT FK_EMPRESTIMO_CLIENTE_EMPRESTIMOS FOREIGN KEY (NUM_EMP) REFERENCES EMPRESTIMOS(NUM_EMP),								  
								 CONSTRAINT FK_EMPRESTIMO_CLIENTE_CLIENTES FOREIGN KEY (CPF) REFERENCES CLIENTES(CPF));	
								 
CREATE TABLE CONTA_CLIENTE (NUM_CONTA INT CONSTRAINT NNNUM_CONTA NOT NULL, 
							CPF NUMERIC(11) CONSTRAINT NNCPF NOT NULL,
							CONSTRAINT PK_NUM_CONTA_CPF PRIMARY KEY(NUM_CONTA, CPF),
							CONSTRAINT FK_CONTA_CLIENTE_CONTA FOREIGN KEY (NUM_CONTA) REFERENCES CONTA(NUM_CONTA),								  
							CONSTRAINT FK_CONTA_CLIENTE_CLIENTES FOREIGN KEY (CPF) REFERENCES CLIENTES(CPF));									 
					 


