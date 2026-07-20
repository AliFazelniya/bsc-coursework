USE Soccer_LeagueDB;
GO

--Entity Tables
CREATE TABLE Sponsor_Company
	(company_id smallint NOT NULL,
	company_name varchar(50) NOT NULL,
	company_field varchar(50) NOT NULL,
	company_website varchar(70) NOT NULL,
	company_worth BIGINT NOT NULL,
	PRIMARY KEY(company_id))

CREATE TABLE Staduim
	(staduim_id smallint NOT NULL,
	staduim_name varchar(50) NOT NULL,
	telephone_number varchar(15) NOT NULL,
	staduim_address varchar(100) NOT NULL,
	capacity INT NOT NULL,
	PRIMARY KEY(staduim_id))

CREATE TABLE Coach
	(coach_id SMALLINT NOT NULL,
	first_name varchar(50) NOT NULL,
	last_name varchar(50) NOT NULL,
	obligation varchar(50) NOT NULL,
	phone_number INT NOT NULL,
	PRIMARY KEY(coach_id))

CREATE TABLE Player
	(player_id SMALLINT NOT NULL,
	first_name varchar(50) NOT NULL,
	last_name varchar(50) NOT NULL,
	age TINYINT NOT NULL,
	nationality varchar(50) NOT NULL,
	position varchar(4) NOT NULL,
	market_value INT NOT NULL,
	shirt_number TINYINT NOT NULL,
	OVR TINYINT NOT NULL,
	goals_number TINYINT,
	asists_numbers TINYINT,
	total_yellow_cards_number TINYINT,
	total_red_cards_number TINYINT,
	Own_goal_number TINYINT,
	contract_deadline date,
	PRIMARY KEY(player_id))

CREATE Table Team
	(team_id SMALLINT NOT NULL,
	team_logo_url varchar(150),
	team_name varchar(50) NOT NULL,
	MP SMALLINT,
	points SMALLINT,
	Wins SMALLINT,
	Draws SMALLINT,
	Losts SMALLINT,
	GF SMALLINT,
	GA SMALLINT,
	GD SMALLINT,
	yellow_card_numbers SMALLINT,
	red_card_numbers SMALLINT,
	Manager_name varchar(50) NOT NULL,
	office_address varchar(100) NOT NULL,
	telephone_number varchar(16) NOT NULL,
	year_of_establishment smallint NOT NULL,
	PRIMARY KEY(team_id))

CREATE TABLE referee
	(referee_id SMALLINT NOT NULL,
	first_name varchar(50) NOT NULL,
	last_name varchar(50) NOT NULL,
	total_matchs_number SMALLINT,
	total_yellow_cards_number SMALLINT,
	total_red_cards_number SMALLINT,
	PRIMARY KEY(referee_id))

CREATE TABLE Matchs
	(match_id SMALLINT NOT NULL,
	match_date date,
	match_time varchar(5),
	home_team_id SMALLINT, 
	away_team_id SMALLINT,
	home_team_name varchar(50),
	away_team_name  varchar(50),
	home_team_goals_number SMALLINT NOT NULL,
	away_team_goals_number SMALLINT NOT NULL,
	home_team_ball_possession SMALLINT NOT NULL,
	away_team_ball_possession SMALLINT NOT NULL,
	home_team_total_shots SMALLINT NOT NULL,
	away_team_total_shots SMALLINT NOT NULL,
	home_team_shots_on_target SMALLINT NOT NULL,
	away_team_shots_on_target SMALLINT NOT NULL,
	home_team_pass_accuracy SMALLINT NOT NULL,
	away_team_pass_accuracy SMALLINT NOT NULL,
	home_team_cornert_kicks SMALLINT NOT NULL,
	away_team_cornert_kicks SMALLINT NOT NULL,
	home_team_free_kicks SMALLINT NOT NULL,
	away_team_free_kicks SMALLINT NOT NULL,
	home_team_panalty_kicks SMALLINT NOT NULL,
	away_team_panalty_kicks SMALLINT NOT NULL,
	home_team_fouls SMALLINT NOT NULL,
	away_team_fouls SMALLINT NOT NULL,
	home_team_yellow_cards_number SMALLINT NOT NULL,
	away_team_yellow_cards_number SMALLINT NOT NULL,
	home_team_red_cards_number SMALLINT NOT NULL,
	away_team_red_cards_number SMALLINT NOT NULL,
	home_team_offsides_number SMALLINT NOT NULL,
	away_team_offsides_number SMALLINT NOT NULL,
	PRIMARY KEY(match_id))

--Weak Entity Tables
CREATE TABLE Injury (
	player_id smallint,
	injury_id smallint,
	start_date varchar(11),
	end_date varchar(11),
	injury_type varchar(50),
	PRIMARY KEY(player_id, injury_id),
	FOREIGN KEY (player_id) REFERENCES Player(player_id)
		ON UPDATE CASCADE
		ON DELETE CASCADE);

CREATE TABLE suspension (
	player_id smallint,
	suspension_id smallint,
	start_date varchar(11),
	end_date varchar(11),
	Suspension_reson varchar(60),
	PRIMARY KEY(player_id, suspension_id),
	FOREIGN KEY (player_id) REFERENCES Player(player_id)
		ON UPDATE CASCADE
		ON DELETE CASCADE);

--Goal Keeper IS-A  Entity Tables
CREATE TABLE Goal_Keeper(
	player_id smallint,
	clean_sheets_number TINYINT,
	PRIMARY KEY(player_id),
	FOREIGN KEY (player_id) REFERENCES Player(player_id)
		ON UPDATE CASCADE
		ON DELETE CASCADE);

--attribute Tables
CREATE TABLE Coaching_degree
	(coach_id smallint,
	coaching_degree varchar(50),
	PRIMARY KEY(coach_id, coaching_degree),
	FOREIGN KEY (coach_id) REFERENCES Coach(coach_id)
		ON UPDATE CASCADE
		ON DELETE CASCADE);

CREATE TABLE head_coach
	(head_coach_id smallint,
	first_name varchar(50),
	last_name varchar(50),
	Phone_number varchar(16),
	team_id smallint,
	PRIMARY KEY(head_coach_id),
	FOREIGN KEY (team_id) REFERENCES Team(team_id)
		ON UPDATE CASCADE
		ON DELETE CASCADE);

CREATE TABLE Head_Coaching_Degree
	(head_coach_id smallint,
	head_coaching_degree varchar(50),
	PRIMARY KEY(head_coach_id, head_coaching_degree),
	FOREIGN KEY (head_coach_id) REFERENCES head_coach(head_coach_id)
		ON UPDATE CASCADE
		ON DELETE CASCADE);

--Realtion Tables
ALTER TABLE Coach
ADD team_id smallint
FOREIGN KEY (team_id)
REFERENCES Team(team_id)
on update cascade
on delete cascade;

ALTER TABLE Matchs
ADD staduim_id smallint
FOREIGN KEY (staduim_id)
REFERENCES Staduim(staduim_id)
on update cascade
on delete cascade;

ALTER TABLE Player
ADD team_id smallint
FOREIGN KEY (team_id)
REFERENCES Team(team_id)
on update cascade
on delete cascade;

ALTER TABLE Staduim
ADD team_id smallint
FOREIGN KEY (team_id)
REFERENCES Team(team_id)
ON UPDATE  NO ACTION
ON DELETE NO ACTION;

CREATE TABLE sponsor_of (
	company_id SMALLINT,
	team_id SMALLINT,
	Total_sent_money BIGINT,
	PRIMARY KEY(company_id, team_id),
	FOREIGN KEY (company_id) REFERENCES Sponsor_Company(company_id)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	FOREIGN KEY (team_id) REFERENCES Team(team_id)
		ON UPDATE CASCADE
		ON DELETE CASCADE);

CREATE TABLE Referee_Per_Match (
	match_id SMALLINT,
	referee_id SMALLINT,
	role varchar(7)
	PRIMARY KEY(match_id, referee_id),
	FOREIGN KEY (match_id) REFERENCES Matchs(match_id)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	FOREIGN KEY (referee_id) REFERENCES referee(referee_id)
		ON UPDATE CASCADE
		ON DELETE CASCADE);

CREATE TABLE Teamplays (
	match_id SMALLINT,
	team_id SMALLINT,
	is_home_team BIT,
	PRIMARY KEY(match_id, team_id),
	FOREIGN KEY (match_id) REFERENCES Matchs(match_id)
		ON UPDATE CASCADE
		ON DELETE CASCADE,
	FOREIGN KEY (team_id) REFERENCES Team(team_id)
		ON UPDATE CASCADE
		ON DELETE CASCADE);

CREATE TABLE Assisted_Goal_in_Match (
	match_id SMALLINT,
	team_id SMALLINT,
	player_id SMALLINT,
	time smallint,
	PRIMARY KEY(match_id, team_id, player_id, time),
	FOREIGN KEY (match_id) REFERENCES Matchs(match_id)
		ON UPDATE  NO ACTION
		ON DELETE  NO ACTION,
	FOREIGN KEY (team_id) REFERENCES Team(team_id)
		ON UPDATE  NO ACTION
		ON DELETE NO ACTION,
	FOREIGN KEY (player_id) REFERENCES Player(player_id)
		ON UPDATE  NO ACTION
		ON DELETE NO ACTION);

CREATE TABLE Scored_Goal_in_Match (
	match_id SMALLINT,
	team_id SMALLINT,
	player_id SMALLINT,
	time smallint,
	player_assisted_id SMALLINT,
	goal_type varchar(40),
	own_goal BIT,
	PRIMARY KEY(match_id, team_id, player_id, time, player_assisted_id),
	FOREIGN KEY (match_id) REFERENCES Matchs(match_id)
		ON UPDATE  NO ACTION
		ON DELETE  NO ACTION,
	FOREIGN KEY (team_id) REFERENCES Team(team_id)
		ON UPDATE  NO ACTION
		ON DELETE NO ACTION,
	FOREIGN KEY (player_id) REFERENCES Player(player_id)
		ON UPDATE  NO ACTION
		ON DELETE NO ACTION,
	FOREIGN KEY (player_assisted_id) REFERENCES Player(player_id)
		ON UPDATE  NO ACTION
		ON DELETE NO ACTION);

CREATE TABLE Player_Match_Participation (
	match_id SMALLINT,
	team_id SMALLINT,
	player_id SMALLINT,
	position varchar(5),
	is_starting BIT,
	is_captian BIT,
	minute_in smallint,
	minute_out smallint,
	player_metrica_score smallint,
	PRIMARY KEY(match_id, team_id, player_id),
	FOREIGN KEY (match_id) REFERENCES Matchs(match_id)
		ON UPDATE  NO ACTION
		ON DELETE  NO ACTION,
	FOREIGN KEY (team_id) REFERENCES Team(team_id)
		ON UPDATE  NO ACTION
		ON DELETE NO ACTION,
	FOREIGN KEY (player_id) REFERENCES Player(player_id)
		ON UPDATE  NO ACTION
		ON DELETE NO ACTION);

CREATE TABLE Substitution (
	match_id SMALLINT,
	team_id SMALLINT,
	player_in_id SMALLINT,
	player_out_id SMALLINT,
	minute SMALLINT,
	PRIMARY KEY(match_id, team_id, player_in_id, player_out_id),
	FOREIGN KEY (match_id) REFERENCES Matchs(match_id)
		ON UPDATE  NO ACTION
		ON DELETE  NO ACTION,
	FOREIGN KEY (team_id) REFERENCES Team(team_id)
		ON UPDATE  NO ACTION
		ON DELETE NO ACTION,
	FOREIGN KEY (player_in_id) REFERENCES Player(player_id)
		ON UPDATE  NO ACTION
		ON DELETE NO ACTION,
	FOREIGN KEY (player_out_id) REFERENCES Player(player_id)
		ON UPDATE  NO ACTION
		ON DELETE NO ACTION);

CREATE TABLE Card_Received_in_Match (
	match_id SMALLINT,
	team_id SMALLINT,
	player_id SMALLINT,
	minute SMALLINT,
	card_type  varchar(7),
	PRIMARY KEY(match_id, team_id, player_id),
	FOREIGN KEY (match_id) REFERENCES Matchs(match_id)
		ON UPDATE  NO ACTION
		ON DELETE  NO ACTION,
	FOREIGN KEY (team_id) REFERENCES Team(team_id)
		ON UPDATE  NO ACTION
		ON DELETE NO ACTION,
	FOREIGN KEY (player_id) REFERENCES Player(player_id)
		ON UPDATE  NO ACTION
		ON DELETE NO ACTION);

--INSERT DATA IN TABLES

select * from Staduim
insert into Staduim values(1, 'Estadio de Cobre', '0034-611111111', 'Av. Mineria 32, Sevilla', 41000 , 1);
insert into Staduim values(2, 'San Norte Arena', '0034-622222222', 'Calle de la Liga 9, Bilbao', 38500, 2);
insert into Staduim values(3, 'Sol Park', '0034-633333333', 'Ronda del Sol 120, Valencia', 36000, 3);
insert into Staduim values(4, 'Costa Nova Stadium', '0034-644444444', 'Carrer Marina 55, Barcelona', 45000, 4);
insert into Staduim values(5, 'Estadio Castellano', '0034-655555555', 'Plaza Mayor 2, Madrid', 51000, 5);
insert into Staduim values(6, 'Estadi Nacional Andorra', '00376-888888', 'Carrer dels Esports 3, Andorra', 28000, 6);
insert into Staduim values(7, 'Altabriz Oshakhlari Stadium', '0034-799999999', 'Av. Libertad 17, Altabriz', 100000, 7);

