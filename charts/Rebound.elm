module Charts.Rebound exposing (..)

import Player exposing (Position(..), Player)
import Charts.Foul as Foul 
import Die exposing (DiceSet2(..))
import Lineup exposing (Lineup)

type Result =
    Offense Position
    | Defense Position
    | Foul Player

type alias OnCourt = { offenseLineup : Lineup, defenseLineup : Lineup }

result : OnCourt -> DiceSet2 -> Result
result {offenseLineup, defenseLineup} (DiceSet2 (red,white) r2 ) =
    let
        rebound = case white of
                      1 ->
                          Defense PG
                      2 ->
                          Defense SG
                      3 ->
                          Defense SF
                      4 ->
                          Defense PF
                      5 ->
                          Defense C
        Offense PG


