module InGameStats exposing (..)

import Dict exposing (Dict) 
import Player exposing (Player)

{--
Model to track the in game numbers. E.g. possessions, timeouts, quarters
scores, team fouls
--}


type alias Model =
    {
      possession : Team
    , home : Team
    , visitor : Team
    , quarter : Int
    , homeFouls : Int
    , visitorFouls : Int
    }

type alias Team = Dict String Player

pg = "point guard"
sg = "shooting guard"
sf = "small forward"
pf = "power forward"
c  =  "center"

home5: Team
home5 = Dict.empty 

visitor5 : Team
visitor5 = Dict.empty

{--
Model for GameSetup
--}
type alias GameModel =
    {
      quarterLength : Int
    }
