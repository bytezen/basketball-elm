module Chart exposing (..)

import Player exposing (Player,  Position(..) )
import Team exposing (Side (..), Possession(..))
import Charts.Pass as Pass 
import Either exposing (Either(..) )

-- type Special =
--     InjuryChart | FoulChart | JumpballChart | SpecialEventChart

-- type Pass = Pass
-- type Jumpball = Jumpball

type SpecialPassMsg =
    SpecialEvent
    | Injury 
    | FoulCommitted
    | TieUp
    -- | Jumpball (Side, Position)
    -- | Foul Possession ( List Player -> Player )

type PassMsg =
    Completed Position
    | Turnover
    | Jumpball (Side,Position)
    -- | Foul ((List Player) -> Player)

-- type SpecialResult =


-- jumpball : a -> Int -> Result a (Side,Position)
jumpball: Int -> (Side,Position) --PassMsg 
jumpball n =
    let
        res = 
        if n <= 19 then
             (Home,PG) 
        else if n <= 39 then
             (Home,SG)
        else if n <= 49 then
             (Home,SF)
        else if n <= 59 then
             (Home,PF)
        else if n <= 74 then
             (Away,PG)
         else if n <= 89 then
             (Away,SG)
        else if n <= 94 then
             (Away,SF)
        else -- <= 99
             (Away,PF)
    in
        res
        -- Debug.log
        --     ("this is the die roll" ++ (toString n))
        --     <| (Jumpball res)

pass : Int -> Int -> Either SpecialPassMsg PassMsg
pass rating n =
    if n <= 4 then
        Left SpecialEvent
    else if n >= 5 && n <= rating then
             Pass.completed n
                |> Completed
                |> Right
    else
        Right Turnover


-- FOR TESTING ONLY

        {--
        if n >= 5 && n <= rating then
            Pass.completed n
                |> Outcome -- Pass
        else if n > rating then
            Pass.turnover
                |> Outcome -- Pass
        else
            Pass.specialEvent |> Outcome -- Pass
            --}

specialEvent : Int -> Either SpecialPassMsg PassMsg
specialEvent n =
    if n <= 4 then
        Left Injury
    else if n <= 9 then
        Left SpecialEvent
    else if n <= 29 then
        Left TieUp
    else
        Left  FoulCommitted


-- specialEvent : Int -> SpecialOutcome
-- specialEvent n =
--     if n <= 6 then
--         Technical (Home,PG)
--     else if n <= 13 then
--         Technical (Home,SG)
--     else if n <= 20 then
--         Technical (Home,SF)
--     else if n <= 27 then
--         Technical (Home,PF)
--     else if n <= 34 then
--         Technical (Home,C)
--     else if n <= 41 then
--         Technical (Away,PG)
--     else if n <= 48 then
--         Technical (Away,SG)
--     else if n <= 55 then
--         Technical (Away,SF)
--     else if n <= 62 then
--         Technical (Away,PF)
--     else if n <= 69 then
--         Technical (Away,C)
--     else if n <= 78 then
--         TechnicalCoach Home
--     else if n <= 87 then
--         TechnicalCoach Away
--     else if n <= 89 then
--         Fight PG
--     else if n <= 91 then
--         Fight SG
--     else if n <= 93 then
--         Fight SF
--     else if n <= 95 then
--         Fight PF
--     else if n <= 97 then
--         Fight C
--     else 
--         Brawl

-- injury : Int -> SpecialOutcome
-- injury n =
--     if n <= 9 then
--         Injury (Home,PG)
--     else if n <= 19 then
--         Injury (Home,SG)
--     else if n <= 29 then
--         Injury (Home,SF)
--     else if n <= 39 then
--         Injury (Home,PF)
--     else if n <= 49 then
--         Injury (Home,C)
--     else if n <= 59 then
--         Injury (Away,PG)
--     else if n <= 69 then
--         Injury (Away,SG)
--     else if n <= 79 then
--         Injury (Away,SF)
--     else if n <= 89 then
--         Injury (Away,PF)
--     else 
--         Injury (Away,C)

-- minorInjury : Int -> SpecialOutcome
-- minorInjury n =
--     if n <= 24 then
--         OutQuarter 0
--     else if n <= 49 then
--         OutQuarter 1
--     else if n <= 74 then
--         OutQuarter 2
--     else if n <= 93 then
--         OutGame 0
--     else if n <= 95 then
--         OutGame 1
--     else if n <= 97 then
--         OutGame 2
--     else 
--         OutGame 3

-- majorInjury : Int -> SpecialOutcome
-- majorInjury n =
--     if n <= 19 then
--         OutGame 0
--     else if n <= 29 then
--         OutGame 1
--     else if n <= 39 then
--         OutGame 2
--     else if n <= 49 then
--         OutGame 3
--     else if n <= 59 then
--         OutGame 4
--     else if n <= 66 then
--         OutGame 5
--     else if n <= 68 then
--         OutGame 6
--     else if n <= 70 then
--         OutGame 7
--     else if n <= 72 then
--         OutGame 8
--     else if n <= 74 then
--         OutGame 9
--     else if n <= 76 then
--         OutGame 10
--     else if n == 77 then
--         OutGame 11
--     else if n == 78 then
--         OutGame 12
--     else if n == 79 then
--         OutGame 13
--     else if n == 80 then
--         OutGame 14
--     else if n == 81 then
--         OutGame 15
--     else if n == 82 then
--         OutGame 16
--     else if n == 83 then
--         OutGame 17
--     else if n == 84 then
--         OutGame 18
--     else if n == 85 then
--         OutGame 19
--     else if n == 86 then
--         OutGame 20
--     else if n == 87 then
--         OutGame 21
--     else if n == 88 then
--         OutGame 22
--     else if n == 89 then
--         OutGame 23
--     else if n == 90 then
--         OutGame 24
--     else if n == 91 then
--         OutGame 25
--     else if n == 92 then
--         OutGame 30
--     else if n == 93 then
--         OutGame 35
--     else if n == 94 then
--         OutGame 40
--     else if n == 95 then
--         OutGame 45
--     else if n == 96 then
--         OutGame 50
--     else if n == 97 then
--         OutGame 55
--     else if n == 98 then
--         OutGame 60
--     else 
--         OutGame 82

-- foul : Int -> SpecialOutcome
-- foul  = Foul <| Chart.foul
 
