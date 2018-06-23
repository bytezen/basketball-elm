module View.SimulationView exposing (view, Msg(..))

import Html exposing (..)
import Html.Events exposing (onClick)
import SimState exposing (SimState(..))
import GameModel exposing (EventModel,PlayModel)
import StateMachine exposing (State(..))


type Msg = Jumpball

view : {m| simState : SimState, eventModel: EventModel } -> Html Msg
view {simState,eventModel} =
    let
        subview = case simState of
                      Tip ( State {playModel} ) ->
                          div []
                              [
                               tipView playModel eventModel
                              ,button [onClick Jumpball] [text "Jumpball"]
                              ]

                      _ ->
                          p [] [text "no view for this simulation state"]
    in

        div []
            [
             h1 [] [ text "Simulation State"]
            ,subview
            ]


tipView : PlayModel -> EventModel -> Html Msg
tipView model events =
    div []
        [h3 [] [text "tip view"]]
