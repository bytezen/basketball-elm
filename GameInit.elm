module GameInit exposing (..)

--import GameState exposing (..)
import Team exposing (Team)
import GameModel as GM
import Player exposing (Position(..))
import Lineup 
import Celtics

initPlayModel : GM.PlayModel
initPlayModel =
    {
     homeLineup = Celtics.startingLineup
    ,awayLineup = Celtics.startingLineup
    ,possessionModel = initPossessionModel
    }

initPossessionModel : GM.PossessionModel
initPossessionModel =
    {
     onBall = (C, Lineup.center Celtics.startingLineup)
    ,side = Team.Home
    ,passCount = 0
    ,minPasses = 1
    }

initGameModel : GM.GameModel
initGameModel =
    {
     plays = 0
    ,quarterLength = 0
    ,quarter = 1
    ,homeTimeouts = 0
    ,awayTimeouts = 0
    ,homeFouls = 0
    ,awayFouls = 0
    ,homeScore = 0
    ,awayScore = 0
    ,homeTeam = Celtics.team
    ,awayTeam = Celtics.team
    }

-- initTeamDefinition : GM.TeamDefinition
-- initTeamDefinition =
--     {
--      homeTeam = Celtics.team
--     ,awayTeam = Celtics.team
--     }

initEventModel : GM.EventModel 
initEventModel = []
