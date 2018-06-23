module SimState exposing (..)  

import StateMachine exposing (State, State(..), Allowed)
import GameModel exposing (PlayModel)
import GameEvent exposing (Event)

type alias Model = { playModel : PlayModel }

type SimState =
    Init (State { tip: Allowed} Model )
    | Tip (State { passOnly: Allowed } Model )
    | PassOnly ( State {passOrShoot : Allowed ,shootOnly : Allowed}
                     Model
               )
    -- | PassOrShoot ( State  {} { possessionModel : Model.PossessionModel} )
    -- | ShootOnly ( State  {} { possessionModel : Model.PossessionModel} )
    -- | Possession ( )
    -- | Rebound ( )
    -- | Inbound ( )
    -- | Inbound ( )
    -- | Stolen ( )
    -- | Turnover ( )


untag : SimState -> Model 
untag simstate =
    let
        untag_ state = 
            case state of
                Init s ->
                    StateMachine.untag s
                Tip s ->
                    StateMachine.untag s
                PassOnly s  ->
                    StateMachine.untag s
    in
        untag_ simstate


-- update functions
update : Event -> SimState -> SimState
update event state =
    state

-- mapPossession : (a -> b) -> {m | possessionModel : a } -> { m | possessionModel : b }
-- mapPossession fn =
--     \model ->
--         { model | possessionModel = fn model.possessionModel }

-- mapPlayModel : (a -> b) -> {m | playModel : a } -> {m | playModel : b } 
-- mapPlayModel fn old =
--     {old | playModel = fn old.playModel}

-- init : SimState
-- init = Init (State {}) 

tip : Model -> SimState
tip model = Tip <| State model 

toTipWithModel : Model -> State { tip: Allowed } m ->  SimState
toTipWithModel model state = Tip (State model ) 


-- updatePossession : (GameModel.PossessionModel -> GameModel.PossessionModel)
--                    -> State p Model
--                    -> State p Model
-- updatePossession fn state =
    -- StateMachine.map ( .playModel >> GameModel.possessionModel >> fn) state

-- updatePossession : (Model -> Model) -> State tran Model -> State tran Model
-- updatePossession fn 

toPassOnlyWithModel : State { passOnly : Allowed } m -> Model -> SimState
toPassOnlyWithModel state model =
    PassOnly ( State  model )

toPassOnly : State { passOnly : Allowed } Model -> SimState
toPassOnly (State model ) =
    PassOnly ( State model )

toTip : State { tip: Allowed} Model -> SimState
toTip (State m) = Tip <| State m


-- untag : State tag value -> value
-- untag = StateMachine.untag

{-- mapPossessionModel : (a->b) -> {m| possessionModel:a} -> {m| possessionModel:b}
mapPossessionModel fn ({possessionModel} as oldmodel) =
    {oldmodel | possessionModel = fn possessionModel}

 }--updateTipState : (PossessionModel -> PossessionModel) ->  
--} 



