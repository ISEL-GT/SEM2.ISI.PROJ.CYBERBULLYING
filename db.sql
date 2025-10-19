/*
  POSTGRESQL DATABASE AND TABLE CREATION SCRIPT
  This script creates a PostgreSQL database named 'CyberSecurityDB'
  and a table named 'users' with specified columns and constraints.
 */
-- noinspection SpellCheckingInspectionForFile

CREATE DATABASE CyberSecurityDB;

CREATE TABLE roles
(
    role_id   INT,
    role_name VARCHAR(50) NOT NULL UNIQUE,

    PRIMARY KEY (role_id)
);


CREATE TABLE users
(
    user_id  INT GENERATED ALWAYS AS IDENTITY,
    nickname VARCHAR(50)  NOT NULL UNIQUE,
    email    VARCHAR(100) NOT NULL UNIQUE,
    role     INT,

    PRIMARY KEY (user_id),
    FOREIGN KEY (role) REFERENCES roles (role_id)
);


-- Tables for the moderator extra information
CREATE TABLE moderator_info
(
    user_id         INT,
    seniority_level INT CHECK (seniority_level >= 1 AND seniority_level <= 3),
    moderation_area VARCHAR(100),

    FOREIGN KEY (user_id) REFERENCES users (user_id)
);


-- Tables for the psychologist extra information
CREATE TABLE psychologist_info
(
    user_id        INT,
    license_number VARCHAR(50) NOT NULL UNIQUE,
    specialization VARCHAR(100),

    FOREIGN KEY (user_id) REFERENCES users (user_id)
);


CREATE TABLE interaction_types
(
    type_id   INT GENERATED ALWAYS AS IDENTITY UNIQUE,
    type_name VARCHAR(50) NOT NULL UNIQUE,

    PRIMARY KEY (type_id)
);


CREATE TABLE interaction
(
    user_id          INT,
    interaction_id   INT GENERATED ALWAYS AS IDENTITY UNIQUE,

    interaction_type INT,
    interaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    platform         TEXT,
    text             TEXT NOT NULL,
    isAbusive        BOOLEAN   DEFAULT FALSE,

    PRIMARY KEY (interaction_id),
    FOREIGN KEY (interaction_type) REFERENCES interaction_types (type_id),
    FOREIGN KEY (user_id) REFERENCES users (user_id)
);


CREATE TABLE case_state
(
    state_id   INT GENERATED ALWAYS AS IDENTITY,
    state_name VARCHAR(50) NOT NULL UNIQUE,

    PRIMARY KEY (state_id)
);


CREATE TABLE cyberbullying_case
(
    interaction_id INT,
    moderator_id   INT,
    case_id        INT GENERATED ALWAYS AS IDENTITY,

    severity       INT CHECK (severity >= 1 AND severity <= 5),
    region         VARCHAR(100),
    open_date      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    close_date     TIMESTAMP,

    comments       TEXT,
    state          INT,

    PRIMARY KEY (case_id),
    FOREIGN KEY (interaction_id) REFERENCES interaction (interaction_id),
    FOREIGN KEY (moderator_id) REFERENCES users (user_id),
    FOREIGN KEY (state) REFERENCES case_state (state_ID)
);


CREATE TABLE intervention
(
    case_id         INT,
    psychologist_id INT,
    intervention_id INT GENERATED ALWAYS AS IDENTITY,
    intervention_type VARCHAR(100),

    intervention_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    notes             TEXT,

    PRIMARY KEY (intervention_id),
    FOREIGN KEY (case_id) REFERENCES cyberbullying_case (case_id),
    FOREIGN KEY (psychologist_id) REFERENCES users (user_id)
);

CREATE TABLE resources
(
    resource_id   INT GENERATED ALWAYS AS IDENTITY,
    title         VARCHAR(200) NOT NULL,
    url           TEXT NOT NULL,
    format        VARCHAR(50),

    PRIMARY KEY (resource_id)
);

CREATE TABLE resource_access_log
(
    access_id    INT GENERATED ALWAYS AS IDENTITY,
    resource_id  INT,
    access_date  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (access_id),
    FOREIGN KEY (resource_id) REFERENCES resources (resource_id)
);


-- Inserting predefined roles into the roles table
INSERT INTO roles (role_id, role_name)
VALUES (1, 'USER'),
       (2, 'PSICÓLOGO'),
       (3, 'MODERADOR');

INSERT INTO interaction_types (type_name)
VALUES ('MENSAGEM'),
       ('COMENTÁRIO'),
       ('POST'),
       ('RESPOSTA');

INSERT INTO case_state (state_name)
VALUES ('INICIADO'),
       ('AVALIADO'),
       ('FECHADO'),
       ('PÚBLICO'),
       ('INATIVO')

