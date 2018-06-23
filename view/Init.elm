module View.Init exposing
    (view, Msg(..), Msg, Translator, TranslatorDict, ModelAdaptor )

import Html exposing (..)
import Html.Events exposing (onClick)
import Team exposing (Team) 
import Lineup exposing (Lineup)
import Player 

 
type Msg =
    ChooseHomeTeam Team
    | ChooseAwayTeam Team
    | ChooseHomeLineup Lineup
    | ChooseAwayLineup Lineup
    | Done 

type alias Translator msg = (Msg -> msg)
type alias TranslatorDict msg =
    {
     onChooseHomeTeam : Translator msg
    ,onChooseAwayTeam : Translator msg
    ,onChooseHomeLineup : Translator msg
    ,onChooseAwayLineup : Translator msg
    ,onDone :  Translator msg
    }

type alias Model =
    {
        homeTeam : Team
        ,homeLineup : Lineup
        ,awayTeam : Team
        ,awayLineup : Lineup
    }

type alias ModelAdaptor a =
    a -> Model
 
--view : {m | definition: TeamDefinition } -> Translator msg -> Html msg
view : Model -> TranslatorDict msg -> Html msg
view {homeTeam,awayTeam,homeLineup,awayLineup}
     {onChooseHomeTeam, onChooseAwayTeam, onChooseHomeLineup, onChooseAwayLineup, onDone} =
         let
             btn : String -> msg  -> Html msg
             btn lbl msg =
                 button [ onClick msg] [text lbl]

             h2_ lbl = h2 [] [text lbl]

             okbtn = btn "ok"

             divHomeTeam =
                 div []
                     [h2_ <| "Home Team: " ++ (Team.abbr homeTeam)
                     ,okbtn (onChooseHomeTeam <| ChooseHomeTeam homeTeam)
                     ]

             divAwayTeam =
                 div []
                     [h2_ <| "Away Team: " ++ (Team.abbr awayTeam)
                     ,okbtn (onChooseAwayTeam <| ChooseAwayTeam awayTeam)
                     ]

             divHomeLineup =
                 div []
                     [h2_ "Home Lineup"
                     ,viewLineup homeLineup
                     ,okbtn (onChooseHomeLineup <| ChooseHomeLineup homeLineup)
                     ]
 
             divAwayLineup =
                 div []
                     [h2_ "Away Lineup"
                     ,viewLineup awayLineup
                     ,okbtn (onChooseAwayLineup <| ChooseAwayLineup awayLineup)
                     ]
                    
         in
    div
      []
      [
         h1 [] [text "Choose Teams and Starting Lineups"]
         , divHomeTeam
         , divAwayTeam
         , divHomeLineup
         , divAwayLineup
         , button
             [onClick <| onDone Done]
             [text "continue"]
      ]
      
viewLineup : Lineup -> Html msg
viewLineup lineup =
    let
        show pos name =
            p [] [text pos
                 ,br [][]
                 ,text name
                 ]

        mapLineupNames =
            List.map
                ( \(pos,name)->
                     show (Player.positionToString pos) name 
                )
    in
        div [] (mapLineupNames <| Lineup.names lineup)

viewTeam : Team -> Html msg
viewTeam (Team.Team {abbr}) =
    h4 [] [text abbr]

