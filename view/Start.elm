module View.Start exposing
       (view)

import Html exposing (Html, text, button, div, h1, h2)
import Html.Events exposing (onClick)

import Team exposing (Team)
import Lineup exposing (Lineup)
import Player exposing (Player)

type Msg =
    Done

type alias Model =
    {
        
    }

