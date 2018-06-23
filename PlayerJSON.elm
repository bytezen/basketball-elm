module PlayerJSON exposing (..)

import Array
import Result
import Player exposing (Player, Rating(..))


{--
Name,Team,Position,2pt,3pt,limit,ft,passing,stealing,,rebound,block,,defense,stamina,foul,injury
--}

parseDataRecord : List String -> Player
parseDataRecord data =
    let
         fields = Array.fromList data
         strValue i = Maybe.withDefault "none" (Array.get i fields)
         intValue i = Result.withDefault 0 <| String.toInt <| Maybe.withDefault "0" <| Array.get i fields
         floatValue i = Result.withDefault 0.0 <| String.toFloat <| Maybe.withDefault "0.0" <| (Array.get i fields)

         name = strValue 0
         team = strValue 1
         position =  String.toLower <| strValue 2
         fg2 = Rating <| intValue 3
         fg3 = Rating <| intValue 4
         fg3Max = Rating <| intValue 5
         ft = Rating <| intValue 6

         pass = Rating <| intValue 7
         stealing1 = intValue 8
         stealing2 = intValue 9
         rebound = Rating <| intValue 10
         block1 = intValue 11
         block2 = intValue 12
         defense = Rating <| intValue 13
         stamina = Rating <| intValue 14
         foul = Rating <| intValue 15
         injury = Rating <| intValue 16

         stealing = if stealing1 == stealing2 then
                        Rating stealing1
                    else
                        Range stealing1 stealing2

         block = if block1 == block2 then
                        Rating block1
                    else
                        Range block1 block2
         rating =
            {
             rebound = rebound
            ,pass = pass
            ,steal = stealing
            ,block = block
            ,defense = defense
            ,stamina = stamina
            ,foul = foul
            ,injury = injury
            }

         shooting =
             {
              fg2 = fg2
             ,fg3 = fg3
             ,fg3Max = fg3Max
             ,ft = ft
             }
    in
        {
         name=name
        ,team=team
        ,position=position
        ,rating = rating
        ,shooting = shooting
        }

parseTeam : List (List String) -> List Player
parseTeam team =
        List.map parseDataRecord team


lookupPlayer : String -> List Player.Player -> Maybe Player
lookupPlayer name ps =
    let
        lookup = List.filter
                  (\p ->
                     Player.name p == name
                  )
                  ps

    in
        List.head <| lookup


fetchPlayer : List Player.Player -> String -> Player
fetchPlayer ps name =
        case lookupPlayer name ps of
            (Just x) ->
                x
            _ ->
                Debug.crash <| (" player " ++ name ++ " not found.")
             

{--
positionFromString : String -> Player.Position
positionFromString s =
    case s of
        "guard" -> Player.PG
        "guard" -> Player.SG
        "forward" -> Player.PF
        "forward" -> Player.SF
        "center" -> Player.C
        _ -> Debug.crash <| "unknown position string: " ++ s


--fetchPlayer : String -> (List Player) -> Result Player
fetchPlayer : String -> Team.Roster -> Player
fetchPlayer name players =
    let
        res = Result.fromMaybe ("player " ++ name ++ " not found")
              
        lookup playerdata =
            case List.head playerdata of
                Just n ->
                    if Player.name n == name then
                       True
                   else
                       False
                _ ->
                    False

        fetch ps =
            case ps of
                x::xs ->
                    if lookup x then
                        res <| Just x
                    else
                        fetch xs
                [] ->
                        res Nothing

        result =
            res <| List.head <| List.filter (\p -> Player.name p == name) players
    in
       case result of
           Ok p -> p
           _ -> Player.anon
        --fetch players
        {--
        List.map (\player ->
                     Maybe.andThen lookup (List.head player)
                 )
            team
        fn xs  = ((==)name) <| Maybe.withDefault "" (List.head xs)
        result = case (List.filter fn team) of
                     x::xs ->
                         Result
        --}
--}

