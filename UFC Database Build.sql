/*
Author: Matthew Laken
Course: IST659 M403
Term: Fall 2020
*/


/*
Dont want to lose all my imports ***

DROP TABLE IF EXISTS TheMatch
DROP TABLE IF EXISTS FightCard
DROP TABLE IF EXISTS WeightClass
DROP TABLE IF EXISTS Loser
DROP TABLE IF EXISTS Winner
DROP TABLE IF EXISTS MethMove
DROP TABLE IF EXISTS Method
DROP TABLE IF EXISTS FinMove
DROP TABLE IF EXISTS LeagueFighter
DROP TABLE IF EXISTS Fighter
DROP TABLE IF EXISTS Stance
DROP TABLE IF EXISTS League
*/

-- creating league table
CREATE TABLE League (
-- col for table
	LeagueID int identity, 
	LeagueName varchar(20) not null,
	President varchar(200),
-- constraints
	CONSTRAINT PK_League PRIMARY KEY (LeagueID)
	)
	-- end of table

-- creating Stance table
CREATE TABLE Stance (
-- col for table
	StanceID int identity, 
	Stance varchar(20) not null,
-- constraints
	CONSTRAINT PK_Stance PRIMARY KEY (StanceID)
	)
	-- end of table

	-- creating Fighter table
CREATE TABLE Fighter (
-- col for table
	FighterID int identity, 
	FighterName varchar(20) not null,
	StanceID int,
-- constraints
	CONSTRAINT PK_Fighter PRIMARY KEY (FighterID),
	CONSTRAINT FK1_Fighter FOREIGN KEY (StanceID) REFERENCES Stance(StanceID)
	)
	-- end of table

-- creating LeagueFighter table
CREATE TABLE LeagueFighter (
-- col for table
	LeagueFighterID int identity, 
	LeagueID int,
	FighterID int,
-- constraints
	CONSTRAINT PK_LeagueFighter PRIMARY KEY (LeagueFighterID),
	CONSTRAINT FK1_LeagueFighter FOREIGN KEY (LeagueID) REFERENCES League(LeagueID),
	CONSTRAINT FK2_LeagueFighter FOREIGN KEY (FighterID) REFERENCES Fighter(FighterID)
	)
	-- end of table

-- creating FinMove table
CREATE TABLE FinMove (
-- col for table
	FinMoveID int identity, 
	FinMoveName varchar(20) not null,
-- constraints
	CONSTRAINT PK_FinMove PRIMARY KEY (FinMoveID)
	)
	-- end of table

-- creating Method table
CREATE TABLE Method (
-- col for table
	MethodID int identity, 
	MethodName varchar(20) not null,
-- constraints
	CONSTRAINT PK_Method PRIMARY KEY (MethodID)
	)
	-- end of table

-- creating MethMove table
CREATE TABLE MethMove (
-- col for table
	MethMoveID int identity, 
	MethodID int,
	FinMoveID int,
-- constraints
	CONSTRAINT PK_MethMove PRIMARY KEY (MethMoveID),
	CONSTRAINT FK1_MethMove FOREIGN KEY (MethodID) REFERENCES Method(MethodID),
	CONSTRAINT FK2_MethMove FOREIGN KEY (FinMoveID) REFERENCES FinMove(FinMoveID)
	)
	-- end of table

	-- creating Winner table
CREATE TABLE Winner (
-- col for table
	WinnerID int identity, 
	FighterID int,
	FinishRound int,
	TotalTime int,
	WinOdds int,
	WinHeight int, 
	WinWeight int,
	WinReach int,
	WinAge int,
	WinKD int,
	WinSigStrLand int,
	WinSigStrAtt int,
	WinTotStrLand int,
	WinTotStrAtt int,
	WinTdLand int,
	WinTdAtt int, 
	WinSubAtt int,
-- constraints
	CONSTRAINT PK_Winner PRIMARY KEY (WinnerID),
	CONSTRAINT FK1_Winner FOREIGN KEY (FighterID) REFERENCES Fighter(FighterID)
	)
	-- end of table

	-- creating Loser table
CREATE TABLE Loser (
-- col for table
	LoserID int identity, 
	FighterID int, 
	FinishRound int,
	TotalTime int,
	RoundTime int,
	LoseOdds int,
	LoseHeight int, 
	LoseWeight int,
	LoseReach int,
	LoseAge int,
	LoseKD int,
	LoseSigStrLand int,
	LoseSigStrAtt int,
	LoseTotStrLand int,
	LoseTotStrAtt int,
	LoseTdLand int,
	LoseTdAtt int, 
	LoseSubAtt int,
-- constraints
	CONSTRAINT PK_Loser PRIMARY KEY (LoserID),
	CONSTRAINT FK1_Loser FOREIGN KEY (FighterID) REFERENCES Fighter(FighterID)
	)
	-- end of table

-- creating WeightClass table
CREATE TABLE WeightClass (
-- col for table
	WeightClassID int identity, 
	WeightClassName varchar(50) not null,
-- constraints
	CONSTRAINT PK_WeightClass PRIMARY KEY (WeightClassID)
	)
	-- end of table

-- creating FightCard table
CREATE TABLE FightCard (
-- col for table
	FightCardID int identity,
	LeagueID int,
	FightCardName varchar(50) not null,
	CardDate Date not null,
	Venue varchar(50),
-- constraints
	CONSTRAINT PK_FightCard PRIMARY KEY (FightCardID),
	CONSTRAINT FK_LeagueID FOREIGN KEY (LeagueID) REFERENCES League(LeagueID)
	)
	-- end of table

	-- creating Match table
CREATE TABLE TheMatch (
-- col for table
	TheMatchID int identity, 
	FightCardID int,
	WeightClassID int,
	WinnerID int,
	LoserID int,
	TitleBout bit,
	TotalRounds int,
	MethMove int,
-- constraints
	CONSTRAINT PK_TheMatch PRIMARY KEY (TheMatchID),
	CONSTRAINT FK1_TheMatch FOREIGN KEY (FightCardID) REFERENCES FightCard(FightCardID),
	CONSTRAINT FK2_TheMatch FOREIGN KEY (WeightClassID) REFERENCES WeightClass(WeightClassID),
	CONSTRAINT FK3_TheMatch FOREIGN KEY (WinnerID) REFERENCES Winner(WinnerID),
	CONSTRAINT FK4_TheMatch FOREIGN KEY (LoserID) REFERENCES Loser(LoserID)
	CONSTRAINT FK5_TheMatch FOREIGN KEY (MethMoveID) REFERENCES MethMove(MethMoveID)
	)
	-- end of table


