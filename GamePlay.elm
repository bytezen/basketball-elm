module GamePlay exposing (..)

import Player exposing (Player)
import Team
import Celtics


type Model =
    Model {
       homeTeam : String
      ,visitorTeam : String
      ,homeTeamTiming: Int
      ,visitorTeamTiming: Int
      ,homelineup : Lineup
      ,visitorlineup : Lineup
      ,homeroster : Team.Roster
      ,visitorroster : Team.Roster
    }

homeTeamData = Celtics.data
visitorTeamData = Celtics.data

homeTeam = Tuple.first homeTeamData
visitorTeam = Tuple.first visitorTeamData

{--

init : Model
init =
    Model
    {homeTeam = Team.name homeTeam
    ,visitorTeam = Team.name visitorTeam
    ,homeTeamTiming = Team.timing homeTeam
    ,visitorTeamTiming = Team.timing visitorTeam
    ,homelineup = Tuple.second homeTeamData
    ,visitorlineup = Tuple.second visitorTeamData }
--}
