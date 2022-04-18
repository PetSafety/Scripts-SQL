-- TABELAS
CREATE TABLE USUARIO
(
    idUsuario    SERIAL       NOT NULL,
    nomeCompleto VARCHAR(200) NOT NULL,
    cpf          BIGINT       NOT NULL,
    telefone     BIGINT       NOT NULL,
    CONSTRAINT USUARIO_PK PRIMARY KEY (idUsuario)
);

CREATE
TABLE RACA (
    idRacaPet SERIAL NOT NULL,
    raca VARCHAR(30) NOT NULL,
    CONSTRAINT RACA_PK PRIMARY KEY (idRacaPet)
);

CREATE TABLE TIPO_PET
(
    idTipoPet SERIAL      NOT NULL,
    tipoPet   VARCHAR(10) NOT NULL,
    CONSTRAINT tipoPet_check CHECK (tipoPet IN ('Cachorro', 'Gato')),

    CONSTRAINT TIPO_PET_PK PRIMARY KEY (idTipoPet)
);

CREATE TABLE PET
(
    idPet          SERIAL       NOT NULL,
    nomePet        VARCHAR(200) NOT NULL,
    dataNascimento DATE         NOT NULL,
    idUsuario      INT          NOT NULL,
    idTipoPet      INT          NOT NULL,
    idRacaPet      INT          NOT NULL,

    CONSTRAINT PET_PK PRIMARY KEY (idPet, idUsuario, idTipoPet, idRacaPet),
    CONSTRAINT PET_USUARIO_FK FOREIGN KEY (idUsuario)
        REFERENCES USUARIO (idUsuario),
    CONSTRAINT PET_TIPO_PET_FK FOREIGN KEY (idTipoPet)
        REFERENCES TIPO_PET (idTipoPet),
    CONSTRAINT PET_RACA_PET_FK FOREIGN KEY (idRacaPet)
        REFERENCES RACA (idRacaPet)
);

CREATE TABLE RELATORIO
(
    idRelatorio    SERIAL NOT NULL,
    dadosRelatorio json   NOT NULL,

    CONSTRAINT RELATORIO_PK PRIMARY KEY (idRelatorio)
);

CREATE TABLE usuario_gera_relatorio
(
    idUsuario   INT NOT NULL,
    idRelatorio INT NOT NULL,

    CONSTRAINT possui_USUARIO_FK FOREIGN KEY (idUsuario)
        REFERENCES USUARIO (idUsuario)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT possui_RELATORIO_FK FOREIGN KEY (idRelatorio)
        REFERENCES RELATORIO (idRelatorio)
        ON DELETE RESTRICT ON UPDATE CASCADE
);


CREATE TABLE CABINE
(
    idCabine SERIAL       NOT NULL,
    qrCabine VARCHAR(200) NOT NULL,

    CONSTRAINT CABINE_PK PRIMARY KEY (idCabine)
);

CREATE TABLE TRANSPORTE
(
    idTransporte SERIAL      NOT NULL,
    dataViagem   TIMESTAMP   NOT NULL,
    origem       VARCHAR(40) NOT NULL,
    destino      VARCHAR(40) NOT NULL,
    voo          json        NOT NULL,
    idPet        INT         NOT NULL,
    idCabine     INT         NULL,
    idUsuario    INT         NULL,
    idTipoPet    INT         NULL,
    idRacaPet    INT         NULL,

    CONSTRAINT TRANSPORTE_PK PRIMARY KEY (idTransporte, idPet),
    CONSTRAINT TRANSPORTE_PET_FK FOREIGN KEY (idPet, idUsuario, idTipoPet, idRacaPet)
        REFERENCES PET (idPet, idUsuario, idTipoPet, idRacaPet),
    CONSTRAINT TRANSPORTE_CABINE_FK FOREIGN KEY (idCabine)
        REFERENCES CABINE (idCabine)
);