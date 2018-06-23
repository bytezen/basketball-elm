module Charts.Jumpball exposing (jumpball, Result(..))

import Player exposing (Position(..), Player )
import Team exposing (Side(..))
import Random
import Simulation


type Result = Possession (Side,Position) 


chart : Int -> (Side, Position)
chart n =
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
        Debug.log
            ("this is the die roll" ++ (toString n)) res



result : Int -> Result
result n =
    let
        res = 
        if n <= 19 then
            Possession (Home,PG) 
        else if n <= 39 then
            Possession (Home,SG)
        else if n <= 49 then
            Possession (Home,SF)
        else if n <= 59 then
            Possession (Home,PF)
        else if n <= 74 then
            Possession (Away,PG)
        else if n <= 89 then
            Possession (Away,SG)
        else if n <= 94 then
            Possession (Away,SF)
        else -- <= 99
            Possession (Away,PF)
    in
        Debug.log
            ("this is the die roll" ++ (toString n)) res

{--
jumpball : ( Result -> msg ) -> Cmd msg
jumpball msg =
    Random.int 0 99
    |> Random.map result
    |> Random.generate msg 
--}

jumpball : (Simulation.Msg -> msg) -> Cmd msg --(Simulation.Msg)
--jumpball: (Int -> msg) -> Cmd msg
jumpball msg =
    --Random.generate msg <| Random.int 0 99
    Random.int 0 99
    |> Random.map result
    |> Random.generate (\(Possession (side,pos) ) ->
                            msg <| Simulation.jumpball pos side
                       )



