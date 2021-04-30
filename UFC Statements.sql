DROP VIEW IF EXISTS TaleOfTape
DROP VIEW IF EXISTS FinishedFights
DROP VIEW IF EXISTS PunchesByClass
DROP FUNCTION IF EXISTS dbo.FighterNameLookup
DROP FUNCTION IF EXISTS dbo.MethMoveDecode

/* Update ** realized Mike Pierce Age was entered incorrectly since he fought on his birthday ** */

UPDATE Winner
SET WinAge = '30' 
WHERE WinnerID = 146

/*Finished fight view */

SELECT TheMatch.TheMatchID, FightCard.FightCardName, Winner.WinnerID, Fighter.FighterName, Winner.WinOdds, Method.MethodName, FinMove.FinMoveName
FROM ((Method INNER JOIN (FinMove INNER JOIN MethMove ON FinMove.[FinMoveID] = MethMove.[FinMoveID]) ON Method.[MethodID] = MethMove.[MethodID]) INNER JOIN (Fighter INNER JOIN Winner ON Fighter.[FighterID] = Winner.[FighterID]) ON MethMove.[MethMoveID] = Winner.[MethMoveID]) 
INNER JOIN (FightCard INNER JOIN TheMatch ON FightCard.[FightCardID] = TheMatch.[FightCardID]) ON Winner.[WinnerID] = TheMatch.[WinnerID];


SELECT
    FightCard.*
	, TheMatch.*
    , WinningFighter.*
    , Winner.*
    , LosingFighter.*
    , Loser.*
	, MethMove.*
	, Method.*
FROM TheMatch TheMatch
	INNER JOIN FightCard FightCard ON FightCard.FightCardID = TheMatch.FightCardID
    INNER JOIN Winner  Winner ON Winner.WinnerID = TheMatch.WinnerID
    INNER JOIN Fighter WinningFighter ON Winner.FighterID = WinningFighter.FighterID
    INNER JOIN Loser Loser ON Loser.LoserID = TheMatch.LoserID
    INNER JOIN Fighter LosingFighter ON Loser.FighterID = LosingFighter.FighterID
	INNER JOIN MethMove MethMove ON MethMove.MethMoveID = TheMatch.MethMoveID
	INNER JOIN Method Method ON Method.MethodID = MethMove.MethodID

/*
/*TaleOfTape */
CREATE VIEW TaleOfTape AS
SELECT
    FightCard.*
	, TheMatch.*
    , WinningFighter.*
    , Winner.*
    , LosingFighter.*
    , Loser.*
	, MethMove.*
	, Method.*
FROM TheMatch TheMatch
	INNER JOIN FightCard FightCard ON FightCard.FightCardID = TheMatch.FightCardID
    INNER JOIN Winner  Winner ON Winner.WinnerID = TheMatch.WinnerID
    INNER JOIN Fighter WinningFighter ON Winner.FighterID = WinningFighter.FighterID
    INNER JOIN Loser Loser ON Loser.LoserID = TheMatch.LoserID
    INNER JOIN Fighter LosingFighter ON Loser.FighterID = LosingFighter.FighterID
	INNER JOIN MethMove MethMove ON MethMove.MethMoveID = TheMatch.MethMoveID
	INNER JOIN Method Method ON Method.MethodID = MethMove.MethodID
GO

--CREATE VIEW TaleOfTheTape
SELECT TheMatch.TheMatchID, Winner.WinnerID, Winner.FighterID AS FightWinID, Fighter.FighterName AS WinnerName, Winner.FinishRound, Winner.TotalTime, Winner.WinOdds, Winner.WinHeight, Winner.WinWeight, Winner.WinReach, Winner.WinAge, 
Winner.WinKD, Winner.WinSigStrLand, Winner.WinSigStrAtt, Winner.WinTotStrLand, Winner.WinTotStrAtt, Winner.WinTdLand, Winner.WinTdAtt, Winner.WinSubAtt, Loser.LoserID, Loser.FighterID AS FightLoseID, Fighter_1.FighterName AS LoserName
FROM Fighter AS Fighter_1, ((Fighter INNER JOIN Winner ON Fighter.[FighterID] = Winner.[FighterID]) INNER JOIN Loser ON Fighter.[FighterID] = Loser.[FighterID]) INNER JOIN TheMatch ON Loser.[LoserID] = TheMatch.[LoserID]
--GO



-- both fighters
Create view BothFighters AS
SELECT TheMatch.TheMatchID, Winner.WinnerID, Winner.FighterID AS FightWinID, Fighter.FighterName AS WinnerName, Loser.LoserID, Loser.FighterID AS FightLoseID, Fighter_1.FighterName AS LoserName
FROM Fighter AS Fighter_1, ((Fighter INNER JOIN Winner ON Fighter.[FighterID] = Winner.[FighterID]) INNER JOIN Loser ON Fighter.[FighterID] = Loser.[FighterID]) INNER JOIN TheMatch ON Loser.[LoserID] = TheMatch.[LoserID]
GO
*/

