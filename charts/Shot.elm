module Charts.Shot exposing (..)

import Player exposing (Player, fg2Rating, ftRating, fg3Rating, intRating)

type ShotType = FG2 | FT | FG3
type Result =
    Made ShotType
    | And1 ShotType
    | Foul
    | Missed ShotType


result : Player -> ShotType -> Int -> Result
result offense shot roll =
    let
        rating = case shot of
                     FG2 ->
                         fg2Rating offense
                     FG3 ->
                         fg3Rating offense
                     FT ->
                         ftRating offense

        isMade = roll <= (intRating rating)
        isFoul = roll % 10 == 0

    in
        case shot of
            FT ->
                if isMade then
                    Made FT
                else
                    Missed FT
            FG2 ->
                if isMade then
                    if isFoul then
                        And1 FG2
                    else
                        Made FG2
                else
                    Missed FG2
            FG3 ->
                if isMade then
                    if isFoul then
                        And1 FG3
                    else
                        Made FG3
                else
                    Missed FG3








