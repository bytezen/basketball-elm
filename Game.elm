module Game exposing (..)

import Player exposing (Player)
-- import GameState exposing (GameStateModel)
--import Lineup exposing (Lineup)
--import Charts.Jumpball as Jumpball 
--import Die 

type alias From = Player
type alias To = Player
type alias Offense = Player
type alias Defense = Player

type SimOutcome =
    CompletedPass From To
    | FG Player
    | FG3 Player
    | FT Player
    | FGM Player
    | FG3M Player
    | FTM Player
    | Turnover Player
    | Block Offense Defense
    | Rebound Player
    | Foul Player
    | WonJumpball Player
    | Steal Offense Defense

type SimInput =
    PassAttempt Player
    | FGA Player
    | FG3A Player
    | FTA Player

type Action =
     Jumpball
    |Pass 



-- Simulation functions
{--


jumpball : { m | homeLineup : Lineup, visitorLineup : Lineup } -> Die.Model -> SimOutcome
jumpball {homeLineup,visitorLineup} dice =
    let
        roll = Die.toInt dice
        result =
            case Jumpball.result roll of
                Jumpball.Home p ->
                    Lineup.position homeLineup p
                Jumpball.Visitor p ->
                    Lineup.position visitorLineup p
    in
       WonJumpball result
--}


{--

pass : Player -> Die.Model -> SimOutcome
pass player dice =
    let
        roll = Die.toInt dice
        passrating = Player.passRating player
        result =
            case Pass.result roll of 
    in
       result
--}


