module Team exposing (..)

import Player exposing (Player, Position(..))

type Team =
    Team {
          name: String
         ,abbr: String
         ,timing : Int
        }

type alias Roster = List Player.Player

type Side = Home | Away 

type Possession = Offense | Defense 

name : Team -> String
name (Team {name}) = name

abbr : Team -> String
abbr (Team {abbr}) = abbr

timing : Team -> Int
timing (Team {timing}) = timing

sideToString : Side -> String
sideToString side =
    case side of
        Home -> "Home"
        Away -> "Away"



