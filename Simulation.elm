module Simulation exposing (..)

import Random exposing (Generator, generate,andThen,map)

import Player exposing (Player,Position,Position(..))
import Team exposing (Side)
import Lineup
import Either exposing (Either,Either(..) ) 
import Chart exposing  (PassMsg(..), SpecialPassMsg(..))
import Charts.Foul as Foul
import Charts.Special as Special
import Charts.Injury as Injury 
import GameModel as GM
import SimState
import GameEvent exposing  ( Event ) 

-- type Msg =
--     Jumpball (Side, Position)
--     | Pass (Player,Position)
--     | Turnover Player
--     | OffensiveFoul ( (List Player) -> Player )
--     | DefensiveFoul ( (List Player) -> Player )
--     | OutGame Side Position Int
--     | OutQuarter Side Position Int
--     | Technical Side Position
--     | TechnicalCoach Side
--     | Fight Position
--     | TeamFight Special.EjectionFn
--     | Special

type alias Model =
    { simState : SimState.SimState
    , playModel : GM.PlayModel
    }


-- type alias Translator msg = (Msg -> msg)

rollDie : Generator Int
rollDie =
    Random.int 0 99


wrap : a -> Generator a
wrap a =
    Random.map
        ( always a )
        ( Random.int 0 0 )


-- jumpballEventGenerator : GM.PlayModel -> Generator GameEvent.Event
-- jumpballEventGenerator {homeLineup,awayLineup} =
--     let
--         player side pos = case side of
--                           Team.Home ->
--                               Lineup.player pos homeLineup
--                           Team.Away ->
--                               Lineup.player pos awayLineup

--         jumpball_ ( side,pos ) =
--             GameEvent.jumpball side (pos,player side pos)
--     in
--         Random.map Chart.jumpball rollDie
--             |> andThen ( jumpball_ >> wrap)

jumpballEvent : GM.PlayModel -> Int -> GameEvent.Event
jumpballEvent {homeLineup, awayLineup} n =
    let
        event_ (side,pos) =
            GameEvent.jumpball side (pos,player side pos) 

        player side pos = case side of
                          Team.Home ->
                              Lineup.player pos homeLineup
                          Team.Away ->
                              Lineup.player pos awayLineup
    in
        Chart.jumpball n |> event_ 
 

jumpball : GM.PlayModel -> Cmd GameEvent.Event
jumpball playModel  =
    let
        event_ n = jumpballEvent playModel n
    in
        generate event_ rollDie
        -- generate jumpball_ (jumpballEventGenerator playModel) 
        -- generate GameEvent.jumpball result 