-- Tale of The tape view : full match details and stats of results

CREATE VIEW TaleOfTape AS
SELECT
    FightCard.FightCardName AS FightCardName, FightCard.CardDate AS CardDate, FightCard.Venue AS Venue
	, WeightClass.WeightClassName AS WeightClassName
	, TheMatch.TotalRounds AS TotalRounds, TheMatch.MethMoveID AS MethMoveID
    , WinningFighter.FighterName AS WinnerName
	, Winner.FinishRound AS FinishRound, Winner.TotalTime AS TotalTime, Winner.WinOdds AS WinOdds, Winner.WinHeight AS WinHeight, Winner.WinWeight AS WinWeight, Winner.WinReach AS WinReach, Winner.WinAge AS WinAge,
	Winner.WinKD AS WinKD, Winner.WinSigStrLand AS WinSigStrLand, Winner.WinSigStrAtt AS WinSigStrAtt, Winner.WinTotStrLand AS WinTotStrLand, Winner.WinTotStrAtt AS WinTotStrAtt, Winner.WinTdLand AS WinTdLand, Winner.WinTdAtt AS WinTdAtt, Winner.WinSubAtt AS WinSubAtt
    , LosingFighter.FighterName AS LoserName
    , Loser.LoseOdds AS LoseOdds, Loser.LoseHeight AS LoseHeight, Loser.LoseWeight AS LoseWeight, Loser.LoseReach AS LoseReach, Loser.LoseAge AS LoseAge,
	Loser.LoseKD AS LoseKD, Loser.LoseSigStrLand AS LoseSigStrLand, Loser.LoseSigStrAtt AS LoseSigStrAtt, Loser.LoseTotStrLand AS LoseTotStrLand, Loser.LoseTotStrAtt AS LoseTotStrAtt, Loser.LoseTdLand AS LoseTdLand, Loser.LoseTdAtt AS LoseTdAtt, Loser.LoseSubAtt AS LoseSubAtt
	, Method.MethodName
FROM TheMatch TheMatch
	INNER JOIN FightCard FightCard ON FightCard.FightCardID = TheMatch.FightCardID
	INNER JOIN WeightClass WeightClass ON WeightClass.WeightClassID = TheMatch.WeightClassID
    INNER JOIN Winner  Winner ON Winner.WinnerID = TheMatch.WinnerID
    INNER JOIN Fighter WinningFighter ON Winner.FighterID = WinningFighter.FighterID
    INNER JOIN Loser Loser ON Loser.LoserID = TheMatch.LoserID
    INNER JOIN Fighter LosingFighter ON Loser.FighterID = LosingFighter.FighterID
	INNER JOIN MethMove MethMove ON MethMove.MethMoveID = TheMatch.MethMoveID
	INNER JOIN Method Method ON Method.MethodID = MethMove.MethodID
GO
-- Preview
SELECT * FROM TaleOfTape


CREATE VIEW TOT AS
SELECT TOP 2000 
FightCard.FightCardName, FightCard.CardDate, FightCard.Venue, WeightClass.WeightClassName, TheMatch.TotalRounds, TheMatch.MethMoveID, Method.MethodName, Winner.FinishRound, Winner.TotalTime, Winner.FighterID AS Winner_FighterID, Winner.WinOdds, 
Winner.WinHeight, Winner.WinWeight, Winner.WinReach, Winner.WinAge, Winner.WinKD, Winner.WinSigStrLand, Winner.WinSigStrAtt, Winner.WinTotStrLand, Winner.WinTotStrAtt, Winner.WinTdLand, Winner.WinTdAtt, Winner.WinSubAtt, 
Loser.FighterID AS Loser_FighterID, Loser.LoseOdds, Loser.LoseHeight, Loser.LoseWeight, Loser.LoseReach, Loser.LoseAge, Loser.LoseKD, Loser.LoseSigStrLand, Loser.LoseSigStrAtt, Loser.LoseTotStrLand, Loser.LoseTotStrAtt, Loser.LoseTdLand, Loser.LoseTdAtt, Loser.LoseSubAtt
FROM Winner INNER JOIN (((Method INNER JOIN MethMove ON Method.[MethodID] = MethMove.[MethodID]) INNER JOIN (Fighter INNER JOIN Loser ON Fighter.[FighterID] = Loser.[FighterID]) ON MethMove.[MethMoveID] = Loser.[MethMoveID]) 
INNER JOIN (FightCard INNER JOIN (WeightClass INNER JOIN TheMatch ON WeightClass.[WeightClassID] = TheMatch.[WeightClassID]) ON FightCard.[FightCardID] = TheMatch.[FightCardID]) ON Loser.[LoserID] = TheMatch.[LoserID]) ON Winner.[WinnerID] = TheMatch.[WinnerID]
ORDER BY CardDate
GO

