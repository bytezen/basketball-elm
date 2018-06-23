module Charts.Injury exposing (..)

import Player exposing (Position(..))
import Team exposing (Side(..))


type Msg  = Injured (Side,Position) Duration
type Result =  Injury (Side,Position)  
    
type Duration =   OutGame Int | OutQuarter Int

type Severity = Minor | Major

injury: Int -> Result
injury n =
    if n <= 9 then
        Injury (Home,PG)
    else if n <= 19 then
        Injury (Home,SG)
    else if n <= 29 then
        Injury (Home,SF)
    else if n <= 39 then
        Injury (Home,PF)
    else if n <= 49 then
        Injury (Home,C)
    else if n <= 59 then
        Injury (Away,PG)
    else if n <= 69 then
        Injury (Away,SG)
    else if n <= 79 then
        Injury (Away,SF)
    else if n <= 89 then
        Injury (Away,PF)
    else 
        Injury (Away,C)

injured : Result -> Duration -> Msg
injured (Injury x) duration =
    Injured x duration


minorInjury : Int -> Duration
minorInjury n =
    if n <= 24 then
        OutQuarter 0
    else if n <= 49 then
        OutQuarter 1
    else if n <= 74 then
        OutQuarter 2
    else if n <= 93 then
        OutGame 0
    else if n <= 95 then
        OutGame 1
    else if n <= 97 then
        OutGame 2
    else 
        OutGame 3


majorInjury : Int -> Duration
majorInjury n =
    if n <= 19 then
        OutGame 0
    else if n <= 29 then
        OutGame 1
    else if n <= 39 then
        OutGame 2
    else if n <= 49 then
        OutGame 3
    else if n <= 59 then
        OutGame 4
    else if n <= 66 then
        OutGame 5
    else if n <= 68 then
        OutGame 6
    else if n <= 70 then
        OutGame 7
    else if n <= 72 then
        OutGame 8
    else if n <= 74 then
        OutGame 9
    else if n <= 76 then
        OutGame 10
    else if n == 77 then
        OutGame 11
    else if n == 78 then
        OutGame 12
    else if n == 79 then
        OutGame 13
    else if n == 80 then
        OutGame 14
    else if n == 81 then
        OutGame 15
    else if n == 82 then
        OutGame 16
    else if n == 83 then
        OutGame 17
    else if n == 84 then
        OutGame 18
    else if n == 85 then
        OutGame 19
    else if n == 86 then
        OutGame 20
    else if n == 87 then
        OutGame 21
    else if n == 88 then
        OutGame 22
    else if n == 89 then
        OutGame 23
    else if n == 90 then
        OutGame 24
    else if n == 91 then
        OutGame 25
    else if n == 92 then
        OutGame 30
    else if n == 93 then
        OutGame 35
    else if n == 94 then
        OutGame 40
    else if n == 95 then
        OutGame 45
    else if n == 96 then
        OutGame 50
    else if n == 97 then
        OutGame 55
    else if n == 98 then
        OutGame 60
    else 
        OutGame 82

