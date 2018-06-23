module Simulation.Messages exposing (..)

import Simulation as Sim

tip : String -> String -> String
tip team player =
    "tip controlled by " ++ team ++ " " ++ player
