module SimStateMachine exposing (..)

import SimState 
import StateMachine 
import GameModel as GM
import GameEvent

-- update : (SimState.SimState -> SimState.SimState)
--          -> {m|simState : SimState.SimState}
--          -> {m|simState : SimState.SimState}


update : SimState.SimState -> GameEvent.Event -> SimState.SimState
update state event =
    case state of

        SimState.Tip (StateMachine.State {possessionModel}) ->
            updateTip state event 

        _ ->
            state
        -- SimState.Init state ->
        --     updateInitState state event

-- updateInitState event =
--     SimState.tip GameInit.initPossessionModel
updateTip : SimState.SimState -> GameEvent.Event -> SimState.SimState
updateTip simstate event =
    case  simstate of
        SimState.Tip ( (StateMachine.State model) as tipState ) ->
            case event of
                ( GameEvent.Event ( GameEvent.Jumpball side (pos,player) ) )->
                    SimState.toPassOnlyWithModel
                        tipState
                        model.possessionModel
            --update the possession model and transition to pass only

        _ ->
            simstate



