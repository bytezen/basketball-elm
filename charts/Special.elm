module Charts.Special exposing (..)

import Player exposing (Position(..),Player)
import Team exposing (Side(..))

type Msg =
    Technical Side Position
    | TechnicalCoach Side
    | Fight Position
    | BenchBrawl EjectionFn 

type alias EjectionFn =
    ((List Player) -> (List Player) -> (List Player))

result : Int -> Msg
result n =
    if n <= 6 then
        Technical Home PG
    else if n <= 13 then
        Technical Home SG
    else if n <= 20 then
        Technical Home SF
    else if n <= 27 then
        Technical Home PF
    else if n <= 34 then
        Technical Home C
    else if n <= 41 then
        Technical Away PG
    else if n <= 48 then
        Technical Away SG
    else if n <= 55 then
        Technical Away SF
    else if n <= 62 then
        Technical Away PF
    else if n <= 69 then
        Technical Away C
    else if n <= 78 then
        TechnicalCoach Home
    else if n <= 87 then
        TechnicalCoach Away 
    else if n <= 89 then
        Fight PG
    else if n <= 91 then
        Fight SG
    else if n <= 93 then
        Fight SF
    else if n <= 95 then
        Fight PF
    else if n <= 97 then
        Fight C
    else
        BenchBrawl
            (\xs ys ->
               (List.take 3 xs)
               ++ (List.take 3 ys) 
            )
