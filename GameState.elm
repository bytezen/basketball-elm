module GameState exposing (..)

import GameModel exposing (GameModel) 
import StateMachine exposing (State, State(..), Allowed)

type GameState =
    Init (State { setup: Allowed } Model )
   |Setup (State { play: Allowed } Model)
   |Play (State { play : Allowed } Model )

type alias Model = { gameModel : GameModel}


update : GameState -> GameState
update state =
    Debug.log
        "{GameState.update} not doing any updates in game state yet .. "
        state
         
-- update functions
mapGameModel : (GameModel -> GameModel) -> Model -> Model
mapGameModel fn old =
    { old | gameModel = fn old.gameModel} 


updatePlayState : (GameModel -> GameModel) ->
                  State trans Model ->
                  State trans Model 
updatePlayState fn state =
    StateMachine.map (mapGameModel fn) state


-- State Constructors
init : Model -> GameState
init model =
    Init <| State model
 
setup : { m| gameModel : GameModel } -> GameState
setup { gameModel } =
    Setup <| State { gameModel = gameModel }


-- transition functions 
toSetupWithModel : {m | gameModel : GameModel}
                   -> State {setup: Allowed} Model
                   -> GameState
toSetupWithModel model state =
    setup model


toSetup : State { setup: Allowed } Model
                -> GameState
toSetup (State m) = Setup <| State m


toPlayWithModel : { m | gameModel : GameModel}
                  -> State { play : Allowed } Model
                  -> GameState
toPlayWithModel { gameModel } state  =
    Play <| State { gameModel = gameModel }
