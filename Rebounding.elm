module Rebounding exposing (..)



type alias Die = Int
type alias Roll = (Die,Die)
type Msg = DefPG
type ReboundOutcome = Rebound TeamSide PlayerPos
                    | Foul

type alias ReboundFn = (Die -> ReboundOutcome)

type PlayerPos = PG | SG  | SF | PF | C
type TeamSide = Off | Def
type Player = Player {name : String, position: String, team: String} 

type alias Bar = {biz: String, baz:Int}

test : Bar
test = { biz="something", baz = 100}

joe : Player
joe = Player {name ="Joe", position="PG", team="Boston"} 
outcome : Roll
        -> (List Player)
        -> {offense: String, defense: String} 
        -> ReboundOutcome
outcome (r,w) ps {offense,defense} =
    if (r >= 2 && r <= 7) then
        chart w
    else
        Foul


chart : Die -> ReboundOutcome
chart n =
    case n of
        0 -> Foul 
        1 -> Rebound Def PG
        2 -> Rebound Def SG
        3 -> Rebound Def SF
        4 -> Rebound Def PF
        5 -> Rebound Def C
        _ -> Foul

onOffense : List Player -> {offense:String} -> List Player
onOffense ps {offense} =
    List.filter (\(Player {team}) -> team  == offense) ps 

onDefense : List Player -> {defense:String} -> List Player
onDefense ps {defense} =
    List.filter (\(Player {team}) -> team  == defense) ps 

--sortByRebounding : {rebounding: }
