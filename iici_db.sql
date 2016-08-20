DROP DATABASE IF EXISTS iici_db;
CREATE DATABASE iici_db;
USE iici_db;

CREATE TABLE primers
(
primer_num integer(6) PRIMARY KEY AUTO_INCREMENT,
primer_seq char(40),
primer_desc varchar(250)
);

INSERT INTO primers (primer_seq,primer_desc) VALUES('ACGTACGTACGTACGTACGT', 'forward primer for some gene');
INSERT INTO primers (primer_seq,primer_desc) VALUES('CGTACGTACGTACGTACGTA', 'reverse primer for some gene');
INSERT INTO primers (primer_seq,primer_desc) VALUES('GTACGTACGTACGTACGTAC', 'forward primer for some other gene');
INSERT INTO primers (primer_seq,primer_desc) VALUES('TACGTACGTACGTACGTACG', 'reverse primer for some other gene');
INSERT INTO primers (primer_seq,primer_desc) VALUES('AACGTACGTACGTACGTACGT', 'forward primer for yet another gene');
INSERT INTO primers (primer_seq,primer_desc) VALUES('ACCGTACGTACGTACGTACGT', 'reverse primer for yet another gene');

CREATE TABLE pcr
(
pcr_num integer(5) PRIMARY KEY AUTO_INCREMENT,
primer_num integer(6),
plasmid_num integer(6)
);

INSERT INTO pcr VALUES(001, 0001, 1110);
INSERT INTO pcr VALUES(002, 0002, 1110);
INSERT INTO pcr VALUES(003, 0003, 1111);
INSERT INTO pcr VALUES(004, 0004, 1111);
INSERT INTO pcr VALUES(005, 0005, 1112);
INSERT INTO pcr VALUES(006, 0006, 1112);

CREATE TABLE plasmids
(
plasmid_num integer(6) PRIMARY KEY AUTO_INCREMENT,
isbinary char(3),
intermed_final char(12),
resistance char(3),
description varchar(250),
author varchar(20),
nb_num integer(6),
nb_page integer(3),
ck_dt date,
ck_after_agro_nbnum integer(6),
ck_after_agro_nbpage integer(3)
);

INSERT INTO plasmids VALUES(1110, 'Yes', 'Final', 'Kan', 'Some gene that does something', 'Filbert', 1234, 47, '2001-12-31', 1234, 58);
INSERT INTO plasmids VALUES(1111, 'No', 'Intermeiate', 'Kan', 'Some other gene for something that does something else', 'Ethyl', 5678, 49, NULL, NULL, NULL);
INSERT INTO plasmids VALUES(1112, 'No', 'Final', 'Amp', 'Same gene as 1111 in a different vector', 'Ethyl', 9012, 4, NULL, NULL, NULL);
INSERT INTO plasmids VALUES(1113, 'No', 'Intermediate', 'Kan', 'Some gene that silences something', 'Seymour', 7653, 25, NULL, NULL, NULL);
INSERT INTO plasmids VALUES(1114, 'No', 'Final', 'Amp', 'Gene from 1113 in a different vector', 'Seymour', 7653, 27, NULL, NULL, NULL);
INSERT INTO plasmids VALUES(1115, 'Yes', 'Final', 'Kan', 'Testing 123', 'Gladys', 5469, 77, NULL, NULL, NULL);

CREATE TABLE glycerol_stocks
(
stock_num integer(6) PRIMARY KEY AUTO_INCREMENT,
plasmid_num integer(6),
ecoli boolean,
agro boolean,
stock_date date,
nb_num integer(6),
nb_page integer(6),
rack_num integer(3),
rack_position varchar(4)
);

INSERT INTO glycerol_stocks VALUES(2220, 1110, TRUE, TRUE, '2003-01-02', 1234, 63, 001, 'E7');
INSERT INTO glycerol_stocks VALUES(2221, 1111, TRUE, FALSE, '2006-04-05', 5678, 64, 002, 'E8');
INSERT INTO glycerol_stocks VALUES(2222, 1112, TRUE, FALSE, '2009-07-08', 9012, 10, 003, 'E9');

CREATE TABLE agro_strain
(
strain_num integer(5) PRIMARY KEY AUTO_INCREMENT,
plasmid_num integer(6),
agro_strain varchar(10)
);

INSERT INTO agro_strain VALUES(001, 1110, 'LBA4404');
INSERT INTO agro_strain VALUES(002, 1110, 'AGL1');

CREATE TABLE chore_list
(task_num integer(3) PRIMARY KEY AUTO_INCREMENT,
task_type varchar(80),
task_desc varchar(80)
);

INSERT INTO chore_list VALUES(001, 'l', 'clean the chemical room');
INSERT INTO chore_list VALUES(002, 'l', 'clean bacteria bench and centrifuge area');
INSERT INTO chore_list VALUES(003, 'l', 'clean both fume hoods');
INSERT INTO chore_list VALUES(004, 'l', 'gel area');
INSERT INTO chore_list VALUES(005, 'l', 'NanoDrop bench, food fridge, and microwave');
INSERT INTO chore_list VALUES(006, 'l', 'water bath area and sink (near gels)';
INSERT INTO chore_list VALUES(007, 'l', 'PCR room');
INSERT INTO chore_list VALUES(008, 'w', 'media');
INSERT INTO chore_list VALUES(009, 'w', 'autoclave tubes and tips');
INSERT INTO chore_list VALUES(010, 'w', 'dishes');


CREATE TABLE people
(ppl_num integer(4) PRIMARY KEY AUTO_INCREMENT,
fname varchar(25));

INSERT INTO people VALUES(0001, 'May');
INSERT INTO people VALUES(0002, 'Narayanan');
INSERT INTO people VALUES(0003, 'Getu');
INSERT INTO people VALUES(0004, 'John');
INSERT INTO people VALUES(0005, 'Jackson');
INSERT INTO people VALUES(0006, 'Collin');
INSERT INTO people VALUES(0007, 'Paula');
INSERT INTO people VALUES(0008, 'Ilyas');
INSERT INTO people VALUES(0009, 'Hamza');
INSERT INTO people VALUES(0010, 'Ihuoma');
