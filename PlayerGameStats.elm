module PlayerGameStats exposing (..)

import Dict exposing (..)

{--
Model for the individual statistics during the game. This will
track fatigue levels, three point shot limit, injuries, etc.
--}


type alias Model =
    {
     stats : Dict String Stats
    }

type alias Stats =
    {
     fga : Int
    ,fgm : Int
    ,fg3a : Int
    ,fg3m : Int
    ,fta : Int
    ,ftm : Int
    ,drb : Int
    ,orb : Int
    ,ast : Int
    ,stl : Int
    ,to : Int
    ,fouls : Int
    }
