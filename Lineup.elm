module Lineup exposing (..)

import Player exposing (..)

type alias Lineup = 
    {
      pointGuard : Player
    , shootingGuard : Player
    , smallForward : Player
    , powerForward : Player
    , center : Player
    }

subPlayer : Position -> Player -> Lineup -> Lineup
subPlayer pos =
    case pos of
        SG -> subShootingGuard
        PG -> subPointGuard
        PF -> subPowerForward
        SF -> subSmallForward
        C  -> subCenter

subShootingGuard : Player -> Lineup -> Lineup
subShootingGuard p l =
    {l | shootingGuard = p}

subPointGuard : Player -> Lineup -> Lineup
subPointGuard p l =
    {l | pointGuard = p}

subPowerForward : Player -> Lineup -> Lineup
subPowerForward p l =
    {l | powerForward = p}

subSmallForward : Player -> Lineup -> Lineup
subSmallForward p l =
    {l | smallForward = p}

subCenter : Player -> Lineup -> Lineup
subCenter p l =
    {l | center = p}
 
names : Lineup -> List (Position ,String )
names l =
    let
        get = List.map (\(a,b) ->
                            (a, Player.name b)
                       )

        pg = [(PG, .pointGuard l)] |> get
        sg = [(SF, .shootingGuard l)] |> get
        pf = [(PF, .powerForward l)] |> get
        sf = [(SF, .smallForward l)] |> get
        c  = [(C, .center l)] |> get
    in
        pg ++ sg ++ c ++ pf ++ sf
--    [Player.name <|(.pointGuard l)]

player : Position ->  Lineup -> Player
player pos =
    case pos of
        PG -> pointGuard
        SG -> shootingGuard
        SF -> smallForward
        PF -> powerForward
        C  -> center

position : Lineup -> Player -> Maybe Position
position {pointGuard, shootingGuard, smallForward, powerForward, center} player =
    let
        playerName = .name player
    in
        if .name pointGuard == playerName then
            Just PG
        else if .name shootingGuard == playerName then
            Just SG
        else if .name powerForward == playerName then
            Just PF
        else if .name smallForward == playerName then
            Just SF
        else if .name center == playerName then
            Just C
        else
            Nothing


pointGuard : Lineup -> Player
pointGuard = .pointGuard

shootingGuard : Lineup -> Player
shootingGuard = .shootingGuard
        
powerForward : Lineup -> Player
powerForward = .powerForward
        
smallForward : Lineup -> Player
smallForward = .smallForward
        
center : Lineup -> Player
center = .center

sortedBy : ( Player -> Int ) -> Lineup -> List Player
sortedBy fn lineup =
    List.sortBy fn (toList lineup)
        |> List.reverse


toList : Lineup -> List Player
toList l =
    [
     l.pointGuard
    ,l.shootingGuard
    ,l.smallForward
    ,l.powerForward
    ,l.center
    ]


byDefenseRating : Lineup -> List Player
byDefenseRating = sortedBy Player.defenseRating

byFoulRating : Lineup -> List Player
byFoulRating = sortedBy Player.foulRating
