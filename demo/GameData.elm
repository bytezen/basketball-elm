module Demo.GameData exposing (..)

import Celtics
import Player
import Team
import PlayerJSON exposing (fetchPlayer)
import Lineup

team1 : Team.Team
team1 = Celtics.team 

team2 : Team.Team
team2 = Celtics.team 

team1Lineup : Lineup.Lineup
team1Lineup =
    {
      pointGuard = fetchPlayer "Rajon Rondo" Celtics.roster
    , shootingGuard = fetchPlayer "Ray Allen" Celtics.roster
    , powerForward = fetchPlayer "Glen Davis" Celtics.roster
    , smallForward = fetchPlayer "Paul Pierce" Celtics.roster
    , center = fetchPlayer "Kevin Garnett" Celtics.roster
    }

team2Lineup : Lineup.Lineup
team2Lineup =
    {
      pointGuard = fetchPlayer "Eddie House" Celtics.roster
    , shootingGuard = fetchPlayer "Tony Allen" Celtics.roster
    , powerForward = fetchPlayer "P.J. Brown" Celtics.roster
    , smallForward = fetchPlayer "Leon Powe" Celtics.roster
    , center = fetchPlayer "Kendrick Perkins" Celtics.roster
    }

matchup =
    {
        homeLineup = team1Lineup
       ,visitorLineup = team2Lineup 
    }
