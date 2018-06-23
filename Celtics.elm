module Celtics exposing (team, roster, paulpierce,startingLineup)

import PlayerJSON exposing (fetchPlayer, parseDataRecord)
import Player 
import Team exposing (Team)
import Lineup exposing (Lineup)

type alias Roster = List Player.Player

rawdata :  List (List String) 
           
rawdata = [["Paul Pierce","Boston","Forward","49","38","5","83","87","96","99","45","99","99","-4","19","35","98"], ["Kevin Garnett","Boston","Forward","54","0","1","79","85","95","99","73","98","99","-5","15","35","87"], ["Ray Allen","Boston","Guard","48","39","7","90","84","97","99","37","99","99","-4","20","28","89"], ["Rajon Rondo","Boston","Guard","49","25","1","60","92","93","99","45","99","99","-5","10","41","94"], ["Eddie House","Boston","Guard","42","38","4","91","85","95","99","39","99","99","-2","11","39","95"], ["James Posey","Boston","Forward","49","37","4","80","83","95","99","52","99","99","-2","10","50","90"], ["Kendrick Perkins","Boston","Center","61","0","1","61","82","98","99","66","96","99","-5","5","64","95"], ["Tony Allen","Boston","Guard","45","31","1","75","84","95","99","41","99","99","-2","6","61","92"], ["Leon Powe","Boston","Forward","57","0","1","70","80","98","99","73","99","99","-2","5","79","68"], ["Glen Davis","Boston","Forward","47","0","0","65","81","96","99","61","99","99","-2","4","85","84"], ["Sam Cassell","Boston","Guard","37","40","2","83","86","96","99","37","99","99","-2","9","49","21"], ["Brian Scalabrine","Boston","Forward","28","32","1","74","83","98","99","47","99","99","-2","3","62","59"], ["Scot Pollard","Boston","Center","51","0","0","67","80","98","99","59","98","99","-2","2","100","27"], ["P.J. Brown","Boston","Center","34","0","1","68","82","97","99","82","98","99","-2","3","70","22"]]

data : (Team, Roster)
data =
    let
        players = List.map parseDataRecord rawdata
    in
        (
         Team.Team {name="Boston Celtics", abbr="Bos", timing=20}
        ,players
        )

roster : Roster
roster = Tuple.second data

team : Team 
team = Tuple.first data
startingLineup : Lineup
startingLineup =
    let
        fetch = fetchPlayer roster
    in
      {
        pointGuard = fetch "Rajon Rondo" 
       ,shootingGuard = fetch "Ray Allen" 
       ,smallForward = fetch "Paul Pierce"
       ,powerForward = fetch "Glen Davis"
       ,center = fetch "P.J. Brown"
      }

        
paulpierce : Player.Player
paulpierce = fetchPlayer roster "Paul Pierce" 


--starting5 = List Player
