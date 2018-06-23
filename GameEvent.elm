module GameEvent exposing (..)

import Team exposing (Side)
import Player exposing (Position, Player)


type Play = Jumpball Side (Position,Player)
          | Pass (Position,Player) (Position,Player)
          | Turnover Player
          | OffensiveFoul Player
          | DefensiveFoul Player
          | HomeTechnicalFoul Player
          | AwayTechnicalFoul Player
          | HomeTechnicalFoulCoach
          | AwayTechnicalFoulCoach
          | Fight Position
          | BenchClear (List Player)
          | OutForQuarter Player Int
          | OutForGame Player Int

    
type Event  = Event Play 



-- Event Messages
toString : Event -> String
toString (Event play) =
    case play of
        Jumpball side (pos,player) ->
            jumpballToString side (pos,player)

        Pass from to ->
            passToString from to

        Turnover by ->
            turnoverToString by

        OffensiveFoul player ->
            offensiveFoulToString player

        DefensiveFoul player ->
            defensiveFoulToString player

        HomeTechnicalFoul player ->
            technicalFoulToString player

        AwayTechnicalFoul player ->
            technicalFoulToString player

        HomeTechnicalFoulCoach ->
            technicalFoulCoachToString Team.Home

        AwayTechnicalFoulCoach ->
            technicalFoulCoachToString Team.Away

        Fight pos -> 
            fightToString pos

        BenchClear ps ->
            benchClearToString ps
 
        OutForQuarter player duration ->
            outForQuarterToString player duration

        OutForGame player duration ->
            outForGameToString player duration


-- Aux functions
playerDisplay : (Position,Player) -> String
playerDisplay (pos,player) =
    Player.name player
    ++ "("
    ++ Player.positionToString pos
    ++ ")"


-- Play To String
jumpballToString : Side -> (Position,Player) -> String
jumpballToString side (pos,player) =
        "Tip was won by "
        ++ (Team.sideToString side)
        ++ " team "
        ++ (playerDisplay (pos,player)) 

passToString : (Position,Player) -> (Position,Player) -> String
passToString from to =
    "pass from "
    ++ (playerDisplay from)
    ++ " to "
    ++ (playerDisplay from)

turnoverToString : Player -> String
turnoverToString player =
    "turnover by " ++ (Player.name player)

offensiveFoulToString : Player -> String
offensiveFoulToString player =
    "offensive foul on " ++ (Player.name player)

defensiveFoulToString : Player -> String
defensiveFoulToString player =
    "foul on " ++ (Player.name  player)

-- homeTechnicalFoulToString : Player -> String
-- homeTechnicalFoulToString player =
--     "technical foul on " ++ (playerDisplay player)

technicalFoulToString : Player -> String
technicalFoulToString player =
    "technical foul on " ++ (Player.name player)

technicalFoulCoachToString : Side -> String
technicalFoulCoachToString side =
    "technical foul on " ++ (Team.sideToString side)


fightToString : Position -> String
fightToString pos =
    "fight between the "
    ++ (Player.positionToString pos)
    ++ " both players are ejected "

benchClearToString : List Player -> String
benchClearToString ps =
    let
        players = List.map Player.name ps
    in
        List.foldl
            (++)
            "there was a bench brawl!! the following players are eject"
            players


outForQuarterToString : Player -> Int -> String 
outForQuarterToString player duration =
    let
        dur = Basics.toString duration
    in
        "Oh no!"
        ++ (Player.name player)
        ++ " was injured. It's a minor injury. "
        ++ " He will be out for "
        ++ dur
        ++ " quarters."

outForGameToString : Player -> Int -> String 
outForGameToString player duration =
    let
        dur = Basics.toString duration
    in
        "Oh no!"
        ++ (Player.name player)
        ++ " was injured. It's a minor injury. "
        ++ " He will be out for "
        ++ dur
        ++ " quarters."

-- Event Generators 

jumpball : Side -> (Position,Player) -> Event
jumpball side (pos,player) = Jumpball side (pos,player) |> Event

pass : (Position,Player) -> (Position,Player) -> Event
pass from to =
    Pass from to
        |> Event 

turnover : Player -> Event
turnover player =
    Turnover player
        |> Event

offensiveFoul : Player -> Event
offensiveFoul player =
    OffensiveFoul player
        |> Event

defensiveFoul : Player -> Event
defensiveFoul player =
    DefensiveFoul player
        |> Event

homeTechnicalFoul : Player -> Event
homeTechnicalFoul player =
    HomeTechnicalFoul player
        |> Event

awayTechnicalFoul : Player -> Event
awayTechnicalFoul player =
    AwayTechnicalFoul player
        |> Event

awayTechnicalFoulCoach :  Event
awayTechnicalFoulCoach = Event AwayTechnicalFoulCoach 

homeTechnicalFoulCoach :  Event
homeTechnicalFoulCoach = Event HomeTechnicalFoulCoach 

fight : Position -> Event
fight pos =
    Fight pos
        |> Event

benchClear : List Player -> Event
benchClear ps =
    BenchClear ps
        |> Event

injuredForQuarter : Player -> Int -> Event
injuredForQuarter player n =
    OutForQuarter player n
        |> Event

injuredForGame : Player -> Int -> Event
injuredForGame player n =
    OutForGame player n
        |> Event