-- pass : Player -> Cmd Msg
pass : GM.PlayModel -> Cmd GameEvent.Event
pass ( {homeLineup,awayLineup,possessionModel} as playModel) =
    let
        offenseLineup = GM.offenseLineup playModel
        defenseLineup = GM.defenseLineup playModel

        defensePlayers = Lineup.toList defenseLineup
        offensePlayers = Lineup.toList offenseLineup

        (passingPos, player) = possessionModel.onBall

        rating = Player.passRating player 

        -- toMsg : PassMsg -> Msg
        toMsg : PassMsg -> GameEvent.Event
        toMsg msg =
            case msg of 
                Chart.Completed pos ->
                    -- Pass (player,pos)
                    GameEvent.pass
                        possessionModel.onBall
                        (pos, Lineup.player pos offenseLineup)

                Chart.Turnover ->
                    -- Turnover player
                    GameEvent.turnover player

                Chart.Jumpball (side,pos) ->
                    -- Jumpball sideposTuple
                    GameEvent.jumpball side ( pos, player )

        -- foulToMsg : Foul.Msg -> Msg
        foulToMsg : Foul.Msg -> GameEvent.Event
        foulToMsg msg =
            case msg of
                Left fn ->
                    -- OffensiveFoul fn 
                    GameEvent.offensiveFoul
                        <| fn 
                        <| Lineup.toList offenseLineup
                Right fn ->
                    -- DefensiveFoul fn 
                    GameEvent.defensiveFoul
                        <| fn 
                        <| Lineup.toList defenseLineup

        specialToMsg : Special.Msg -> GameEvent.Event
        specialToMsg msg =
            case msg of
               Special.Technical side pos ->
                   -- Technical side pos
                       case side of
                           Team.Home ->
                               GameEvent.homeTechnicalFoul
                                   <| Lineup.player pos homeLineup 
                           Team.Away ->
                               GameEvent.awayTechnicalFoul
                                  <| Lineup.player pos awayLineup  

               Special.TechnicalCoach side ->
                   -- TechnicalCoach side
                       case side of
                           Team.Home ->
                               GameEvent.homeTechnicalFoulCoach
                           Team.Away ->
                               GameEvent.awayTechnicalFoulCoach

               Special.Fight position ->
                   -- Fight position
                   GameEvent.fight position

               Special.BenchBrawl fn ->
                   -- TeamFight fn
                   GameEvent.benchClear
                       <| fn
                           ( Lineup.toList offenseLineup )
                           ( Lineup.toList defenseLineup )

        -- injuryToMsg : Injury.Msg -> Msg
        injuryToMsg : Injury.Msg -> GameEvent.Event
        injuryToMsg ( Injury.Injured (side,pos) duration) =
            let
                -- injuredPlayer = case side of
                --              Home ->
                --                  Lineup.player pos homeLineup
                --              Away ->
                --                  Lineup.player pos awayLineup

                dur = case duration of
                          Injury.OutGame n ->
                              -- OutGame side pos n
                              GameEvent.injuredForGame player n

                          Injury.OutQuarter n ->
                              -- OutQuarter side pos n
                              GameEvent.injuredForQuarter player n
            in
                dur
                -- case duration of
                --     Injury.Outgame n ->
                --         Event.injuredForGame injuredPlayer n
                --     Injury.OutQuarter n ->
                --         Event.injuredForQuarter injuredPlayer n

        attemptPass : Generator (Either SpecialPassMsg PassMsg) 
        attemptPass  =
            Random.map (Chart.pass rating) rollDie


        -- this should only have to handle PassMsg
        resolveAttempt : (Either SpecialPassMsg PassMsg)
                         -> Generator GameEvent.Event 
                         -- -> Generator Msg 
        resolveAttempt either =
            case either of
                Right msg ->
                    Random.map
                        (always ( toMsg msg ))
                        <| Random.int 0 0 
                Left msg ->
                    resolveSpecialEvent msg

        resolveSpecialEvent : Chart.SpecialPassMsg -> Generator GameEvent.Event
        resolveSpecialEvent msg =
            case msg of
                Chart.TieUp ->
                    let
                        event_ n = jumpballEvent playModel n
                    in
                        Random.map event_ rollDie
                    -- |> andThen ( ( always jumpballGenerator )  >> wrap) 
                    -- |> andthen ( jumpball  >> wrap) 

                Chart.Injury ->
                    let
                        foulRating = Player.foulRating player

                        injuryDuration : Either a b -> Generator Injury.Duration
                        injuryDuration severity =
                            case severity of
                                Left _ ->
                                    Random.map Injury.minorInjury rollDie
                                Right _ ->
                                    Random.map Injury.majorInjury rollDie

                        injury = Random.map Injury.injury rollDie

                        severity : Int -> (Either Injury.Severity Injury.Severity)
                        severity n =
                            if n <= foulRating then
                                Left Injury.Minor
                            else
                                Right Injury.Major

                        duration =
                            Random.map severity rollDie
                                |> andThen injuryDuration
                    in
                        Random.map2
                            Injury.injured
                            injury
                            duration
                        |> andThen ( injuryToMsg >> wrap )

                Chart.SpecialEvent ->
                    Random.map Special.result rollDie
                        |> andThen ( specialToMsg >> wrap )

                Chart.FoulCommitted ->
                    Random.map (Foul.result) rollDie
                        |> andThen ( foulToMsg >> wrap )
    in
        ( attemptPass |> andThen resolveAttempt )
        |> generate identity


-- translate : Translator msg -> Msg -> msg
-- translate fn msg =
--     fn msg

-- update : Msg -> Model -> Model 
-- update msg ({playModel,simState} as model ) =
--     model
