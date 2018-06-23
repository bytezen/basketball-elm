module View.GameView exposing (view, Msg(..))

import Html exposing (..)
import GameState exposing (GameState)


type Msg = None
    
view : GameState -> Html Msg
view gameState =
    div []
        [
         h1 [] [ text "GameView"]
        ]
