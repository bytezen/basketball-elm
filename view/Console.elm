module View.Console exposing
    (view, Msg(..), Msg, Translator, TranslatorDict, ModelAdaptor)


import Html exposing (..)

import Team exposing (Team, Side(..))
import Lineup exposing (Lineup)
import Player exposing (Player)

import Html exposing (..)
import Html.Events exposing (onClick)
import Team exposing (Team) 
import Lineup exposing (Lineup)
import Player 
import GameModel as GM
import GameEvent
import SimState as SimState

type Msg =
     -- Done 
      Tip
     | Pass


type alias Translator msg = (Msg -> msg)

type alias TranslatorDict msg =
    {
    onTip : Translator msg 
    ,onPass : Translator msg
    -- ,onDone :  Translator msg
    }

type alias Model =
    {
     playModel : GM.PlayModel
    ,simState : SimState.SimState
    ,eventModel : GM.EventModel
    }

type alias ModelAdaptor a =
    a -> Model

-- type alias TipViewModel =
--     {
--      eventModel : GM.EventModel
--     ,homeLineup : Lineup
--     ,awayLineup : Lineup
--     ,possessionModel : GM.PossessionModel
    -- }
view : Model -> TranslatorDict msg -> Html msg
view ({ playModel, simState, eventModel } as model) {onPass,onTip}=
         let
             message m = p [] [text m]
         in
             case simState of
                 SimState.Tip state ->
                     viewTip model {onTip = onTip} 

                 SimState.PassOnly state ->
                     div []
                         [viewCoachCorner
                         ,viewEventLog model.eventModel
                         ,viewButton (onPass Pass) "Pass"
                         ]
                        
                 _ -> 
                     Debug.crash "No view associated with current Sim State"

                 -- SimState.Init x ->
                 --     div []
                 --         [h1 [] [text "tipoff"]
                 --         ,button [(onTip >> onClick) Tip] [text "JumpBall"]
                 --         ]

viewEventLog : GM.EventModel -> Html msg
viewEventLog events =
    let
        messageElem s = p [] [text s]
    in
        div
        []
        <| List.map
            (GameEvent.toString >> messageElem)
            events

viewTip : Model -> {onTip: Translator msg} -> Html msg
viewTip ({eventModel,playModel,simState} ) {onTip} =
    let
        possessionModel = playModel.possessionModel
        sideStr =
            case possessionModel.side of
                Home -> "home team"
                Away -> "away team"

        lineup = GM.sideToLineup possessionModel.side playModel

        (pos,player) = possessionModel.onBall

        msg = sideStr ++ " won the tip to " ++ (Player.name player) 

    in

    div []
        [ 
         h2 [] [text "Tipoff"]
        ,p [] [text msg]
        , viewCoachCorner
        , viewEventLog eventModel
        ,viewButton (onTip Tip) "pass"
        ]


viewCoachCorner : Html msg
viewCoachCorner =
    div []
        [h3 [] [text "Coach Corner"]]


viewButton : msg -> String -> Html msg
viewButton msg label =
    button [onClick msg][text label]



message : String -> Html msg
message m = p [] [text m]

      
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