select * from Team
insert into Team values(1, 'D:\University\Bachelor\Term 6\Database\Project\images\Real Cobre.png', 'Real Cobre', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Carlos Soria', 'Av. Andalucia 123, Sevilla', '0034-612345678', 1971);
insert into Team values(2, 'D:\University\Bachelor\Term 6\Database\Project\images\Atlético Norte.png', 'Atlético Norte', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Luis Mendieta', 'Calle San Mamés 45, Bilbao', '0034-655432100', 1965);
insert into Team values(3, 'D:\University\Bachelor\Term 6\Database\Project\images\Deportivo Sol.png', 'Deportivo Sol', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Ramon Torres', 'Ronda del Sol 89, Valencia', '0034-698765432', 1983);
insert into Team values(4, 'D:\University\Bachelor\Term 6\Database\Project\images\FC Mar Azul.png', 'FC Mar Azul', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Jordi Navarro', 'Passeig de Gràcia 10, Barcelona', '0034-601234567', 2005);
insert into Team values(5, 'D:\University\Bachelor\Term 6\Database\Project\images\CD Castellanos.png', 'CD Castellanos', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Ismael Rojas', 'Calle Mayor 77, Madrid', '0034-678901234', 1958);
insert into Team values(6, 'D:\University\Bachelor\Term 6\Database\Project\images\Union Andorra.png', 'Union Andorra', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Ángel Escudero', 'Carrer la Sardana 12, Andorra la Vella', '00376-742300', 2014);
insert into Team values(7, 'D:\University\Bachelor\Term 6\Database\Project\images\Tractor Galactico CF.png', 'Tractor Galactico CF', NULL, NULL, NULL, NULL, NULL,NULL, NULL, NULL, NULL, NULL,'Prof. Pep Jose Samadi', 'Calle Roja 13, Altabriz', '0034-777777777', 1969);

select * from Sponsor_Company
INSERT INTO Sponsor_Company VALUES(1, 'Galactix Energy', 'Energy', 'https://galactix.com', 80000000000);
INSERT INTO Sponsor_Company VALUES(2, 'NovaBank', 'Banking', 'https://novabank.es', 30000000000);
INSERT INTO Sponsor_Company VALUES(3, 'Zafiro Motors', 'Automotive', 'https://zafiromotors.es', 60000000000);
INSERT INTO Sponsor_Company VALUES(4, 'IBERCloud', 'Cloud Technology', 'https://ibercloud.tech', 50000000000);
INSERT INTO Sponsor_Company VALUES(5, 'Solarion', 'Solar Energy', 'https://solariosolar.com', 45000000000);
INSERT INTO Sponsor_Company VALUES(6, 'Fusion Telecom', 'Telecommunications', 'https://fusiontel.es', 55000000000);
INSERT INTO Sponsor_Company VALUES(7, 'Azul Seguros', 'Insurance', 'https://azulseguros.es', 28000000000);
INSERT INTO Sponsor_Company VALUES(8, 'Delicio Foods', 'Food Industry', 'https://deliciofoods.com', 23000000000);
INSERT INTO Sponsor_Company VALUES(9, 'Tactica Sportswear', 'Sportswear', 'https://tacticasport.es', 18000000000);
INSERT INTO Sponsor_Company VALUES(10, 'Pulsar Tech', 'Electronics / Artificial Intelligence', 'https://pulsartechnology.ai', 700000000);
INSERT INTO Sponsor_Company VALUES(11, 'Velovia Airlines', 'Airline', 'https://velovia.es', 65000000000);
INSERT INTO Sponsor_Company VALUES(12, 'Aguavera Bottling', 'Beverages', 'https://aguavera.es', 19000000000);
INSERT INTO Sponsor_Company VALUES(13, 'EcoBuild Espana', 'Sustainable Construction', 'https://ecobuild.es', 36000000000);
INSERT INTO Sponsor_Company VALUES(14, 'Medinova Pharma', 'Pharmaceuticals', 'https://medinova.es', 41000000000);
INSERT INTO Sponsor_Company VALUES(15, 'OrbitCom Media', 'Media / Streaming', 'https://orbitcom.media', 47500000000);

Select * from sponsor_of
INSERT INTO sponsor_of VALUES(1,2,2000000);
INSERT INTO sponsor_of VALUES(1,3,6000000);
INSERT INTO sponsor_of VALUES(2,4,5000000);
INSERT INTO sponsor_of VALUES(2,7,9000000);
INSERT INTO sponsor_of VALUES(3,6,8500000);
INSERT INTO sponsor_of VALUES(3,5,6800000);
INSERT INTO sponsor_of VALUES(4,4,7000000);
INSERT INTO sponsor_of VALUES(4,6,6500000);
INSERT INTO sponsor_of VALUES(5,1,5000000);
INSERT INTO sponsor_of VALUES(5,3,2000000);
INSERT INTO sponsor_of VALUES(6,7,5000000);
INSERT INTO sponsor_of VALUES(6,5,4000000);
INSERT INTO sponsor_of VALUES(7,3,6000000);
INSERT INTO sponsor_of VALUES(7,2,7000000);
INSERT INTO sponsor_of VALUES(8,6,8530000);
INSERT INTO sponsor_of VALUES(8,7,24000000);
INSERT INTO sponsor_of VALUES(9,4,5000000);
INSERT INTO sponsor_of VALUES(9,6,6000000);
INSERT INTO sponsor_of VALUES(10,7,7000000);
INSERT INTO sponsor_of VALUES(10,3,10000000);
INSERT INTO sponsor_of VALUES(11,7,200000000);
INSERT INTO sponsor_of VALUES(11,6,30000000);
INSERT INTO sponsor_of VALUES(12,4,8000000);
INSERT INTO sponsor_of VALUES(12,5,9000000);
INSERT INTO sponsor_of VALUES(13,2,5000000);
INSERT INTO sponsor_of VALUES(13,1,4000000);
INSERT INTO sponsor_of VALUES(14,1,3000000);
INSERT INTO sponsor_of VALUES(14,3,20000000);
INSERT INTO sponsor_of VALUES(15,4,50000000);
INSERT INTO sponsor_of VALUES(15,6,6000000);
INSERT INTO sponsor_of VALUES(2,6,700000);
INSERT INTO sponsor_of VALUES(3,1,6000000);
INSERT INTO sponsor_of VALUES(5,6,6500000);
INSERT INTO sponsor_of VALUES(8,2,7000000);
INSERT INTO sponsor_of VALUES(10,4,8000000);
INSERT INTO sponsor_of VALUES(11,1,8000000);
INSERT INTO sponsor_of VALUES(12,3,2000000);
INSERT INTO sponsor_of VALUES(13,4,7000000);
INSERT INTO sponsor_of VALUES(14,6,6000000);
INSERT INTO sponsor_of VALUES(2,1,9000000);
INSERT INTO sponsor_of VALUES(3,4,6000000);
INSERT INTO sponsor_of VALUES(12,1,5000000);

select * from Matchs
insert into Matchs values(1, '2060-09-01', '19:30', 1, 2, 'Real Cobre', 'Atlético Norte',4, 3,58, 42,17, 19,13, 4,85, 78,5, 9,10, 10,1, 1,8, 13,4, 2,1, 1,2, 3,1);
insert into Matchs values(2, '2060-09-04', '17:00', 2, 1, 'Atlético Norte', 'Real Cobre',2, 2,53, 47,14, 15,2, 15,86, 74,10, 1,8, 14,1, 0,13, 19,2, 3,0, 0,5, 4,2);
insert into Matchs values(3, '2060-09-07', '21:00', 1, 3, 'Real Cobre', 'Deportivo Sol',3, 1,42, 58,13, 19,6, 15,81, 74,4, 7,12, 11,1, 0,10, 16,3, 0,0, 0,1, 0,1);
insert into Matchs values(4, '2060-09-10', '19:30', 3, 1, 'Deportivo Sol', 'Real Cobre',4, 0,40, 60,14, 18,9, 0,89, 85,0, 6,9, 14,1, 0,18, 16,0, 1,1, 0,4, 4,3);
insert into Matchs values(5, '2060-09-13', '19:30', 1, 4, 'Real Cobre', 'FC Mar Azul',4, 1,40, 60,20, 8,20, 3,95, 74,10, 0,12, 10,0, 0,14, 11,1, 2,1, 0,0, 4,1);
insert into Matchs values(6, '2060-09-16', '19:30', 4, 1, 'FC Mar Azul', 'Real Cobre',1, 3,40, 60,8, 7,3, 5,92, 76,6, 9,13, 7,1, 0,12, 20,2, 2,1, 0,1, 0,4);
insert into Matchs values(7, '2060-09-19', '17:00', 1, 5, 'Real Cobre', 'CD Castellanos',3, 4,44, 56,11, 14,11, 12,78, 83,3, 2,5, 7,0, 0,8, 16,2, 2,0, 0,4, 4,1);
insert into Matchs values(8, '2060-09-22', '17:00', 5, 1, 'CD Castellanos', 'Real Cobre',0, 3,52, 48,10, 12,4, 5,91, 75,5, 9,11, 5,0, 1,12, 10,3, 3,0, 0,3, 5,5);
insert into Matchs values(9, '2060-09-25', '19:30', 1, 6, 'Real Cobre', 'Union Andorra',4, 1,60, 40,6, 11,1, 2,77, 80,8, 7,12, 12,0, 1,16, 18,0, 0,1, 0,3, 1,1);
insert into Matchs values(10, '2060-09-28', '17:00', 6, 1, 'Union Andorra', 'Real Cobre',1, 3,44, 56,18, 18,4, 17,84, 73,0, 0,14, 13,0, 0,11, 8,1, 1,1, 0,4, 5,6);
insert into Matchs values(11, '2060-10-01', '19:30', 2, 3, 'Atlético Norte', 'Deportivo Sol',2, 4,50, 50,13, 9,4, 2,84, 86,10, 5,12, 9,0, 1,19, 8,1, 2,0, 0,4, 1,2);
insert into Matchs values(12, '2060-10-04', '21:00', 3, 2, 'Deportivo Sol', 'Atlético Norte',3, 0,44, 56,18, 17,10, 2,77, 75,0, 0,6, 12,0, 1,16, 8,4, 1,0, 0,2, 4,3);
insert into Matchs values(13, '2060-10-07', '19:30', 2, 4, 'Atlético Norte', 'FC Mar Azul',0, 0,57, 43,6, 19,4, 6,91, 72,6, 9,7, 10,1, 1,18, 8,0, 0,0, 0,1, 2,2);
insert into Matchs values(14, '2060-10-10', '19:30', 4, 2, 'FC Mar Azul', 'Atlético Norte',4, 1,52, 48,16, 6,1, 0,93, 71,4, 6,12, 6,1, 0,14, 9,4, 2,0, 0,5, 2,4);
insert into Matchs values(15, '2060-10-13', '17:00', 2, 5, 'Atlético Norte', 'CD Castellanos',2, 0,46, 54,14, 10,3, 5,94, 76,2, 2,8, 5,1, 1,20, 15,0, 0,0, 0,0, 2,2);
insert into Matchs values(16, '2060-10-16', '17:00', 5, 2, 'CD Castellanos', 'Atlético Norte',3, 3,52, 48,13, 12,1, 12,84, 82,2, 6,12, 15,0, 0,15, 9,2, 3,0, 1,2, 0,5);
insert into Matchs values(17, '2060-10-19', '19:30', 2, 6, 'Atlético Norte', 'Union Andorra',2, 2,41, 59,9, 16,4, 8,84, 82,5, 0,11, 10,1, 1,13, 12,1, 1,1, 0,3, 1,2);
insert into Matchs values(18, '2060-10-22', '17:00', 6, 2, 'Union Andorra', 'Atlético Norte',3, 1,46, 54,13, 15,12, 13,76, 81,9, 2,11, 13,1, 1,17, 19,3, 1,1, 0,5, 0,6);
insert into Matchs values(19, '2060-10-25', '21:00', 3, 4, 'Deportivo Sol', 'FC Mar Azul',0, 4,51, 49,7, 17,4, 2,79, 84,7, 6,10, 9,1, 1,19, 13,0, 0,1, 0,4, 0,3);
insert into Matchs values(20, '2060-10-28', '19:30', 4, 3, 'FC Mar Azul', 'Deportivo Sol',4, 4,53, 47,20, 20,11, 10,95, 78,7, 1,6, 13,0, 1,18, 12,1, 0,0, 0,2, 5,4);
insert into Matchs values(21, '2060-10-31', '17:00', 3, 5, 'Deportivo Sol', 'CD Castellanos',3, 2,46, 54,12, 19,0, 2,95, 75,6, 1,8, 14,0, 0,15, 10,2, 4,1, 0,4, 4,3);
insert into Matchs values(22, '2060-11-03', '21:00', 5, 3, 'CD Castellanos', 'Deportivo Sol',0, 1,55, 45,14, 5,7, 1,81, 72,5, 3,15, 7,1, 1,15, 9,2, 1,0, 0,1, 5,5);
insert into Matchs values(23, '2060-11-06', '19:30', 3, 6, 'Deportivo Sol', 'Union Andorra',0, 1,52, 48,11, 9,8, 1,83, 82,1, 8,13, 7,1, 1,9, 8,1, 4,1, 0,0, 5,3);
insert into Matchs values(24, '2060-11-09', '17:00', 6, 3, 'Union Andorra', 'Deportivo Sol',4, 3,41, 59,10, 18,9, 2,76, 80,10, 0,12, 9,1, 1,18, 19,2, 3,1, 1,1, 1,6);
insert into Matchs values(25, '2060-11-12', '19:30', 4, 5, 'FC Mar Azul', 'CD Castellanos',0, 1,60, 40,17, 8,13, 0,94, 85,10, 3,13, 11,1, 1,16, 15,2, 3,0, 1,0, 4,4);
insert into Matchs values(26, '2060-11-15', '19:30', 5, 4, 'CD Castellanos', 'FC Mar Azul',3, 2,57, 43,6, 9,3, 1,93, 86,10, 9,14, 9,1, 1,11, 12,4, 0,0, 0,0, 2,5);
insert into Matchs values(27, '2060-11-18', '17:00', 4, 6, 'FC Mar Azul', 'Union Andorra',0, 3,56, 44,17, 10,16, 1,83, 76,4, 8,15, 14,0, 0,17, 20,1, 1,0, 1,5, 1,4);
insert into Matchs values(28, '2060-11-21', '17:00', 6, 4, 'Union Andorra', 'FC Mar Azul',3, 0,51, 49,20, 6,6, 1,86, 88,1, 10,11, 10,0, 1,18, 15,2, 2,0, 0,5, 3,6);
insert into Matchs values(29, '2060-11-24', '21:00', 5, 6, 'CD Castellanos', 'Union Andorra',4, 4,41, 59,10, 12,8, 10,75, 87,3, 6,11, 9,1, 0,8, 9,2, 4,1, 1,5, 1,5);
insert into Matchs values(30, '2060-11-27', '21:00', 6, 5, 'Union Andorra', 'CD Castellanos',4, 2,57, 43,9, 10,8, 1,93, 70,10, 3,11, 13,0, 1,14, 16,3, 4,1, 0,5, 0,6);
INSERT INTO Matchs VALUES (31, '2060-10-01', '20:00', 7, 1, 'Tractor Galactico', 'Real Cobre', 3, 0, 61, 39, 15, 6, 9, 2, 88, 76, 6, 2, 10, 10, 0, 0, 12, 14, 1, 2, 0, 0, 1, 2,7);
INSERT INTO Matchs VALUES (32, '2060-10-04', '20:00', 1, 7, 'Real Cobre', 'Tractor Galactico', 0, 4, 40, 60, 6, 15, 2, 8, 76, 88, 2, 6, 10, 10, 0, 0, 14, 12, 2, 1, 0, 0, 2, 1,1);
INSERT INTO Matchs VALUES (33, '2060-10-07', '20:00', 7, 2, 'Tractor Galactico', 'Atlético Norte', 4, 2, 62, 38, 17, 7, 10, 3, 89, 74, 7, 2, 11, 10, 0, 0, 11, 13, 1, 2, 0, 0, 1, 1,7);
INSERT INTO Matchs VALUES (34, '2060-10-10', '20:00', 2, 7, 'Atlético Norte', 'Tractor Galactico', 0, 4, 38, 62, 7, 17, 3, 10, 74, 89, 2, 7, 10, 11, 0, 0, 13, 11, 2, 1, 0, 0, 1, 1,2);
INSERT INTO Matchs VALUES (35, '2060-10-13', '20:00', 7, 3, 'Tractor Galactico', 'Deportivo Sol', 3, 0, 59, 41, 14, 8, 8, 3, 86, 78, 5, 2, 10, 10, 0, 0, 13, 12, 2, 1, 0, 0, 2, 1,7);
INSERT INTO Matchs VALUES (36, '2060-10-16', '20:00', 3, 7, 'Deportivo Sol', 'Tractor Galactico', 0, 5, 41, 59, 8, 14, 3, 8, 78, 86, 2, 5, 10, 10, 0, 0, 12, 13, 1, 2, 0, 0, 1, 2,3);
INSERT INTO Matchs VALUES (37, '2060-10-19', '20:00', 7, 4, 'Tractor Galactico', 'FC Mar Azul', 5, 0, 65, 35, 18, 6, 11, 2, 91, 72, 8, 1, 10, 10, 0, 0, 11, 14, 1, 2, 0, 0, 2, 1,7);
INSERT INTO Matchs VALUES (38, '2060-10-22', '20:00', 4, 7, 'FC Mar Azul', 'Tractor Galactico', 2, 5, 35, 65, 6, 18, 2, 11, 72, 91, 1, 8, 10, 10, 0, 0, 14, 11, 2, 1, 0, 0, 1, 2,4);
INSERT INTO Matchs VALUES (39, '2060-10-25', '20:00', 7, 5, 'Tractor Galactico', 'CD Castellanos', 3, 1, 60, 40, 16, 7, 10, 2, 87, 77, 5, 2, 10, 10, 0, 0, 13, 13, 1, 2, 0, 0, 1, 2,7);
INSERT INTO Matchs VALUES (40, '2060-10-28', '20:00', 5, 7, 'CD Castellanos', 'Tractor Galactico', 2, 3, 40, 60, 7, 16, 2, 10, 77, 87, 2, 5, 10, 10, 0, 0, 13, 13, 2, 1, 0, 0, 2, 1,5);
INSERT INTO Matchs VALUES (41, '2060-10-31', '20:00', 7, 6, 'Tractor Galactico', 'Union Andorra', 4, 0, 63, 37, 17, 9, 9, 4, 90, 75, 6, 2, 10, 10, 0, 0, 12, 14, 1, 2, 0, 0, 1, 2,7);
INSERT INTO Matchs VALUES (42, '2060-11-03', '20:00', 6, 7, 'Union Andorra', 'Tractor Galactico', 2, 6, 37, 63, 9, 17, 4, 9, 75, 90, 2, 6, 10, 10, 0, 0, 14, 12, 2, 1, 0, 0, 2, 1,6);


ALTER TABLE Player
ADD player_photo_url varchar(150); 

select * from Player

-- Real Cobre
INSERT INTO Player VALUES (1, 'Randy', 'Clarke', 21, 'Burkina Faso', 'CAM',11599036, 86, 87, NULL, NULL,NULL, NULL, NULL, '2067-12-18',1);
INSERT INTO Player VALUES (2, 'Randy', 'Davis', 35, 'Norway', 'RW',12734456, 40, 89, NULL, NULL,NULL, NULL, NULL, '2067-04-03',1);
INSERT INTO Player VALUES (3, 'Linda', 'Mcgrath', 27, 'Faroe Islands', 'CB',16202964, 15, 68, NULL, NULL,NULL, NULL, NULL, '2066-06-10',1);
INSERT INTO Player VALUES (4, 'Christopher', 'Franklin', 19, 'Japan', 'CB',12191975, 90, 64, NULL, NULL,NULL, NULL, NULL, '2067-10-13',1);
INSERT INTO Player VALUES (5, 'Linda', 'Kennedy', 33, 'Burundi', 'RW',12083836, 61, 85, NULL, NULL,NULL, NULL, NULL, '2066-11-22',1);
INSERT INTO Player VALUES (6, 'John', 'Sullivan', 18, 'Trinidad and Tobago', 'ST',4829996, 90, 71, NULL, NULL,NULL, NULL, NULL, '2067-11-01',1);
INSERT INTO Player VALUES (7, 'Bonnie', 'Lang', 34, 'Sweden', 'CB',9617441, 29, 70, NULL, NULL,NULL, NULL, NULL, '2067-10-05',1);
INSERT INTO Player VALUES (8, 'Peter', 'Williamson', 34, 'Zimbabwe', 'GK',4777216, 32, 60, NULL, NULL,NULL, NULL, NULL, '2067-08-09',1);
INSERT INTO Player VALUES (9, 'Joseph', 'Pham', 32, 'Monaco', 'CDM',13929460, 65, 90, NULL, NULL,NULL, NULL, NULL, '2066-07-13',1);
INSERT INTO Player VALUES (10, 'Caleb', 'Sanchez', 18, 'Monaco', 'RW',7201048, 63, 90, NULL, NULL,NULL, NULL, NULL, '2067-10-23',1);
INSERT INTO Player VALUES (11, 'Kristen', 'Stevenson', 32, 'El Salvador', 'RW',8352410, 10, 80, NULL, NULL,NULL, NULL, NULL, '2067-06-20',1);
INSERT INTO Player VALUES (12, 'Jason', 'Christensen', 26, 'Cayman Islands', 'RW',3914967, 38, 84, NULL, NULL,NULL, NULL, NULL, '2068-01-23',1);
INSERT INTO Player VALUES (13, 'Robert', 'Mueller', 28, 'United Arab Emirates', 'ST',14161282, 2, 81, NULL, NULL,NULL, NULL, NULL, '2067-02-26',1);
INSERT INTO Player VALUES (14, 'Kelsey', 'Harris', 22, 'French Southern Territories', 'RW',10257729, 25, 64,NULL, NULL,NULL, NULL, NULL, '2066-10-07',1);
INSERT INTO Player VALUES (15, 'Peggy', 'Bradley', 24, 'Madagascar', 'CDM',9190377, 16, 86, NULL, NULL,NULL, NULL, NULL, '2067-03-25',1);
INSERT INTO Player VALUES (16, 'Stephanie', 'Cohen', 32, 'Oman', 'GK',3084002, 23, 64, NULL, NULL,NULL, NULL, NULL, '2066-08-14',1);
INSERT INTO Player VALUES (17, 'Brenda', 'Wagner', 25, 'Togo', 'ST',8735709, 11, 78, NULL, NULL,NULL, NULL, NULL, '2068-02-27',1);
INSERT INTO Player VALUES (18, 'Brandi', 'Vega', 34, 'Tonga', 'RW',17601079, 64, 80, NULL, NULL,NULL, NULL, NULL, '2067-11-30',1);
INSERT INTO Player VALUES (19, 'Kayla', 'Wolfe', 28, 'Cameroon', 'CDM',630934, 38, 63, NULL, NULL,NULL, NULL, NULL, '2068-02-27',1);
INSERT INTO Player VALUES (20, 'Jacob', 'Dunlap', 21, 'Bangladesh', 'ST',3894303, 21, 82, NULL, NULL,NULL, NULL, NULL, '2068-03-05',1);

-- Atlético Norte
INSERT INTO Player VALUES (21, 'Jennifer', 'Stewart', 33, 'Korea', 'RW',13605894, 6, 90, NULL, NULL,NULL, NULL, NULL, '2067-10-07',2);
INSERT INTO Player VALUES (22, 'Mary', 'Holden', 30, 'Cocos (Keeling) Islands', 'CM',2223659, 82, 80, NULL, NULL,NULL, NULL, NULL, '2067-11-05',2);
INSERT INTO Player VALUES (23, 'Heidi', 'Powell', 24, 'British Indian Ocean Territory', 'CM',10361330, 6, 65, NULL, NULL,NULL, NULL, NULL, '2066-08-27',2);
INSERT INTO Player VALUES (24, 'Marie', 'Everett', 20, 'Tokelau', 'CM',8766807, 86, 60, NULL, NULL,NULL, NULL, NULL, '2067-02-08',2);
INSERT INTO Player VALUES (25, 'Calvin', 'Contreras', 30, 'Guam', 'LB',8656632, 37, 86, NULL, NULL,NULL, NULL, NULL, '2067-10-20',2);
INSERT INTO Player VALUES (26, 'Jenna', 'Bennett', 34, 'Belgium', 'CM',13489538, 48, 86, NULL, NULL,NULL, NULL, NULL, '2068-02-25',2);
INSERT INTO Player VALUES (27, 'Jessica', 'Kaufman', 35, 'Libyan Arab Jamahiriya', 'ST',19371842, 46, 73, NULL, NULL,NULL, NULL, NULL, '2067-11-14',2);
INSERT INTO Player VALUES (28, 'Jonathan', 'Walker', 35, 'Mauritius', 'ST',4433153, 54, 83, NULL, NULL,NULL, NULL, NULL, '2067-07-22',2);
INSERT INTO Player VALUES (29, 'Jessica', 'Sanders', 29, 'Armenia', 'GK',8733420, 11, 90, NULL, NULL,NULL, NULL, NULL, '2067-12-19',2);
INSERT INTO Player VALUES (30, 'Edward', 'Mccoy', 32, 'Solomon Islands', 'RB',7177931, 25, 84, NULL, NULL,NULL, NULL, NULL, '2066-12-07',2);
INSERT INTO Player VALUES (31, 'Timothy', 'Dixon', 22, 'Singapore', 'CM',13616382, 67, 87, NULL, NULL,NULL, NULL, NULL, '2066-09-25',2);
INSERT INTO Player VALUES (32, 'John', 'Neal', 30, 'Peru', 'CAM',9716281, 49, 70, NULL, NULL,NULL, NULL, NULL, '2067-10-31',2);
INSERT INTO Player VALUES (33, 'Julie', 'Lopez', 26, 'Netherlands Antilles', 'LB',7284742, 91, 65, NULL, NULL,NULL, NULL, NULL, '2066-10-17',2);
INSERT INTO Player VALUES (34, 'James', 'Crawford', 20, 'Reunion', 'CM',12179803, 9, 90, NULL, NULL,NULL, NULL, NULL, '2067-06-02',2);
INSERT INTO Player VALUES (35, 'Tammy', 'Taylor', 27, 'United States Minor Outlying Islands', 'GK',11968726, 75, 71, NULL, NULL,NULL, NULL, NULL, '2068-02-22',2);
INSERT INTO Player VALUES (36, 'Henry', 'Mueller', 27, 'Martinique', 'RW',15662869, 72, 87, NULL, NULL,NULL, NULL, NULL, '2066-09-28',2);
INSERT INTO Player VALUES (37, 'Ryan', 'Dunn', 18, 'Oman', 'LB',3336437, 14, 90, NULL, NULL,NULL, NULL, NULL, '2066-07-05',2);
INSERT INTO Player VALUES (38, 'Alexandra', 'Salas', 23, 'Algeria', 'LW',19332914, 54, 75, NULL, NULL,NULL, NULL, NULL, '2068-05-24',2);
INSERT INTO Player VALUES (39, 'Veronica', 'King', 19, 'Saudi Arabia', 'CB',12095975, 8, 68, NULL, NULL,NULL, NULL, NULL, '2067-10-22',2);
INSERT INTO Player VALUES (40, 'Rebecca', 'Dunn', 24, 'Yemen', 'CB',15898248, 71, 76, NULL, NULL,NULL, NULL, NULL, '2067-01-04',2);

-- Deportivo Sol
INSERT INTO Player VALUES (41, 'William', 'Howard', 22, 'Netherlands Antilles', 'LB',3036544, 27, 83, NULL, NULL,NULL, NULL, NULL, '2067-03-22',3);
INSERT INTO Player VALUES (42, 'Ronald', 'Wood', 31, 'Afghanistan', 'CB',5885571, 39, 67, NULL, NULL,NULL, NULL, NULL, '2067-05-28',3);
INSERT INTO Player VALUES (43, 'Nicole', 'Hill', 23, 'Central African Republic', 'ST',10524738, 73, 81, NULL, NULL,NULL, NULL, NULL, '2067-05-29',3);
INSERT INTO Player VALUES (44, 'Michelle', 'Gilbert', 22, 'Svalbard & Jan Mayen Islands', 'RW',8024139, 93, 72, NULL, NULL,NULL, NULL, NULL, '2066-07-14',3);
INSERT INTO Player VALUES (45, 'James', 'Rodgers', 32, 'Bermuda', 'CB',2899155, 79, 90, NULL, NULL,NULL, NULL, NULL, '2067-01-02',3);
INSERT INTO Player VALUES (46, 'Daniel', 'Alexander', 35, 'Morocco', 'LW',18516500, 15, 77, NULL, NULL,NULL, NULL, NULL, '2067-05-03',3);
INSERT INTO Player VALUES (47, 'Isabel', 'Jones', 34, 'Japan', 'ST',673823, 67, 72, NULL, NULL,NULL, NULL, NULL, '2068-03-10',3);
INSERT INTO Player VALUES (48, 'Jason', 'Riley', 27, 'Ukraine', 'CM',10415438, 22, 82, NULL, NULL,NULL, NULL, NULL, '2068-02-27',3);
INSERT INTO Player VALUES (49, 'Jonathan', 'Rodriguez', 23, 'Montserrat', 'CDM',6355550, 28, 62, NULL, NULL,NULL, NULL, NULL, '2066-12-06',3);
INSERT INTO Player VALUES (50, 'Sarah', 'Jones', 20, 'Dominica', 'RB',4925044, 34, 84, NULL, NULL,NULL, NULL, NULL, '2068-05-08',3);
INSERT INTO Player VALUES (51, 'Tara', 'Green', 33, 'Chad', 'CB',10299869, 1, 73, NULL, NULL,NULL, NULL, NULL, '2066-08-20',3);
INSERT INTO Player VALUES (52, 'Heather', 'Jackson', 24, 'Tunisia', 'CDM',809520, 7, 63, NULL, NULL,NULL, NULL, NULL, '2067-12-14',3);
INSERT INTO Player VALUES (53, 'Logan', 'Garcia', 29, 'Palestinian Territory', 'ST',13495250, 55, 68, NULL, NULL,NULL, NULL, NULL, '2066-07-11',3);
INSERT INTO Player VALUES (54, 'Jessica', 'Sanchez', 19, 'Liechtenstein', 'CB',1728474, 69, 69, NULL, NULL,NULL, NULL, NULL, '2067-05-09',3);
INSERT INTO Player VALUES (55, 'James', 'Hall', 34, 'Greece', 'GK',8643357, 47, 82, NULL, NULL,NULL, NULL, NULL, '2067-12-12',3);
INSERT INTO Player VALUES (56, 'Kyle', 'Potts', 24, 'Cuba', 'ST',3764728, 84, 72, NULL, NULL,NULL, NULL, NULL, '2066-05-26',3);
INSERT INTO Player VALUES (57, 'Arthur', 'Martinez', 19, 'Gabon', 'CDM',6603216, 36, 63, NULL, NULL,NULL, NULL, NULL, '2066-06-24',3);
INSERT INTO Player VALUES (58, 'Brian', 'Beasley', 31, 'Hong Kong', 'CM',15985647, 35, 73, NULL, NULL,NULL, NULL, NULL, '2067-02-07',3);
INSERT INTO Player VALUES (59, 'Travis', 'Allen', 20, 'Mexico', 'RB',3231484, 85, 60, NULL, NULL,NULL, NULL, NULL, '2067-09-10',3);
INSERT INTO Player VALUES (60, 'Rodney', 'Vazquez', 24, 'Egypt', 'CB',7701336, 21, 71, NULL, NULL,NULL, NULL, NULL, '2067-11-12',3);

-- FC Mar Azul
INSERT INTO Player VALUES (61, 'Cheryl', 'Rivera', 20, 'Indonesia', 'LB',12845825, 62, 88, NULL, NULL,NULL, NULL, NULL, '2067-10-22',4);
INSERT INTO Player VALUES (62, 'Troy', 'Williams', 25, 'Dominican Republic', 'LW',17726625, 35, 65, NULL, NULL,NULL, NULL, NULL, '2067-02-17',4);
INSERT INTO Player VALUES (63, 'Jessica', 'Humphrey', 21, 'Ecuador', 'GK',10568825, 24, 84, NULL, NULL,NULL, NULL, NULL, '2067-05-17',4);
INSERT INTO Player VALUES (64, 'Roberta', 'Howard', 34, 'Antigua and Barbuda', 'RW',5964366, 76, 83, NULL, NULL,NULL, NULL, NULL, '2066-10-28',4);
INSERT INTO Player VALUES (65, 'Bradley', 'Smith', 34, 'Germany', 'RB',13187058, 22, 68, NULL, NULL,NULL, NULL, NULL, '2066-10-15',4);
INSERT INTO Player VALUES (66, 'Marcus', 'Jones', 19, 'Guadeloupe', 'ST',4246998, 35, 74, NULL, NULL,NULL, NULL, NULL, '2067-10-23',4);
INSERT INTO Player VALUES (67, 'Christopher', 'Howard', 22, 'Guinea-Bissau', 'LB',3395580, 32, 76, NULL, NULL,NULL, NULL, NULL, '2068-01-05',4);
INSERT INTO Player VALUES (68, 'Tammy', 'Rios', 24, 'Oman', 'LW',12723763, 49, 90, NULL, NULL,NULL, NULL, NULL, '2067-04-05',4);
INSERT INTO Player VALUES (69, 'Jaime', 'Palmer', 25, 'Czech Republic', 'RB',6737800, 77, 63, NULL, NULL,NULL, NULL, NULL, '2066-09-25',4);
INSERT INTO Player VALUES (70, 'Scott', 'Valentine', 18, 'Malawi', 'CM',5183665, 68, 80, NULL, NULL,NULL, NULL, NULL, '2068-02-28',4);
INSERT INTO Player VALUES (71, 'Ruben', 'Curtis', 31, 'Cape Verde', 'CAM',7830614, 37, 77, NULL, NULL,NULL, NULL, NULL, '2066-12-28',4);
INSERT INTO Player VALUES (72, 'Ray', 'Potter', 21, 'Luxembourg', 'LB',11126350, 90, 72, NULL, NULL,NULL, NULL, NULL, '2067-06-17',4);
INSERT INTO Player VALUES (73, 'Karina', 'Gross', 19, 'Turkmenistan', 'RB',1600152, 21, 81, NULL, NULL,NULL, NULL, NULL, '2067-04-18',4);
INSERT INTO Player VALUES (74, 'Rebecca', 'Williams', 19, 'Uruguay', 'CAM',18152444, 4, 90, NULL, NULL,NULL, NULL, NULL, '2067-09-01',4);
INSERT INTO Player VALUES (75, 'Devon', 'Jones', 21, 'Dominica', 'LW',6460169, 19, 90, NULL, NULL,NULL, NULL, NULL, '2066-08-24',4);
INSERT INTO Player VALUES (76, 'Christopher', 'Diaz', 21, 'Seychelles', 'RW',11759279, 78, 75, NULL, NULL,NULL, NULL, NULL, '2067-01-29',4);
INSERT INTO Player VALUES (77, 'Kathleen', 'Thompson', 34, 'Brazil', 'CAM',7958973, 86, 80, NULL, NULL,NULL, NULL, NULL, '2067-08-11',4);
INSERT INTO Player VALUES (78, 'Seth', 'Hensley', 19, 'Netherlands', 'LB',15016997, 86, 89, NULL, NULL,NULL, NULL, NULL, '2068-01-21',4);
INSERT INTO Player VALUES (79, 'Alexander', 'Reese', 31, 'Sao Tome and Principe', 'RB',11492594, 10, 60, NULL, NULL,NULL, NULL, NULL, '2068-04-06',4);
INSERT INTO Player VALUES (80, 'Katelyn', 'Patton', 31, 'Trinidad and Tobago', 'CAM',17561117, 9, 74, NULL, NULL,NULL, NULL, NULL, '2066-08-01',4);

-- CD Castellanos
INSERT INTO Player VALUES (81, 'Ricky', 'Vaughn', 31, 'Sri Lanka', 'LW',13671619, 91, 70, NULL, NULL,NULL, NULL, NULL, '2067-11-15',5);
INSERT INTO Player VALUES (82, 'Wayne', 'Ford', 18, 'Austria', 'CB',17104568, 23, 72, NULL, NULL,NULL, NULL, NULL, '2068-05-14',5);
INSERT INTO Player VALUES (83, 'Karen', 'Brown', 20, 'Tokelau', 'RW',14847986, 66, 63, NULL, NULL,NULL, NULL, NULL, '2068-03-27',5);
INSERT INTO Player VALUES (84, 'Deborah', 'Lopez', 29, 'Vietnam', 'LW',7451322, 92, 64, NULL, NULL,NULL, NULL, NULL, '2067-10-30',5);
INSERT INTO Player VALUES (85, 'Kristin', 'Diaz', 21, 'Saudi Arabia', 'ST',7507212, 37, 67, NULL, NULL,NULL, NULL, NULL, '2067-12-05',5);
INSERT INTO Player VALUES (86, 'Douglas', 'Dyer', 31, 'Equatorial Guinea', 'LW',11059792, 85, 76, NULL, NULL,NULL, NULL, NULL, '2067-03-28',5);
INSERT INTO Player VALUES (87, 'Rebecca', 'Peters', 35, 'New Zealand', 'ST',10259892, 77, 79, NULL, NULL,NULL, NULL, NULL, '2066-09-28',5);
INSERT INTO Player VALUES (88, 'Robert', 'Fowler', 31, 'British Indian Ocean Territory', 'CM',962643, 38, 80, NULL, NULL,NULL, NULL, NULL, '2068-03-27',5);
INSERT INTO Player VALUES (89, 'Joshua', 'Lloyd', 31, 'Palestinian Territory', 'RB',14468835, 40, 67, NULL, NULL,NULL, NULL, NULL, '2067-12-11',5);
INSERT INTO Player VALUES (90, 'Dana', 'Kim', 35, 'South Georgia and the South Sandwich Islands', 'CM',2872483, 29, 89,NULL, NULL,NULL, NULL, NULL, '2067-05-25',5);
INSERT INTO Player VALUES (91, 'Charles', 'Mcdowell', 31, 'Lebanon', 'RW',6385227, 17, 73, NULL, NULL,NULL, NULL, NULL, '2066-06-24',5);
INSERT INTO Player VALUES (92, 'Christopher', 'Schultz', 27, 'Palau', 'CDM',18457079, 20, 82, NULL, NULL,NULL, NULL, NULL, '2066-08-30',5);
INSERT INTO Player VALUES (93, 'Joseph', 'Young', 34, 'Saint Helena', 'CDM',11483614, 99, 87, NULL, NULL,NULL, NULL, NULL, '2067-11-15',5);
INSERT INTO Player VALUES (94, 'Christian', 'Allen', 30, 'Tunisia', 'CB',7796417, 30, 63,NULL, NULL,NULL, NULL, NULL, '2067-03-16',5);
INSERT INTO Player VALUES (95, 'Melissa', 'Dunlap', 34, 'Guyana', 'LW',16199238, 35, 68, NULL, NULL,NULL, NULL, NULL,  '2068-01-07',5);
INSERT INTO Player VALUES (96, 'Brandy', 'Miller', 20, 'United States Virgin Islands', 'RW',10897659, 22, 76, NULL, NULL,NULL, NULL, NULL, '2067-11-20',5);
INSERT INTO Player VALUES (97, 'Wayne', 'Schmidt', 21, 'Yemen', 'LW',15513278, 75, 62, NULL, NULL,NULL, NULL, NULL, '2067-05-12',5);
INSERT INTO Player VALUES (98, 'Amy', 'Sanford', 26, 'Lebanon', 'CM',16714423, 54, 82, NULL, NULL,NULL, NULL, NULL, '2068-05-05',5);
INSERT INTO Player VALUES (99, 'Cassandra', 'Thompson', 25, 'Algeria', 'CB',9706872, 79, 89, NULL, NULL,NULL, NULL, NULL, '2067-09-11',5);
INSERT INTO Player VALUES (100, 'Stephen', 'Johnson', 21, 'Burkina Faso', 'GK',9264555, 67, 82, NULL, NULL,NULL, NULL, NULL, '2067-05-03',5);

-- Union Andorra
INSERT INTO Player VALUES (101, 'Robin', 'Lee', 31, 'Turkey', 'RB',11716144, 49, 82, NULL, NULL,NULL, NULL, NULL, '2066-09-18',6);
INSERT INTO Player VALUES (102, 'Pam', 'Logan', 22, 'Venezuela', 'ST',13406912, 33, 82, NULL, NULL,NULL, NULL, NULL, '2066-08-03',6);
INSERT INTO Player VALUES (103, 'Richard', 'Johnson', 26, 'Seychelles', 'ST',3994000, 72, 90, NULL, NULL,NULL, NULL, NULL, '2068-03-23',6);
INSERT INTO Player VALUES (104, 'Nicholas', 'Edwards', 34, 'New Caledonia', 'RW',15283086, 53, 86, NULL, NULL,NULL, NULL, NULL, '2067-07-03',6);
INSERT INTO Player VALUES (105, 'Ronnie', 'Short', 34, 'Peru', 'CM',18774712, 93, 86, NULL, NULL,NULL, NULL, NULL, '2066-05-25',6);
INSERT INTO Player VALUES (106, 'Rebecca', 'Rios', 29, 'Panama', 'CM',14952645, 34, 84, NULL, NULL,NULL, NULL, NULL, '2066-11-05',6);
INSERT INTO Player VALUES (107, 'Mark', 'Perez', 20, 'Dominica', 'CDM',11285613, 59, 88, NULL, NULL,NULL, NULL, NULL, '2067-03-17',6);
INSERT INTO Player VALUES (108, 'Johnathan', 'Mendoza', 21, 'Puerto Rico', 'ST',19628681, 66, 62, NULL, NULL,NULL, NULL, NULL, '2067-12-19',6);
INSERT INTO Player VALUES (109, 'Holly', 'Nguyen', 34, 'Korea', 'LB',786271, 54, 83, NULL, NULL,NULL, NULL, NULL, '2067-03-10',6);
INSERT INTO Player VALUES (110, 'Robert', 'Johnson', 20, 'Gibraltar', 'GK',1264209, 7, 73, NULL, NULL,NULL, NULL, NULL, '2066-12-06',6);
INSERT INTO Player VALUES (111, 'Charles', 'Foley', 30, 'Qatar', 'LW',16718878, 81, 75, NULL, NULL,NULL, NULL, NULL, '2068-01-10',6);
INSERT INTO Player VALUES (112, 'Michael', 'Pineda', 18, 'Rwanda', 'CB',18476658, 27, 66, NULL, NULL,NULL, NULL, NULL, '2068-01-27',6);
INSERT INTO Player VALUES (113, 'Jeffery', 'Gomez', 31, 'Antarctica (the territory South of 60 deg S)', 'RB',10181095, 83, 70, NULL, NULL,NULL, NULL, NULL, '2067-07-09',6);
INSERT INTO Player VALUES (114, 'Robin', 'Richard', 23, 'Aruba', 'LB',3397991, 51, 85, NULL, NULL,NULL, NULL, NULL, '2068-01-25',6);
INSERT INTO Player VALUES (115, 'Kristy', 'Reynolds', 32, 'Jamaica', 'RW',18002814, 20, 90, NULL, NULL,NULL, NULL, NULL, '2068-02-09',6);
INSERT INTO Player VALUES (116, 'Meagan', 'Ellis', 22, 'Syrian Arab Republic', 'CM',18900201, 60, 66, NULL, NULL,NULL, NULL, NULL, '2068-10-02',6);
INSERT INTO Player VALUES (117, 'Sara', 'Hubbard', 31, 'Barbados', 'RB',16420909, 79, 80, NULL, NULL,NULL, NULL, NULL, '2067-05-11',6);
INSERT INTO Player VALUES (118, 'Rebecca', 'Cervantes', 26, 'Chile', 'CDM',16652365, 41, 77, NULL, NULL,NULL, NULL, NULL, '2066-08-04',6);
INSERT INTO Player VALUES (119, 'Tara', 'Abbott', 23, 'Brazil', 'CDM',18269363, 16, 90, NULL, NULL,NULL, NULL, NULL, '2066-10-09',6);
INSERT INTO Player VALUES (120, 'Chase', 'West', 29, 'Pakistan', 'ST',18883884, 66, 69, NULL, NULL,NULL, NULL, NULL, '2067-09-15',6);

-- Tractor Galactico CF
INSERT INTO Player VALUES(121, 'Evan', 'Nguyen', 27, 'Bolivia', 'GK',17545194, 1, 79, NULL, NULL,NULL, NULL, NULL, '2063-11-22',7);
INSERT INTO Player VALUES(122, 'Melanie', 'Cline', 23, 'Greece', 'RW',13702093, 2, 73, NULL, NULL,NULL, NULL, NULL, '2062-03-09',7);
INSERT INTO Player VALUES(123, 'Christopher', 'Morris', 33, 'Marshall Islands', 'LW',5183444, 3, 66, NULL, NULL,NULL, NULL, NULL, '2061-02-06',7);
INSERT INTO Player VALUES(124, 'Christine', 'Porter', 23, 'Mayotte', 'LB',10861289, 4, 83, NULL, NULL,NULL, NULL, NULL, '2066-07-03',7);
INSERT INTO Player VALUES(125, 'Jeff', 'Cisneros', 19, 'Lesotho', 'CDM',8793834, 5, 73, NULL, NULL,NULL, NULL, NULL, '2066-06-28',7);
INSERT INTO Player VALUES(126, 'Erica', 'Harris', 34, 'Suriname', 'LB',3790100, 6, 86, NULL, NULL,NULL, NULL, NULL, '2066-07-14',7);
INSERT INTO Player VALUES(127, 'Joyce', 'Hunter', 27, 'Montserrat', 'RW',9247460, 7, 89, NULL, NULL,NULL, NULL, NULL, '2067-01-27',7);
INSERT INTO Player VALUES(128, 'Renee', 'Brown', 20, 'Sao Tome and Principe', 'LB',12905189, 8, 74, NULL, NULL,NULL, NULL, NULL, '2028-02-12',7);
INSERT INTO Player VALUES(129, 'Nicole', 'Turner', 24, 'Colombia', 'RB',10316135, 9, 74, NULL, NULL,NULL, NULL, NULL, '2067-12-11',7);
INSERT INTO Player VALUES(130, 'Anthony', 'Smith', 34, 'Bosnia and Herzegovina', 'CM',13026845, 10, 67,NULL, NULL,NULL, NULL, NULL, '2027-07-16',7);
INSERT INTO Player VALUES(131, 'Tyler', 'Vasquez', 20, 'Cape Verde', 'CAM',10478550, 11, 85, NULL, NULL,NULL, NULL, NULL, '2067-05-04',7);
INSERT INTO Player VALUES(132, 'Mariah', 'Davidson', 19, 'Djibouti', 'LW',10103784, 12, 74, NULL, NULL,NULL, NULL, NULL, '2067-12-03',7);
INSERT INTO Player VALUES(133, 'Cheryl', 'Walker', 34, 'Tokelau', 'RW',16632148, 13, 63, NULL, NULL,NULL, NULL, NULL, '2068-01-25',7);
INSERT INTO Player VALUES(134, 'Krista', 'Duncan', 25, 'Japan', 'RB',7295696, 14, 88, NULL, NULL,NULL, NULL, NULL, '2066-05-23',7);
INSERT INTO Player VALUES(135, 'Ian', 'Grimes', 25, 'Antarctica (the territory South of 60 deg S)', 'LB',6648010, 15, 67, NULL, NULL,NULL, NULL, NULL, '2067-09-09',7);
INSERT INTO Player VALUES(136, 'Katie', 'Townsend', 28, 'Nigeria', 'CDM',3449211, 16, 67, NULL, NULL,NULL, NULL, NULL, '2066-11-11',7);
INSERT INTO Player VALUES(137, 'Jackie', 'Pitts', 20, 'Somalia', 'GK',4111827, 17, 83, NULL, NULL,NULL, NULL, NULL, '2068-03-12',7);
INSERT INTO Player VALUES(138, 'David', 'Goodwin', 33, 'Congo', 'RB',16741070, 18, 72, NULL, NULL,NULL, NULL, NULL, '2067-05-14',7);
INSERT INTO Player VALUES(139, 'Tiffany', 'Wilson', 19, 'Denmark', 'CB',5896915, 19, 80, NULL, NULL,NULL, NULL, NULL, '2068-02-26',7);
INSERT INTO Player VALUES (140, 'Angelica', 'Davis', 32, 'Tajikistan', 'CDM',2156896, 20, 76, NULL, NULL,NULL, NULL, NULL,  '2066-04-28',7);

Select * from Goal_Keeper
INSERT INTO Goal_Keeper VALUES(8,1);
INSERT INTO Goal_Keeper VALUES(16,0);
INSERT INTO Goal_Keeper VALUES(29,1);
INSERT INTO Goal_Keeper VALUES(35,1);
INSERT INTO Goal_Keeper VALUES(55,3);
INSERT INTO Goal_Keeper VALUES(63,2);
INSERT INTO Goal_Keeper VALUES(100,1);
INSERT INTO Goal_Keeper VALUES(110,3);
INSERT INTO Goal_Keeper VALUES(121,5);
INSERT INTO Goal_Keeper VALUES(137,2);

ALTER TABLE Coach
ADD coach_photo_url varchar(150); 

select * from Coach
-- Real Cobre
INSERT INTO Coach VALUES(1, 'Carlos', 'Navarro', 'Goalkeeping Coach', 612345678,1);
INSERT INTO Coach VALUES(2, 'Miguel', 'Ruiz', 'Assistant Coach', 634567890,1);
INSERT INTO Coach VALUES(3, 'Sergio', 'Lopez', 'Fitness Coach', 645678901,1);
INSERT INTO Coach VALUES(4, 'Javier', 'Santos', 'Tactical Analyst', 689012345,1);
INSERT INTO Coach VALUES(5, 'Luis', 'Gomez', 'Physiotherapist', 623456789,1);
INSERT INTO Coach VALUES(6, 'Andrés', 'Moreno', 'Nutritionist', 698765432,1);
INSERT INTO Coach VALUES(7, 'Raul', 'Hernandez', 'Defensive Coach', 654321098,1);
INSERT INTO Coach VALUES(8, 'Melinda', 'Jones', 'Team Doctor', 664424445, 1);
INSERT INTO Coach VALUES(9, 'Melissa', 'Warren', 'Masseur', 605802622, 1);
INSERT INTO Coach VALUES(10, 'Robert', 'Sherman', 'Sports Psychologist', 639738237, 1);
INSERT INTO Coach VALUES(11, 'Tracy', 'Fletcher', 'Video Analyst', 603656429, 1);
INSERT INTO Coach VALUES(12, 'Gina', 'Davis', 'Technical Director', 685369660, 1);
INSERT INTO Coach VALUES(13, 'Leslie', 'Clayton', 'Attacking Coach', 611526172, 1);

-- Atlético Norte
INSERT INTO Coach VALUES (14, 'Crystal', 'Khan', 'Assistant Coach', 676699732, 2);
INSERT INTO Coach VALUES (15, 'John', 'Gay', 'Fitness Coach', 619549133, 2);
INSERT INTO Coach VALUES (16, 'Rebecca', 'Jones', 'Goalkeeping Coach', 606635527, 2);
INSERT INTO Coach VALUES (17, 'Harold', 'Miranda', 'Tactical Analyst', 657656368, 2);
INSERT INTO Coach VALUES (18, 'Matthew', 'Robertson', 'Physiotherapist', 657935228, 2);
INSERT INTO Coach VALUES (19, 'Carolyn', 'Best', 'Nutritionist', 665576902, 2);
INSERT INTO Coach VALUES (20, 'Isaac', 'Stewart', 'Defensive Coach', 644473101, 2);
INSERT INTO Coach VALUES (21, 'Samantha', 'Greene', 'Attacking Coach', 644234204, 2);
INSERT INTO Coach VALUES (22, 'Jessica', 'Wright', 'Video Analyst', 653170853, 2);
INSERT INTO Coach VALUES (23, 'Dana', 'Tucker', 'Sports Psychologist', 684335929, 2);
INSERT INTO Coach VALUES (24, 'Brian', 'Wong', 'Masseur', 638714380, 2);
INSERT INTO Coach VALUES (25, 'Richard', 'Ramirez', 'Team Doctor', 697603003, 2);
INSERT INTO Coach VALUES (26, 'Eric', 'Charles', 'Technical Director', 623597173, 2);

-- Deportivo Sol
INSERT INTO Coach VALUES (27, 'Erica', 'Davis', 'Assistant Coach', 614590137, 3);
INSERT INTO Coach VALUES (28, 'Adam', 'George', 'Fitness Coach', 606056709, 3);
INSERT INTO Coach VALUES (29, 'Roy', 'Hill', 'Goalkeeping Coach', 630741201, 3);
INSERT INTO Coach VALUES (30, 'Erin', 'Duncan', 'Tactical Analyst', 631655369, 3);
INSERT INTO Coach VALUES (31, 'Nicole', 'Patrick', 'Physiotherapist', 655980732, 3);
INSERT INTO Coach VALUES (32, 'Jessica', 'Jones', 'Nutritionist', 651586170, 3);
INSERT INTO Coach VALUES (33, 'Aaron', 'Vance', 'Defensive Coach', 678749945, 3);
INSERT INTO Coach VALUES (34, 'Nathan', 'Carlson', 'Attacking Coach', 613333159, 3);
INSERT INTO Coach VALUES (35, 'Alison', 'Martinez', 'Video Analyst', 671798851, 3);
INSERT INTO Coach VALUES (36, 'Joseph', 'Cooper', 'Sports Psychologist', 637088049, 3);
INSERT INTO Coach VALUES (37, 'Dennis', 'Bennett', 'Masseur', 621550334, 3);
INSERT INTO Coach VALUES (38, 'Regina', 'Miller', 'Team Doctor', 687096225, 3);
INSERT INTO Coach VALUES(39, 'Shelly', 'Jones', 'Technical Director', 657645091, 3);

-- FC Mar Azul
INSERT INTO Coach VALUES (40, 'Catherine', 'Holland', 'Assistant Coach', 638985988, 4);
INSERT INTO Coach VALUES (41, 'Tyler', 'Gonzalez', 'Fitness Coach', 690814748, 4);
INSERT INTO Coach VALUES (42, 'Karen', 'Pacheco', 'Goalkeeping Coach', 621796184, 4);
INSERT INTO Coach VALUES (43, 'Gordon', 'Fletcher', 'Tactical Analyst', 610661265, 4);
INSERT INTO Coach VALUES (44, 'Katelyn', 'Wilson', 'Physiotherapist', 634739987, 4);
INSERT INTO Coach VALUES (45, 'Matthew', 'Gibson', 'Nutritionist', 698073844, 4);
INSERT INTO Coach VALUES (46, 'Michael', 'Mcconnell', 'Defensive Coach', 683442565, 4);
INSERT INTO Coach VALUES (47, 'Teresa', 'Williams', 'Attacking Coach', 604194224, 4);
INSERT INTO Coach VALUES (48, 'Jack', 'Thomas', 'Video Analyst', 642194475, 4);
INSERT INTO Coach VALUES (49, 'Michael', 'Black', 'Sports Psychologist', 692735945, 4);
INSERT INTO Coach VALUES (50, 'Eddie', 'Martinez', 'Masseur', 691489181, 4);
INSERT INTO Coach VALUES (51, 'Jacqueline', 'Park', 'Team Doctor', 650773257, 4);
INSERT INTO Coach VALUES (52, 'Kelsey', 'Roberts', 'Technical Director', 601981253, 4);

-- CD Castellanos
INSERT INTO Coach VALUES(53, 'Paul', 'Griffith', 'Assistant Coach', 665078563, 5);
INSERT INTO Coach VALUES (54, 'Jesse', 'Martinez', 'Fitness Coach', 628606777, 5);
INSERT INTO Coach VALUES (55, 'Linda', 'Hall', 'Goalkeeping Coach', 619683091, 5);
INSERT INTO Coach VALUES(56, 'Nicole', 'Harris', 'Tactical Analyst', 644342737, 5);
INSERT INTO Coach VALUES (57, 'Lisa', 'Pearson', 'Physiotherapist', 633674072, 5);
INSERT INTO Coach VALUES (58, 'Stephen', 'Hill', 'Nutritionist', 688752297, 5);
INSERT INTO Coach VALUES (59, 'Kim', 'Joseph', 'Defensive Coach', 619176000, 5);
INSERT INTO Coach VALUES (60, 'Emily', 'Adams', 'Attacking Coach', 692950277, 5);
INSERT INTO Coach VALUES (61, 'Samantha', 'Thompson', 'Video Analyst', 645365059, 5);
INSERT INTO Coach VALUES (62, 'William', 'Murphy', 'Sports Psychologist', 627835088, 5);
INSERT INTO Coach VALUES (63, 'Nicholas', 'Horton', 'Masseur', 651157558, 5);
INSERT INTO Coach VALUES (64, 'April', 'Cross', 'Team Doctor', 622645272, 5);
INSERT INTO Coach VALUES (65, 'Colleen', 'Fisher', 'Technical Director', 616965784, 5);

-- Union Andorra
INSERT INTO Coach VALUES(66, 'Riley', 'Lara', 'Assistant Coach', 697349389, 6);
INSERT INTO Coach VALUES(67, 'Thomas', 'Perry', 'Fitness Coach', 611184543, 6);
INSERT INTO Coach VALUES(68, 'Jenny', 'Mills', 'Goalkeeping Coach', 672085197, 6);
INSERT INTO Coach VALUES (69, 'Christopher', 'Patrick', 'Tactical Analyst', 699388141, 6);
INSERT INTO Coach VALUES(70, 'Samuel', 'Jones', 'Physiotherapist', 601963991, 6);
INSERT INTO Coach VALUES (71, 'Kevin', 'Tanner', 'Nutritionist', 609059372, 6);
INSERT INTO Coach VALUES(72, 'Jeffrey', 'Bennett', 'Defensive Coach', 643460063, 6);
INSERT INTO Coach VALUES (73, 'Elizabeth', 'Campbell', 'Attacking Coach', 695188387, 6);
INSERT INTO Coach VALUES (74, 'Mark', 'Dawson', 'Video Analyst', 692957973, 6);
INSERT INTO Coach VALUES (75, 'Rebecca', 'Buchanan', 'Sports Psychologist', 632571137, 6);
INSERT INTO Coach VALUES (76, 'James', 'Cummings', 'Masseur', 681199835, 6);
INSERT INTO Coach VALUES (77, 'Adam', 'Lopez', 'Team Doctor', 618098518, 6);
INSERT INTO Coach VALUES (78, 'Benjamin', 'Miller', 'Technical Director', 607101916, 6);

-- Tractor Galactico CF
INSERT INTO Coach VALUES(79, 'Donna', 'Lamb', 'Assistant Coach', 623996264, 7);
INSERT INTO Coach VALUES(80, 'Anna', 'Montgomery', 'Fitness Coach', 682446743, 7);
INSERT INTO Coach VALUES(81, 'Jacob', 'Parker', 'Goalkeeping Coach', 654509651, 7);
INSERT INTO Coach VALUES(82, 'Amber', 'Cole', 'Tactical Analyst', 652901218, 7);
INSERT INTO Coach VALUES(83, 'Kelly', 'Collins', 'Physiotherapist', 695161668, 7);
INSERT INTO Coach VALUES(84, 'Kevin', 'Butler', 'Nutritionist', 680374178, 7);
INSERT INTO Coach VALUES(85, 'Joshua', 'Anderson', 'Defensive Coach', 695406030, 7);
INSERT INTO Coach VALUES(86, 'Adrienne', 'Clark', 'Attacking Coach', 643976913, 7);
INSERT INTO Coach VALUES(87, 'Sarah', 'Griffin', 'Video Analyst', 643086048, 7);
INSERT INTO Coach VALUES(88, 'Judy', 'Grant', 'Sports Psychologist', 604380247, 7);
INSERT INTO Coach VALUES(89, 'James', 'Anderson', 'Masseur', 647317569, 7);
INSERT INTO Coach VALUES(90, 'Benjamin', 'Johnson', 'Team Doctor', 633348753, 7);
INSERT INTO Coach VALUES(91, 'Michael', 'Robinson', 'Technical Director', 659914396, 7);

select * from Coaching_degree
INSERT INTO Coaching_degree VALUES(1, 'UEFA Goalkeeping License');
INSERT INTO Coaching_degree VALUES(1, 'FIFA Goalkeeping Coaching Certificate');
INSERT INTO Coaching_degree VALUES(2, 'UEFA A License');
INSERT INTO Coaching_degree VALUES(2, 'UEFA B License');
INSERT INTO Coaching_degree VALUES(3, 'CSCS');
INSERT INTO Coaching_degree VALUES(3, 'UEFA Fitness Coaching Certificate');
INSERT INTO Coaching_degree VALUES(4, 'UEFA Tactical Analysis Module');
INSERT INTO Coaching_degree VALUES(4, 'PFSA Level 2 Performance Analysis');
INSERT INTO Coaching_degree VALUES(5, 'FIFA Medical Diploma');
INSERT INTO Coaching_degree VALUES(5, 'MSc in Sports Physiotherapy');
INSERT INTO Coaching_degree VALUES(6, 'CISSN');
INSERT INTO Coaching_degree VALUES(6, 'Sports Nutrition Certificate');
INSERT INTO Coaching_degree VALUES(7, 'UEFA A License');
INSERT INTO Coaching_degree VALUES(8, 'FIFA Medical Diploma');
INSERT INTO Coaching_degree VALUES(9, 'Certified Massage Therapist (CMT)');
INSERT INTO Coaching_degree VALUES(10, 'Certified Mental Performance Consultant (CMPC)');
INSERT INTO Coaching_degree VALUES(11, 'Video Analysis Certification');
INSERT INTO Coaching_degree VALUES(11, 'PFSA Level 1 Performance Analysis');
INSERT INTO Coaching_degree VALUES(12, 'UEFA Technical Director Diploma');
INSERT INTO Coaching_degree VALUES(12, 'FIFA Technical Leadership Diploma');
INSERT INTO Coaching_degree VALUES(13, 'UEFA A License');
INSERT INTO Coaching_degree VALUES(14, 'UEFA Goalkeeping License');
INSERT INTO Coaching_degree VALUES(14, 'FIFA Goalkeeping Coaching Certificate');
INSERT INTO Coaching_degree VALUES(15, 'UEFA A License');
INSERT INTO Coaching_degree VALUES(15, 'UEFA B License');
INSERT INTO Coaching_degree VALUES(16, 'CSCS');
INSERT INTO Coaching_degree VALUES(16, 'UEFA Fitness Coaching Certificate');
INSERT INTO Coaching_degree VALUES(17, 'UEFA Tactical Analysis Module');
INSERT INTO Coaching_degree VALUES(17, 'PFSA Level 2 Performance Analysis');
INSERT INTO Coaching_degree VALUES(18, 'FIFA Medical Diploma');
INSERT INTO Coaching_degree VALUES(18, 'MSc in Sports Physiotherapy');
INSERT INTO Coaching_degree VALUES(19, 'CISSN');
INSERT INTO Coaching_degree VALUES(19, 'Sports Nutrition Certificate');
INSERT INTO Coaching_degree VALUES(20, 'UEFA A License');
INSERT INTO Coaching_degree VALUES(21, 'FIFA Medical Diploma');
INSERT INTO Coaching_degree VALUES(22, 'Certified Massage Therapist (CMT)');
INSERT INTO Coaching_degree VALUES(23, 'Certified Mental Performance Consultant (CMPC)');
INSERT INTO Coaching_degree VALUES(24, 'Video Analysis Certification');
INSERT INTO Coaching_degree VALUES(24, 'PFSA Level 1 Performance Analysis');
INSERT INTO Coaching_degree VALUES(25, 'UEFA Technical Director Diploma');
INSERT INTO Coaching_degree VALUES(25, 'FIFA Technical Leadership Diploma');
INSERT INTO Coaching_degree VALUES(26, 'UEFA A License');
INSERT INTO Coaching_degree VALUES(27, 'UEFA Goalkeeping License');
INSERT INTO Coaching_degree VALUES(27, 'FIFA Goalkeeping Coaching Certificate');
INSERT INTO Coaching_degree VALUES(28, 'UEFA A License');
INSERT INTO Coaching_degree VALUES(28, 'UEFA B License');
INSERT INTO Coaching_degree VALUES(29, 'CSCS');
INSERT INTO Coaching_degree VALUES (29, 'UEFA Fitness Coaching Certificate');
INSERT INTO Coaching_degree VALUES(30, 'UEFA Tactical Analysis Module');
INSERT INTO Coaching_degree VALUES(30, 'PFSA Level 2 Performance Analysis');
INSERT INTO Coaching_degree VALUES(31, 'FIFA Medical Diploma');
INSERT INTO Coaching_degree VALUES(31, 'MSc in Sports Physiotherapy');
INSERT INTO Coaching_degree VALUES(32, 'CISSN');
INSERT INTO Coaching_degree VALUES (32, 'Sports Nutrition Certificate');
INSERT INTO Coaching_degree VALUES(33, 'UEFA A License');
INSERT INTO Coaching_degree VALUES(34, 'FIFA Medical Diploma');
INSERT INTO Coaching_degree VALUES(35, 'Certified Massage Therapist (CMT)');
INSERT INTO Coaching_degree VALUES(36, 'Certified Mental Performance Consultant (CMPC)');
INSERT INTO Coaching_degree VALUES(37, 'Video Analysis Certification');
INSERT INTO Coaching_degree VALUES(37, 'PFSA Level 1 Performance Analysis');
INSERT INTO Coaching_degree VALUES(38, 'UEFA Technical Director Diploma');
INSERT INTO Coaching_degree VALUES(38, 'FIFA Technical Leadership Diploma');
INSERT INTO Coaching_degree VALUES(39, 'UEFA A License');
INSERT INTO Coaching_degree VALUES(40, 'UEFA Goalkeeping License');
INSERT INTO Coaching_degree VALUES(40, 'FIFA Goalkeeping Coaching Certificate');
INSERT INTO Coaching_degree VALUES(41, 'UEFA A License');
INSERT INTO Coaching_degree VALUES(41, 'UEFA B License');
INSERT INTO Coaching_degree VALUES(42, 'CSCS');
INSERT INTO Coaching_degree VALUES(42, 'UEFA Fitness Coaching Certificate');
INSERT INTO Coaching_degree VALUES(43, 'UEFA Tactical Analysis Module');
INSERT INTO Coaching_degree VALUES(43, 'PFSA Level 2 Performance Analysis');
INSERT INTO Coaching_degree VALUES(44, 'FIFA Medical Diploma');
INSERT INTO Coaching_degree VALUES(44, 'MSc in Sports Physiotherapy');
INSERT INTO Coaching_degree VALUES(45, 'CISSN');
INSERT INTO Coaching_degree VALUES(45, 'Sports Nutrition Certificate');
INSERT INTO Coaching_degree VALUES(46, 'UEFA A License');
INSERT INTO Coaching_degree VALUES(47, 'FIFA Medical Diploma');
INSERT INTO Coaching_degree VALUES(48, 'Certified Massage Therapist (CMT)');
INSERT INTO Coaching_degree VALUES(49, 'Certified Mental Performance Consultant (CMPC)');
INSERT INTO Coaching_degree VALUES(50, 'Video Analysis Certification');
INSERT INTO Coaching_degree VALUES(50, 'PFSA Level 1 Performance Analysis');
INSERT INTO Coaching_degree VALUES(51, 'UEFA Technical Director Diploma');
INSERT INTO Coaching_degree VALUES(51, 'FIFA Technical Leadership Diploma');
INSERT INTO Coaching_degree VALUES(52, 'UEFA A License');
INSERT INTO Coaching_degree VALUES(53, 'UEFA Goalkeeping License');
INSERT INTO Coaching_degree VALUES(53, 'FIFA Goalkeeping Coaching Certificate')
INSERT INTO Coaching_degree VALUES(54, 'UEFA A License');
INSERT INTO Coaching_degree VALUES(54, 'UEFA B License');
INSERT INTO Coaching_degree VALUES(55, 'CSCS');
INSERT INTO Coaching_degree VALUES(55, 'UEFA Fitness Coaching Certificate');
INSERT INTO Coaching_degree VALUES(56, 'UEFA Tactical Analysis Module');
INSERT INTO Coaching_degree VALUES(56, 'PFSA Level 2 Performance Analysis');
INSERT INTO Coaching_degree VALUES(57, 'FIFA Medical Diploma');
INSERT INTO Coaching_degree VALUES(57, 'MSc in Sports Physiotherapy');
INSERT INTO Coaching_degree VALUES(58, 'CISSN');
INSERT INTO Coaching_degree VALUES(58, 'Sports Nutrition Certificate');
INSERT INTO Coaching_degree VALUES(59, 'UEFA A License');
INSERT INTO Coaching_degree VALUES(60, 'FIFA Medical Diploma');
INSERT INTO Coaching_degree VALUES(61, 'Certified Massage Therapist (CMT)');
INSERT INTO Coaching_degree VALUES(62, 'Certified Mental Performance Consultant (CMPC)');
INSERT INTO Coaching_degree VALUES(63, 'Video Analysis Certification');
INSERT INTO Coaching_degree VALUES(63, 'PFSA Level 1 Performance Analysis');
INSERT INTO Coaching_degree VALUES(64, 'UEFA Technical Director Diploma');
INSERT INTO Coaching_degree VALUES(64, 'FIFA Technical Leadership Diploma');
INSERT INTO Coaching_degree VALUES(65, 'UEFA A License');
INSERT INTO Coaching_degree VALUES(66, 'UEFA Goalkeeping License');
INSERT INTO Coaching_degree VALUES(66, 'FIFA Goalkeeping Coaching Certificate');
INSERT INTO Coaching_degree VALUES(67, 'UEFA A License');
INSERT INTO Coaching_degree VALUES(67, 'UEFA B License');
INSERT INTO Coaching_degree VALUES(68, 'CSCS');
INSERT INTO Coaching_degree VALUES(68, 'UEFA Fitness Coaching Certificate');
INSERT INTO Coaching_degree VALUES(69, 'UEFA Tactical Analysis Module');
INSERT INTO Coaching_degree VALUES(69, 'PFSA Level 2 Performance Analysis');
INSERT INTO Coaching_degree VALUES(70, 'FIFA Medical Diploma');
INSERT INTO Coaching_degree VALUES(70, 'MSc in Sports Physiotherapy');
INSERT INTO Coaching_degree VALUES(71, 'CISSN');
INSERT INTO Coaching_degree VALUES(71, 'Sports Nutrition Certificate');
INSERT INTO Coaching_degree VALUES(72, 'UEFA A License');
INSERT INTO Coaching_degree VALUES(73, 'FIFA Medical Diploma');
INSERT INTO Coaching_degree VALUES(74, 'Certified Massage Therapist (CMT)');
INSERT INTO Coaching_degree VALUES(75, 'Certified Mental Performance Consultant (CMPC)');
INSERT INTO Coaching_degree VALUES(76, 'Video Analysis Certification');
INSERT INTO Coaching_degree VALUES(76, 'PFSA Level 1 Performance Analysis');
INSERT INTO Coaching_degree VALUES(77, 'UEFA Technical Director Diploma');
INSERT INTO Coaching_degree VALUES(77, 'FIFA Technical Leadership Diploma');
INSERT INTO Coaching_degree VALUES(78, 'UEFA A License');
INSERT INTO Coaching_degree VALUES(79, 'UEFA Goalkeeping License');
INSERT INTO Coaching_degree VALUES(79, 'FIFA Goalkeeping Coaching Certificate');
INSERT INTO Coaching_degree VALUES(80, 'UEFA A License');
INSERT INTO Coaching_degree VALUES(80, 'UEFA B License');
INSERT INTO Coaching_degree VALUES(81, 'CSCS');
INSERT INTO Coaching_degree VALUES(81, 'UEFA Fitness Coaching Certificate');
INSERT INTO Coaching_degree VALUES(82, 'UEFA Tactical Analysis Module');
INSERT INTO Coaching_degree VALUES(82, 'PFSA Level 2 Performance Analysis');
INSERT INTO Coaching_degree VALUES(83, 'FIFA Medical Diploma');
INSERT INTO Coaching_degree VALUES(83, 'MSc in Sports Physiotherapy');
INSERT INTO Coaching_degree VALUES(84, 'CISSN');
INSERT INTO Coaching_degree VALUES(84, 'Sports Nutrition Certificate');
INSERT INTO Coaching_degree VALUES(85, 'UEFA A License');
INSERT INTO Coaching_degree VALUES(86, 'FIFA Medical Diploma');
INSERT INTO Coaching_degree VALUES(87, 'Certified Massage Therapist (CMT)');
INSERT INTO Coaching_degree VALUES(88, 'Certified Mental Performance Consultant (CMPC)');
INSERT INTO Coaching_degree VALUES (89, 'Video Analysis Certification');
INSERT INTO Coaching_degree VALUES(89, 'PFSA Level 1 Performance Analysis');
INSERT INTO Coaching_degree VALUES(90, 'UEFA Technical Director Diploma');
INSERT INTO Coaching_degree VALUES(90, 'FIFA Technical Leadership Diploma');
INSERT INTO Coaching_degree VALUES (91, 'UEFA A License');

ALTER TABLE head_coach
ADD head_coach_photo_url varchar(150); 

Select * from head_coach
INSERT INTO head_coach VALUES(1,'Luis', 'Gomez', '623456789', 1);
INSERT INTO head_coach VALUES(2,'Andres', 'Moreno', '698765432', 2);
INSERT INTO head_coach VALUES(3, 'Danielle', 'Ford', '653979852', 3);
INSERT INTO head_coach VALUES(4, 'Kelly', 'Patterson', '678873098', 4);
INSERT INTO head_coach VALUES(5, 'Donna', 'Williamson','685410706', 5);
INSERT INTO head_coach VALUES(6, 'Jessica', 'King', '627290299', 6);
INSERT INTO head_coach VALUES(7,'Raul', 'Hernandez', '654321098', 7);

Select * from Head_Coaching_Degree
INSERT INTO Head_Coaching_Degree VALUES(1,'UEFA A License');
INSERT INTO Head_Coaching_Degree VALUES(1,'UEFA B License');
INSERT INTO Head_Coaching_Degree VALUES(1,'UEFA C License');
INSERT INTO Head_Coaching_Degree VALUES(2,'UEFA A License');
INSERT INTO Head_Coaching_Degree VALUES(2,'UEFA B License');
INSERT INTO Head_Coaching_Degree VALUES(3,'UEFA Pro License');
INSERT INTO Head_Coaching_Degree VALUES(3,'UEFA A License');
INSERT INTO Head_Coaching_Degree VALUES(3,'UEFA B License');
INSERT INTO Head_Coaching_Degree VALUES(4,'UEFA B License');
INSERT INTO Head_Coaching_Degree VALUES(4,'UEFA C License');
INSERT INTO Head_Coaching_Degree VALUES(5,'UEFA Pro License');
INSERT INTO Head_Coaching_Degree VALUES(5,'UEFA A License');
INSERT INTO Head_Coaching_Degree VALUES(6,'UEFA A License');
INSERT INTO Head_Coaching_Degree VALUES(6,'UEFA B License');
INSERT INTO Head_Coaching_Degree VALUES(7,'UEFA Pro License');
INSERT INTO Head_Coaching_Degree VALUES(7,'UEFA A License');
INSERT INTO Head_Coaching_Degree VALUES(7,'UEFA B License');

select * from referee
INSERT INTO referee VALUES(1, 'Alicia', 'Nguyen', NULL,NULL, NULL);
INSERT INTO referee VALUES (2, 'Hayley', 'Burgess', NULL,NULL, NULL);
INSERT INTO referee VALUES(3, 'Donna', 'Phillips', NULL,NULL, NULL);
INSERT INTO referee VALUES(4, 'Ross', 'Davis', NULL,NULL, NULL);
INSERT INTO referee VALUES(5, 'Jared', 'Short', NULL,NULL, NULL);
INSERT INTO referee VALUES (6, 'Anna', 'Barber', NULL,NULL, NULL);
INSERT INTO referee VALUES (7, 'Brandon', 'Coffey', NULL,NULL, NULL);
INSERT INTO referee VALUES (8, 'Michelle', 'Andrews', NULL,NULL, NULL);
INSERT INTO referee VALUES (9, 'Heather', 'Valentine', NULL,NULL, NULL);
INSERT INTO referee VALUES (10, 'Adam', 'Maynard', NULL,NULL, NULL);
INSERT INTO referee VALUES (11, 'Matthew', 'Brock', NULL,NULL, NULL);
INSERT INTO referee VALUES (12, 'Jacob', 'Porter', NULL,NULL, NULL);
INSERT INTO referee VALUES (13, 'Jessica', 'Green', NULL,NULL, NULL);
INSERT INTO referee VALUES (14, 'Brett', 'Guerrero', NULL,NULL, NULL);
INSERT INTO referee VALUES (15, 'Michelle', 'Adams', NULL,NULL, NULL);
INSERT INTO referee VALUES (16, 'Craig', 'Novak', NULL,NULL, NULL);
INSERT INTO referee VALUES(17, 'Keith', 'Hayes', NULL,NULL, NULL);
INSERT INTO referee VALUES (18, 'Stacey', 'Johnson', NULL,NULL, NULL);
INSERT INTO referee VALUES (19, 'Emily', 'Delacruz', NULL,NULL, NULL);
INSERT INTO referee VALUES (20, 'Laura', 'Horn', NULL,NULL, NULL);

Select * from Referee_Per_Match
-- Match 1
INSERT INTO Referee_Per_Match VALUES(1,5,'main');
INSERT INTO Referee_Per_Match VALUES(1,9,'asist');
INSERT INTO Referee_Per_Match VALUES(1,2,'asist');
INSERT INTO Referee_Per_Match VALUES(1,7,'asist');
-- Match 2
INSERT INTO Referee_Per_Match VALUES(2,5,'main');
INSERT INTO Referee_Per_Match VALUES(2,11,'asist');
INSERT INTO Referee_Per_Match VALUES(2,10,'asist');
INSERT INTO Referee_Per_Match VALUES(2,13,'asist');
-- Match 3
INSERT INTO Referee_Per_Match VALUES(3,9,'main');
INSERT INTO Referee_Per_Match VALUES(3,10,'asist');
INSERT INTO Referee_Per_Match VALUES(3,8,'asist');
INSERT INTO Referee_Per_Match VALUES(3,15,'asist');
-- Match 4
INSERT INTO Referee_Per_Match VALUES(4,19,'main');
INSERT INTO Referee_Per_Match VALUES(4,17,'asist');
INSERT INTO Referee_Per_Match VALUES(4,8,'asist');
INSERT INTO Referee_Per_Match VALUES(4,13,'asist');
-- Match 5
INSERT INTO Referee_Per_Match VALUES(5,4,'main');
INSERT INTO Referee_Per_Match VALUES(5,18,'asist');
INSERT INTO Referee_Per_Match VALUES(5,13,'asist');
INSERT INTO Referee_Per_Match VALUES(5,16,'asist');
-- Match 6
INSERT INTO Referee_Per_Match VALUES(6,6,'main');
INSERT INTO Referee_Per_Match VALUES(6,4,'asist');
INSERT INTO Referee_Per_Match VALUES(6,13,'asist');
INSERT INTO Referee_Per_Match VALUES(6,14,'asist');
-- Match 7
INSERT INTO Referee_Per_Match VALUES(7,4,'main');
INSERT INTO Referee_Per_Match VALUES(7,15,'asist');
INSERT INTO Referee_Per_Match VALUES(7,14,'asist');
INSERT INTO Referee_Per_Match VALUES(7,12,'asist');
-- Match 8
INSERT INTO Referee_Per_Match VALUES(8,14,'main');
INSERT INTO Referee_Per_Match VALUES(8,7,'asist');
INSERT INTO Referee_Per_Match VALUES(8,20,'asist');
INSERT INTO Referee_Per_Match VALUES(8,10,'asist');
-- Match 9
INSERT INTO Referee_Per_Match VALUES(9,17,'main');
INSERT INTO Referee_Per_Match VALUES(9,6,'asist');
INSERT INTO Referee_Per_Match VALUES(9,18,'asist');
INSERT INTO Referee_Per_Match VALUES(9,3,'asist');
-- Match 10
INSERT INTO Referee_Per_Match VALUES(10,1,'main');
INSERT INTO Referee_Per_Match VALUES(10,4,'asist');
INSERT INTO Referee_Per_Match VALUES(10,15,'asist');
INSERT INTO Referee_Per_Match VALUES(10,10,'asist');
-- Match 11
INSERT INTO Referee_Per_Match VALUES(11,18,'main');
INSERT INTO Referee_Per_Match VALUES(11,5,'asist');
INSERT INTO Referee_Per_Match VALUES(11,2,'asist');
INSERT INTO Referee_Per_Match VALUES(11,6,'asist');
-- Match 12
INSERT INTO Referee_Per_Match VALUES(12,10,'main');
INSERT INTO Referee_Per_Match VALUES(12,5,'asist');
INSERT INTO Referee_Per_Match VALUES(12,8,'asist');
INSERT INTO Referee_Per_Match VALUES(12,3,'asist');
-- Match 13
INSERT INTO Referee_Per_Match VALUES(13,9,'main');
INSERT INTO Referee_Per_Match VALUES(13,16,'asist');
INSERT INTO Referee_Per_Match VALUES(13,18,'asist');
INSERT INTO Referee_Per_Match VALUES(13,19,'asist');
-- Match 14
INSERT INTO Referee_Per_Match VALUES(14,3,'main');
INSERT INTO Referee_Per_Match VALUES(14,14,'asist');
INSERT INTO Referee_Per_Match VALUES(14,2,'asist');
INSERT INTO Referee_Per_Match VALUES(14,18,'asist');
-- Match 15
INSERT INTO Referee_Per_Match VALUES(15,3,'main');
INSERT INTO Referee_Per_Match VALUES(15,11,'asist');
INSERT INTO Referee_Per_Match VALUES(15,13,'asist');
INSERT INTO Referee_Per_Match VALUES(15,7,'asist');
-- Match 16
INSERT INTO Referee_Per_Match VALUES(16,18,'main');
INSERT INTO Referee_Per_Match VALUES(16,9,'asist');
INSERT INTO Referee_Per_Match VALUES(16,12,'asist');
INSERT INTO Referee_Per_Match VALUES(16,13,'asist');
-- Match 17
INSERT INTO Referee_Per_Match VALUES(17,19,'main');
INSERT INTO Referee_Per_Match VALUES(17,10,'asist');
INSERT INTO Referee_Per_Match VALUES(17,4,'asist');
INSERT INTO Referee_Per_Match VALUES(17,14,'asist');
-- Match 18
INSERT INTO Referee_Per_Match VALUES(18,1,'main');
INSERT INTO Referee_Per_Match VALUES(18,3,'asist');
INSERT INTO Referee_Per_Match VALUES(18,7,'asist');
INSERT INTO Referee_Per_Match VALUES(18,9,'asist');
-- Match 19
INSERT INTO Referee_Per_Match VALUES(19,13,'main');
INSERT INTO Referee_Per_Match VALUES(19,11,'asist');
INSERT INTO Referee_Per_Match VALUES(19,9,'asist');
INSERT INTO Referee_Per_Match VALUES(19,14,'asist');
-- Match 20
INSERT INTO Referee_Per_Match VALUES(20,6,'main');
INSERT INTO Referee_Per_Match VALUES(20,7,'asist');
INSERT INTO Referee_Per_Match VALUES(20,16,'asist');
INSERT INTO Referee_Per_Match VALUES(20,2,'asist');
-- Match 21
INSERT INTO Referee_Per_Match VALUES(21,9,'main');
INSERT INTO Referee_Per_Match VALUES(21,4,'asist');
INSERT INTO Referee_Per_Match VALUES(21,18,'asist');
INSERT INTO Referee_Per_Match VALUES(21,14,'asist');
-- Match 22
INSERT INTO Referee_Per_Match VALUES(22,13,'main');
INSERT INTO Referee_Per_Match VALUES(22,5,'asist');
INSERT INTO Referee_Per_Match VALUES(22,7,'asist');
INSERT INTO Referee_Per_Match VALUES(22,2,'asist');
-- Match 23
INSERT INTO Referee_Per_Match VALUES(23,11,'main');
INSERT INTO Referee_Per_Match VALUES(23,20,'asist');
INSERT INTO Referee_Per_Match VALUES(23,16,'asist');
INSERT INTO Referee_Per_Match VALUES(23,9,'asist');
-- Match 24
INSERT INTO Referee_Per_Match VALUES(24,19,'main');
INSERT INTO Referee_Per_Match VALUES(24,18,'asist');
INSERT INTO Referee_Per_Match VALUES(24,8,'asist');
INSERT INTO Referee_Per_Match VALUES(24,13,'asist');
-- Match 25
INSERT INTO Referee_Per_Match VALUES(25,3,'main');
INSERT INTO Referee_Per_Match VALUES(25,16,'asist');
INSERT INTO Referee_Per_Match VALUES(25,9,'asist');
INSERT INTO Referee_Per_Match VALUES(25,1,'asist');
-- Match 26
INSERT INTO Referee_Per_Match VALUES(26,7,'main');
INSERT INTO Referee_Per_Match VALUES(26,10,'asist');
INSERT INTO Referee_Per_Match VALUES(26,11,'asist');
INSERT INTO Referee_Per_Match VALUES(26,5,'asist');
-- Match 27
INSERT INTO Referee_Per_Match VALUES(27,19,'main');
INSERT INTO Referee_Per_Match VALUES(27,16,'asist');
INSERT INTO Referee_Per_Match VALUES(27,3,'asist');
INSERT INTO Referee_Per_Match VALUES(27,9,'asist');
-- Match 28
INSERT INTO Referee_Per_Match VALUES(28,15,'main');
INSERT INTO Referee_Per_Match VALUES(28,14,'asist');
INSERT INTO Referee_Per_Match VALUES(28,13,'asist');
INSERT INTO Referee_Per_Match VALUES(28,7,'asist');
-- Match 29
INSERT INTO Referee_Per_Match VALUES(29,14,'main');
INSERT INTO Referee_Per_Match VALUES(29,1,'asist');
INSERT INTO Referee_Per_Match VALUES(29,18,'asist');
INSERT INTO Referee_Per_Match VALUES(29,12,'asist');
-- Match 30
INSERT INTO Referee_Per_Match VALUES(30,19,'main');
INSERT INTO Referee_Per_Match VALUES(30,5,'asist');
INSERT INTO Referee_Per_Match VALUES(30,15,'asist');
INSERT INTO Referee_Per_Match VALUES(30,16,'asist');
-- Match 31
INSERT INTO Referee_Per_Match VALUES(31,5,'main');
INSERT INTO Referee_Per_Match VALUES(31,9,'asist');
INSERT INTO Referee_Per_Match VALUES(31,20,'asist');
INSERT INTO Referee_Per_Match VALUES(31,16,'asist');
-- Match 32
INSERT INTO Referee_Per_Match VALUES(32,6,'main');
INSERT INTO Referee_Per_Match VALUES(32,18,'asist');
INSERT INTO Referee_Per_Match VALUES(32,3,'asist');
INSERT INTO Referee_Per_Match VALUES(32,8,'asist');
-- Match 33
INSERT INTO Referee_Per_Match VALUES(33,18,'main');
INSERT INTO Referee_Per_Match VALUES(33,3,'asist');
INSERT INTO Referee_Per_Match VALUES(33,5,'asist');
INSERT INTO Referee_Per_Match VALUES(33,10,'asist');
-- Match 34
INSERT INTO Referee_Per_Match VALUES(34,12,'main');
INSERT INTO Referee_Per_Match VALUES(34,11,'asist');
INSERT INTO Referee_Per_Match VALUES(34,5,'asist');
INSERT INTO Referee_Per_Match VALUES(34,2,'asist');
-- Match 35
INSERT INTO Referee_Per_Match VALUES(35,2,'main');
INSERT INTO Referee_Per_Match VALUES(35,13,'asist');
INSERT INTO Referee_Per_Match VALUES(35,15,'asist');
INSERT INTO Referee_Per_Match VALUES(35,14,'asist');
-- Match 36
INSERT INTO Referee_Per_Match VALUES(36,16,'main');
INSERT INTO Referee_Per_Match VALUES(36,1,'asist');
INSERT INTO Referee_Per_Match VALUES(36,15,'asist');
INSERT INTO Referee_Per_Match VALUES(36,19,'asist');
-- Match 37
INSERT INTO Referee_Per_Match VALUES(37,20,'main');
INSERT INTO Referee_Per_Match VALUES(37,11,'asist');
INSERT INTO Referee_Per_Match VALUES(37,8,'asist');
INSERT INTO Referee_Per_Match VALUES(37,2,'asist');
-- Match 38
INSERT INTO Referee_Per_Match VALUES(38,12,'main');
INSERT INTO Referee_Per_Match VALUES(38,16,'asist');
INSERT INTO Referee_Per_Match VALUES(38,9,'asist');
INSERT INTO Referee_Per_Match VALUES(38,5,'asist');
-- Match 39
INSERT INTO Referee_Per_Match VALUES(39,17,'main');
INSERT INTO Referee_Per_Match VALUES(39,19,'asist');
INSERT INTO Referee_Per_Match VALUES(39,2,'asist');
INSERT INTO Referee_Per_Match VALUES(39,15,'asist');
-- Match 40
INSERT INTO Referee_Per_Match VALUES(40,4,'main');
INSERT INTO Referee_Per_Match VALUES(40,3,'asist');
INSERT INTO Referee_Per_Match VALUES(40,15,'asist');
INSERT INTO Referee_Per_Match VALUES(40,10,'asist');
-- Match 41
INSERT INTO Referee_Per_Match VALUES(41,5,'main');
INSERT INTO Referee_Per_Match VALUES(41,17,'asist');
INSERT INTO Referee_Per_Match VALUES(41,15,'asist');
INSERT INTO Referee_Per_Match VALUES(41,12,'asist');
-- Match 42
INSERT INTO Referee_Per_Match VALUES(42,10,'main');
INSERT INTO Referee_Per_Match VALUES(42,20,'asist');
INSERT INTO Referee_Per_Match VALUES(42,19,'asist');
INSERT INTO Referee_Per_Match VALUES(42,8,'asist');

Select * from Teamplays
INSERT INTO Teamplays VALUES(1,1,1);
INSERT INTO Teamplays VALUES(1,2,0);
INSERT INTO Teamplays VALUES(2,2,1);
INSERT INTO Teamplays VALUES(2,1,0);
INSERT INTO Teamplays VALUES(3,1,1);
INSERT INTO Teamplays VALUES(3,3,0);
INSERT INTO Teamplays VALUES(4,3,1);
INSERT INTO Teamplays VALUES(4,1,0);
INSERT INTO Teamplays VALUES(5,1,1);
INSERT INTO Teamplays VALUES(5,4,0);
INSERT INTO Teamplays VALUES(6,4,1);
INSERT INTO Teamplays VALUES(6,1,0);
INSERT INTO Teamplays VALUES(7,1,1);
INSERT INTO Teamplays VALUES(7,5,0);
INSERT INTO Teamplays VALUES(8,5,1);
INSERT INTO Teamplays VALUES(8,1,0);
INSERT INTO Teamplays VALUES(9,1,1);
INSERT INTO Teamplays VALUES(9,6,0);
INSERT INTO Teamplays VALUES(10,6,1);
INSERT INTO Teamplays VALUES(10,1,0);
INSERT INTO Teamplays VALUES(11,2,1);
INSERT INTO Teamplays VALUES(11,3,0);
INSERT INTO Teamplays VALUES(12,3,1);
INSERT INTO Teamplays VALUES(12,2,0);
INSERT INTO Teamplays VALUES(13,2,1);
INSERT INTO Teamplays VALUES(13,4,0);
INSERT INTO Teamplays VALUES(14,4,1);
INSERT INTO Teamplays VALUES(14,2,0);
INSERT INTO Teamplays VALUES(15,2,1);
INSERT INTO Teamplays VALUES(15,5,0);
INSERT INTO Teamplays VALUES(16,5,1);
INSERT INTO Teamplays VALUES(16,2,0);
INSERT INTO Teamplays VALUES(17,2,1);
INSERT INTO Teamplays VALUES(17,6,0);
INSERT INTO Teamplays VALUES(18,6,1);
INSERT INTO Teamplays VALUES(18,2,0);
INSERT INTO Teamplays VALUES(19,3,1);
INSERT INTO Teamplays VALUES(19,4,0);
INSERT INTO Teamplays VALUES(20,4,1);
INSERT INTO Teamplays VALUES(20,3,0);
INSERT INTO Teamplays VALUES(21,3,1);
INSERT INTO Teamplays VALUES(21,5,0);
INSERT INTO Teamplays VALUES(22,5,1);
INSERT INTO Teamplays VALUES(22,3,0);
INSERT INTO Teamplays VALUES(23,3,1);
INSERT INTO Teamplays VALUES(23,6,0);
INSERT INTO Teamplays VALUES(24,6,1);
INSERT INTO Teamplays VALUES(24,3,0);
INSERT INTO Teamplays VALUES(25,4,1);
INSERT INTO Teamplays VALUES(25,5,0);
INSERT INTO Teamplays VALUES(26,5,1);
INSERT INTO Teamplays VALUES(26,4,0);
INSERT INTO Teamplays VALUES(27,4,1);
INSERT INTO Teamplays VALUES(27,6,0);
INSERT INTO Teamplays VALUES(28,6,1);
INSERT INTO Teamplays VALUES(28,4,0);
INSERT INTO Teamplays VALUES(29,5,1);
INSERT INTO Teamplays VALUES(29,6,0);
INSERT INTO Teamplays VALUES(30,6,1);
INSERT INTO Teamplays VALUES(30,5,0);
INSERT INTO Teamplays VALUES(31,7,1);
INSERT INTO Teamplays VALUES(31,1,0);
INSERT INTO Teamplays VALUES(32,1,1);
INSERT INTO Teamplays VALUES(32,7,0);
INSERT INTO Teamplays VALUES(33,7,1);
INSERT INTO Teamplays VALUES(33,2,0);
INSERT INTO Teamplays VALUES(34,2,1);
INSERT INTO Teamplays VALUES(34,7,0);
INSERT INTO Teamplays VALUES(35,7,1);
INSERT INTO Teamplays VALUES(35,3,0);
INSERT INTO Teamplays VALUES(36,3,1);
INSERT INTO Teamplays VALUES(36,7,0);
INSERT INTO Teamplays VALUES(37,7,1);
INSERT INTO Teamplays VALUES(37,4,0);
INSERT INTO Teamplays VALUES(38,4,1);
INSERT INTO Teamplays VALUES(38,7,0);
INSERT INTO Teamplays VALUES(39,7,1);
INSERT INTO Teamplays VALUES(39,5,0);
INSERT INTO Teamplays VALUES(40,5,1);
INSERT INTO Teamplays VALUES(40,7,0);
INSERT INTO Teamplays VALUES(41,7,1);
INSERT INTO Teamplays VALUES(41,6,0);
INSERT INTO Teamplays VALUES(42,6,1);
INSERT INTO Teamplays VALUES(42,7,0);

Select * from Scored_Goal_in_Match
-- Match 1
INSERT INTO Scored_Goal_in_Match VALUES(1,1, 8, 34, 15,'Header', 0);
INSERT INTO Scored_Goal_in_Match VALUES(1,1, 14, 41, 10,'Header', 0);
INSERT INTO Scored_Goal_in_Match VALUES(1,1, 5, 45, 14,'Inside Box Shot', 0);
INSERT INTO Scored_Goal_in_Match VALUES(1,1, 4, 62, 17,'Penalty', 0);
INSERT INTO Scored_Goal_in_Match VALUES(1,2, 39, 23, 30,'Rebound', 0);
INSERT INTO Scored_Goal_in_Match VALUES(1,2, 30, 37, 38,'Free Kick', 0);
INSERT INTO Scored_Goal_in_Match VALUES(1,2, 37, 74, 24,'Goal from Corner', 0);
-- Match 2
INSERT INTO Scored_Goal_in_Match VALUES(2,2, 22, 10, 24,'Goal from Corner', 0);
INSERT INTO Scored_Goal_in_Match VALUES(2,2, 32, 18, 34,' Outside Box Shot', 0);
INSERT INTO Scored_Goal_in_Match VALUES(2,1, 13, 66, 4,'Dribble Past Goalkeeper', 0);
INSERT INTO Scored_Goal_in_Match VALUES(2,1, 2, 92, 11,' Outside Box Shot', 0);
-- Match 3
INSERT INTO Scored_Goal_in_Match VALUES(3,1, 13, 58, 3,' Outside Box Shot', 0);
INSERT INTO Scored_Goal_in_Match VALUES(3,1, 11, 64, 13,'Goal from Corner', 0);
INSERT INTO Scored_Goal_in_Match VALUES(3,1, 12, 70, 6,'Penalty', 0);
INSERT INTO Scored_Goal_in_Match VALUES(3,3, 43, 48, 56,' Outside Box Shot', 0);
-- Match 4
INSERT INTO Scored_Goal_in_Match VALUES(4,3, 41, 23, 46,'Penalty', 0);
INSERT INTO Scored_Goal_in_Match VALUES(4,3, 45, 39, 41,'Free Kick', 0);
INSERT INTO Scored_Goal_in_Match VALUES(4,3, 56, 43, 57,'Free Kick', 0);
INSERT INTO Scored_Goal_in_Match VALUES(4,3, 57, 69, 46,'Dribble Past Goalkeeper', 0);
-- Match 5
INSERT INTO Scored_Goal_in_Match VALUES(5,1, 11, 27, 15,'One-Touch Finish', 0);
INSERT INTO Scored_Goal_in_Match VALUES(5,1, 12, 37, 16,'One-Touch Finish', 0);
INSERT INTO Scored_Goal_in_Match VALUES(5,1, 4, 46, 1,'Header', 0);
INSERT INTO Scored_Goal_in_Match VALUES(5,1, 10, 49, 13,'Dribble Past Goalkeeper', 0);
INSERT INTO Scored_Goal_in_Match VALUES(5,4, 69, 16, 74,'Free Kick', 0);
-- Match 6
INSERT INTO Scored_Goal_in_Match VALUES(6,4, 75, 36, 64,'Inside Box Shot', 0);
INSERT INTO Scored_Goal_in_Match VALUES(6,1, 19, 4, 1,'Goal from Corner', 0);
INSERT INTO Scored_Goal_in_Match VALUES(6,1, 19, 41, 10,'Inside Box Shot', 0);
INSERT INTO Scored_Goal_in_Match VALUES(6,1, 1, 52, 18,'Rebound', 0);
-- Match 7
INSERT INTO Scored_Goal_in_Match VALUES(7,1, 5, 17, 11,'One-Touch Finish', 0);
INSERT INTO Scored_Goal_in_Match VALUES(7,1, 2, 27, 18,'Goal from Corner', 0);
INSERT INTO Scored_Goal_in_Match VALUES(7,1, 3, 43, 1,'Dribble Past Goalkeeper', 0);
INSERT INTO Scored_Goal_in_Match VALUES(7,5, 99, 69, 82,' Outside Box Shot', 0);
INSERT INTO Scored_Goal_in_Match VALUES(7,5, 96, 74, 94,' Outside Box Shot', 0);
INSERT INTO Scored_Goal_in_Match VALUES(7,5, 95, 80, 98,'Header', 0);
INSERT INTO Scored_Goal_in_Match VALUES(7,5, 85, 88, 99,'Dribble Past Goalkeeper', 0);
-- Match 8
INSERT INTO Scored_Goal_in_Match VALUES(8,1, 13, 29, 19,'Free Kick', 0);
INSERT INTO Scored_Goal_in_Match VALUES(8,1, 7, 67, 2,'Penalty', 0);
INSERT INTO Scored_Goal_in_Match VALUES(8,1, 17, 90, 20,'Rebound', 0);
-- Match 9
INSERT INTO Scored_Goal_in_Match VALUES(9,1, 13, 40, 5,'Header', 0);
INSERT INTO Scored_Goal_in_Match VALUES(9,1, 12, 57, 13,'One-Touch Finish', 0);
INSERT INTO Scored_Goal_in_Match VALUES(9,1, 10, 63, 2,'Dribble Past Goalkeeper', 0);
INSERT INTO Scored_Goal_in_Match VALUES(9,1, 5, 69, 14,'Rebound', 0);
INSERT INTO Scored_Goal_in_Match VALUES(9,6, 120, 48, 117,'Penalty', 0);
-- Match 10
INSERT INTO Scored_Goal_in_Match VALUES(10,6, 116, 60, 116,'Counter-Attack Goal', 0);
INSERT INTO Scored_Goal_in_Match VALUES(10,1, 7, 10, 13,' Outside Box Shot', 0);
INSERT INTO Scored_Goal_in_Match VALUES(10,1, 2, 24, 12,'Dribble Past Goalkeeper', 0);
INSERT INTO Scored_Goal_in_Match VALUES(10,1, 15, 47, 14,'Rebound', 0);
-- Match 11
INSERT INTO Scored_Goal_in_Match VALUES(11,2, 36, 64, 24,'Rebound', 0);
INSERT INTO Scored_Goal_in_Match VALUES(11,2, 26, 81, 37,'One-Touch Finish', 0);
INSERT INTO Scored_Goal_in_Match VALUES(11,3, 55, 9, 50,'Penalty', 0);
INSERT INTO Scored_Goal_in_Match VALUES(11,3, 51, 67, 51,'Free Kick', 0);
INSERT INTO Scored_Goal_in_Match VALUES(11,3, 49, 72, 52,'Free Kick', 0);
INSERT INTO Scored_Goal_in_Match VALUES(11,3, 56, 95, 55,'One-Touch Finish', 0);
-- Match 12
INSERT INTO Scored_Goal_in_Match VALUES(12,3, 53, 36, 44,'Inside Box Shot', 0);
INSERT INTO Scored_Goal_in_Match VALUES(12,3, 55, 66, 53,'Dribble Past Goalkeeper', 0);
INSERT INTO Scored_Goal_in_Match VALUES(12,3, 41, 93, 52,' Outside Box Shot', 0);
-- Match 13 : No goal
-- Match 14
INSERT INTO Scored_Goal_in_Match VALUES(14,4, 73, 60, 61,'Free Kick', 0);
INSERT INTO Scored_Goal_in_Match VALUES(14,4, 65, 71, 72,'Dribble Past Goalkeeper', 0);
INSERT INTO Scored_Goal_in_Match VALUES(14,4, 63, 79, 74,'Goal from Corner', 0);
INSERT INTO Scored_Goal_in_Match VALUES(14,4, 80, 85, 68,'Inside Box Shot', 0);
INSERT INTO Scored_Goal_in_Match VALUES(14,2, 27, 56, 35,'Dribble Past Goalkeeper', 0);
-- Match 15
INSERT INTO Scored_Goal_in_Match VALUES(15,2, 40, 87, 32,'Inside Box Shot', 0);
INSERT INTO Scored_Goal_in_Match VALUES(15,2, 27, 92, 26,'Penalty', 0);
-- Match 16
INSERT INTO Scored_Goal_in_Match VALUES(16,5, 90, 52, 91,' Outside Box Shot', 0);
INSERT INTO Scored_Goal_in_Match VALUES(16,5, 99, 58, 90,'Dribble Past Goalkeeper', 0);
INSERT INTO Scored_Goal_in_Match VALUES(16,5, 83, 91, 82,'Free Kick', 0);
INSERT INTO Scored_Goal_in_Match VALUES(16,2, 34, 10, 35,'One-Touch Finish', 0);
INSERT INTO Scored_Goal_in_Match VALUES(16,2, 40, 19, 36,'Goal from Corner', 0);
INSERT INTO Scored_Goal_in_Match VALUES(16,2, 25, 43, 30,'Dribble Past Goalkeeper', 0);
-- Match 17
INSERT INTO Scored_Goal_in_Match VALUES(17,2, 38, 77, 40,'Penalty', 0);
INSERT INTO Scored_Goal_in_Match VALUES(17,2, 23, 80, 31,' Outside Box Shot', 0);
INSERT INTO Scored_Goal_in_Match VALUES(17,6, 107, 14, 120,'Dribble Past Goalkeeper', 0);
INSERT INTO Scored_Goal_in_Match VALUES(17,6, 118, 93, 119,'Penalty', 0);
-- Match 18
INSERT INTO Scored_Goal_in_Match VALUES(18,6, 115, 42, 104,' Outside Box Shot', 0);
INSERT INTO Scored_Goal_in_Match VALUES(18,6, 120, 58, 111,'Penalty', 0);
INSERT INTO Scored_Goal_in_Match VALUES(18,6, 113, 82, 103,'One-Touch Finish', 0);
INSERT INTO Scored_Goal_in_Match VALUES(18,2, 32, 19, 32,'Penalty', 0);
-- Match 19
INSERT INTO Scored_Goal_in_Match VALUES(19,4, 76, 28, 75,'Header', 0);
INSERT INTO Scored_Goal_in_Match VALUES(19,4, 69, 64, 72,'Penalty', 0);
INSERT INTO Scored_Goal_in_Match VALUES(19,4, 63, 77, 75,'One-Touch Finish', 0);
INSERT INTO Scored_Goal_in_Match VALUES(19,4, 79, 89, 76,'One-Touch Finish', 0);
-- Match 20
INSERT INTO Scored_Goal_in_Match VALUES(20,4, 79, 9, 68,'Dribble Past Goalkeeper', 0);
INSERT INTO Scored_Goal_in_Match VALUES(20,4, 64, 33, 61,'Header', 0);
INSERT INTO Scored_Goal_in_Match VALUES(20,4, 76, 45, 69,'Goal from Corner', 0);
INSERT INTO Scored_Goal_in_Match VALUES(20,4, 62, 67, 75,'One-Touch Finish', 0);
INSERT INTO Scored_Goal_in_Match VALUES(20,3, 51, 22, 54,'Counter-Attack Goal', 0);
INSERT INTO Scored_Goal_in_Match VALUES(20,3, 51, 40, 49,'Dribble Past Goalkeeper', 0);
INSERT INTO Scored_Goal_in_Match VALUES(20,3, 52, 52, 49,'Header', 0);
INSERT INTO Scored_Goal_in_Match VALUES(20,3, 42, 90, 60,'Penalty', 0);
-- Match 21
INSERT INTO Scored_Goal_in_Match VALUES(21,3, 43, 25, 41,'Goal from Corner', 0);
INSERT INTO Scored_Goal_in_Match VALUES(21,3, 50, 65, 59,' Outside Box Shot', 0);
INSERT INTO Scored_Goal_in_Match VALUES(21,3, 43, 88, 50,'Inside Box Shot', 0);
INSERT INTO Scored_Goal_in_Match VALUES(21,5, 100, 35, 83,'Rebound', 0);
INSERT INTO Scored_Goal_in_Match VALUES(21,5, 95, 95, 93,'Free Kick', 0);
-- Match 22
INSERT INTO Scored_Goal_in_Match VALUES(22,3, 48, 54, 47,'Penalty', 0);
-- Match 23
INSERT INTO Scored_Goal_in_Match VALUES(23,6, 102, 47, 114,'Penalty', 0);
-- Match 24
INSERT INTO Scored_Goal_in_Match VALUES(24,6, 105, 48, 119,'Dribble Past Goalkeeper', 0);
INSERT INTO Scored_Goal_in_Match VALUES(24,6, 101, 62, 120,'Penalty', 0);
INSERT INTO Scored_Goal_in_Match VALUES(24,6, 101, 72, 107,'Header', 0);
INSERT INTO Scored_Goal_in_Match VALUES(24,6, 104, 89, 111,'Dribble Past Goalkeeper', 0);
INSERT INTO Scored_Goal_in_Match VALUES(24,3, 51, 70, 55,' Outside Box Shot', 0);
INSERT INTO Scored_Goal_in_Match VALUES(24,3, 58, 84, 50,'Dribble Past Goalkeeper', 0);
INSERT INTO Scored_Goal_in_Match VALUES(24,3, 58, 95, 44,'Penalty', 0);
-- Match 25
INSERT INTO Scored_Goal_in_Match VALUES(25,5, 90, 22, 98,'Counter-Attack Goal', 0);
-- Match 26
INSERT INTO Scored_Goal_in_Match VALUES(26,5, 87, 38, 97,'Dribble Past Goalkeeper', 0);
INSERT INTO Scored_Goal_in_Match VALUES(26,5, 81, 64, 86,'Goal from Corner', 0);
INSERT INTO Scored_Goal_in_Match VALUES(26,5, 99, 79, 94,'Penalty', 0);
INSERT INTO Scored_Goal_in_Match VALUES(26,4, 65, 22, 71,' Outside Box Shot', 0);
INSERT INTO Scored_Goal_in_Match VALUES(26,4, 65, 49, 76,'Inside Box Shot', 0);
-- Match 27
INSERT INTO Scored_Goal_in_Match VALUES(27,6, 115, 54, 109,'Free Kick', 0);
INSERT INTO Scored_Goal_in_Match VALUES(27,6, 112, 60, 114,'Free Kick', 0);
INSERT INTO Scored_Goal_in_Match VALUES(27,6, 107, 87, 118,'Goal from Corner', 0);
-- Match 28
INSERT INTO Scored_Goal_in_Match VALUES(28,6, 116, 6, 117,'Goal from Corner', 0);
INSERT INTO Scored_Goal_in_Match VALUES(28,6, 114, 17, 120,' Outside Box Shot', 0);
INSERT INTO Scored_Goal_in_Match VALUES(28,6, 120, 23, 118,'Rebound', 0);
-- Match 29
INSERT INTO Scored_Goal_in_Match VALUES(29,5, 86, 62, 90,'Counter-Attack Goal', 0);
INSERT INTO Scored_Goal_in_Match VALUES(29,5, 82, 71, 87,'Penalty', 0);
INSERT INTO Scored_Goal_in_Match VALUES(29,5, 84, 82, 87,'Rebound', 0);
INSERT INTO Scored_Goal_in_Match VALUES(29,5, 84, 89, 81,'Goal from Corner', 0);
INSERT INTO Scored_Goal_in_Match VALUES(29,6, 116, 3, 109,'Dribble Past Goalkeeper', 0);
INSERT INTO Scored_Goal_in_Match VALUES(29,6, 116, 6, 114,'Counter-Attack Goal', 0);
INSERT INTO Scored_Goal_in_Match VALUES(29,6, 115, 44, 113,'Header', 0);
INSERT INTO Scored_Goal_in_Match VALUES(29,6, 108, 50, 105,'Header', 0);
-- Match 30
INSERT INTO Scored_Goal_in_Match VALUES(30,6, 118, 31, 116,'One-Touch Finish', 0);
INSERT INTO Scored_Goal_in_Match VALUES(30,6, 114, 42, 109,'Header', 0);
INSERT INTO Scored_Goal_in_Match VALUES(30,6, 112, 67, 107,' Outside Box Shot', 0);
INSERT INTO Scored_Goal_in_Match VALUES(30,6, 107, 70, 101,'Header', 0);
INSERT INTO Scored_Goal_in_Match VALUES(30,5, 86, 19, 96,'Counter-Attack Goal', 0);
INSERT INTO Scored_Goal_in_Match VALUES(30,5, 83, 38, 84,'Penalty', 0);
-- Match 31
INSERT INTO Scored_Goal_in_Match VALUES(31,7, 123,37, 134,'Header', 0);
INSERT INTO Scored_Goal_in_Match VALUES(31,7, 122, 43, 130,' Outside Box Shot', 0);
INSERT INTO Scored_Goal_in_Match VALUES(31,7, 132, 87, 128,'Counter-Attack Goal', 0);
-- Match 32
INSERT INTO Scored_Goal_in_Match VALUES(32,7, 123, 37, 126,'Free Kick', 0);
INSERT INTO Scored_Goal_in_Match VALUES(32,7, 131, 51, 140,'Header', 0);
INSERT INTO Scored_Goal_in_Match VALUES(32,7, 124, 70, 129,'Dribble Past Goalkeeper', 0);
INSERT INTO Scored_Goal_in_Match VALUES(32,7, 125, 88, 138,'Counter-Attack Goal', 0);
-- Match 33
INSERT INTO Scored_Goal_in_Match VALUES(33,7, 136, 14, 135,'Header', 0);
INSERT INTO Scored_Goal_in_Match VALUES(33,7, 121, 22, 139,'One-Touch Finish', 0);
INSERT INTO Scored_Goal_in_Match VALUES(33,7, 122, 50, 121,'Inside Box Shot', 0);
INSERT INTO Scored_Goal_in_Match VALUES(33,7, 140, 61, 126,'Inside Box Shot', 0);
INSERT INTO Scored_Goal_in_Match VALUES(33,2, 34, 42, 37,'Goal from Corner', 0);
INSERT INTO Scored_Goal_in_Match VALUES(33,2, 34, 58, 31,'Inside Box Shot', 0);
-- Match 34
INSERT INTO Scored_Goal_in_Match VALUES(34,7, 137, 56, 129,'Inside Box Shot', 0);
INSERT INTO Scored_Goal_in_Match VALUES(34,7, 128, 59, 138,'Rebound', 0);
INSERT INTO Scored_Goal_in_Match VALUES(34,7, 131, 68, 139,'Header', 0);
INSERT INTO Scored_Goal_in_Match VALUES(34,7, 138, 80, 127,'Inside Box Shot', 0);
-- Match 35
INSERT INTO Scored_Goal_in_Match VALUES(35,7, 127, 66, 128,'Inside Box Shot', 0);
INSERT INTO Scored_Goal_in_Match VALUES(35,7, 129, 71, 133,'Inside Box Shot', 0);
INSERT INTO Scored_Goal_in_Match VALUES(35,7, 134, 80, 139,'Header', 0);
-- Match 36
INSERT INTO Scored_Goal_in_Match VALUES(36,7, 129, 49, 121,'Header', 0);
INSERT INTO Scored_Goal_in_Match VALUES(36,7, 138, 67, 129,' Outside Box Shot', 0);
INSERT INTO Scored_Goal_in_Match VALUES(36,7, 121, 78, 121,'Header', 0);
INSERT INTO Scored_Goal_in_Match VALUES(36,7, 134, 89, 124,'Rebound', 0);
INSERT INTO Scored_Goal_in_Match VALUES(36,7, 133, 92, 136,' Outside Box Shot', 0);
-- Match 37
INSERT INTO Scored_Goal_in_Match VALUES(37,7, 129, 70, 126,'Inside Box Shot', 0);
INSERT INTO Scored_Goal_in_Match VALUES(37,7, 128, 80, 132,'One-Touch Finish', 0);
INSERT INTO Scored_Goal_in_Match VALUES(37,7, 130, 83, 125,'Rebound', 0);
INSERT INTO Scored_Goal_in_Match VALUES(37,7, 127, 89, 123,'Dribble Past Goalkeeper', 0);
INSERT INTO Scored_Goal_in_Match VALUES(37,7, 133, 93, 127,' Outside Box Shot', 0);
-- Match 38
INSERT INTO Scored_Goal_in_Match VALUES(38,4, 72, 42, 79,'Free Kick', 0);
INSERT INTO Scored_Goal_in_Match VALUES(38,4, 61, 60, 61,'Dribble Past Goalkeeper', 0);
INSERT INTO Scored_Goal_in_Match VALUES(38,7, 137, 23, 124,'Free Kick', 0);
INSERT INTO Scored_Goal_in_Match VALUES(38,7, 140, 78, 124,'One-Touch Finish', 0);
INSERT INTO Scored_Goal_in_Match VALUES(38,7, 134, 82, 133,'Dribble Past Goalkeeper', 0);
INSERT INTO Scored_Goal_in_Match VALUES(38,7, 126, 89, 129,'Free Kick', 0);
INSERT INTO Scored_Goal_in_Match VALUES(38,7, 130, 93, 130,' Outside Box Shot', 0);
-- Match 39
INSERT INTO Scored_Goal_in_Match VALUES(39,7, 121, 35, 126,'Free Kick', 0);
INSERT INTO Scored_Goal_in_Match VALUES(39,7, 121, 41, 125,'Free Kick', 0);
INSERT INTO Scored_Goal_in_Match VALUES(39,7, 123, 67, 127,'Inside Box Shot', 0);
INSERT INTO Scored_Goal_in_Match VALUES(39,5, 93, 52, 85,'Dribble Past Goalkeeper', 0);
-- Match 40
INSERT INTO Scored_Goal_in_Match VALUES(40,5, 90, 51, 96,'Dribble Past Goalkeeper', 0);
INSERT INTO Scored_Goal_in_Match VALUES(40,5, 85, 85, 84,'Free Kick', 0);
INSERT INTO Scored_Goal_in_Match VALUES(40,7, 129, 66, 128,'Counter-Attack Goal', 0);
INSERT INTO Scored_Goal_in_Match VALUES(40,7, 135, 81, 131,'Header', 0);
INSERT INTO Scored_Goal_in_Match VALUES(40,7, 134, 91, 126,'Goal from Corner', 0);
-- Match 41
INSERT INTO Scored_Goal_in_Match VALUES(41,7, 128, 23, 130,'Header', 0);
INSERT INTO Scored_Goal_in_Match VALUES(41,7, 138, 35, 137,'Rebound', 0);
INSERT INTO Scored_Goal_in_Match VALUES(41,7, 133, 60, 136,'Header', 0);
INSERT INTO Scored_Goal_in_Match VALUES(41,7, 134, 69, 134,'Counter-Attack Goal', 0);
-- Match 42
INSERT INTO Scored_Goal_in_Match VALUES(42,6, 113, 27, 103,'Inside Box Shot', 0);
INSERT INTO Scored_Goal_in_Match VALUES(42,6, 114, 47, 101,'Goal from Corner', 0);
INSERT INTO Scored_Goal_in_Match VALUES(42,7, 136, 14, 123,'Free Kick', 0);
INSERT INTO Scored_Goal_in_Match VALUES(42,7, 123, 43, 132,'Goal from Corner', 0);
INSERT INTO Scored_Goal_in_Match VALUES(42,7, 125, 52, 131,' Outside Box Shot', 0);
INSERT INTO Scored_Goal_in_Match VALUES(42,7, 133, 68, 139,' Outside Box Shot', 0);
INSERT INTO Scored_Goal_in_Match VALUES(42,7, 140, 73, 123,'Inside Box Shot', 0);
INSERT INTO Scored_Goal_in_Match VALUES(42,7, 121, 89, 139,'Goal from Corner', 0);


Select * from Assisted_Goal_in_Match
-- Match 1
INSERT INTO Assisted_Goal_in_Match VALUES(1,1,15,34);
INSERT INTO Assisted_Goal_in_Match VALUES(1,1,10,41);
INSERT INTO Assisted_Goal_in_Match VALUES(1,1,14,45);
INSERT INTO Assisted_Goal_in_Match VALUES(1,1,17,62);
INSERT INTO Assisted_Goal_in_Match VALUES(1,2,30,23);
INSERT INTO Assisted_Goal_in_Match VALUES(1,2,38,37);
INSERT INTO Assisted_Goal_in_Match VALUES(1,2,24,74);
-- Match 2
INSERT INTO Assisted_Goal_in_Match VALUES(2,2,24,10);
INSERT INTO Assisted_Goal_in_Match VALUES(2,2,34,18);
INSERT INTO Assisted_Goal_in_Match VALUES(2,1,4,66);
INSERT INTO Assisted_Goal_in_Match VALUES(2,1,11,92);
-- Match 3
INSERT INTO Assisted_Goal_in_Match VALUES(3,1,3,58);
INSERT INTO Assisted_Goal_in_Match VALUES(3,1,13,64);
INSERT INTO Assisted_Goal_in_Match VALUES(3,1,6,70);
INSERT INTO Assisted_Goal_in_Match VALUES(3,3,56,48);
-- Match 4
INSERT INTO Assisted_Goal_in_Match VALUES(4,3,46,23);
INSERT INTO Assisted_Goal_in_Match VALUES(4,3,41,39);
INSERT INTO Assisted_Goal_in_Match VALUES(4,3,57,43);
INSERT INTO Assisted_Goal_in_Match VALUES(4,3,46,69);
-- Match 5
INSERT INTO Assisted_Goal_in_Match VALUES(5,1,15,27);
INSERT INTO Assisted_Goal_in_Match VALUES(5,1,16,37);
INSERT INTO Assisted_Goal_in_Match VALUES(5,1,1,46);
INSERT INTO Assisted_Goal_in_Match VALUES(5,1,13,49);
INSERT INTO Assisted_Goal_in_Match VALUES(5,4,74,16);
-- Match 6
INSERT INTO Assisted_Goal_in_Match VALUES(6,4,64,36);
INSERT INTO Assisted_Goal_in_Match VALUES(6,1,1,4);
INSERT INTO Assisted_Goal_in_Match VALUES(6,1,10,41);
INSERT INTO Assisted_Goal_in_Match VALUES(6,1,18,52);
-- Match 7
INSERT INTO Assisted_Goal_in_Match VALUES(7,1,11,17);
INSERT INTO Assisted_Goal_in_Match VALUES(7,1,18,27);
INSERT INTO Assisted_Goal_in_Match VALUES(7,1,1,43);
INSERT INTO Assisted_Goal_in_Match VALUES(7,5,82,69);
INSERT INTO Assisted_Goal_in_Match VALUES(7,5,94,74);
INSERT INTO Assisted_Goal_in_Match VALUES(7,5,98,80);
INSERT INTO Assisted_Goal_in_Match VALUES(7,5,99,88);
-- Match 8
INSERT INTO Assisted_Goal_in_Match VALUES(8,1,19,29);
INSERT INTO Assisted_Goal_in_Match VALUES(8,1,2,67);
INSERT INTO Assisted_Goal_in_Match VALUES(8,1,20,90);
-- Match 9
INSERT INTO Assisted_Goal_in_Match VALUES(9,1,5,40);
INSERT INTO Assisted_Goal_in_Match VALUES(9,1,13,57);
INSERT INTO Assisted_Goal_in_Match VALUES(9,1,2,63);
INSERT INTO Assisted_Goal_in_Match VALUES(9,1,14,69);
INSERT INTO Assisted_Goal_in_Match VALUES(9,6,117,48);
-- Match 10
INSERT INTO Assisted_Goal_in_Match VALUES(10,6,116,60);
INSERT INTO Assisted_Goal_in_Match VALUES(10,1,13,10);
INSERT INTO Assisted_Goal_in_Match VALUES(10,1,12,24);
INSERT INTO Assisted_Goal_in_Match VALUES(10,1,14,47);
-- Match 11
INSERT INTO Assisted_Goal_in_Match VALUES(11,2,24,64);
INSERT INTO Assisted_Goal_in_Match VALUES(11,2,37,81);
INSERT INTO Assisted_Goal_in_Match VALUES(11,3,50,9);
INSERT INTO Assisted_Goal_in_Match VALUES(11,3,51,67);
INSERT INTO Assisted_Goal_in_Match VALUES(11,3,52,72);
INSERT INTO Assisted_Goal_in_Match VALUES(11,3,55,95);
-- Match 12
INSERT INTO Assisted_Goal_in_Match VALUES(12,3,44,36);
INSERT INTO Assisted_Goal_in_Match VALUES(12,3,53,66);
INSERT INTO Assisted_Goal_in_Match VALUES(12,3,52,93);
-- Match 13 : No goal
-- Match 14
INSERT INTO Assisted_Goal_in_Match VALUES(14,4,61,60);
INSERT INTO Assisted_Goal_in_Match VALUES(14,4,72,71);
INSERT INTO Assisted_Goal_in_Match VALUES(14,4,74,79);
INSERT INTO Assisted_Goal_in_Match VALUES(14,4,68,85);
INSERT INTO Assisted_Goal_in_Match VALUES(14,2,35,56);
-- Match 15
INSERT INTO Assisted_Goal_in_Match VALUES(15,2,32,87);
INSERT INTO Assisted_Goal_in_Match VALUES(15,2,26,92);
-- Match 16
INSERT INTO Assisted_Goal_in_Match VALUES(16,5,91,52);
INSERT INTO Assisted_Goal_in_Match VALUES(16,5,90,58);
INSERT INTO Assisted_Goal_in_Match VALUES(16,5,82,91);
INSERT INTO Assisted_Goal_in_Match VALUES(16,2,35,10);
INSERT INTO Assisted_Goal_in_Match VALUES(16,2,36,19);
INSERT INTO Assisted_Goal_in_Match VALUES(16,2,30,43);
-- Match 17
INSERT INTO Assisted_Goal_in_Match VALUES(17,2,40,77);
INSERT INTO Assisted_Goal_in_Match VALUES(17,2,31,80);
INSERT INTO Assisted_Goal_in_Match VALUES(17,6,120,14);
INSERT INTO Assisted_Goal_in_Match VALUES(17,6,119,93);
-- Match 18
INSERT INTO Assisted_Goal_in_Match VALUES(18,6,104,42);
INSERT INTO Assisted_Goal_in_Match VALUES(18,6,111,58);
INSERT INTO Assisted_Goal_in_Match VALUES(18,6,103,82);
INSERT INTO Assisted_Goal_in_Match VALUES(18,2,32,19);
-- Match 19
INSERT INTO Assisted_Goal_in_Match VALUES(19,4,75,28);
INSERT INTO Assisted_Goal_in_Match VALUES(19,4,72,64);
INSERT INTO Assisted_Goal_in_Match VALUES(19,4,75,77);
INSERT INTO Assisted_Goal_in_Match VALUES(19,4,76,89);
-- Match 20
INSERT INTO Assisted_Goal_in_Match VALUES(20,4,68,9);
INSERT INTO Assisted_Goal_in_Match VALUES(20,4,61,33);
INSERT INTO Assisted_Goal_in_Match VALUES(20,4,69,45);
INSERT INTO Assisted_Goal_in_Match VALUES(20,4,75,67);
INSERT INTO Assisted_Goal_in_Match VALUES(20,3,54,22);
INSERT INTO Assisted_Goal_in_Match VALUES(20,3,49,40);
INSERT INTO Assisted_Goal_in_Match VALUES(20,3,49,52);
INSERT INTO Assisted_Goal_in_Match VALUES(20,3,60,90);
-- Match 21
INSERT INTO Assisted_Goal_in_Match VALUES(21,3,41,25);
INSERT INTO Assisted_Goal_in_Match VALUES(21,3,59,65);
INSERT INTO Assisted_Goal_in_Match VALUES(21,3,50,88);
INSERT INTO Assisted_Goal_in_Match VALUES(21,5,83,35);
INSERT INTO Assisted_Goal_in_Match VALUES(21,5,93,95);
-- Match 22
INSERT INTO Assisted_Goal_in_Match VALUES(22,3,47,54);
-- Match 23
INSERT INTO Assisted_Goal_in_Match VALUES(23,6,114,47);
-- Match 24
INSERT INTO Assisted_Goal_in_Match VALUES(24,6,119,48);
INSERT INTO Assisted_Goal_in_Match VALUES(24,6,120,62);
INSERT INTO Assisted_Goal_in_Match VALUES(24,6,107,72);
INSERT INTO Assisted_Goal_in_Match VALUES(24,6,111,89);
INSERT INTO Assisted_Goal_in_Match VALUES(24,3,55,70);
INSERT INTO Assisted_Goal_in_Match VALUES(24,3,50,84);
INSERT INTO Assisted_Goal_in_Match VALUES(24,3,44,95);
-- Match 25
INSERT INTO Assisted_Goal_in_Match VALUES(25,5,98,22);
-- Match 26
INSERT INTO Assisted_Goal_in_Match VALUES(26,5,97,38);
INSERT INTO Assisted_Goal_in_Match VALUES(26,5,86,64);
INSERT INTO Assisted_Goal_in_Match VALUES(26,5,94,79);
INSERT INTO Assisted_Goal_in_Match VALUES(26,4,71,22);
INSERT INTO Assisted_Goal_in_Match VALUES(26,4,76,49);
-- Match 27
INSERT INTO Assisted_Goal_in_Match VALUES(27,6,109,54);
INSERT INTO Assisted_Goal_in_Match VALUES(27,6,114,60);
INSERT INTO Assisted_Goal_in_Match VALUES(27,6,118,87);
-- Match 28
INSERT INTO Assisted_Goal_in_Match VALUES(28,6,117,6);
INSERT INTO Assisted_Goal_in_Match VALUES(28,6,120,17);
INSERT INTO Assisted_Goal_in_Match VALUES(28,6,118,23);
-- Match 29
INSERT INTO Assisted_Goal_in_Match VALUES(29,5,90,62);
INSERT INTO Assisted_Goal_in_Match VALUES(29,5,87,71);
INSERT INTO Assisted_Goal_in_Match VALUES(29,5,87,82);
INSERT INTO Assisted_Goal_in_Match VALUES(29,5,81,89);
INSERT INTO Assisted_Goal_in_Match VALUES(29,6,109,3);
INSERT INTO Assisted_Goal_in_Match VALUES(29,6,114,6);
INSERT INTO Assisted_Goal_in_Match VALUES(29,6,113,44);
INSERT INTO Assisted_Goal_in_Match VALUES(29,6,105,50);
-- Match 30
INSERT INTO Assisted_Goal_in_Match VALUES(30,6,116,31);
INSERT INTO Assisted_Goal_in_Match VALUES(30,6,109,42);
INSERT INTO Assisted_Goal_in_Match VALUES(30,6,107,67);
INSERT INTO Assisted_Goal_in_Match VALUES(30,6,101,70);
INSERT INTO Assisted_Goal_in_Match VALUES(30,5,96,19);
INSERT INTO Assisted_Goal_in_Match VALUES(30,5,84,38);
-- Match 31
INSERT INTO Assisted_Goal_in_Match VALUES(31,7,134,37);
INSERT INTO Assisted_Goal_in_Match VALUES(31,7,130,43);
INSERT INTO Assisted_Goal_in_Match VALUES(31,7,128,87);
-- Match 32
INSERT INTO Assisted_Goal_in_Match VALUES(32,7,126,37);
INSERT INTO Assisted_Goal_in_Match VALUES(32,7,140,51);
INSERT INTO Assisted_Goal_in_Match VALUES(32,7,129,70);
INSERT INTO Assisted_Goal_in_Match VALUES(32,7,138,88);
-- Match 33
INSERT INTO Assisted_Goal_in_Match VALUES(33,7,135,14);
INSERT INTO Assisted_Goal_in_Match VALUES(33,7,139,22);
INSERT INTO Assisted_Goal_in_Match VALUES(33,7,121,50);
INSERT INTO Assisted_Goal_in_Match VALUES(33,7,126,61);
INSERT INTO Assisted_Goal_in_Match VALUES(33,2,37,42);
INSERT INTO Assisted_Goal_in_Match VALUES(33,2,31,58);
-- Match 34
INSERT INTO Assisted_Goal_in_Match VALUES(34,7,129,56);
INSERT INTO Assisted_Goal_in_Match VALUES(34,7,138,59);
INSERT INTO Assisted_Goal_in_Match VALUES(34,7,139,68);
INSERT INTO Assisted_Goal_in_Match VALUES(34,7,127,80);
-- Match 35
INSERT INTO Assisted_Goal_in_Match VALUES(35,7,128,66);
INSERT INTO Assisted_Goal_in_Match VALUES(35,7,133,71);
INSERT INTO Assisted_Goal_in_Match VALUES(35,7,139,80);
-- Match 36
INSERT INTO Assisted_Goal_in_Match VALUES(36,7,121,49);
INSERT INTO Assisted_Goal_in_Match VALUES(36,7,129,67);
INSERT INTO Assisted_Goal_in_Match VALUES(36,7,121,78);
INSERT INTO Assisted_Goal_in_Match VALUES(36,7,124,89);
INSERT INTO Assisted_Goal_in_Match VALUES(36,7,136,92);
-- Match 37
INSERT INTO Assisted_Goal_in_Match VALUES(37,7,126,70);
INSERT INTO Assisted_Goal_in_Match VALUES(37,7,132,80);
INSERT INTO Assisted_Goal_in_Match VALUES(37,7,125,83);
INSERT INTO Assisted_Goal_in_Match VALUES(37,7,123,89);
INSERT INTO Assisted_Goal_in_Match VALUES(37,7,127,93);
-- Match 38
INSERT INTO Assisted_Goal_in_Match VALUES(38,4,79,42);
INSERT INTO Assisted_Goal_in_Match VALUES(38,4,61,60);
INSERT INTO Assisted_Goal_in_Match VALUES(38,7,124,23);
INSERT INTO Assisted_Goal_in_Match VALUES(38,7,124,78);
INSERT INTO Assisted_Goal_in_Match VALUES(38,7,133,82);
INSERT INTO Assisted_Goal_in_Match VALUES(38,7,129,89);
INSERT INTO Assisted_Goal_in_Match VALUES(38,7,130,93);
-- Match 39
INSERT INTO Assisted_Goal_in_Match VALUES(39,7,126,35);
INSERT INTO Assisted_Goal_in_Match VALUES(39,7,125,41);
INSERT INTO Assisted_Goal_in_Match VALUES(39,7,127,67);
INSERT INTO Assisted_Goal_in_Match VALUES(39,5,85,52);
-- Match 40
INSERT INTO Assisted_Goal_in_Match VALUES(40,5,96,51);
INSERT INTO Assisted_Goal_in_Match VALUES(40,5,84,85);
INSERT INTO Assisted_Goal_in_Match VALUES(40,7,128,66);
INSERT INTO Assisted_Goal_in_Match VALUES(40,7,131,81);
INSERT INTO Assisted_Goal_in_Match VALUES(40,7,126,91);
-- Match 41
INSERT INTO Assisted_Goal_in_Match VALUES(41,7,130,23);
INSERT INTO Assisted_Goal_in_Match VALUES(41,7,137,35);
INSERT INTO Assisted_Goal_in_Match VALUES(41,7,136,60);
INSERT INTO Assisted_Goal_in_Match VALUES(41,7,134,69);
-- Match 42
INSERT INTO Assisted_Goal_in_Match VALUES(42,6,103,27);
INSERT INTO Assisted_Goal_in_Match VALUES(42,6,101,47);
INSERT INTO Assisted_Goal_in_Match VALUES(42,7,123,14);
INSERT INTO Assisted_Goal_in_Match VALUES(42,7,132,43);
INSERT INTO Assisted_Goal_in_Match VALUES(42,7,131,52);
INSERT INTO Assisted_Goal_in_Match VALUES(42,7,139,68);
INSERT INTO Assisted_Goal_in_Match VALUES(42,7,123,73);

Select * from Card_Received_in_Match
-- Match 1
INSERT INTO Card_Received_in_Match VALUES(1,1, 5, 86, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(1,1, 13, 8, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(1,1, 16, 14, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(1,1, 17, 51, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(1,2, 25, 39, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(1,2, 31, 70, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(1,1, 9, 14, 'red');
INSERT INTO Card_Received_in_Match VALUES(1,2, 23, 31, 'red');
-- Match 2
INSERT INTO Card_Received_in_Match VALUES(2,2, 21, 94, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(2,2, 25, 1, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(2,1, 13, 80, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(2,1, 2, 52, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(2,1, 4, 56, 'yellow');
-- Match 3
INSERT INTO Card_Received_in_Match VALUES(3,1, 9, 94, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(3,1, 19, 92, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(3,1, 16, 53, 'yellow');
-- Match 4
INSERT INTO Card_Received_in_Match VALUES(4,1, 10, 78, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(4,3, 60, 32, 'red');
-- Match 5
INSERT INTO Card_Received_in_Match VALUES(5,1, 1, 92, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(5,4, 79, 2, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(5,4, 80, 91, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(5,1, 15, 9, 'red');
-- Match 6
INSERT INTO Card_Received_in_Match VALUES(6,4, 71, 87, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(6,4, 68, 65, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(6,1, 9, 81, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(6,1, 6, 66, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(6,4, 70, 71, 'red');
-- Match 7
INSERT INTO Card_Received_in_Match VALUES(7,1, 9, 75, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(7,1, 5, 30, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(7,5, 100, 22, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(7,5, 85, 94, 'yellow');
-- Match 8
INSERT INTO Card_Received_in_Match VALUES(8,5, 88, 55, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(8,5, 89, 30, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(8,5, 92, 38, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(8,1, 9, 63, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(8,1, 14, 71, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(8,1, 4, 54, 'yellow');
-- Match 9
INSERT INTO Card_Received_in_Match VALUES(9,1, 12, 57, 'red');
-- Match 10
INSERT INTO Card_Received_in_Match VALUES(10,6, 114, 27, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(10,1, 4, 86, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(10,6, 109, 42, 'red');
-- Match 11
INSERT INTO Card_Received_in_Match VALUES(11,2, 38, 86, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(11,3, 51, 49, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(11,3, 53, 17, 'yellow');
-- Match 12
INSERT INTO Card_Received_in_Match VALUES(12,3, 52, 12, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(12,3, 48, 31, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(12,3, 44, 82, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(12,3, 42, 10, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(12,2, 22, 27, 'yellow');
-- Match 13 : NO CARD
-- Match 14
INSERT INTO Card_Received_in_Match VALUES(14,4, 69, 82, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(14,4, 80, 6, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(14,4, 66, 34, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(14,4, 70, 42, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(14,2, 32, 45, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(14,2, 22, 7, 'yellow');
-- Match 15 : NO CARD
-- Match 16
INSERT INTO Card_Received_in_Match VALUES(16,5, 84, 19, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(16,5, 91, 26, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(16,2, 27, 16, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(16,2, 26, 41, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(16,2, 30, 18, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(16,2, 36, 10, 'red');
-- Match 17
INSERT INTO Card_Received_in_Match VALUES(17,2, 34, 7, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(17,6, 115, 94, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(17,2, 23, 43, 'red');
-- Match 18
INSERT INTO Card_Received_in_Match VALUES(18,6, 108, 77, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(18,6, 118, 63, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(18,6, 102, 11, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(18,2, 33, 41, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(18,6, 107, 31, 'red');
-- Match 19
INSERT INTO Card_Received_in_Match VALUES(19,3, 49, 12, 'red');
-- Match 20
INSERT INTO Card_Received_in_Match VALUES(20,4, 64, 3, 'yellow');
-- Match 21
INSERT INTO Card_Received_in_Match VALUES(21,3, 59, 36, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(21,3, 47, 8, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(21,5, 85, 96, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(21,5, 81, 96, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(21,5, 82, 93, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(21,5, 86, 34, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(21,3, 46, 1, 'red');
-- Match 22
INSERT INTO Card_Received_in_Match VALUES(22,5, 84, 57, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(22,5, 85, 26, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(22,3, 46, 49, 'yellow');
-- Match 23
INSERT INTO Card_Received_in_Match VALUES(23,3, 46, 94, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(23,6, 102, 3, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(23,6, 115, 56, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(23,6, 117, 27, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(23,6, 110, 34, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(23,3, 44, 97, 'red');
-- Match 24
INSERT INTO Card_Received_in_Match VALUES(24,6, 108, 89, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(24,6, 111, 35, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(24,3, 51, 35, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(24,3, 45, 55, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(24,3, 59, 14, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(24,6, 110, 56, 'red');
INSERT INTO Card_Received_in_Match VALUES(24,3, 53, 31, 'red');
-- Match 25
INSERT INTO Card_Received_in_Match VALUES(25,4, 71, 41, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(25,4, 76, 9, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(25,5, 94, 96, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(25,5, 90, 1, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(25,5, 82, 82, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(25,5, 98, 38, 'red');
-- Match 26
INSERT INTO Card_Received_in_Match VALUES(26,5, 102, 82, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(26,5, 100, 10, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(26,5, 91, 48, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(26,5, 95, 60, 'yellow');
-- Match 27
INSERT INTO Card_Received_in_Match VALUES(27,4, 61, 97, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(27,6, 104, 13, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(27,6, 107, 97, 'red');
-- Match 28
INSERT INTO Card_Received_in_Match VALUES(28,6, 119, 11, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(28,6, 112, 50, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(28,4, 67, 71, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(28,4, 76, 2, 'yellow');
-- Match 29
INSERT INTO Card_Received_in_Match VALUES(29,5, 88, 79, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(29,5, 81, 71, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(29,6, 113, 31, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(29,6, 109, 74, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(29,6, 103, 35, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(29,6, 105, 73, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(29,5, 97, 32, 'red');
INSERT INTO Card_Received_in_Match VALUES(29,6, 114, 90, 'red');
-- Match 30
INSERT INTO Card_Received_in_Match VALUES(30,6, 118, 75, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(30,6, 119, 59, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(30,6, 112, 94, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(30,5, 86, 62, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(30,5, 87, 71, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(30,5, 94, 4, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(30,5, 95, 12, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(30,6, 104, 68, 'red');
-- Match 31
INSERT INTO Card_Received_in_Match VALUES(31,7, 138, 96, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(31,1, 12, 18, 'yellow');
-- Match 32
INSERT INTO Card_Received_in_Match VALUES(32,1, 10, 83, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(32,1, 11, 84, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(32,7, 138, 34, 'yellow');
-- Match 33
INSERT INTO Card_Received_in_Match VALUES(33,7, 121, 73, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(33,2, 37, 70, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(33,2, 26, 78, 'yellow');
-- Match 34
INSERT INTO Card_Received_in_Match VALUES(34,2, 33, 71, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(34,2, 21, 15, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(34,7, 135, 76, 'yellow');
-- Match 35
INSERT INTO Card_Received_in_Match VALUES(35,7, 134, 84, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(35,7, 139, 68, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(35,3, 42, 69, 'yellow');
-- Match 36
INSERT INTO Card_Received_in_Match VALUES(36,3, 43, 7, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(36,7, 126, 44, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(36,7, 133, 47, 'yellow');
-- Match 37
INSERT INTO Card_Received_in_Match VALUES(37,7, 127, 40, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(37,4, 77, 68, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(37,4, 63, 54, 'yellow');
-- Match 38
INSERT INTO Card_Received_in_Match VALUES(38,4, 74, 88, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(38,4, 64, 60, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(38,7, 137, 37, 'yellow');
-- Match 39
INSERT INTO Card_Received_in_Match VALUES(39,7, 122, 29, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(39,5, 87, 58, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(39,5, 91, 62, 'yellow');
-- Match 40
INSERT INTO Card_Received_in_Match VALUES(40,5, 96, 84, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(40,5, 85, 82, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(40,7, 126, 11, 'yellow');
-- Match 41
INSERT INTO Card_Received_in_Match VALUES(41,7, 138, 79, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(41,6, 110, 57, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(41,6, 113, 53, 'yellow');
-- Match 42
INSERT INTO Card_Received_in_Match VALUES(42,6, 116, 87, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(42,6, 109, 63, 'yellow');
INSERT INTO Card_Received_in_Match VALUES(42,7, 135, 38, 'yellow');

Select * from Player_Match_Participation
-- Match 1
INSERT INTO Player_Match_Participation VALUES(1,1, 5, NULL, 1 , 0 ,63, 100,10.0);
INSERT INTO Player_Match_Participation VALUES(1,1, 4, NULL, 1 , 0 ,26, 100,8.5);
INSERT INTO Player_Match_Participation VALUES(1,1, 19, NULL, 1 , 0 ,26, 100,6.0);
INSERT INTO Player_Match_Participation VALUES(1,1, 3, NULL, 1 , 0 ,56, 100,7.3);
INSERT INTO Player_Match_Participation VALUES(1,1, 8, NULL, 1 , 0 ,57, 100,6.7);
INSERT INTO Player_Match_Participation VALUES(1,1, 6, NULL, 1 , 0 ,40, 100,6.6);
INSERT INTO Player_Match_Participation VALUES(1,1, 1, NULL, 1 , 0 ,70, 100,8.5);
INSERT INTO Player_Match_Participation VALUES(1,1, 14, NULL, 1 , 0 ,61, 100,8.6);
INSERT INTO Player_Match_Participation VALUES(1,1, 20, NULL, 1 , 0 ,89, 100,8.8);
INSERT INTO Player_Match_Participation VALUES(1,1, 9, NULL, 1 , 0 ,13, 100,7.4);
INSERT INTO Player_Match_Participation VALUES(1,1, 12, NULL, 1 , 0 ,43, 100,7.6);
INSERT INTO Player_Match_Participation VALUES(1,2, 26, NULL, 1 , 0 ,96, 100,5.8);
INSERT INTO Player_Match_Participation VALUES(1,2, 28, NULL, 1 , 0 ,85, 100,7.8);
INSERT INTO Player_Match_Participation VALUES(1,2, 31, NULL, 1 , 0 ,71, 100,7.2);
INSERT INTO Player_Match_Participation VALUES(1,2, 20, NULL, 1 , 0 ,29, 100,8.7);
INSERT INTO Player_Match_Participation VALUES(1,2, 38, NULL, 1 , 0 ,90, 100,6.0);
INSERT INTO Player_Match_Participation VALUES(1,2, 27, NULL, 1 , 0 ,59, 100,6.3);
INSERT INTO Player_Match_Participation VALUES(1,2, 21, NULL, 1 , 0 ,80, 100,6.8);
INSERT INTO Player_Match_Participation VALUES(1,2, 36, NULL, 1 , 0 ,67, 100,9.2);
INSERT INTO Player_Match_Participation VALUES(1,2, 39, NULL, 1 , 0 ,41, 100,6.0);
INSERT INTO Player_Match_Participation VALUES(1,2, 24, NULL, 1 , 0 ,16, 100,5.8);
INSERT INTO Player_Match_Participation VALUES(1,2, 33, NULL, 1 , 0 ,7, 100,9.5);
-- Match 2
INSERT INTO Player_Match_Participation VALUES(2,2, 35, NULL, 1 , 0 ,92, 100,7.7);
INSERT INTO Player_Match_Participation VALUES(2,2, 23, NULL, 1 , 0 ,46, 100,9.7);
INSERT INTO Player_Match_Participation VALUES(2,2, 34, NULL, 1 , 0 ,90, 100,6.4);
INSERT INTO Player_Match_Participation VALUES(2,2, 32, NULL, 1 , 0 ,74, 100,9.8);
INSERT INTO Player_Match_Participation VALUES(2,2, 40, NULL, 1 , 0 ,92, 100,6.9);
INSERT INTO Player_Match_Participation VALUES(2,2, 22, NULL, 1 , 0 ,66, 100,6.1);
INSERT INTO Player_Match_Participation VALUES(2,2, 21, NULL, 1 , 0 ,81, 100,8.0);
INSERT INTO Player_Match_Participation VALUES(2,2, 28, NULL, 1 , 0 ,82, 100,9.2);
INSERT INTO Player_Match_Participation VALUES(2,2, 36, NULL, 1 , 0 ,89, 100,8.0);
INSERT INTO Player_Match_Participation VALUES(2,2, 26, NULL, 1 , 0 ,34, 100,8.1);
INSERT INTO Player_Match_Participation VALUES(2,2, 39, NULL, 1 , 0 ,60, 100,9.0);
INSERT INTO Player_Match_Participation VALUES(2,1, 20, NULL, 1 , 0 ,18, 100,5.8);
INSERT INTO Player_Match_Participation VALUES(2,1, 6, NULL, 1 , 0 ,38, 100,6.4);
INSERT INTO Player_Match_Participation VALUES(2,1, 5, NULL, 1 , 0 ,61, 100,6.6);
INSERT INTO Player_Match_Participation VALUES(2,1, 13, NULL, 1 , 0 ,47, 100,9.2);
INSERT INTO Player_Match_Participation VALUES(2,1, 10, NULL, 1 , 0 ,88, 100,7.6);
INSERT INTO Player_Match_Participation VALUES(2,1, 7, NULL, 1 , 0 ,8, 100,6.6);
INSERT INTO Player_Match_Participation VALUES(2,1, 21, NULL, 1 , 0 ,34, 100,7.5);
INSERT INTO Player_Match_Participation VALUES(2,1, 1, NULL, 1 , 0 ,10, 100,9.3);
INSERT INTO Player_Match_Participation VALUES(2,1, 4, NULL, 1 , 0 ,46, 100,8.5);
INSERT INTO Player_Match_Participation VALUES(2,1, 8, NULL, 1 , 0 ,53, 100,8.5);
INSERT INTO Player_Match_Participation VALUES(2,1, 15, NULL, 1 , 0 ,79, 100,9.1);
-- Match 3
INSERT INTO Player_Match_Participation VALUES(3,1, 9, NULL, 1 , 0 ,2, 100,6.6);
INSERT INTO Player_Match_Participation VALUES(3,1, 20, NULL, 1 , 0 ,40, 100,9.0);
INSERT INTO Player_Match_Participation VALUES(3,1, 5, NULL, 1 , 0 ,88, 100,7.4);
INSERT INTO Player_Match_Participation VALUES(3,1, 19, NULL, 1 , 0 ,20, 100,8.0);
INSERT INTO Player_Match_Participation VALUES(3,1, 6, NULL, 1 , 0 ,57, 100,6.7);
INSERT INTO Player_Match_Participation VALUES(3,1, 1, NULL, 1 , 0 ,17, 100,5.9);
INSERT INTO Player_Match_Participation VALUES(3,1, 11, NULL, 1 , 0 ,94, 100,6.6);
INSERT INTO Player_Match_Participation VALUES(3,1, 7, NULL, 1 , 0 ,14, 100,7.7);
INSERT INTO Player_Match_Participation VALUES(3,1, 10, NULL, 1 , 0 ,72, 100,7.4);
INSERT INTO Player_Match_Participation VALUES(3,1, 12, NULL, 1 , 0 ,15, 100,7.4);
INSERT INTO Player_Match_Participation VALUES(3,1, 4, NULL, 1 , 0 ,47, 100,9.8);
INSERT INTO Player_Match_Participation VALUES(3,3, 41, NULL, 1 , 0 ,58, 100,7.3);
INSERT INTO Player_Match_Participation VALUES(3,3, 43, NULL, 1 , 0 ,30, 100,8.4);
INSERT INTO Player_Match_Participation VALUES(3,3, 47, NULL, 1 , 0 ,34, 100,7.5);
INSERT INTO Player_Match_Participation VALUES(3,3, 44, NULL, 1 , 0 ,27, 100,9.1);
INSERT INTO Player_Match_Participation VALUES(3,3, 59, NULL, 1 , 0 ,7, 100,7.8);
INSERT INTO Player_Match_Participation VALUES(3,3, 60, NULL, 1 , 0 ,32, 100,9.2);
INSERT INTO Player_Match_Participation VALUES(3,3, 45, NULL, 1 , 0 ,25, 100,5.6);
INSERT INTO Player_Match_Participation VALUES(3,3, 46, NULL, 1 , 0 ,40, 100,10.0);
INSERT INTO Player_Match_Participation VALUES(3,3, 56, NULL, 1 , 0 ,53, 100,9.0);
INSERT INTO Player_Match_Participation VALUES(3,3, 57, NULL, 1 , 0 ,66, 100,8.0);
INSERT INTO Player_Match_Participation VALUES(3,3, 42, NULL, 1 , 0 ,66, 100,8.8);
-- Match 4
INSERT INTO Player_Match_Participation VALUES(4,3, 44, NULL, 1 , 0 ,49, 100,5.7);
INSERT INTO Player_Match_Participation VALUES(4,3, 48, NULL, 1 , 0 ,7, 100,8.0);
INSERT INTO Player_Match_Participation VALUES(4,3, 58, NULL, 1 , 0 ,77, 100,5.9);
INSERT INTO Player_Match_Participation VALUES(4,3, 55, NULL, 1 , 0 ,30, 100,8.3);
INSERT INTO Player_Match_Participation VALUES(4,3, 45, NULL, 1 , 0 ,46, 100,7.0);
INSERT INTO Player_Match_Participation VALUES(4,3, 60, NULL, 1 , 0 ,11, 100,7.1);
INSERT INTO Player_Match_Participation VALUES(4,3, 40, NULL, 1 , 0 ,60, 100,6.1);
INSERT INTO Player_Match_Participation VALUES(4,3, 57, NULL, 1 , 0 ,63, 100,7.9);
INSERT INTO Player_Match_Participation VALUES(4,3, 49, NULL, 1 , 0 ,74, 100,6.2);
INSERT INTO Player_Match_Participation VALUES(4,3, 43, NULL, 1 , 0 ,43, 100,8.5);
INSERT INTO Player_Match_Participation VALUES(4,3, 41, NULL, 1 , 0 ,71, 100,9.5);
INSERT INTO Player_Match_Participation VALUES(4,1, 17, NULL, 1 , 0 ,57, 100,7.4);
INSERT INTO Player_Match_Participation VALUES(4,1, 11, NULL, 1 , 0 ,97, 100,6.9);
INSERT INTO Player_Match_Participation VALUES(4,1, 7, NULL, 1 , 0 ,66, 100,8.5);
INSERT INTO Player_Match_Participation VALUES(4,1, 18, NULL, 1 , 0 ,68, 100,9.5);
INSERT INTO Player_Match_Participation VALUES(4,1, 8, NULL, 1 , 0 ,83, 100,6.6);
INSERT INTO Player_Match_Participation VALUES(4,1, 15, NULL, 1 , 0 ,18, 100,8.0);
INSERT INTO Player_Match_Participation VALUES(4,1, 20, NULL, 1 , 0 ,89, 100,9.7);
INSERT INTO Player_Match_Participation VALUES(4,1, 2, NULL, 1 , 0 ,42, 100,5.9);
INSERT INTO Player_Match_Participation VALUES(4,1, 16, NULL, 1 , 0 ,10, 100,6.1);
INSERT INTO Player_Match_Participation VALUES(4,1, 4, NULL, 1 , 0 ,94, 100,9.4);
INSERT INTO Player_Match_Participation VALUES(4,1, 19, NULL, 1 , 0 ,10, 100,9.4);
-- Match 5
INSERT INTO Player_Match_Participation VALUES(5,1, 16, NULL, 1 , 0 ,62, 100,6.8);
INSERT INTO Player_Match_Participation VALUES(5,1, 7, NULL, 1 , 0 ,41, 100,6.5);
INSERT INTO Player_Match_Participation VALUES(5,1, 10, NULL, 1 , 0 ,93, 100,6.2);
INSERT INTO Player_Match_Participation VALUES(5,1, 11, NULL, 1 , 0 ,21, 100,5.8);
INSERT INTO Player_Match_Participation VALUES(5,1, 3, NULL, 1 , 0 ,59, 100,8.5);
INSERT INTO Player_Match_Participation VALUES(5,1, 20, NULL, 1 , 0 ,89, 100,8.6);
INSERT INTO Player_Match_Participation VALUES(5,1, 1, NULL, 1 , 0 ,27, 100,8.0);
INSERT INTO Player_Match_Participation VALUES(5,1, 13, NULL, 1 , 0 ,45, 100,8.4);
INSERT INTO Player_Match_Participation VALUES(5,1, 2, NULL, 1 , 0 ,49, 100,7.8);
INSERT INTO Player_Match_Participation VALUES(5,1, 8, NULL, 1 , 0 ,80, 100,6.5);
INSERT INTO Player_Match_Participation VALUES(5,1, 18, NULL, 1 , 0 ,65, 100,7.5);
INSERT INTO Player_Match_Participation VALUES(5,4, 70, NULL, 1 , 0 ,8, 100,6.4);
INSERT INTO Player_Match_Participation VALUES(5,4, 71, NULL, 1 , 0 ,91, 100,7.5);
INSERT INTO Player_Match_Participation VALUES(5,4, 77, NULL, 1 , 0 ,72, 100,7.8);
INSERT INTO Player_Match_Participation VALUES(5,4, 72, NULL, 1 , 0 ,16, 100,9.5);
INSERT INTO Player_Match_Participation VALUES(5,4, 78, NULL, 1 , 0 ,23, 100,6.0);
INSERT INTO Player_Match_Participation VALUES(5,4, 80, NULL, 1 , 0 ,89, 100,6.9);
INSERT INTO Player_Match_Participation VALUES(5,4, 73, NULL, 1 , 0 ,76, 100,6.0);
INSERT INTO Player_Match_Participation VALUES(5,4, 68, NULL, 1 , 0 ,68, 100,10.0);
INSERT INTO Player_Match_Participation VALUES(5,4, 64, NULL, 1 , 0 ,9, 100,5.6);
INSERT INTO Player_Match_Participation VALUES(5,4, 63, NULL, 1 , 0 ,47, 100,9.2);
INSERT INTO Player_Match_Participation VALUES(5,4, 69, NULL, 1 , 0 ,23, 100,6.7);
-- Match 6
INSERT INTO Player_Match_Participation VALUES(6,4, 77, NULL, 1 , 0 ,68, 100,7.7);
INSERT INTO Player_Match_Participation VALUES(6,4, 80, NULL, 1 , 0 ,21, 100,6.0);
INSERT INTO Player_Match_Participation VALUES(6,4, 62, NULL, 1 , 0 ,34, 100,9.2);
INSERT INTO Player_Match_Participation VALUES(6,4, 79, NULL, 1 , 0 ,64, 100,6.6);
INSERT INTO Player_Match_Participation VALUES(6,4, 65, NULL, 1 , 0 ,21, 100,6.2);
INSERT INTO Player_Match_Participation VALUES(6,4, 78, NULL, 1 , 0 ,78, 100,5.6);
INSERT INTO Player_Match_Participation VALUES(6,4, 76, NULL, 1 , 0 ,54, 100,9.9);
INSERT INTO Player_Match_Participation VALUES(6,4, 67, NULL, 1 , 0 ,90, 100,9.0);
INSERT INTO Player_Match_Participation VALUES(6,4, 72, NULL, 1 , 0 ,35, 100,6.1);
INSERT INTO Player_Match_Participation VALUES(6,4, 70, NULL, 1 , 0 ,97, 100,5.5);
INSERT INTO Player_Match_Participation VALUES(6,4, 69, NULL, 1 , 0 ,64, 100,8.8);
INSERT INTO Player_Match_Participation VALUES(6,1, 9, NULL, 1 , 0 ,3, 100,6.4);
INSERT INTO Player_Match_Participation VALUES(6,1, 18, NULL, 1 , 0 ,4, 100,6.1);
INSERT INTO Player_Match_Participation VALUES(6,1, 15, NULL, 1 , 0 ,18, 100,8.9);
INSERT INTO Player_Match_Participation VALUES(6,1, 8, NULL, 1 , 0 ,27, 100,6.3);
INSERT INTO Player_Match_Participation VALUES(6,1, 17, NULL, 1 , 0 ,5, 100,5.9);
INSERT INTO Player_Match_Participation VALUES(6,1, 19, NULL, 1 , 0 ,86, 100,7.3);
INSERT INTO Player_Match_Participation VALUES(6,1, 3, NULL, 1 , 0 ,2, 100,8.2);
INSERT INTO Player_Match_Participation VALUES(6,1, 13, NULL, 1 , 0 ,84, 100,8.8);
INSERT INTO Player_Match_Participation VALUES(6,1, 6, NULL, 1 , 0 ,80, 100,8.9);
INSERT INTO Player_Match_Participation VALUES(6,1, 11, NULL, 1 , 0 ,95, 100,8.1);
INSERT INTO Player_Match_Participation VALUES(6,1, 16, NULL, 1 , 0 ,36, 100,9.8);
-- Match 7
INSERT INTO Player_Match_Participation VALUES(7,1, 8, NULL, 1 , 0 ,68, 100,6.5);
INSERT INTO Player_Match_Participation VALUES(7,1, 5, NULL, 1 , 0 ,80, 100,8.2);
INSERT INTO Player_Match_Participation VALUES(7,1, 19, NULL, 1 , 0 ,56, 100,7.7);
INSERT INTO Player_Match_Participation VALUES(7,1, 15, NULL, 1 , 0 ,16, 100,7.8);
INSERT INTO Player_Match_Participation VALUES(7,1, 10, NULL, 1 , 0 ,19, 100,6.7);
INSERT INTO Player_Match_Participation VALUES(7,1, 12, NULL, 1 , 0 ,32, 100,9.9);
INSERT INTO Player_Match_Participation VALUES(7,1, 18, NULL, 1 , 0 ,7, 100,6.7);
INSERT INTO Player_Match_Participation VALUES(7,1, 16, NULL, 1 , 0 ,86, 100,7.1);
INSERT INTO Player_Match_Participation VALUES(7,1, 20, NULL, 1 , 0 ,47, 100,9.2);
INSERT INTO Player_Match_Participation VALUES(7,1, 17, NULL, 1 , 0 ,19, 100,9.2);
INSERT INTO Player_Match_Participation VALUES(7,1, 6, NULL, 1 , 0 ,28, 100,8.4);
INSERT INTO Player_Match_Participation VALUES(7,5, 89, NULL, 1 , 0 ,73, 100,8.5);
INSERT INTO Player_Match_Participation VALUES(7,5, 86, NULL, 1 , 0 ,93, 100,7.5);
INSERT INTO Player_Match_Participation VALUES(7,5, 93, NULL, 1 , 0 ,21, 100,7.5);
INSERT INTO Player_Match_Participation VALUES(7,5, 100, NULL, 1 , 0 ,4, 100,9.5);
INSERT INTO Player_Match_Participation VALUES(7,5, 83, NULL, 1 , 0 ,1, 100,7.1);
INSERT INTO Player_Match_Participation VALUES(7,5, 90, NULL, 1 , 0 ,86, 100,8.8);
INSERT INTO Player_Match_Participation VALUES(7,5, 91, NULL, 1 , 0 ,7, 100,9.0);
INSERT INTO Player_Match_Participation VALUES(7,5, 94, NULL, 1 , 0 ,78, 100,8.1);
INSERT INTO Player_Match_Participation VALUES(7,5, 97, NULL, 1 , 0 ,12, 100,7.4);
INSERT INTO Player_Match_Participation VALUES(7,5, 95, NULL, 1 , 0 ,57, 100,6.3);
INSERT INTO Player_Match_Participation VALUES(7,5, 82, NULL, 1 , 0 ,34, 100,9.4);
-- Match 8
INSERT INTO Player_Match_Participation VALUES(8,5, 98, NULL, 1 , 0 ,41, 100,6.1);
INSERT INTO Player_Match_Participation VALUES(8,5, 85, NULL, 1 , 0 ,31, 100,7.0);
INSERT INTO Player_Match_Participation VALUES(8,5, 99, NULL, 1 , 0 ,78, 100,7.1);
INSERT INTO Player_Match_Participation VALUES(8,5, 89, NULL, 1 , 0 ,33, 100,8.9);
INSERT INTO Player_Match_Participation VALUES(8,5, 82, NULL, 1 , 0 ,46, 100,8.5);
INSERT INTO Player_Match_Participation VALUES(8,5, 97, NULL, 1 , 0 ,84, 100,9.9);
INSERT INTO Player_Match_Participation VALUES(8,5, 88, NULL, 1 , 0 ,58, 100,7.6);
INSERT INTO Player_Match_Participation VALUES(8,5, 92, NULL, 1 , 0 ,95, 100,8.6);
INSERT INTO Player_Match_Participation VALUES(8,5, 93, NULL, 1 , 0 ,25, 100,6.4);
INSERT INTO Player_Match_Participation VALUES(8,5, 100, NULL, 1 , 0 ,4, 100,8.9);
INSERT INTO Player_Match_Participation VALUES(8,5, 86, NULL, 1 , 0 ,69, 100,8.5);
INSERT INTO Player_Match_Participation VALUES(8,1, 8, NULL, 1 , 0 ,35, 100,5.9);
INSERT INTO Player_Match_Participation VALUES(8,1, 5, NULL, 1 , 0 ,64, 100,7.0);
INSERT INTO Player_Match_Participation VALUES(8,1, 4, NULL, 1 , 0 ,13, 100,7.0);
INSERT INTO Player_Match_Participation VALUES(8,1, 19, NULL, 1 , 0 ,49, 100,7.1);
INSERT INTO Player_Match_Participation VALUES(8,1, 20, NULL, 1 , 0 ,64, 100,7.2);
INSERT INTO Player_Match_Participation VALUES(8,1, 1, NULL, 1 , 0 ,12, 100,5.7);
INSERT INTO Player_Match_Participation VALUES(8,1, 12, NULL, 1 , 0 ,80, 100,7.4);
INSERT INTO Player_Match_Participation VALUES(8,1, 17, NULL, 1 , 0 ,94, 100,8.4);
INSERT INTO Player_Match_Participation VALUES(8,1, 6, NULL, 1 , 0 ,79, 100,7.2);
INSERT INTO Player_Match_Participation VALUES(8,1, 13, NULL, 1 , 0 ,63, 100,7.9);
INSERT INTO Player_Match_Participation VALUES(8,1, 10, NULL, 1 , 0 ,11, 100,5.8);
-- Match 9
INSERT INTO Player_Match_Participation VALUES(9,1, 7, NULL, 1 , 0 ,95, 100,9.3);
INSERT INTO Player_Match_Participation VALUES(9,1, 15, NULL, 1 , 0 ,84, 100,9.5);
INSERT INTO Player_Match_Participation VALUES(9,1, 14, NULL, 1 , 0 ,44, 100,5.9);
INSERT INTO Player_Match_Participation VALUES(9,1, 5, NULL, 1 , 0 ,30, 100,6.9);
INSERT INTO Player_Match_Participation VALUES(9,1, 16, NULL, 1 , 0 ,80, 100,7.3);
INSERT INTO Player_Match_Participation VALUES(9,1, 12, NULL, 1 , 0 ,96, 100,8.8);
INSERT INTO Player_Match_Participation VALUES(9,1, 10, NULL, 1 , 0 ,36, 100,8.3);
INSERT INTO Player_Match_Participation VALUES(9,1, 17, NULL, 1 , 0 ,24, 100,8.6);
INSERT INTO Player_Match_Participation VALUES(9,1, 18, NULL, 1 , 0 ,79, 100,9.3);
INSERT INTO Player_Match_Participation VALUES(9,1, 1, NULL, 1 , 0 ,28, 100,9.9);
INSERT INTO Player_Match_Participation VALUES(9,1, 13, NULL, 1 , 0 ,15, 100,5.5);
INSERT INTO Player_Match_Participation VALUES(9,6, 111, NULL, 1 , 0 ,15, 100,7.6);
INSERT INTO Player_Match_Participation VALUES(9,6, 115, NULL, 1 , 0 ,85, 100,9.6);
INSERT INTO Player_Match_Participation VALUES(9,6, 109, NULL, 1 , 0 ,60, 100,8.5);
INSERT INTO Player_Match_Participation VALUES(9,6, 103, NULL, 1 , 0 ,67, 100,8.4);
INSERT INTO Player_Match_Participation VALUES(9,6, 118, NULL, 1 , 0 ,67, 100,9.1);
INSERT INTO Player_Match_Participation VALUES(9,6, 119, NULL, 1 , 0 ,85, 100,9.8);
INSERT INTO Player_Match_Participation VALUES(9,6, 104, NULL, 1 , 0 ,49, 100,9.8);
INSERT INTO Player_Match_Participation VALUES(9,6, 112, NULL, 1 , 0 ,57, 100,8.7);
INSERT INTO Player_Match_Participation VALUES(9,6, 107, NULL, 1 , 0 ,43, 100,7.7);
INSERT INTO Player_Match_Participation VALUES(9,6, 117, NULL, 1 , 0 ,54, 100,8.7);
INSERT INTO Player_Match_Participation VALUES(9,6, 116, NULL, 1 , 0 ,16, 100,6.5);
-- Match 10
INSERT INTO Player_Match_Participation VALUES(10,6, 109, NULL, 1 , 0 ,71, 100,9.0);
INSERT INTO Player_Match_Participation VALUES(10,6, 108, NULL, 1 , 0 ,30, 100,6.2);
INSERT INTO Player_Match_Participation VALUES(10,6, 101, NULL, 1 , 0 ,68, 100,6.7);
INSERT INTO Player_Match_Participation VALUES(10,6, 106, NULL, 1 , 0 ,20, 100,7.9);
INSERT INTO Player_Match_Participation VALUES(10,6, 114, NULL, 1 , 0 ,44, 100,8.1);
INSERT INTO Player_Match_Participation VALUES(10,6, 105, NULL, 1 , 0 ,93, 100,6.1);
INSERT INTO Player_Match_Participation VALUES(10,6, 119, NULL, 1 , 0 ,63, 100,5.9);
INSERT INTO Player_Match_Participation VALUES(10,6, 118, NULL, 1 , 0 ,36, 100,7.4);
INSERT INTO Player_Match_Participation VALUES(10,6, 110, NULL, 1 , 0 ,28, 100,6.3);
INSERT INTO Player_Match_Participation VALUES(10,6, 112, NULL, 1 , 0 ,68, 100,8.3);
INSERT INTO Player_Match_Participation VALUES(10,6, 107, NULL, 1 , 0 ,87, 100,8.6);
INSERT INTO Player_Match_Participation VALUES(10,1, 18, NULL, 1 , 0 ,46, 100,6.1);
INSERT INTO Player_Match_Participation VALUES(10,1, 8, NULL, 1 , 0 ,23, 100,5.7);
INSERT INTO Player_Match_Participation VALUES(10,1, 3, NULL, 1 , 0 ,74, 100,7.1);
INSERT INTO Player_Match_Participation VALUES(10,1, 5, NULL, 1 , 0 ,90, 100,7.6);
INSERT INTO Player_Match_Participation VALUES(10,1, 9, NULL, 1 , 0 ,67, 100,8.3);
INSERT INTO Player_Match_Participation VALUES(10,1, 17, NULL, 1 , 0 ,91, 100,8.2);
INSERT INTO Player_Match_Participation VALUES(10,1, 4, NULL, 1 , 0 ,1, 100,8.6);
INSERT INTO Player_Match_Participation VALUES(10,1, 13, NULL, 1 , 0 ,33, 100,9.0);
INSERT INTO Player_Match_Participation VALUES(10,1, 15, NULL, 1 , 0 ,87, 100,8.1);
INSERT INTO Player_Match_Participation VALUES(10,1, 11, NULL, 1 , 0 ,69, 100,7.3);
INSERT INTO Player_Match_Participation VALUES(10,1, 16, NULL, 1 , 0 ,73, 100,8.9);
-- Match 11
INSERT INTO Player_Match_Participation VALUES(11,2, 22, NULL, 1 , 0 ,18, 100,7.7);
INSERT INTO Player_Match_Participation VALUES(11,2, 29, NULL, 1 , 0 ,68, 100,6.2);
INSERT INTO Player_Match_Participation VALUES(11,2, 23, NULL, 1 , 0 ,45, 100,6.7);
INSERT INTO Player_Match_Participation VALUES(11,2, 28, NULL, 1 , 0 ,15, 100,7.7);
INSERT INTO Player_Match_Participation VALUES(11,2, 26, NULL, 1 , 0 ,35, 100,8.0);
INSERT INTO Player_Match_Participation VALUES(11,2, 38, NULL, 1 , 0 ,74, 100,6.2);
INSERT INTO Player_Match_Participation VALUES(11,2, 33, NULL, 1 , 0 ,5, 100,8.6);
INSERT INTO Player_Match_Participation VALUES(11,2, 27, NULL, 1 , 0 ,89, 100,6.9);
INSERT INTO Player_Match_Participation VALUES(11,2, 25, NULL, 1 , 0 ,38, 100,6.7);
INSERT INTO Player_Match_Participation VALUES(11,2, 30, NULL, 1 , 0 ,76, 100,7.1);
INSERT INTO Player_Match_Participation VALUES(11,2, 21, NULL, 1 , 0 ,47, 100,7.2);
INSERT INTO Player_Match_Participation VALUES(11,3, 44, NULL, 1 , 0 ,48, 100,5.7);
INSERT INTO Player_Match_Participation VALUES(11,3, 47, NULL, 1 , 0 ,64, 100,9.5);
INSERT INTO Player_Match_Participation VALUES(11,3, 53, NULL, 1 , 0 ,56, 100,8.0);
INSERT INTO Player_Match_Participation VALUES(11,3, 60, NULL, 1 , 0 ,32, 100,7.4);
INSERT INTO Player_Match_Participation VALUES(11,3, 57, NULL, 1 , 0 ,74, 100,7.1);
INSERT INTO Player_Match_Participation VALUES(11,3, 51, NULL, 1 , 0 ,33, 100,8.3);
INSERT INTO Player_Match_Participation VALUES(11,3, 61, NULL, 1 , 0 ,33, 100,6.6);
INSERT INTO Player_Match_Participation VALUES(11,3, 43, NULL, 1 , 0 ,21, 100,6.2);
INSERT INTO Player_Match_Participation VALUES(11,3, 52, NULL, 1 , 0 ,70, 100,6.9);
INSERT INTO Player_Match_Participation VALUES(11,3, 55, NULL, 1 , 0 ,47, 100,5.9);
INSERT INTO Player_Match_Participation VALUES(11,3, 58, NULL, 1 , 0 ,30, 100,6.9);
-- Match 12
INSERT INTO Player_Match_Participation VALUES(12,3, 59, NULL, 1 , 0 ,77, 100,6.9);
INSERT INTO Player_Match_Participation VALUES(12,3, 52, NULL, 1 , 0 ,36, 100,6.0);
INSERT INTO Player_Match_Participation VALUES(12,3, 48, NULL, 1 , 0 ,4, 100,9.8);
INSERT INTO Player_Match_Participation VALUES(12,3, 53, NULL, 1 , 0 ,18, 100,9.0);
INSERT INTO Player_Match_Participation VALUES(12,3, 56, NULL, 1 , 0 ,28, 100,5.6);
INSERT INTO Player_Match_Participation VALUES(12,3, 51, NULL, 1 , 0 ,78, 100,5.7);
INSERT INTO Player_Match_Participation VALUES(12,3, 49, NULL, 1 , 0 ,54, 100,5.9);
INSERT INTO Player_Match_Participation VALUES(12,3, 54, NULL, 1 , 0 ,11, 100,9.0);
INSERT INTO Player_Match_Participation VALUES(12,3, 58, NULL, 1 , 0 ,62, 100,8.0);
INSERT INTO Player_Match_Participation VALUES(12,3, 43, NULL, 1 , 0 ,66, 100,9.0);
INSERT INTO Player_Match_Participation VALUES(12,3, 50, NULL, 1 , 0 ,56, 100,7.4);
INSERT INTO Player_Match_Participation VALUES(12,2, 27, NULL, 1 , 0 ,15, 100,5.7);
INSERT INTO Player_Match_Participation VALUES(12,2, 28, NULL, 1 , 0 ,87, 100,9.3);
INSERT INTO Player_Match_Participation VALUES(12,2, 40, NULL, 1 , 0 ,70, 100,9.9);
INSERT INTO Player_Match_Participation VALUES(12,2, 39, NULL, 1 , 0 ,20, 100,5.7);
INSERT INTO Player_Match_Participation VALUES(12,2, 35, NULL, 1 , 0 ,52, 100,9.7);
INSERT INTO Player_Match_Participation VALUES(12,2, 24, NULL, 1 , 0 ,35, 100,7.0);
INSERT INTO Player_Match_Participation VALUES(12,2, 21, NULL, 1 , 0 ,61, 100,9.6);
INSERT INTO Player_Match_Participation VALUES(12,2, 23, NULL, 1 , 0 ,85, 100,7.8);
INSERT INTO Player_Match_Participation VALUES(12,2, 38, NULL, 1 , 0 ,59, 100,5.6);
INSERT INTO Player_Match_Participation VALUES(12,2, 26, NULL, 1 , 0 ,57, 100,9.4);
INSERT INTO Player_Match_Participation VALUES(12,2, 37, NULL, 1 , 0 ,65, 100,9.1);
-- Match 13
INSERT INTO Player_Match_Participation VALUES(13,2, 24, NULL, 1 , 0 ,57, 100,8.4);
INSERT INTO Player_Match_Participation VALUES(13,2, 25, NULL, 1 , 0 ,13, 100,8.5);
INSERT INTO Player_Match_Participation VALUES(13,2, 23, NULL, 1 , 0 ,84, 100,6.6);
INSERT INTO Player_Match_Participation VALUES(13,2, 21, NULL, 1 , 0 ,1, 100,6.3);
INSERT INTO Player_Match_Participation VALUES(13,2, 30, NULL, 1 , 0 ,46, 100,8.4);
INSERT INTO Player_Match_Participation VALUES(13,2, 29, NULL, 1 , 0 ,7, 100,7.9);
INSERT INTO Player_Match_Participation VALUES(13,2, 35, NULL, 1 , 0 ,60, 100,9.6);
INSERT INTO Player_Match_Participation VALUES(13,2, 28, NULL, 1 , 0 ,78, 100,8.6);
INSERT INTO Player_Match_Participation VALUES(13,2, 27, NULL, 1 , 0 ,28, 100,5.5);
INSERT INTO Player_Match_Participation VALUES(13,2, 40, NULL, 1 , 0 ,70, 100,7.3);
INSERT INTO Player_Match_Participation VALUES(13,2, 22, NULL, 1 , 0 ,78, 100,6.9);
INSERT INTO Player_Match_Participation VALUES(13,4, 62, NULL, 1 , 0 ,55, 100,5.8);
INSERT INTO Player_Match_Participation VALUES(13,4, 73, NULL, 1 , 0 ,13, 100,6.7);
INSERT INTO Player_Match_Participation VALUES(13,4, 66, NULL, 1 , 0 ,95, 100,6.9);
INSERT INTO Player_Match_Participation VALUES(13,4, 78, NULL, 1 , 0 ,34, 100,5.7);
INSERT INTO Player_Match_Participation VALUES(13,4, 80, NULL, 1 , 0 ,76, 100,6.9);
INSERT INTO Player_Match_Participation VALUES(13,4, 63, NULL, 1 , 0 ,66, 100,6.4);
INSERT INTO Player_Match_Participation VALUES(13,4, 75, NULL, 1 , 0 ,59, 100,7.2);
INSERT INTO Player_Match_Participation VALUES(13,4, 65, NULL, 1 , 0 ,49, 100,6.4);
INSERT INTO Player_Match_Participation VALUES(13,4, 67, NULL, 1 , 0 ,78, 100,8.3);
INSERT INTO Player_Match_Participation VALUES(13,4, 74, NULL, 1 , 0 ,75, 100,7.0);
INSERT INTO Player_Match_Participation VALUES(13,4, 60, NULL, 1 , 0 ,4, 100,6.5);
-- Match 14
INSERT INTO Player_Match_Participation VALUES(14,4, 63, NULL, 1 , 0 ,92, 100,8.2);
INSERT INTO Player_Match_Participation VALUES(14,4, 69, NULL, 1 , 0 ,10, 100,8.6);
INSERT INTO Player_Match_Participation VALUES(14,4, 80, NULL, 1 , 0 ,70, 100,7.2);
INSERT INTO Player_Match_Participation VALUES(14,4, 61, NULL, 1 , 0 ,72, 100,7.0);
INSERT INTO Player_Match_Participation VALUES(14,4, 72, NULL, 1 , 0 ,73, 100,6.0);
INSERT INTO Player_Match_Participation VALUES(14,4, 73, NULL, 1 , 0 ,76, 100,8.8);
INSERT INTO Player_Match_Participation VALUES(14,4, 68, NULL, 1 , 0 ,78, 100,7.4);
INSERT INTO Player_Match_Participation VALUES(14,4, 64, NULL, 1 , 0 ,7, 100,7.0);
INSERT INTO Player_Match_Participation VALUES(14,4, 70, NULL, 1 , 0 ,44, 100,9.7);
INSERT INTO Player_Match_Participation VALUES(14,4, 62, NULL, 1 , 0 ,75, 100,9.9);
INSERT INTO Player_Match_Participation VALUES(14,4, 60, NULL, 1 , 0 ,21, 100,6.6);
INSERT INTO Player_Match_Participation VALUES(14,2, 22, NULL, 1 , 0 ,41, 100,8.0);
INSERT INTO Player_Match_Participation VALUES(14,2, 32, NULL, 1 , 0 ,71, 100,8.5);
INSERT INTO Player_Match_Participation VALUES(14,2, 39, NULL, 1 , 0 ,40, 100,8.4);
INSERT INTO Player_Match_Participation VALUES(14,2, 34, NULL, 1 , 0 ,1, 100,6.8);
INSERT INTO Player_Match_Participation VALUES(14,2, 33, NULL, 1 , 0 ,31, 100,9.1);
INSERT INTO Player_Match_Participation VALUES(14,2, 24, NULL, 1 , 0 ,16, 100,9.2);
INSERT INTO Player_Match_Participation VALUES(14,2, 28, NULL, 1 , 0 ,84, 100,8.1);
INSERT INTO Player_Match_Participation VALUES(14,2, 21, NULL, 1 , 0 ,34, 100,6.3);
INSERT INTO Player_Match_Participation VALUES(14,2, 35, NULL, 1 , 0 ,49, 100,6.1);
INSERT INTO Player_Match_Participation VALUES(14,2, 29, NULL, 1 , 0 ,65, 100,5.8);
INSERT INTO Player_Match_Participation VALUES(14,2, 20, NULL, 1 , 0 ,87, 100,9.5);
-- Match 15
INSERT INTO Player_Match_Participation VALUES(15,2, 30, NULL, 1 , 0 ,87, 100,6.8);
INSERT INTO Player_Match_Participation VALUES(15,2, 26, NULL, 1 , 0 ,1, 100,6.0);
INSERT INTO Player_Match_Participation VALUES(15,2, 39, NULL, 1 , 0 ,87, 100,9.5);
INSERT INTO Player_Match_Participation VALUES(15,2, 36, NULL, 1 , 0 ,54, 100,8.4);
INSERT INTO Player_Match_Participation VALUES(15,2, 35, NULL, 1 , 0 ,84, 100,7.1);
INSERT INTO Player_Match_Participation VALUES(15,2, 32, NULL, 1 , 0 ,44, 100,7.3);
INSERT INTO Player_Match_Participation VALUES(15,2, 21, NULL, 1 , 0 ,2, 100,9.6);
INSERT INTO Player_Match_Participation VALUES(15,2, 37, NULL, 1 , 0 ,76, 100,9.4);
INSERT INTO Player_Match_Participation VALUES(15,2, 29, NULL, 1 , 0 ,54, 100,8.8);
INSERT INTO Player_Match_Participation VALUES(15,2, 33, NULL, 1 , 0 ,86, 100,9.6);
INSERT INTO Player_Match_Participation VALUES(15,2, 24, NULL, 1 , 0 ,44, 100,6.6);
INSERT INTO Player_Match_Participation VALUES(15,5, 82, NULL, 1 , 0 ,22, 100,8.7);
INSERT INTO Player_Match_Participation VALUES(15,5, 99, NULL, 1 , 0 ,36, 100,5.7);
INSERT INTO Player_Match_Participation VALUES(15,5, 83, NULL, 1 , 0 ,35, 100,9.4);
INSERT INTO Player_Match_Participation VALUES(15,5, 84, NULL, 1 , 0 ,34, 100,8.0);
INSERT INTO Player_Match_Participation VALUES(15,5, 88, NULL, 1 , 0 ,15, 100,6.8);
INSERT INTO Player_Match_Participation VALUES(15,5, 87, NULL, 1 , 0 ,31, 100,6.5);
INSERT INTO Player_Match_Participation VALUES(15,5, 81, NULL, 1 , 0 ,28, 100,5.6);
INSERT INTO Player_Match_Participation VALUES(15,5, 97, NULL, 1 , 0 ,35, 100,7.9);
INSERT INTO Player_Match_Participation VALUES(15,5, 95, NULL, 1 , 0 ,44, 100,9.0);
INSERT INTO Player_Match_Participation VALUES(15,5, 86, NULL, 1 , 0 ,90, 100,6.1);
INSERT INTO Player_Match_Participation VALUES(15,5, 94, NULL, 1 , 0 ,69, 100,7.4);
-- Match 16
INSERT INTO Player_Match_Participation VALUES(16,5, 96, NULL, 1 , 0 ,93, 100,8.1);
INSERT INTO Player_Match_Participation VALUES(16,5, 94, NULL, 1 , 0 ,85, 100,8.6);
INSERT INTO Player_Match_Participation VALUES(16,5, 93, NULL, 1 , 0 ,20, 100,7.0);
INSERT INTO Player_Match_Participation VALUES(16,5, 91, NULL, 1 , 0 ,63, 100,8.8);
INSERT INTO Player_Match_Participation VALUES(16,5, 89, NULL, 1 , 0 ,93, 100,8.5);
INSERT INTO Player_Match_Participation VALUES(16,5, 92, NULL, 1 , 0 ,67, 100,6.5);
INSERT INTO Player_Match_Participation VALUES(16,5, 90, NULL, 1 , 0 ,11, 100,8.2);
INSERT INTO Player_Match_Participation VALUES(16,5, 82, NULL, 1 , 0 ,47, 100,7.6);
INSERT INTO Player_Match_Participation VALUES(16,5, 83, NULL, 1 , 0 ,26, 100,8.7);
INSERT INTO Player_Match_Participation VALUES(16,5, 97, NULL, 1 , 0 ,8, 100,8.8);
INSERT INTO Player_Match_Participation VALUES(16,5, 80, NULL, 1 , 0 ,33, 100,8.0);
INSERT INTO Player_Match_Participation VALUES(16,2, 34, NULL, 1 , 0 ,97, 100,6.5);
INSERT INTO Player_Match_Participation VALUES(16,2, 27, NULL, 1 , 0 ,11, 100,9.4);
INSERT INTO Player_Match_Participation VALUES(16,2, 21, NULL, 1 , 0 ,13, 100,9.5);
INSERT INTO Player_Match_Participation VALUES(16,2, 26, NULL, 1 , 0 ,30, 100,6.8);
INSERT INTO Player_Match_Participation VALUES(16,2, 29, NULL, 1 , 0 ,61, 100,9.3);
INSERT INTO Player_Match_Participation VALUES(16,2, 22, NULL, 1 , 0 ,95, 100,9.0);
INSERT INTO Player_Match_Participation VALUES(16,2, 37, NULL, 1 , 0 ,18, 100,8.1);
INSERT INTO Player_Match_Participation VALUES(16,2, 31, NULL, 1 , 0 ,26, 100,7.0);
INSERT INTO Player_Match_Participation VALUES(16,2, 35, NULL, 1 , 0 ,58, 100,7.9);
INSERT INTO Player_Match_Participation VALUES(16,2, 23, NULL, 1 , 0 ,64, 100,9.1);
INSERT INTO Player_Match_Participation VALUES(16,2, 40, NULL, 1 , 0 ,61, 100,6.9);
-- Match 17
INSERT INTO Player_Match_Participation VALUES(17,2, 23, NULL, 1 , 0 ,48, 100,6.8);
INSERT INTO Player_Match_Participation VALUES(17,2, 33, NULL, 1 , 0 ,45, 100,7.7);
INSERT INTO Player_Match_Participation VALUES(17,2, 38, NULL, 1 , 0 ,11, 100,8.4);
INSERT INTO Player_Match_Participation VALUES(17,2, 35, NULL, 1 , 0 ,97, 100,9.0);
INSERT INTO Player_Match_Participation VALUES(17,2, 32, NULL, 1 , 0 ,33, 100,5.8);
INSERT INTO Player_Match_Participation VALUES(17,2, 27, NULL, 1 , 0 ,55, 100,9.1);
INSERT INTO Player_Match_Participation VALUES(17,2, 40, NULL, 1 , 0 ,16, 100,6.7);
INSERT INTO Player_Match_Participation VALUES(17,2, 21, NULL, 1 , 0 ,70, 100,8.1);
INSERT INTO Player_Match_Participation VALUES(17,2, 22, NULL, 1 , 0 ,62, 100,6.6);
INSERT INTO Player_Match_Participation VALUES(17,2, 39, NULL, 1 , 0 ,51, 100,7.4);
INSERT INTO Player_Match_Participation VALUES(17,2, 37, NULL, 1 , 0 ,19, 100,6.9);
INSERT INTO Player_Match_Participation VALUES(17,6, 109, NULL, 1 , 0 ,84, 100,5.9);
INSERT INTO Player_Match_Participation VALUES(17,6, 106, NULL, 1 , 0 ,53, 100,9.8);
INSERT INTO Player_Match_Participation VALUES(17,6, 101, NULL, 1 , 0 ,76, 100,8.7);
INSERT INTO Player_Match_Participation VALUES(17,6, 105, NULL, 1 , 0 ,49, 100,9.9);
INSERT INTO Player_Match_Participation VALUES(17,6, 107, NULL, 1 , 0 ,33, 100,6.8);
INSERT INTO Player_Match_Participation VALUES(17,6, 104, NULL, 1 , 0 ,97, 100,8.4);
INSERT INTO Player_Match_Participation VALUES(17,6, 108, NULL, 1 , 0 ,34, 100,7.8);
INSERT INTO Player_Match_Participation VALUES(17,6, 118, NULL, 1 , 0 ,55, 100,8.3);
INSERT INTO Player_Match_Participation VALUES(17,6, 114, NULL, 1 , 0 ,40, 100,8.9);
INSERT INTO Player_Match_Participation VALUES(17,6, 117, NULL, 1 , 0 ,85, 100,6.2);
INSERT INTO Player_Match_Participation VALUES(17,6, 102, NULL, 1 , 0 ,8, 100,6.8);
-- Match 18
INSERT INTO Player_Match_Participation VALUES(18,6, 114, NULL, 1 , 0 ,68, 100,7.4);
INSERT INTO Player_Match_Participation VALUES(18,6, 116, NULL, 1 , 0 ,38, 100,6.3);
INSERT INTO Player_Match_Participation VALUES(18,6, 109, NULL, 1 , 0 ,23, 100,8.8);
INSERT INTO Player_Match_Participation VALUES(18,6, 102, NULL, 1 , 0 ,32, 100,5.6);
INSERT INTO Player_Match_Participation VALUES(18,6, 115, NULL, 1 , 0 ,73, 100,6.0);
INSERT INTO Player_Match_Participation VALUES(18,6, 118, NULL, 1 , 0 ,65, 100,5.8);
INSERT INTO Player_Match_Participation VALUES(18,6, 107, NULL, 1 , 0 ,42, 100,9.0);
INSERT INTO Player_Match_Participation VALUES(18,6, 104, NULL, 1 , 0 ,63, 100,6.0);
INSERT INTO Player_Match_Participation VALUES(18,6, 103, NULL, 1 , 0 ,27, 100,6.3);
INSERT INTO Player_Match_Participation VALUES(18,6, 119, NULL, 1 , 0 ,38, 100,8.9);
INSERT INTO Player_Match_Participation VALUES(18,6, 105, NULL, 1 , 0 ,72, 100,6.6);
INSERT INTO Player_Match_Participation VALUES(18,2, 32, NULL, 1 , 0 ,86, 100,6.9);
INSERT INTO Player_Match_Participation VALUES(18,2, 34, NULL, 1 , 0 ,39, 100,7.6);
INSERT INTO Player_Match_Participation VALUES(18,2, 39, NULL, 1 , 0 ,94, 100,8.9);
INSERT INTO Player_Match_Participation VALUES(18,2, 38, NULL, 1 , 0 ,26, 100,7.1);
INSERT INTO Player_Match_Participation VALUES(18,2, 25, NULL, 1 , 0 ,88, 100,8.9);
INSERT INTO Player_Match_Participation VALUES(18,2, 26, NULL, 1 , 0 ,28, 100,6.2);
INSERT INTO Player_Match_Participation VALUES(18,2, 33, NULL, 1 , 0 ,67, 100,8.4);
INSERT INTO Player_Match_Participation VALUES(18,2, 35, NULL, 1 , 0 ,69, 100,6.0);
INSERT INTO Player_Match_Participation VALUES(18,2, 27, NULL, 1 , 0 ,78, 100,7.3);
INSERT INTO Player_Match_Participation VALUES(18,2, 28, NULL, 1 , 0 ,37, 100,5.9);
INSERT INTO Player_Match_Participation VALUES(18,2, 22, NULL, 1 , 0 ,14, 100,5.6);
-- Match 19
INSERT INTO Player_Match_Participation VALUES(19,3, 50, NULL, 1 , 0 ,52, 100,9.2);
INSERT INTO Player_Match_Participation VALUES(19,3, 58, NULL, 1 , 0 ,89, 100,8.6);
INSERT INTO Player_Match_Participation VALUES(19,3, 42, NULL, 1 , 0 ,45, 100,7.1);
INSERT INTO Player_Match_Participation VALUES(19,3, 54, NULL, 1 , 0 ,44, 100,6.5);
INSERT INTO Player_Match_Participation VALUES(19,3, 60, NULL, 1 , 0 ,56, 100,8.2);
INSERT INTO Player_Match_Participation VALUES(19,3, 47, NULL, 1 , 0 ,19, 100,7.9);
INSERT INTO Player_Match_Participation VALUES(19,3, 43, NULL, 1 , 0 ,14, 100,6.3);
INSERT INTO Player_Match_Participation VALUES(19,3, 44, NULL, 1 , 0 ,30, 100,7.3);
INSERT INTO Player_Match_Participation VALUES(19,3, 45, NULL, 1 , 0 ,52, 100,9.7);
INSERT INTO Player_Match_Participation VALUES(19,3, 46, NULL, 1 , 0 ,69, 100,5.8);
INSERT INTO Player_Match_Participation VALUES(19,3, 52, NULL, 1 , 0 ,54, 100,6.4);
INSERT INTO Player_Match_Participation VALUES(19,4, 63, NULL, 1 , 0 ,13, 100,9.3);
INSERT INTO Player_Match_Participation VALUES(19,4, 68, NULL, 1 , 0 ,73, 100,9.6);
INSERT INTO Player_Match_Participation VALUES(19,4, 69, NULL, 1 , 0 ,37, 100,7.6);
INSERT INTO Player_Match_Participation VALUES(19,4, 80, NULL, 1 , 0 ,56, 100,9.2);
INSERT INTO Player_Match_Participation VALUES(19,4, 73, NULL, 1 , 0 ,55, 100,8.1);
INSERT INTO Player_Match_Participation VALUES(19,4, 70, NULL, 1 , 0 ,46, 100,8.5);
INSERT INTO Player_Match_Participation VALUES(19,4, 67, NULL, 1 , 0 ,47, 100,7.4);
INSERT INTO Player_Match_Participation VALUES(19,4, 71, NULL, 1 , 0 ,73, 100,7.9);
INSERT INTO Player_Match_Participation VALUES(19,4, 64, NULL, 1 , 0 ,42, 100,8.1);
INSERT INTO Player_Match_Participation VALUES(19,4, 79, NULL, 1 , 0 ,56, 100,9.1);
INSERT INTO Player_Match_Participation VALUES(19,4, 65, NULL, 1 , 0 ,67, 100,9.1);
-- Match 20
INSERT INTO Player_Match_Participation VALUES(20,4, 64, NULL, 1 , 0 ,23, 100,5.6);
INSERT INTO Player_Match_Participation VALUES(20,4, 72, NULL, 1 , 0 ,52, 100,9.0);
INSERT INTO Player_Match_Participation VALUES(20,4, 65, NULL, 1 , 0 ,21, 100,9.6);
INSERT INTO Player_Match_Participation VALUES(20,4, 66, NULL, 1 , 0 ,19, 100,5.8);
INSERT INTO Player_Match_Participation VALUES(20,4, 74, NULL, 1 , 0 ,5, 100,6.4);
INSERT INTO Player_Match_Participation VALUES(20,4, 70, NULL, 1 , 0 ,5, 100,7.8);
INSERT INTO Player_Match_Participation VALUES(20,4, 79, NULL, 1 , 0 ,85, 100,10.0);
INSERT INTO Player_Match_Participation VALUES(20,4, 77, NULL, 1 , 0 ,95, 100,6.2);
INSERT INTO Player_Match_Participation VALUES(20,4, 73, NULL, 1 , 0 ,96, 100,6.3);
INSERT INTO Player_Match_Participation VALUES(20,4, 76, NULL, 1 , 0 ,46, 100,9.3);
INSERT INTO Player_Match_Participation VALUES(20,4, 78, NULL, 1 , 0 ,67, 100,6.7);
INSERT INTO Player_Match_Participation VALUES(20,3, 57, NULL, 1 , 0 ,90, 100,7.4);
INSERT INTO Player_Match_Participation VALUES(20,3, 51, NULL, 1 , 0 ,53, 100,5.6);
INSERT INTO Player_Match_Participation VALUES(20,3, 50, NULL, 1 , 0 ,36, 100,7.3);
INSERT INTO Player_Match_Participation VALUES(20,3, 49, NULL, 1 , 0 ,71, 100,8.9);
INSERT INTO Player_Match_Participation VALUES(20,3, 46, NULL, 1 , 0 ,88, 100,5.7);
INSERT INTO Player_Match_Participation VALUES(20,3, 45, NULL, 1 , 0 ,65, 100,7.1);
INSERT INTO Player_Match_Participation VALUES(20,3, 52, NULL, 1 , 0 ,52, 100,8.3);
INSERT INTO Player_Match_Participation VALUES(20,3, 59, NULL, 1 , 0 ,30, 100,7.5);
INSERT INTO Player_Match_Participation VALUES(20,3, 44, NULL, 1 , 0 ,4, 100,9.2);
INSERT INTO Player_Match_Participation VALUES(20,3, 53, NULL, 1 , 0 ,59, 100,7.4);
INSERT INTO Player_Match_Participation VALUES(20,3, 41, NULL, 1 , 0 ,9, 100,7.0);
-- Match 21
INSERT INTO Player_Match_Participation VALUES(21,3, 50, NULL, 1 , 0 ,57, 100,5.6);
INSERT INTO Player_Match_Participation VALUES(21,3, 58, NULL, 1 , 0 ,55, 100,6.8);
INSERT INTO Player_Match_Participation VALUES(21,3, 55, NULL, 1 , 0 ,85, 100,7.6);
INSERT INTO Player_Match_Participation VALUES(21,3, 47, NULL, 1 , 0 ,31, 100,5.8);
INSERT INTO Player_Match_Participation VALUES(21,3, 59, NULL, 1 , 0 ,70, 100,7.0);
INSERT INTO Player_Match_Participation VALUES(21,3, 56, NULL, 1 , 0 ,68, 100,8.1);
INSERT INTO Player_Match_Participation VALUES(21,3, 46, NULL, 1 , 0 ,38, 100,7.0);
INSERT INTO Player_Match_Participation VALUES(21,3, 42, NULL, 1 , 0 ,52, 100,9.9);
INSERT INTO Player_Match_Participation VALUES(21,3, 54, NULL, 1 , 0 ,17, 100,5.8);
INSERT INTO Player_Match_Participation VALUES(21,3, 48, NULL, 1 , 0 ,35, 100,7.2);
INSERT INTO Player_Match_Participation VALUES(21,3, 45, NULL, 1 , 0 ,57, 100,7.7);
INSERT INTO Player_Match_Participation VALUES(21,5, 99, NULL, 1 , 0 ,46, 100,6.3);
INSERT INTO Player_Match_Participation VALUES(21,5, 90, NULL, 1 , 0 ,2, 100,6.1);
INSERT INTO Player_Match_Participation VALUES(21,5, 85, NULL, 1 , 0 ,91, 100,7.6);
INSERT INTO Player_Match_Participation VALUES(21,5, 94, NULL, 1 , 0 ,51, 100,9.1);
INSERT INTO Player_Match_Participation VALUES(21,5, 92, NULL, 1 , 0 ,17, 100,10.0);
INSERT INTO Player_Match_Participation VALUES(21,5, 93, NULL, 1 , 0 ,8, 100,5.8);
INSERT INTO Player_Match_Participation VALUES(21,5, 89, NULL, 1 , 0 ,94, 100,9.1);
INSERT INTO Player_Match_Participation VALUES(21,5, 82, NULL, 1 , 0 ,9, 100,7.1);
INSERT INTO Player_Match_Participation VALUES(21,5, 81, NULL, 1 , 0 ,78, 100,7.3);
INSERT INTO Player_Match_Participation VALUES(21,5, 96, NULL, 1 , 0 ,45, 100,8.4);
INSERT INTO Player_Match_Participation VALUES(21,5, 83, NULL, 1 , 0 ,40, 100,7.3);
-- Match 22
INSERT INTO Player_Match_Participation VALUES(22,5, 93, NULL, 1 , 0 ,22, 100,6.7);
INSERT INTO Player_Match_Participation VALUES(22,5, 94, NULL, 1 , 0 ,54, 100,6.7);
INSERT INTO Player_Match_Participation VALUES(22,5, 92, NULL, 1 , 0 ,95, 100,7.3);
INSERT INTO Player_Match_Participation VALUES(22,5, 88, NULL, 1 , 0 ,8, 100,9.4);
INSERT INTO Player_Match_Participation VALUES(22,5, 95, NULL, 1 , 0 ,76, 100,6.2);
INSERT INTO Player_Match_Participation VALUES(22,5, 91, NULL, 1 , 0 ,47, 100,7.9);
INSERT INTO Player_Match_Participation VALUES(22,5, 86, NULL, 1 , 0 ,1, 100,9.9);
INSERT INTO Player_Match_Participation VALUES(22,5, 97, NULL, 1 , 0 ,18, 100,7.3);
INSERT INTO Player_Match_Participation VALUES(22,5, 83, NULL, 1 , 0 ,66, 100,7.3);
INSERT INTO Player_Match_Participation VALUES(22,5, 100, NULL, 1 , 0 ,64, 100,7.2);
INSERT INTO Player_Match_Participation VALUES(22,5, 81, NULL, 1 , 0 ,9, 100,9.7);
INSERT INTO Player_Match_Participation VALUES(22,3, 51, NULL, 1 , 0 ,97, 100,9.3);
INSERT INTO Player_Match_Participation VALUES(22,3, 44, NULL, 1 , 0 ,10, 100,7.3);
INSERT INTO Player_Match_Participation VALUES(22,3, 50, NULL, 1 , 0 ,71, 100,9.1);
INSERT INTO Player_Match_Participation VALUES(22,3, 47, NULL, 1 , 0 ,61, 100,5.7);
INSERT INTO Player_Match_Participation VALUES(22,3, 42, NULL, 1 , 0 ,33, 100,7.8);
INSERT INTO Player_Match_Participation VALUES(22,3, 52, NULL, 1 , 0 ,47, 100,6.7);
INSERT INTO Player_Match_Participation VALUES(22,3, 53, NULL, 1 , 0 ,41, 100,5.6);
INSERT INTO Player_Match_Participation VALUES(22,3, 48, NULL, 1 , 0 ,63, 100,8.0);
INSERT INTO Player_Match_Participation VALUES(22,3, 41, NULL, 1 , 0 ,15, 100,7.7);
INSERT INTO Player_Match_Participation VALUES(22,3, 59, NULL, 1 , 0 ,21, 100,9.7);
INSERT INTO Player_Match_Participation VALUES(22,3, 56, NULL, 1 , 0 ,77, 100,6.1);
-- Match 23
INSERT INTO Player_Match_Participation VALUES(23,3, 45, NULL, 1 , 0 ,63, 100,8.0);
INSERT INTO Player_Match_Participation VALUES(23,3, 52, NULL, 1 , 0 ,96, 100,6.0);
INSERT INTO Player_Match_Participation VALUES(23,3, 56, NULL, 1 , 0 ,13, 100,6.7);
INSERT INTO Player_Match_Participation VALUES(23,3, 43, NULL, 1 , 0 ,3, 100,7.4);
INSERT INTO Player_Match_Participation VALUES(23,3, 46, NULL, 1 , 0 ,62, 100,6.5);
INSERT INTO Player_Match_Participation VALUES(23,3, 55, NULL, 1 , 0 ,58, 100,9.2);
INSERT INTO Player_Match_Participation VALUES(23,3, 47, NULL, 1 , 0 ,50, 100,5.6);
INSERT INTO Player_Match_Participation VALUES(23,3, 53, NULL, 1 , 0 ,93, 100,10.0);
INSERT INTO Player_Match_Participation VALUES(23,3, 41, NULL, 1 , 0 ,43, 100,6.3);
INSERT INTO Player_Match_Participation VALUES(23,3, 49, NULL, 1 , 0 ,58, 100,8.5);
INSERT INTO Player_Match_Participation VALUES(23,3, 44, NULL, 1 , 0 ,17, 100,8.1);
INSERT INTO Player_Match_Participation VALUES(23,6, 111, NULL, 1 , 0 ,40, 100,7.4);
INSERT INTO Player_Match_Participation VALUES(23,6, 101, NULL, 1 , 0 ,56, 100,7.7);
INSERT INTO Player_Match_Participation VALUES(23,6, 109, NULL, 1 , 0 ,54, 100,7.3);
INSERT INTO Player_Match_Participation VALUES(23,6, 119, NULL, 1 , 0 ,47, 100,8.2);
INSERT INTO Player_Match_Participation VALUES(23,6, 113, NULL, 1 , 0 ,65, 100,6.8);
INSERT INTO Player_Match_Participation VALUES(23,6, 115, NULL, 1 , 0 ,83, 100,8.6);
INSERT INTO Player_Match_Participation VALUES(23,6, 114, NULL, 1 , 0 ,95, 100,7.8);
INSERT INTO Player_Match_Participation VALUES(23,6, 112, NULL, 1 , 0 ,5, 100,6.3);
INSERT INTO Player_Match_Participation VALUES(23,6, 118, NULL, 1 , 0 ,21, 100,8.6);
INSERT INTO Player_Match_Participation VALUES(23,6, 120, NULL, 1 , 0 ,7, 100,9.8);
INSERT INTO Player_Match_Participation VALUES(23,6, 116, NULL, 1 , 0 ,71, 100,8.6);
-- Match 24
INSERT INTO Player_Match_Participation VALUES(24,6, 117, NULL, 1 , 0 ,7, 100,9.3);
INSERT INTO Player_Match_Participation VALUES(24,6, 102, NULL, 1 , 0 ,18, 100,5.7);
INSERT INTO Player_Match_Participation VALUES(24,6, 115, NULL, 1 , 0 ,62, 100,8.1);
INSERT INTO Player_Match_Participation VALUES(24,6, 118, NULL, 1 , 0 ,80, 100,7.8);
INSERT INTO Player_Match_Participation VALUES(24,6, 120, NULL, 1 , 0 ,11, 100,9.9);
INSERT INTO Player_Match_Participation VALUES(24,6, 103, NULL, 1 , 0 ,6, 100,6.0);
INSERT INTO Player_Match_Participation VALUES(24,6, 113, NULL, 1 , 0 ,53, 100,8.0);
INSERT INTO Player_Match_Participation VALUES(24,6, 106, NULL, 1 , 0 ,87, 100,7.0);
INSERT INTO Player_Match_Participation VALUES(24,6, 108, NULL, 1 , 0 ,54, 100,7.5);
INSERT INTO Player_Match_Participation VALUES(24,6, 116, NULL, 1 , 0 ,31, 100,10.0);
INSERT INTO Player_Match_Participation VALUES(24,6, 105, NULL, 1 , 0 ,14, 100,8.7);
INSERT INTO Player_Match_Participation VALUES(24,3, 49, NULL, 1 , 0 ,91, 100,9.8);
INSERT INTO Player_Match_Participation VALUES(24,3, 45, NULL, 1 , 0 ,55, 100,9.3);
INSERT INTO Player_Match_Participation VALUES(24,3, 60, NULL, 1 , 0 ,22, 100,7.1);
INSERT INTO Player_Match_Participation VALUES(24,3, 47, NULL, 1 , 0 ,85, 100,9.7);
INSERT INTO Player_Match_Participation VALUES(24,3, 50, NULL, 1 , 0 ,46, 100,6.6);
INSERT INTO Player_Match_Participation VALUES(24,3, 56, NULL, 1 , 0 ,88, 100,6.2);
INSERT INTO Player_Match_Participation VALUES(24,3, 52, NULL, 1 , 0 ,11, 100,6.8);
INSERT INTO Player_Match_Participation VALUES(24,3, 46, NULL, 1 , 0 ,92, 100,8.9);
INSERT INTO Player_Match_Participation VALUES(24,3, 61, NULL, 1 , 0 ,19, 100,9.4);
INSERT INTO Player_Match_Participation VALUES(24,3, 48, NULL, 1 , 0 ,60, 100,5.7);
INSERT INTO Player_Match_Participation VALUES(24,3, 42, NULL, 1 , 0 ,73, 100,9.1);
-- Match 25
INSERT INTO Player_Match_Participation VALUES(25,4, 64, NULL, 1 , 0 ,21, 100,6.9);
INSERT INTO Player_Match_Participation VALUES(25,4, 67, NULL, 1 , 0 ,2, 100,9.8);
INSERT INTO Player_Match_Participation VALUES(25,4, 65, NULL, 1 , 0 ,10, 100,6.3);
INSERT INTO Player_Match_Participation VALUES(25,4, 71, NULL, 1 , 0 ,8, 100,6.7);
INSERT INTO Player_Match_Participation VALUES(25,4, 72, NULL, 1 , 0 ,64, 100,6.7);
INSERT INTO Player_Match_Participation VALUES(25,4, 76, NULL, 1 , 0 ,94, 100,8.8);
INSERT INTO Player_Match_Participation VALUES(25,4, 66, NULL, 1 , 0 ,80, 100,9.8);
INSERT INTO Player_Match_Participation VALUES(25,4, 74, NULL, 1 , 0 ,70, 100,10.0);
INSERT INTO Player_Match_Participation VALUES(25,4, 68, NULL, 1 , 0 ,76, 100,9.5);
INSERT INTO Player_Match_Participation VALUES(25,4, 61, NULL, 1 , 0 ,72, 100,5.8);
INSERT INTO Player_Match_Participation VALUES(25,4, 73, NULL, 1 , 0 ,22, 100,6.4);
INSERT INTO Player_Match_Participation VALUES(25,5, 92, NULL, 1 , 0 ,89, 100,5.8);
INSERT INTO Player_Match_Participation VALUES(25,5, 94, NULL, 1 , 0 ,88, 100,5.9);
INSERT INTO Player_Match_Participation VALUES(25,5, 81, NULL, 1 , 0 ,55, 100,9.7);
INSERT INTO Player_Match_Participation VALUES(25,5, 100, NULL, 1 , 0 ,55, 100,7.2);
INSERT INTO Player_Match_Participation VALUES(25,5, 88, NULL, 1 , 0 ,33, 100,7.9);
INSERT INTO Player_Match_Participation VALUES(25,5, 84, NULL, 1 , 0 ,71, 100,6.2);
INSERT INTO Player_Match_Participation VALUES(25,5, 87, NULL, 1 , 0 ,57, 100,6.9);
INSERT INTO Player_Match_Participation VALUES(25,5, 90, NULL, 1 , 0 ,60, 100,6.0);
INSERT INTO Player_Match_Participation VALUES(25,5, 101, NULL, 1 , 0 ,22, 100,5.8);
INSERT INTO Player_Match_Participation VALUES(25,5, 91, NULL, 1 , 0 ,57, 100,8.8);
INSERT INTO Player_Match_Participation VALUES(25,5, 99, NULL, 1 , 0 ,78, 100,6.0);
-- Match 26
INSERT INTO Player_Match_Participation VALUES(26,5, 91, NULL, 1 , 0 ,31, 100,9.7);
INSERT INTO Player_Match_Participation VALUES(26,5, 85, NULL, 1 , 0 ,73, 100,8.4);
INSERT INTO Player_Match_Participation VALUES(26,5, 93, NULL, 1 , 0 ,11, 100,6.4);
INSERT INTO Player_Match_Participation VALUES(26,5, 81, NULL, 1 , 0 ,64, 100,6.8);
INSERT INTO Player_Match_Participation VALUES(26,5, 94, NULL, 1 , 0 ,70, 100,8.2);
INSERT INTO Player_Match_Participation VALUES(26,5, 96, NULL, 1 , 0 ,84, 100,9.4);
INSERT INTO Player_Match_Participation VALUES(26,5, 87, NULL, 1 , 0 ,73, 100,9.5);
INSERT INTO Player_Match_Participation VALUES(26,5, 86, NULL, 1 , 0 ,82, 100,6.7);
INSERT INTO Player_Match_Participation VALUES(26,5, 88, NULL, 1 , 0 ,8, 100,6.8);
INSERT INTO Player_Match_Participation VALUES(26,5, 98, NULL, 1 , 0 ,54, 100,9.0);
INSERT INTO Player_Match_Participation VALUES(26,5, 100, NULL, 1 , 0 ,22, 100,9.2);
INSERT INTO Player_Match_Participation VALUES(26,4, 64, NULL, 1 , 0 ,96, 100,7.1);
INSERT INTO Player_Match_Participation VALUES(26,4, 71, NULL, 1 , 0 ,57, 100,8.2);
INSERT INTO Player_Match_Participation VALUES(26,4, 72, NULL, 1 , 0 ,3, 100,8.8);
INSERT INTO Player_Match_Participation VALUES(26,4, 80, NULL, 1 , 0 ,5, 100,8.7);
INSERT INTO Player_Match_Participation VALUES(26,4, 74, NULL, 1 , 0 ,16, 100,9.9);
INSERT INTO Player_Match_Participation VALUES(26,4, 73, NULL, 1 , 0 ,39, 100,7.6);
INSERT INTO Player_Match_Participation VALUES(26,4, 65, NULL, 1 , 0 ,89, 100,6.0);
INSERT INTO Player_Match_Participation VALUES(26,4, 76, NULL, 1 , 0 ,77, 100,6.2);
INSERT INTO Player_Match_Participation VALUES(26,4, 63, NULL, 1 , 0 ,86, 100,6.2);
INSERT INTO Player_Match_Participation VALUES(26,4, 66, NULL, 1 , 0 ,53, 100,7.9);
INSERT INTO Player_Match_Participation VALUES(26,4, 69, NULL, 1 , 0 ,29, 100,9.1);
-- Match 27
INSERT INTO Player_Match_Participation VALUES(27,4, 64, NULL, 1 , 0 ,9, 100,9.9);
INSERT INTO Player_Match_Participation VALUES(27,4, 70, NULL, 1 , 0 ,57, 100,9.9);
INSERT INTO Player_Match_Participation VALUES(27,4, 66, NULL, 1 , 0 ,77, 100,7.9);
INSERT INTO Player_Match_Participation VALUES(27,4, 67, NULL, 1 , 0 ,48, 100,9.9);
INSERT INTO Player_Match_Participation VALUES(27,4, 73, NULL, 1 , 0 ,73, 100,6.7);
INSERT INTO Player_Match_Participation VALUES(27,4, 74, NULL, 1 , 0 ,50, 100,5.5);
INSERT INTO Player_Match_Participation VALUES(27,4, 80, NULL, 1 , 0 ,57, 100,5.9);
INSERT INTO Player_Match_Participation VALUES(27,4, 75, NULL, 1 , 0 ,16, 100,9.6);
INSERT INTO Player_Match_Participation VALUES(27,4, 71, NULL, 1 , 0 ,21, 100,6.3);
INSERT INTO Player_Match_Participation VALUES(27,4, 65, NULL, 1 , 0 ,91, 100,8.7);
INSERT INTO Player_Match_Participation VALUES(27,4, 78, NULL, 1 , 0 ,52, 100,8.6);
INSERT INTO Player_Match_Participation VALUES(27,6, 111, NULL, 1 , 0 ,7, 100,9.9);
INSERT INTO Player_Match_Participation VALUES(27,6, 104, NULL, 1 , 0 ,66, 100,6.8);
INSERT INTO Player_Match_Participation VALUES(27,6, 114, NULL, 1 , 0 ,95, 100,9.1);
INSERT INTO Player_Match_Participation VALUES(27,6, 103, NULL, 1 , 0 ,69, 100,8.2);
INSERT INTO Player_Match_Participation VALUES(27,6, 101, NULL, 1 , 0 ,77, 100,9.4);
INSERT INTO Player_Match_Participation VALUES(27,6, 102, NULL, 1 , 0 ,27, 100,9.7);
INSERT INTO Player_Match_Participation VALUES(27,6, 117, NULL, 1 , 0 ,36, 100,6.3);
INSERT INTO Player_Match_Participation VALUES(27,6, 109, NULL, 1 , 0 ,1, 100,9.9);
INSERT INTO Player_Match_Participation VALUES(27,6, 112, NULL, 1 , 0 ,38, 100,7.0);
INSERT INTO Player_Match_Participation VALUES(27,6, 118, NULL, 1 , 0 ,56, 100,9.5);
INSERT INTO Player_Match_Participation VALUES(27,6, 113, NULL, 1 , 0 ,47, 100,8.4);
-- Match 28
INSERT INTO Player_Match_Participation VALUES(28,6, 118, NULL, 1 , 0 ,72, 100,7.7);
INSERT INTO Player_Match_Participation VALUES(28,6, 117, NULL, 1 , 0 ,54, 100,6.3);
INSERT INTO Player_Match_Participation VALUES(28,6, 119, NULL, 1 , 0 ,54, 100,6.2);
INSERT INTO Player_Match_Participation VALUES(28,6, 116, NULL, 1 , 0 ,49, 100,8.5);
INSERT INTO Player_Match_Participation VALUES(28,6, 102, NULL, 1 , 0 ,15, 100,6.3);
INSERT INTO Player_Match_Participation VALUES(28,6, 105, NULL, 1 , 0 ,21, 100,6.8);
INSERT INTO Player_Match_Participation VALUES(28,6, 120, NULL, 1 , 0 ,41, 100,6.0);
INSERT INTO Player_Match_Participation VALUES(28,6, 112, NULL, 1 , 0 ,60, 100,8.0);
INSERT INTO Player_Match_Participation VALUES(28,6, 111, NULL, 1 , 0 ,92, 100,8.6);
INSERT INTO Player_Match_Participation VALUES(28,6, 106, NULL, 1 , 0 ,69, 100,6.8);
INSERT INTO Player_Match_Participation VALUES(28,6, 108, NULL, 1 , 0 ,38, 100,6.9);
INSERT INTO Player_Match_Participation VALUES(28,4, 69, NULL, 1 , 0 ,48, 100,7.4);
INSERT INTO Player_Match_Participation VALUES(28,4, 65, NULL, 1 , 0 ,60, 100,9.7);
INSERT INTO Player_Match_Participation VALUES(28,4, 75, NULL, 1 , 0 ,87, 100,8.2);
INSERT INTO Player_Match_Participation VALUES(28,4, 66, NULL, 1 , 0 ,2, 100,9.7);
INSERT INTO Player_Match_Participation VALUES(28,4, 63, NULL, 1 , 0 ,51, 100,7.2);
INSERT INTO Player_Match_Participation VALUES(28,4, 70, NULL, 1 , 0 ,63, 100,6.4);
INSERT INTO Player_Match_Participation VALUES(28,4, 71, NULL, 1 , 0 ,26, 100,6.0);
INSERT INTO Player_Match_Participation VALUES(28,4, 76, NULL, 1 , 0 ,39, 100,7.6);
INSERT INTO Player_Match_Participation VALUES(28,4, 72, NULL, 1 , 0 ,31, 100,5.6);
INSERT INTO Player_Match_Participation VALUES(28,4, 68, NULL, 1 , 0 ,48, 100,6.9);
INSERT INTO Player_Match_Participation VALUES(28,4, 73, NULL, 1 , 0 ,22, 100,9.3);
-- Match 29
INSERT INTO Player_Match_Participation VALUES(29,5, 85, NULL, 1 , 0 ,68, 100,7.2);
INSERT INTO Player_Match_Participation VALUES(29,5, 82, NULL, 1 , 0 ,61, 100,8.2);
INSERT INTO Player_Match_Participation VALUES(29,5, 87, NULL, 1 , 0 ,77, 100,6.8);
INSERT INTO Player_Match_Participation VALUES(29,5, 88, NULL, 1 , 0 ,71, 100,7.6);
INSERT INTO Player_Match_Participation VALUES(29,5, 89, NULL, 1 , 0 ,40, 100,7.9);
INSERT INTO Player_Match_Participation VALUES(29,5, 84, NULL, 1 , 0 ,82, 100,9.7);
INSERT INTO Player_Match_Participation VALUES(29,5, 86, NULL, 1 , 0 ,16, 100,6.0);
INSERT INTO Player_Match_Participation VALUES(29,5, 92, NULL, 1 , 0 ,85, 100,6.7);
INSERT INTO Player_Match_Participation VALUES(29,5, 90, NULL, 1 , 0 ,49, 100,7.3);
INSERT INTO Player_Match_Participation VALUES(29,5, 83, NULL, 1 , 0 ,12, 100,6.8);
INSERT INTO Player_Match_Participation VALUES(29,5, 94, NULL, 1 , 0 ,35, 100,6.6);
INSERT INTO Player_Match_Participation VALUES(29,6, 112, NULL, 1 , 0 ,65, 100,7.1);
INSERT INTO Player_Match_Participation VALUES(29,6, 103, NULL, 1 , 0 ,54, 100,9.9);
INSERT INTO Player_Match_Participation VALUES(29,6, 101, NULL, 1 , 0 ,44, 100,8.0);
INSERT INTO Player_Match_Participation VALUES(29,6, 113, NULL, 1 , 0 ,4, 100,9.7);
INSERT INTO Player_Match_Participation VALUES(29,6, 115, NULL, 1 , 0 ,64, 100,6.8);
INSERT INTO Player_Match_Participation VALUES(29,6, 109, NULL, 1 , 0 ,15, 100,7.6);
INSERT INTO Player_Match_Participation VALUES(29,6, 118, NULL, 1 , 0 ,59, 100,8.9);
INSERT INTO Player_Match_Participation VALUES(29,6, 111, NULL, 1 , 0 ,15, 100,8.4);
INSERT INTO Player_Match_Participation VALUES(29,6, 119, NULL, 1 , 0 ,90, 100,9.9);
INSERT INTO Player_Match_Participation VALUES(29,6, 117, NULL, 1 , 0 ,58, 100,8.5);
INSERT INTO Player_Match_Participation VALUES(29,6, 114, NULL, 1 , 0 ,41, 100,5.5);
-- Match 30
INSERT INTO Player_Match_Participation VALUES(30,6, 119, NULL, 1 , 0 ,58, 100,9.4);
INSERT INTO Player_Match_Participation VALUES(30,6, 120, NULL, 1 , 0 ,24, 100,6.8);
INSERT INTO Player_Match_Participation VALUES(30,6, 110, NULL, 1 , 0 ,68, 100,9.6);
INSERT INTO Player_Match_Participation VALUES(30,6, 105, NULL, 1 , 0 ,88, 100,8.2);
INSERT INTO Player_Match_Participation VALUES(30,6, 109, NULL, 1 , 0 ,54, 100,8.7);
INSERT INTO Player_Match_Participation VALUES(30,6, 112, NULL, 1 , 0 ,88, 100,8.2);
INSERT INTO Player_Match_Participation VALUES(30,6, 107, NULL, 1 , 0 ,48, 100,6.6);
INSERT INTO Player_Match_Participation VALUES(30,6, 103, NULL, 1 , 0 ,87, 100,8.4);
INSERT INTO Player_Match_Participation VALUES(30,6, 116, NULL, 1 , 0 ,96, 100,8.5);
INSERT INTO Player_Match_Participation VALUES(30,6, 111, NULL, 1 , 0 ,49, 100,5.9);
INSERT INTO Player_Match_Participation VALUES(30,6, 114, NULL, 1 , 0 ,26, 100,5.6);
INSERT INTO Player_Match_Participation VALUES(30,5, 91, NULL, 1 , 0 ,52, 100,7.7);
INSERT INTO Player_Match_Participation VALUES(30,5, 89, NULL, 1 , 0 ,46, 100,6.9);
INSERT INTO Player_Match_Participation VALUES(30,5, 83, NULL, 1 , 0 ,88, 100,8.4);
INSERT INTO Player_Match_Participation VALUES(30,5, 99, NULL, 1 , 0 ,56, 100,9.1);
INSERT INTO Player_Match_Participation VALUES(30,5, 95, NULL, 1 , 0 ,97, 100,6.2);
INSERT INTO Player_Match_Participation VALUES(30,5, 93, NULL, 1 , 0 ,94, 100,6.1);
INSERT INTO Player_Match_Participation VALUES(30,5, 90, NULL, 1 , 0 ,94, 100,7.6);
INSERT INTO Player_Match_Participation VALUES(30,5, 92, NULL, 1 , 0 ,83, 100,7.9);
INSERT INTO Player_Match_Participation VALUES(30,5, 96, NULL, 1 , 0 ,6, 100,9.8);
INSERT INTO Player_Match_Participation VALUES(30,5, 94, NULL, 1 , 0 ,86, 100,7.3);
INSERT INTO Player_Match_Participation VALUES(30,5, 100, NULL, 1 , 0 ,72, 100,5.5);
-- Match 31
INSERT INTO Player_Match_Participation VALUES(31,7, 137, NULL, 1 , 0 ,93, 100,8.9);
INSERT INTO Player_Match_Participation VALUES(31,7, 125, NULL, 1 , 0 ,1, 100,5.8);
INSERT INTO Player_Match_Participation VALUES(31,7, 129, NULL, 1 , 0 ,72, 100,8.7);
INSERT INTO Player_Match_Participation VALUES(31,7, 131, NULL, 1 , 0 ,48, 100,9.0);
INSERT INTO Player_Match_Participation VALUES(31,7, 130, NULL, 1 , 0 ,23, 100,6.4);
INSERT INTO Player_Match_Participation VALUES(31,7, 138, NULL, 1 , 0 ,90, 100,9.3);
INSERT INTO Player_Match_Participation VALUES(31,7, 136, NULL, 1 , 0 ,29, 100,9.1);
INSERT INTO Player_Match_Participation VALUES(31,7, 122, NULL, 1 , 0 ,15, 100,7.0);
INSERT INTO Player_Match_Participation VALUES(31,7, 139, NULL, 1 , 0 ,38, 100,9.7);
INSERT INTO Player_Match_Participation VALUES(31,7, 126, NULL, 1 , 0 ,11, 100,8.8);
INSERT INTO Player_Match_Participation VALUES(31,7, 123, NULL, 1 , 0 ,91, 100,9.0);
INSERT INTO Player_Match_Participation VALUES(31,1, 1, NULL, 1 , 0 ,61, 100,7.2);
INSERT INTO Player_Match_Participation VALUES(31,1, 12, NULL, 1 , 0 ,46, 100,8.2);
INSERT INTO Player_Match_Participation VALUES(31,1, 3, NULL, 1 , 0 ,70, 100,9.7);
INSERT INTO Player_Match_Participation VALUES(31,1, 19, NULL, 1 , 0 ,29, 100,6.4);
INSERT INTO Player_Match_Participation VALUES(31,1, 18, NULL, 1 , 0 ,34, 100,7.5);
INSERT INTO Player_Match_Participation VALUES(31,1, 11, NULL, 1 , 0 ,78, 100,6.1);
INSERT INTO Player_Match_Participation VALUES(31,1, 10, NULL, 1 , 0 ,28, 100,9.8);
INSERT INTO Player_Match_Participation VALUES(31,1, 4, NULL, 1 , 0 ,37, 100,9.5);
INSERT INTO Player_Match_Participation VALUES(31,1, 14, NULL, 1 , 0 ,62, 100,7.8);
INSERT INTO Player_Match_Participation VALUES(31,1, 15, NULL, 1 , 0 ,24, 100,6.4);
INSERT INTO Player_Match_Participation VALUES(31,1, 13, NULL, 1 , 0 ,65, 100,6.7);
-- Match 32
INSERT INTO Player_Match_Participation VALUES(32,1, 10, NULL, 1 , 0 ,33, 100,8.5);
INSERT INTO Player_Match_Participation VALUES(32,1, 13, NULL, 1 , 0 ,63, 100,8.6);
INSERT INTO Player_Match_Participation VALUES(32,1, 19, NULL, 1 , 0 ,63, 100,8.8);
INSERT INTO Player_Match_Participation VALUES(32,1, 14, NULL, 1 , 0 ,12, 100,9.5);
INSERT INTO Player_Match_Participation VALUES(32,1, 11, NULL, 1 , 0 ,67, 100,8.8);
INSERT INTO Player_Match_Participation VALUES(32,1, 20, NULL, 1 , 0 ,97, 100,7.6);
INSERT INTO Player_Match_Participation VALUES(32,1, 1, NULL, 1 , 0 ,87, 100,7.8);
INSERT INTO Player_Match_Participation VALUES(32,1, 15, NULL, 1 , 0 ,62, 100,7.3);
INSERT INTO Player_Match_Participation VALUES(32,1, 18, NULL, 1 , 0 ,6, 100,7.4);
INSERT INTO Player_Match_Participation VALUES(32,1, 16, NULL, 1 , 0 ,59, 100,7.4);
INSERT INTO Player_Match_Participation VALUES(32,1, 2, NULL, 1 , 0 ,70, 100,8.9);
INSERT INTO Player_Match_Participation VALUES(32,7, 123, NULL, 1 , 0 ,93, 100,5.6);
INSERT INTO Player_Match_Participation VALUES(32,7, 126, NULL, 1 , 0 ,34, 100,8.4);
INSERT INTO Player_Match_Participation VALUES(32,7, 139, NULL, 1 , 0 ,70, 100,6.4);
INSERT INTO Player_Match_Participation VALUES(32,7, 128, NULL, 1 , 0 ,34, 100,9.1);
INSERT INTO Player_Match_Participation VALUES(32,7, 135, NULL, 1 , 0 ,41, 100,7.7);
INSERT INTO Player_Match_Participation VALUES(32,7, 131, NULL, 1 , 0 ,61, 100,5.7);
INSERT INTO Player_Match_Participation VALUES(32,7, 121, NULL, 1 , 0 ,49, 100,9.7);
INSERT INTO Player_Match_Participation VALUES(32,7, 120, NULL, 1 , 0 ,16, 100,6.0);
INSERT INTO Player_Match_Participation VALUES(32,7, 127, NULL, 1 , 0 ,40, 100,8.2);
INSERT INTO Player_Match_Participation VALUES(32,7, 133, NULL, 1 , 0 ,87, 100,8.5);
INSERT INTO Player_Match_Participation VALUES(32,7, 124, NULL, 1 , 0 ,17, 100,6.0);
-- Match 33
INSERT INTO Player_Match_Participation VALUES(33,7, 125, NULL, 1 , 0 ,88, 100,5.7);
INSERT INTO Player_Match_Participation VALUES(33,7, 127, NULL, 1 , 0 ,65, 100,7.3);
INSERT INTO Player_Match_Participation VALUES(33,7, 132, NULL, 1 , 0 ,50, 100,7.5);
INSERT INTO Player_Match_Participation VALUES(33,7, 122, NULL, 1 , 0 ,59, 100,8.2);
INSERT INTO Player_Match_Participation VALUES(33,7, 128, NULL, 1 , 0 ,5, 100,8.6);
INSERT INTO Player_Match_Participation VALUES(33,7, 123, NULL, 1 , 0 ,91, 100,9.3);
INSERT INTO Player_Match_Participation VALUES(33,7, 130, NULL, 1 , 0 ,42, 100,8.1);
INSERT INTO Player_Match_Participation VALUES(33,7, 126, NULL, 1 , 0 ,69, 100,9.2);
INSERT INTO Player_Match_Participation VALUES(33,7, 129, NULL, 1 , 0 ,64, 100,6.7);
INSERT INTO Player_Match_Participation VALUES(33,7, 120, NULL, 1 , 0 ,73, 100,6.6);
INSERT INTO Player_Match_Participation VALUES(33,7, 140, NULL, 1 , 0 ,86, 100,8.2);
INSERT INTO Player_Match_Participation VALUES(33,2, 37, NULL, 1 , 0 ,42, 100,6.8);
INSERT INTO Player_Match_Participation VALUES(33,2, 26, NULL, 1 , 0 ,47, 100,8.0);
INSERT INTO Player_Match_Participation VALUES(33,2, 30, NULL, 1 , 0 ,47, 100,9.9);
INSERT INTO Player_Match_Participation VALUES(33,2, 25, NULL, 1 , 0 ,44, 100,7.0);
INSERT INTO Player_Match_Participation VALUES(33,2, 23, NULL, 1 , 0 ,75, 100,7.3);
INSERT INTO Player_Match_Participation VALUES(33,2, 27, NULL, 1 , 0 ,15, 100,9.4);
INSERT INTO Player_Match_Participation VALUES(33,2, 33, NULL, 1 , 0 ,28, 100,9.0);
INSERT INTO Player_Match_Participation VALUES(33,2, 24, NULL, 1 , 0 ,75, 100,7.2);
INSERT INTO Player_Match_Participation VALUES(33,2, 38, NULL, 1 , 0 ,51, 100,9.7);
INSERT INTO Player_Match_Participation VALUES(33,2, 35, NULL, 1 , 0 ,20, 100,6.5);
INSERT INTO Player_Match_Participation VALUES(33,2, 29, NULL, 1 , 0 ,96, 100,9.8);
-- Match 34
INSERT INTO Player_Match_Participation VALUES(34,2, 38, NULL, 1 , 0 ,60, 100,6.5);
INSERT INTO Player_Match_Participation VALUES(34,2, 30, NULL, 1 , 0 ,96, 100,9.7);
INSERT INTO Player_Match_Participation VALUES(34,2, 29, NULL, 1 , 0 ,24, 100,8.6);
INSERT INTO Player_Match_Participation VALUES(34,2, 37, NULL, 1 , 0 ,85, 100,8.4);
INSERT INTO Player_Match_Participation VALUES(34,2, 23, NULL, 1 , 0 ,43, 100,6.4);
INSERT INTO Player_Match_Participation VALUES(34,2, 22, NULL, 1 , 0 ,40, 100,7.7);
INSERT INTO Player_Match_Participation VALUES(34,2, 40, NULL, 1 , 0 ,74, 100,6.2);
INSERT INTO Player_Match_Participation VALUES(34,2, 33, NULL, 1 , 0 ,79, 100,8.8);
INSERT INTO Player_Match_Participation VALUES(34,2, 31, NULL, 1 , 0 ,11, 100,5.7);
INSERT INTO Player_Match_Participation VALUES(34,2, 24, NULL, 1 , 0 ,12, 100,9.5);
INSERT INTO Player_Match_Participation VALUES(34,2, 27, NULL, 1 , 0 ,94, 100,8.8);
INSERT INTO Player_Match_Participation VALUES(34,7, 140, NULL, 1 , 0 ,81, 100,9.2);
INSERT INTO Player_Match_Participation VALUES(34,7, 130, NULL, 1 , 0 ,82, 100,6.2);
INSERT INTO Player_Match_Participation VALUES(34,7, 136, NULL, 1 , 0 ,42, 100,7.6);
INSERT INTO Player_Match_Participation VALUES(34,7, 131, NULL, 1 , 0 ,51, 100,8.4);
INSERT INTO Player_Match_Participation VALUES(34,7, 125, NULL, 1 , 0 ,59, 100,9.7);
INSERT INTO Player_Match_Participation VALUES(34,7, 123, NULL, 1 , 0 ,17, 100,5.8);
INSERT INTO Player_Match_Participation VALUES(34,7, 128, NULL, 1 , 0 ,16, 100,8.2);
INSERT INTO Player_Match_Participation VALUES(34,7, 126, NULL, 1 , 0 ,14, 100,10.0);
INSERT INTO Player_Match_Participation VALUES(34,7, 132, NULL, 1 , 0 ,89, 100,7.0);
INSERT INTO Player_Match_Participation VALUES(34,7, 127, NULL, 1 , 0 ,48, 100,7.1);
INSERT INTO Player_Match_Participation VALUES(34,7, 121, NULL, 1 , 0 ,15, 100,9.5);
-- Match 35
INSERT INTO Player_Match_Participation VALUES(35,7, 140, NULL, 1 , 0 ,74, 100,9.2);
INSERT INTO Player_Match_Participation VALUES(35,7, 137, NULL, 1 , 0 ,69, 100,9.5);
INSERT INTO Player_Match_Participation VALUES(35,7, 139, NULL, 1 , 0 ,10, 100,5.5);
INSERT INTO Player_Match_Participation VALUES(35,7, 130, NULL, 1 , 0 ,90, 100,7.8);
INSERT INTO Player_Match_Participation VALUES(35,7, 138, NULL, 1 , 0 ,96, 100,8.1);
INSERT INTO Player_Match_Participation VALUES(35,7, 125, NULL, 1 , 0 ,72, 100,5.9);
INSERT INTO Player_Match_Participation VALUES(35,7, 136, NULL, 1 , 0 ,56, 100,6.1);
INSERT INTO Player_Match_Participation VALUES(35,7, 123, NULL, 1 , 0 ,23, 100,9.9);
INSERT INTO Player_Match_Participation VALUES(35,7, 132, NULL, 1 , 0 ,64, 100,6.9);
INSERT INTO Player_Match_Participation VALUES(35,7, 128, NULL, 1 , 0 ,35, 100,7.3);
INSERT INTO Player_Match_Participation VALUES(35,7, 140, NULL, 1 , 0 ,18, 100,5.9);
INSERT INTO Player_Match_Participation VALUES(35,3, 58, NULL, 1 , 0 ,95, 100,8.7);
INSERT INTO Player_Match_Participation VALUES(35,3, 41, NULL, 1 , 0 ,45, 100,5.5);
INSERT INTO Player_Match_Participation VALUES(35,3, 50, NULL, 1 , 0 ,95, 100,8.1);
INSERT INTO Player_Match_Participation VALUES(35,3, 42, NULL, 1 , 0 ,87, 100,7.1);
INSERT INTO Player_Match_Participation VALUES(35,3, 59, NULL, 1 , 0 ,26, 100,8.4);
INSERT INTO Player_Match_Participation VALUES(35,3, 47, NULL, 1 , 0 ,17, 100,7.5);
INSERT INTO Player_Match_Participation VALUES(35,3, 55, NULL, 1 , 0 ,15, 100,9.0);
INSERT INTO Player_Match_Participation VALUES(35,3, 49, NULL, 1 , 0 ,86, 100,5.9);
INSERT INTO Player_Match_Participation VALUES(35,3, 43, NULL, 1 , 0 ,51, 100,8.6);
INSERT INTO Player_Match_Participation VALUES(35,3, 51, NULL, 1 , 0 ,34, 100,8.2);
INSERT INTO Player_Match_Participation VALUES(35,3, 44, NULL, 1 , 0 ,1, 100,9.5);
-- Match 36
INSERT INTO Player_Match_Participation VALUES(36,3, 42, NULL, 1 , 0 ,31, 100,9.5);
INSERT INTO Player_Match_Participation VALUES(36,3, 45, NULL, 1 , 0 ,51, 100,7.4);
INSERT INTO Player_Match_Participation VALUES(36,3, 46, NULL, 1 , 0 ,35, 100,8.2);
INSERT INTO Player_Match_Participation VALUES(36,3, 44, NULL, 1 , 0 ,53, 100,6.1);
INSERT INTO Player_Match_Participation VALUES(36,3, 56, NULL, 1 , 0 ,20, 100,9.1);
INSERT INTO Player_Match_Participation VALUES(36,3, 43, NULL, 1 , 0 ,38, 100,8.8);
INSERT INTO Player_Match_Participation VALUES(36,3, 50, NULL, 1 , 0 ,86, 100,9.1);
INSERT INTO Player_Match_Participation VALUES(36,3, 41, NULL, 1 , 0 ,94, 100,6.9);
INSERT INTO Player_Match_Participation VALUES(36,3, 51, NULL, 1 , 0 ,26, 100,6.9);
INSERT INTO Player_Match_Participation VALUES(36,3, 58, NULL, 1 , 0 ,13, 100,9.0);
INSERT INTO Player_Match_Participation VALUES(36,3, 47, NULL, 1 , 0 ,76, 100,6.7);
INSERT INTO Player_Match_Participation VALUES(36,7, 129, NULL, 1 , 0 ,36, 100,9.1);
INSERT INTO Player_Match_Participation VALUES(36,7, 130, NULL, 1 , 0 ,94, 100,7.9);
INSERT INTO Player_Match_Participation VALUES(36,7, 134, NULL, 1 , 0 ,97, 100,9.7);
INSERT INTO Player_Match_Participation VALUES(36,7, 131, NULL, 1 , 0 ,19, 100,9.9);
INSERT INTO Player_Match_Participation VALUES(36,7, 137, NULL, 1 , 0 ,52, 100,7.2);
INSERT INTO Player_Match_Participation VALUES(36,7, 122, NULL, 1 , 0 ,67, 100,5.6);
INSERT INTO Player_Match_Participation VALUES(36,7, 132, NULL, 1 , 0 ,32, 100,9.4);
INSERT INTO Player_Match_Participation VALUES(36,7, 121, NULL, 1 , 0 ,72, 100,7.5);
INSERT INTO Player_Match_Participation VALUES(36,7, 125, NULL, 1 , 0 ,44, 100,9.9);
INSERT INTO Player_Match_Participation VALUES(36,7, 139, NULL, 1 , 0 ,37, 100,5.9);
INSERT INTO Player_Match_Participation VALUES(36,7, 120, NULL, 1 , 0 ,95, 100,5.6);
-- Match 37
INSERT INTO Player_Match_Participation VALUES(37,7, 125, NULL, 1 , 0 ,29, 100,5.8);
INSERT INTO Player_Match_Participation VALUES(37,7, 127, NULL, 1 , 0 ,32, 100,6.9);
INSERT INTO Player_Match_Participation VALUES(37,7, 129, NULL, 1 , 0 ,58, 100,8.8);
INSERT INTO Player_Match_Participation VALUES(37,7, 130, NULL, 1 , 0 ,26, 100,9.3);
INSERT INTO Player_Match_Participation VALUES(37,7, 124, NULL, 1 , 0 ,81, 100,8.6);
INSERT INTO Player_Match_Participation VALUES(37,7, 140, NULL, 1 , 0 ,21, 100,9.9);
INSERT INTO Player_Match_Participation VALUES(37,7, 139, NULL, 1 , 0 ,16, 100,5.5);
INSERT INTO Player_Match_Participation VALUES(37,7, 128, NULL, 1 , 0 ,36, 100,8.0);
INSERT INTO Player_Match_Participation VALUES(37,7, 131, NULL, 1 , 0 ,18, 100,8.2);
INSERT INTO Player_Match_Participation VALUES(37,7, 138, NULL, 1 , 0 ,86, 100,9.6);
INSERT INTO Player_Match_Participation VALUES(37,7, 122, NULL, 1 , 0 ,70, 100,6.3);
INSERT INTO Player_Match_Participation VALUES(37,4, 62, NULL, 1 , 0 ,26, 100,9.5);
INSERT INTO Player_Match_Participation VALUES(37,4, 73, NULL, 1 , 0 ,96, 100,7.3);
INSERT INTO Player_Match_Participation VALUES(37,4, 75, NULL, 1 , 0 ,95, 100,5.9);
INSERT INTO Player_Match_Participation VALUES(37,4, 65, NULL, 1 , 0 ,67, 100,8.9);
INSERT INTO Player_Match_Participation VALUES(37,4, 69, NULL, 1 , 0 ,42, 100,9.3);
INSERT INTO Player_Match_Participation VALUES(37,4, 70, NULL, 1 , 0 ,59, 100,9.0);
INSERT INTO Player_Match_Participation VALUES(37,4, 72, NULL, 1 , 0 ,57, 100,7.9);
INSERT INTO Player_Match_Participation VALUES(37,4, 76, NULL, 1 , 0 ,22, 100,6.9);
INSERT INTO Player_Match_Participation VALUES(37,4, 64, NULL, 1 , 0 ,89, 100,9.2);
INSERT INTO Player_Match_Participation VALUES(37,4, 77, NULL, 1 , 0 ,94, 100,7.0);
INSERT INTO Player_Match_Participation VALUES(37,4, 79, NULL, 1 , 0 ,17, 100,8.2);
-- Match 38
INSERT INTO Player_Match_Participation VALUES(38,4, 68, NULL, 1 , 0 ,26, 100,6.1);
INSERT INTO Player_Match_Participation VALUES(38,4, 66, NULL, 1 , 0 ,18, 100,8.2);
INSERT INTO Player_Match_Participation VALUES(38,4, 73, NULL, 1 , 0 ,67, 100,6.0);
INSERT INTO Player_Match_Participation VALUES(38,4, 74, NULL, 1 , 0 ,84, 100,7.4);
INSERT INTO Player_Match_Participation VALUES(38,4, 72, NULL, 1 , 0 ,22, 100,6.9);
INSERT INTO Player_Match_Participation VALUES(38,4, 70, NULL, 1 , 0 ,32, 100,5.6);
INSERT INTO Player_Match_Participation VALUES(38,4, 61, NULL, 1 , 0 ,1, 100,8.7);
INSERT INTO Player_Match_Participation VALUES(38,4, 62, NULL, 1 , 0 ,60, 100,8.7);
INSERT INTO Player_Match_Participation VALUES(38,4, 63, NULL, 1 , 0 ,5, 100,6.0);
INSERT INTO Player_Match_Participation VALUES(38,4, 75, NULL, 1 , 0 ,93, 100,8.2);
INSERT INTO Player_Match_Participation VALUES(38,4, 69, NULL, 1 , 0 ,59, 100,9.2);
INSERT INTO Player_Match_Participation VALUES(38,7, 139, NULL, 1 , 0 ,65, 100,6.5);
INSERT INTO Player_Match_Participation VALUES(38,7, 140, NULL, 1 , 0 ,79, 100,6.3);
INSERT INTO Player_Match_Participation VALUES(38,7, 136, NULL, 1 , 0 ,90, 100,6.7);
INSERT INTO Player_Match_Participation VALUES(38,7, 125, NULL, 1 , 0 ,23, 100,9.9);
INSERT INTO Player_Match_Participation VALUES(38,7, 137, NULL, 1 , 0 ,42, 100,6.6);
INSERT INTO Player_Match_Participation VALUES(38,7, 130, NULL, 1 , 0 ,69, 100,8.9);
INSERT INTO Player_Match_Participation VALUES(38,7, 122, NULL, 1 , 0 ,66, 100,7.4);
INSERT INTO Player_Match_Participation VALUES(38,7, 134, NULL, 1 , 0 ,91, 100,6.9);
INSERT INTO Player_Match_Participation VALUES(38,7, 138, NULL, 1 , 0 ,27, 100,6.8);
INSERT INTO Player_Match_Participation VALUES(38,7, 131, NULL, 1 , 0 ,83, 100,7.8);
INSERT INTO Player_Match_Participation VALUES(38,7, 133, NULL, 1 , 0 ,80, 100,7.7);
-- Match 39
INSERT INTO Player_Match_Participation VALUES(39,7, 123, NULL, 1 , 0 ,60, 100,9.3);
INSERT INTO Player_Match_Participation VALUES(39,7, 135, NULL, 1 , 0 ,46, 100,6.2);
INSERT INTO Player_Match_Participation VALUES(39,7, 136, NULL, 1 , 0 ,27, 100,7.0);
INSERT INTO Player_Match_Participation VALUES(39,7, 140, NULL, 1 , 0 ,1, 100,6.8);
INSERT INTO Player_Match_Participation VALUES(39,7, 134, NULL, 1 , 0 ,44, 100,8.3);
INSERT INTO Player_Match_Participation VALUES(39,7, 138, NULL, 1 , 0 ,50, 100,9.6);
INSERT INTO Player_Match_Participation VALUES(39,7, 139, NULL, 1 , 0 ,26, 100,8.0);
INSERT INTO Player_Match_Participation VALUES(39,7, 132, NULL, 1 , 0 ,43, 100,5.7);
INSERT INTO Player_Match_Participation VALUES(39,7, 126, NULL, 1 , 0 ,47, 100,9.2);
INSERT INTO Player_Match_Participation VALUES(39,7, 127, NULL, 1 , 0 ,38, 100,9.2);
INSERT INTO Player_Match_Participation VALUES(39,7, 133, NULL, 1 , 0 ,63, 100,9.5);
INSERT INTO Player_Match_Participation VALUES(39,5, 95, NULL, 1 , 0 ,17, 100,7.1);
INSERT INTO Player_Match_Participation VALUES(39,5, 96, NULL, 1 , 0 ,56, 100,8.8);
INSERT INTO Player_Match_Participation VALUES(39,5, 100, NULL, 1 , 0 ,24, 100,8.5);
INSERT INTO Player_Match_Participation VALUES(39,5, 86, NULL, 1 , 0 ,91, 100,8.6);
INSERT INTO Player_Match_Participation VALUES(39,5, 98, NULL, 1 , 0 ,70, 100,8.4);
INSERT INTO Player_Match_Participation VALUES(39,5, 101, NULL, 1 , 0 ,28, 100,9.3);
INSERT INTO Player_Match_Participation VALUES(39,5, 88, NULL, 1 , 0 ,14, 100,8.5);
INSERT INTO Player_Match_Participation VALUES(39,5, 83, NULL, 1 , 0 ,56, 100,8.4);
INSERT INTO Player_Match_Participation VALUES(39,5, 97, NULL, 1 , 0 ,79, 100,9.3);
INSERT INTO Player_Match_Participation VALUES(39,5, 93, NULL, 1 , 0 ,96, 100,9.9);
INSERT INTO Player_Match_Participation VALUES(39,5, 87, NULL, 1 , 0 ,34, 100,5.9);
-- Match 40
INSERT INTO Player_Match_Participation VALUES(40,5, 91, NULL, 1 , 0 ,60, 100,9.8);
INSERT INTO Player_Match_Participation VALUES(40,5, 90, NULL, 1 , 0 ,93, 100,8.9);
INSERT INTO Player_Match_Participation VALUES(40,5, 81, NULL, 1 , 0 ,76, 100,6.5);
INSERT INTO Player_Match_Participation VALUES(40,5, 94, NULL, 1 , 0 ,36, 100,8.1);
INSERT INTO Player_Match_Participation VALUES(40,5, 87, NULL, 1 , 0 ,90, 100,8.5);
INSERT INTO Player_Match_Participation VALUES(40,5, 88, NULL, 1 , 0 ,60, 100,5.7);
INSERT INTO Player_Match_Participation VALUES(40,5, 85, NULL, 1 , 0 ,52, 100,7.1);
INSERT INTO Player_Match_Participation VALUES(40,5, 97, NULL, 1 , 0 ,31, 100,9.8);
INSERT INTO Player_Match_Participation VALUES(40,5, 84, NULL, 1 , 0 ,17, 100,7.7);
INSERT INTO Player_Match_Participation VALUES(40,5, 80, NULL, 1 , 0 ,29, 100,7.4);
INSERT INTO Player_Match_Participation VALUES(40,5, 92, NULL, 1 , 0 ,53, 100,6.9);
INSERT INTO Player_Match_Participation VALUES(40,7, 125, NULL, 1 , 0 ,35, 100,7.0);
INSERT INTO Player_Match_Participation VALUES(40,7, 127, NULL, 1 , 0 ,12, 100,8.2);
INSERT INTO Player_Match_Participation VALUES(40,7, 128, NULL, 1 , 0 ,89, 100,5.8);
INSERT INTO Player_Match_Participation VALUES(40,7, 134, NULL, 1 , 0 ,22, 100,8.8);
INSERT INTO Player_Match_Participation VALUES(40,7, 131, NULL, 1 , 0 ,72, 100,9.6);
INSERT INTO Player_Match_Participation VALUES(40,7, 123, NULL, 1 , 0 ,17, 100,6.3);
INSERT INTO Player_Match_Participation VALUES(40,7, 139, NULL, 1 , 0 ,26, 100,5.7);
INSERT INTO Player_Match_Participation VALUES(40,7, 133, NULL, 1 , 0 ,88, 100,8.4);
INSERT INTO Player_Match_Participation VALUES(40,7, 130, NULL, 1 , 0 ,64, 100,8.9);
INSERT INTO Player_Match_Participation VALUES(40,7, 126, NULL, 1 , 0 ,85, 100,9.4);
INSERT INTO Player_Match_Participation VALUES(40,7, 122, NULL, 1 , 0 ,21, 100,7.7);
-- Match 41
INSERT INTO Player_Match_Participation VALUES(41,7, 131, NULL, 1 , 0 ,19, 100,7.0);
INSERT INTO Player_Match_Participation VALUES(41,7, 135, NULL, 1 , 0 ,66, 100,6.4);
INSERT INTO Player_Match_Participation VALUES(41,7, 128, NULL, 1 , 0 ,69, 100,6.8);
INSERT INTO Player_Match_Participation VALUES(41,7, 138, NULL, 1 , 0 ,16, 100,7.3);
INSERT INTO Player_Match_Participation VALUES(41,7, 127, NULL, 1 , 0 ,56, 100,6.6);
INSERT INTO Player_Match_Participation VALUES(41,7, 133, NULL, 1 , 0 ,84, 100,9.3);
INSERT INTO Player_Match_Participation VALUES(41,7, 121, NULL, 1 , 0 ,10, 100,7.3);
INSERT INTO Player_Match_Participation VALUES(41,7, 140, NULL, 1 , 0 ,21, 100,8.1);
INSERT INTO Player_Match_Participation VALUES(41,7, 134, NULL, 1 , 0 ,62, 100,9.7);
INSERT INTO Player_Match_Participation VALUES(41,7, 139, NULL, 1 , 0 ,47, 100,5.9);
INSERT INTO Player_Match_Participation VALUES(41,7, 129, NULL, 1 , 0 ,32, 100,8.7);
INSERT INTO Player_Match_Participation VALUES(41,6, 104, NULL, 1 , 0 ,11, 100,9.9);
INSERT INTO Player_Match_Participation VALUES(41,6, 116, NULL, 1 , 0 ,27, 100,8.3);
INSERT INTO Player_Match_Participation VALUES(41,6, 102, NULL, 1 , 0 ,9, 100,9.6);
INSERT INTO Player_Match_Participation VALUES(41,6, 106, NULL, 1 , 0 ,14, 100,5.5);
INSERT INTO Player_Match_Participation VALUES(41,6, 105, NULL, 1 , 0 ,75, 100,7.1);
INSERT INTO Player_Match_Participation VALUES(41,6, 119, NULL, 1 , 0 ,48, 100,9.6);
INSERT INTO Player_Match_Participation VALUES(41,6, 104, NULL, 1 , 0 ,73, 100,8.7);
INSERT INTO Player_Match_Participation VALUES(41,6, 108, NULL, 1 , 0 ,82, 100,9.4);
INSERT INTO Player_Match_Participation VALUES(41,6, 114, NULL, 1 , 0 ,40, 100,5.9);
INSERT INTO Player_Match_Participation VALUES(41,6, 115, NULL, 1 , 0 ,14, 100,7.6);
INSERT INTO Player_Match_Participation VALUES(41,6, 107, NULL, 1 , 0 ,42, 100,8.4);
-- Match 42
INSERT INTO Player_Match_Participation VALUES(42,6, 117, NULL, 1 , 0 ,64, 100,9.3);
INSERT INTO Player_Match_Participation VALUES(42,6, 108, NULL, 1 , 0 ,90, 100,6.3);
INSERT INTO Player_Match_Participation VALUES(42,6, 113, NULL, 1 , 0 ,14, 100,8.2);
INSERT INTO Player_Match_Participation VALUES(42,6, 107, NULL, 1 , 0 ,5, 100,8.1);
INSERT INTO Player_Match_Participation VALUES(42,6, 119, NULL, 1 , 0 ,50, 100,6.6);
INSERT INTO Player_Match_Participation VALUES(42,6, 120, NULL, 1 , 0 ,57, 100,7.8);
INSERT INTO Player_Match_Participation VALUES(42,6, 102, NULL, 1 , 0 ,13, 100,9.7);
INSERT INTO Player_Match_Participation VALUES(42,6, 110, NULL, 1 , 0 ,20, 100,6.8);
INSERT INTO Player_Match_Participation VALUES(42,6, 105, NULL, 1 , 0 ,19, 100,6.3);
INSERT INTO Player_Match_Participation VALUES(42,6, 101, NULL, 1 , 0 ,89, 100,9.6);
INSERT INTO Player_Match_Participation VALUES(42,6, 103, NULL, 1 , 0 ,28, 100,5.8);
INSERT INTO Player_Match_Participation VALUES(42,7, 139, NULL, 1 , 0 ,46, 100,7.4);
INSERT INTO Player_Match_Participation VALUES(42,7, 134, NULL, 1 , 0 ,96, 100,8.4);
INSERT INTO Player_Match_Participation VALUES(42,7, 140, NULL, 1 , 0 ,50, 100,6.8);
INSERT INTO Player_Match_Participation VALUES(42,7, 136, NULL, 1 , 0 ,53, 100,7.2);
INSERT INTO Player_Match_Participation VALUES(42,7, 133, NULL, 1 , 0 ,96, 100,9.2);
INSERT INTO Player_Match_Participation VALUES(42,7, 132, NULL, 1 , 0 ,42, 100,7.8);
INSERT INTO Player_Match_Participation VALUES(42,7, 129, NULL, 1 , 0 ,71, 100,6.1);
INSERT INTO Player_Match_Participation VALUES(42,7, 137, NULL, 1 , 0 ,52, 100,6.6);
INSERT INTO Player_Match_Participation VALUES(42,7, 138, NULL, 1 , 0 ,66, 100,6.7);
INSERT INTO Player_Match_Participation VALUES(42,7, 126, NULL, 1 , 0 ,67, 100,8.1);
INSERT INTO Player_Match_Participation VALUES(42,7, 122, NULL, 1 , 0 ,22, 100,9.4);

select * from suspension
-- Match 1
INSERT INTO suspension VALUES(9, 1,'2060-09-01','2060-09-07','Direct Red Card'); --1
INSERT INTO suspension VALUES(23, 2, '2060-09-01','2060-10-01', 'Direct Red Card'); --2
-- Match 4
INSERT INTO suspension VALUES(60, 3, '2060-09-10','2060-10-04', 'Direct Red Card');
-- Match 5
INSERT INTO suspension VALUES(15, 4, '2060-09-13','2060-09-19', 'Direct Red Card');
-- Match 6
INSERT INTO suspension VALUES(70, 5, '2060-09-16','2060-10-10', 'Direct Red Card');
-- Match 9
INSERT INTO suspension VALUES(12, 6, '2060-09-25','2060-10-01', 'Direct Red Card');
-- Match 10
INSERT INTO suspension VALUES(109, 7, '2060-09-28','2060-10-22', 'Direct Red Card');
-- Match 16
INSERT INTO suspension VALUES(36, 8, '2060-10-16','2060-10-22', 'Direct Red Card');
-- Match 17
INSERT INTO suspension VALUES(23, 9, '2060-10-19','2060-10-10', 'Direct Red Card');
-- Match 18
INSERT INTO suspension VALUES(107, 10, '2060-10-22','2060-11-09', 'Direct Red Card');
-- Match 19
INSERT INTO suspension VALUES(49, 11, '2060-10-25','2060-10-31', 'Direct Red Card');
-- Match 21
INSERT INTO suspension VALUES(46, 12, '2060-10-31','2060-11-06', 'Direct Red Card');
-- Match 23
INSERT INTO suspension VALUES(44, 13, '2060-11-06','2060-10-16', 'Direct Red Card');
-- Match 24
INSERT INTO suspension VALUES(53, 14, '2060-11-09','2060-11-21', 'Direct Red Card'); --6
INSERT INTO suspension VALUES(110, 15, '2060-11-09','2060-10-16', 'Direct Red Card'); --3
-- Match 25
INSERT INTO suspension VALUES(98, 16, '2060-11-12','2060-11-24', 'Direct Red Card');
-- Match 27
INSERT INTO suspension VALUES(107, 17, '2060-11-18','2060-11-24', 'Direct Red Card');
-- Match 29
INSERT INTO suspension VALUES(97, 18, '2060-11-24','2060-10-25', 'Direct Red Card'); --5
INSERT INTO suspension VALUES(114, 19, '2060-11-24','2060-10-31', 'Direct Red Card'); --6
-- Match 30
INSERT INTO suspension VALUES(104, 20, '2060-11-27','2060-11-03', 'Direct Red Card');


-- Select * from Substitution
-- INSERT INTO Substitution VALUES(31,7,6,3,64);
-- INSERT INTO Substitution VALUES(31,7,19,8,78);
-- INSERT INTO Substitution VALUES(31,1,27,30,50);

-- select * from Injury
-- INSERT INTO Injury VALUES(19, 1,'2060-10-07','2060-10-25','ACL Injury (Anterior Cruciate)');
-- INSERT INTO Injury VALUES(18, 2, '2060-10-22','2060-12-30', 'Muscle Cramp');
-- INSERT INTO Injury VALUES(24, 3, '2060-09-04','2060-12-04', 'Quadriceps Tear');
