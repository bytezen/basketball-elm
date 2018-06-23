module UI exposing (Msg,Msg(..))

import Player 

type Msg = AssignPosition Player.Position Player.Player
