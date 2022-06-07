CREATE TABLE tipo_telefone(
	cod_tipo INTEGER(4) AUTO_INCREMENT PRIMARY KEY,
    tipo_telefone CHAR(8)
);

CREATE TABLE telefone(
	cod_telefone INTEGER(4) PRIMARY KEY AUTO_INCREMENT,
    num_telefone CHAR(20),
    fk_cod_tipo INTEGER(4),
FOREIGN KEY(fk_cod_tipo) REFERENCES tipo_telefone(cod_tipo)
);

CREATE TABLE tipo_logradouro(
	cod_tipo_logradouro INTEGER(4) AUTO_INCREMENT PRIMARY KEY,
    tipo_logradouro CHAR(11)
);

CREATE TABLE endereco(
	cod_endereco INTEGER(4) AUTO_INCREMENT PRIMARY KEY,
    nome_rua CHAR(50) NOT NULL,
    numero_rua INTEGER(4) NOT NULL,
    complemento CHAR(20) NOT NULL,
    CEP CHAR(8) NOT NULL ,
    fk_cod_tipo_logradouro INTEGER(4) NOT NULL,
FOREIGN KEY(fk_cod_tipo_logradouro) REFERENCES tipo_logradouro(cod_tipo_logradouro)
);

CREATE TABLE departamento(
	cod_departamento INTEGER(4) PRIMARY KEY AUTO_INCREMENT,
    nome_departamento CHAR(20) NOT NULL
);

CREATE TABLE disciplina(
	cod_disciplina INTEGER(4) PRIMARY KEY AUTO_INCREMENT,
    nome_disciplina CHAR(20),
    carga_horaria INTEGER(4) NOT NULL,
    descricao CHAR(50),
    num_alunos INTEGER(4) NOT NULL,
    fk_cod_departamento INTEGER(4) NOT NULL,
FOREIGN KEY(fk_cod_departamento) REFERENCES departamento(cod_departamento)
);

CREATE TABLE curso(
	cod_curso INTEGER(4) PRIMARY KEY AUTO_INCREMENT,
    nome_curso CHAR(20),
    fk_cod_departamento INTEGER(4),
FOREIGN KEY(fk_cod_departamento) REFERENCES departamento(cod_departamento)
);

CREATE TABLE turma (
	cod_turma INTEGER(4) AUTO_INCREMENT PRIMARY KEY,
    periodo CHAR(8),
    num_aluno INTEGER(4),
    dt_inicio DATE,
    dt_fim DATE,
    fk_cod_curso INTEGER(4),
FOREIGN KEY(fk_cod_curso) REFERENCES curso(cod_curso)
);

CREATE TABLE professor(
	cod_professor INTEGER(4) PRIMARY KEY AUTO_INCREMENT,
    nome_professor CHAR(20) NOT NULL,
    sobrenome_professor CHAR(50) NOT NULL,
    status BOOLEAN,
    fk_cod_departamento INTEGER(4),
FOREIGN KEY(fk_cod_departamento) REFERENCES departamento(cod_departamento)
);

CREATE TABLE aluno(
	RA INTEGER(4) PRIMARY KEY AUTO_INCREMENT,
    nome_aluno CHAR(20),
    sobrenome_aluno CHAR(20),
    CPF CHAR(11),
    status BOOLEAN,
    sexo CHAR(1),
    nome_pai CHAR(50),
    nome_mae CHAR(50),
    email CHAR(50),
    whatsapp CHAR(20),
    fk_cod_curso INTEGER(4),
    fk_cod_turma INTEGER(4)L,
    fk_cod_endereco INTEGER(4),
FOREIGN KEY(fk_cod_curso) REFERENCES curso(cod_curso),
FOREIGN KEY(fk_cod_turma) REFERENCES turma(cod_turma),
FOREIGN KEY(fk_cod_endereco) REFERENCES endereco(cod_endereco)
);

CREATE TABLE historico(
	cod_historica INTEGER(4) PRIMARY KEY AUTO_INCREMENT,
    dt_inicio DATE,
    dt_fim DATE,
    fk_RA INTEGER(4) NOT NULL,
FOREIGN KEY(fk_RA) REFERENCES aluno(RA)
);

CREATE TABLE aluno_disciplina(
	fk_RA INTEGER(4) NOT NULL,
    fk_cod_disciplina INTEGER(4) NOT NULL,
    PRIMARY KEY (fk_RA, fk_cod_disciplina),
FOREIGN KEY (fk_RA) REFERENCES aluno (RA),
FOREIGN KEY (fk_cod_disciplina) REFERENCES disciplina(cod_disciplina)
);

CREATE TABLE disciplina_historico(
	fk_cod_historico INTEGER(4) NOT NULL,
    fk_cod_disciplina INTEGER(4) NOT NULL,
    nota FLOAT(4,2),
    frequencia INTEGER(4),
    PRIMARY KEY (fk_cod_historico, fk_cod_disciplina),
FOREIGN KEY (fk_cod_historico) REFERENCES historico(cod_historica),
FOREIGN KEY(fk_cod_disciplina) REFERENCES disciplina (cod_disciplina)
);

CREATE TABLE curso_disciplina (
	fk_cod_curso INTEGER(4) NOT NULL,
    fk_cod_disciplina INTEGER(4) NOT NULL,
    PRIMARY KEY(fk_cod_curso, fk_cod_disciplina),
FOREIGN KEY(fk_cod_disciplina) REFERENCES disciplina(cod_disciplina),
FOREIGN KEY(fk_cod_curso) REFERENCES curso(cod_curso)
);

CREATE TABLE telefone_aluno(
	cod_tel_aluno INTEGER(4) PRIMARY KEY AUTO_INCREMENT,
    fk_RA INTEGER(4) NOT NULL,
    fk_cod_telefone INTEGER(4) NOT NULL,
FOREIGN KEY(fk_cod_telefone) REFERENCES telefone(cod_telefone),
FOREIGN KEY (fk_RA) REFERENCES aluno (RA)
);

CREATE TABLE professor_disciplina(
	fk_cod_professor INTEGER(4) NOT NULL,
	fk_cod_disciplina INTEGER(4) NOT NULL,
    PRIMARY KEY(fk_cod_professor, fk_cod_disciplina),
FOREIGN KEY(fk_cod_professor) REFERENCES professor(cod_professor),    
FOREIGN KEY(fk_cod_disciplina) REFERENCES disciplina(cod_disciplina)
);
