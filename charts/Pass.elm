module Charts.Pass exposing (..)

import Either exposing (..)
-- import Charts.Injury
-- import Charts.Special  

import Player exposing (Player,Position,Position(..))
-- import Simulation

type SpecialEvent = TieUp
                  | Injury
                  | Jumpball
                  | SpecialEvent 

type Msg  = Completed Position
          | Turnover



-- type Result  = GoodPass Position
            -- | TurnOver
            -- | Foul Player
            -- | InjuredHome Position
            -- | InjuredAway Position
            -- | OffenseFoul Position
            -- | DefenseFoul Position
            -- | TechnicalHome Position
            -- | TechnicalAway Position
            -- | TechnicalHome Coach
            -- | TechnicalAway Coach
            -- | Fight Position
            -- | FightBench

-- special : Outcome
-- special =
--     Result.mapError (always Special) 

-- completed : Int -> Either a Msg
completed : Int -> Position
completed n =
    let
        to =
            case n % 10  of
                0 ->
                     PG
                1 ->
                     PG
                2 ->
                     SG
                3 ->
                     SG
                4 ->
                     SF
                5 ->
                     SF
                6 ->
                     PF
                7 -> 
                     PF
                8 ->
                     C
                _ ->
                     C
    in
        -- Completed to |> Right
        to 

turnover : Either a Msg
turnover =
    Turnover |> Right

-- foul : Int -> Either SpecialEvent a
-- foul =
--     Charts.Foul.result >> Foul >> Left

-- special : Int -> Either SpecialEvent a
-- special =
--     Charts.Special.result >> Special >> Left

-- specialEvent : Either SpecialEvent a
-- specialEvent = Left SpecialEvent 

-- injury : Int -> Either SpecialEvent a
-- injury =
--     Charts.Injury.injury >> Injury >> Left

-- injured : Charts.Injury.Msg -> Charts.Injury.Duration -> Either SpecialEvent a
-- injured msg duration =
--     Charts.Injury.injured msg duration
--         |> Injury
--         |> Left

jumpball : Either a SpecialEvent
jumpball = Right Jumpball

test : Either SpecialEvent Msg -> String
test outcome =
    case outcome of
        Left x ->
            "got a special outcome"
        Right x ->
            "got a regualar message"

-- turnover : Outcome
-- turnover  =
--     Result a Turnover

-- mapMessage : (x -> b) -> Result a (Msg x) -> Result a (Msg b)
-- mapMessage : fn 

-- type Model =
    -- Model Int Int Int


-- pass : Player -> Result
-- pass player =
--     let
--         rating = Player.passRating player
--     in

-- result : Model -> Player -> Result
-- result (Model roll1 roll2 roll3) player =
--     let
--         rating = Player.passRating player
--         result = if roll1 >= 5 and roll1 <= rating then
--                      resolvePass roll1
--                  else if roll1 < 5 then
--                      specialResult roll2 roll3
--                  else
--                      TurnOver

-- resolvePass : Int -> Result
-- resolvePass roll1 =

--         result =
--             case roll1 % 10  of
--                 0 ->
--                     GoodPass PG
--                 1 ->
--                     GoodPass PG
--                 2 ->
--                     GoodPass SG
--                 3 ->
--                     GoodPass SG
--                 4 ->
--                     GoodPass SF
--                 5 ->
--                     GoodPass SF
--                 6 ->
--                     GoodPass PF
--                 7 -> 
--                     GoodPass PF
--                 8 ->
--                     GoodPass C
--                 9 ->
--                     GoodPass C


-- specialResult : Int -> Int -> Result
-- specialResult roll1 roll2 =
--     if roll1 <= 4 then
--         resolveInjury roll2
--     else if roll <= 9 then
--         resolveSpecialEvent roll2
--     else if roll <= 29 then
--         resolveSpecialEvent roll2
--     else
--         resolveFoul roll2

-- resolveInjury : Int -> Result
    