-- view TOT
SELECT * FROM TOT




/* Match // Meth&Move */

SELECT * FROM TheMatch WHERE MethMoveID = 4398 

SELECT * FROM FinMove

--Fight method endings (finished fight view)
CREATE VIEW FinishedFights AS
SELECT TheMatch.TheMatchID, WeightClass.WeightClassName, Method.MethodName, FinMove.FinMoveName, Loser.FinishRound, Loser.TotalTime
FROM ((Method INNER JOIN (FinMove INNER JOIN MethMove ON FinMove.[FinMoveID] = MethMove.[FinMoveID]) ON Method.[MethodID] = MethMove.[MethodID]) INNER JOIN Loser ON MethMove.[MethMoveID] = Loser.[MethMoveID]) INNER JOIN (WeightClass INNER JOIN TheMatch ON WeightClass.[WeightClassID] = TheMatch.[WeightClassID]) ON Loser.[LoserID] = TheMatch.[LoserID];
GO

--view finished fights
SELECT * FROM FinishedFights

-- High- level descriptive stats of Match finishes
SELECT 
	COUNT (TheMatchID) as Matches,
MIN(TotalTime) as MinTotalTime,
AVG(TotalTime) as AvgTotalTime,
MAX(TotalTime) as MaxTotalTime
FROM FinishedFights

--create view punches by class
CREATE VIEW PunchesByClass AS
SELECT TOP (2000) TheMatch.TheMatchID, WeightClass.WeightClassName, Winner.WinTotStrLand, Winner.WinTotStrAtt, Loser.LoseTotStrLand, Loser.LoseTotStrAtt
FROM Winner INNER JOIN (Loser INNER JOIN (WeightClass INNER JOIN TheMatch ON WeightClass.[WeightClassID] = TheMatch.[WeightClassID]) ON Loser.[LoserID] = TheMatch.[LoserID]) ON Winner.[WinnerID] = TheMatch.[WinnerID]
ORDER BY WeightClass.WeightClassName 
GO
--show view of punches by class
SELECT * FROM PunchesByClass

-- count of punches by class
SELECT PunchesByClass.WeightClassName, 
SUM (PunchesByClass.WinTotStrLand) as TotalWinnerStrikesLanded,
SUM (PunchesByClass.WinTotStrAtt) as TotalWinnerStrikesThrown,
SUM (PunchesByClass.LoseTotStrLand) as TotalLoserStrikesLanded,
SUM (PunchesByClass.LoseTotStrAtt) as TotalLoserStrikesThrown
FROM PunchesByClass
GROUP BY WeightClassName  


-- Function to retrieve the FighterName for a given FighterID 
CREATE FUNCTION dbo.FighterNameLookup(@FighterID int)
RETURNS varchar(20) AS -- vc_userid is an int so well match
BEGIN 
	DECLARE @returnValue varchar(20) -- matches function return type
	-- get username from Fighter record whose ID matches parameter and assigns it to return v
	SELECT @returnValue = FighterName FROM Fighter
	WHERE FighterID = @FighterID
	-- send name back to caller
	RETURN @returnValue
END
GO 

SELECT dbo.FighterNameLookup('9690')

 
-- Function to retrieve the FinMove for a given MethMoveID from Taleoftape
CREATE FUNCTION dbo.MethMoveDecode(@MethMoveID int)
RETURNS varchar(20) AS -- vc_userid is an int so well match
BEGIN 
	DECLARE @returnValue varchar(20)-- matches function return type
	-- get username from Fighter record whose ID matches parameter and assigns it to return v
	SELECT @returnValue = FinMoveName
	FROM MethMove
	INNER JOIN FinMove ON FinMove.FinMoveID = MethMove.FinMoveID
	WHERE MethMoveID = @MethMoveID
	-- send name back to caller
	RETURN @returnValue 
END
GO 

SELECT dbo.MethMoveDecode('4390')


--Update finMove name to accept null ^ so we can see full stats
ALTER TABLE FinMove ALTER COLUMN FinMoveName varchar(20) NULL

SELECT * FROM Method

--creating view to see sub att for each match won by sub
CREATE VIEW SubView AS
SELECT Method.MethodName, Winner.WinSubAtt
FROM ((Method INNER JOIN MethMove ON Method.[MethodID] = MethMove.[MethodID]) INNER JOIN Winner ON MethMove.[MethMoveID] = Winner.[MethMoveID]) INNER JOIN TheMatch ON Winner.[WinnerID] = TheMatch.[WinnerID]
WHERE MethodName = 'SUB'
GO
--show view SubView
SELECT* FROM SubView