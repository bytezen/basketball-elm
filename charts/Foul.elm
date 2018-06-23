module Charts.Foul exposing (..)

import List.Extra exposing ((!!))
import Player exposing (Position,Player)
import Either exposing (..)


-- Left -> Offense
-- Right -> Defense

type alias Msg  = Either ((List Player) -> Player) ((List Player) -> Player)


result : Int -> Msg 
result n =
    let
        get i xs = xs !! i |> (Maybe.withDefault Player.anon)
    in
      if n <= 4 then
          Left <| get 0
      else if n <= 9 then
          Left  <| get 1
      else if n <= 14 then
          Left  <| get 2
      else if n <= 19 then
          Left  <| get 3
      else if n <= 24 then
          Left  <| get 4
      else if n <= 29 then
          Right  <| get 0
      else if n <= 34 then
          Right  <| get 1
      else if n <= 39 then
          Right  <| get 2
      else if n <= 44 then
          Right  <| get 3
      else if n <= 49 then
          Right  <| get 4
      else if n <= 54 then
          Right  <| get 3
      else if n <= 59 then
          Right  <| get 2
      else if n <= 64 then
          Right  <| get 1
      else if n <= 69 then
          Right  <| get 0
      else if n <= 79 then
          Right  <| get 1
      else
          Right  <| get 0










