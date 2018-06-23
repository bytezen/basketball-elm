import Html exposing (Html, text, div, h1, button)

import Player exposing (Position, Position(..))
import Team exposing (Team)

import GameInit as Init
import GameState exposing (GameState)
import GameEvent exposing (Event )
import SimState exposing (SimState) 
import GameModel as GM
import Team exposing ( Side(..))
import Player exposing (Player)
import Simulation

import View.GameView as GameView
import View.SimulationView as SimulationView

type alias Die = Int
type alias PossessionModel =
    {
     possession : Side
    ,position : Position
    }


type alias Model =
    {
     gameState : GameState
    ,simState : SimState
    ,eventModel : GM.EventModel
    -- ,gameModel : GM.GameModel
    -- ,teamDefinition : GM.TeamDefinition
    -- ,playState : GM.PlayState
    }
type alias Roll = (Die, Die)

type Msg =
         Noop 
         | Jumpball
         | Pass Player
         | Done
         | SimResult GameEvent.Event

init : (Model, Cmd Msg) 
init =
    {
    gameState = GameState.init { gameModel = Init.initGameModel }
    ,simState = SimState.tip { playModel = Init.initPlayModel }
    ,eventModel = Init.initEventModel 
    -- ,teamDefinition = Init.initTeamDefinition
    -- ,playState = Init.initPlayState
    }
    ! []


view : Model -> Html Msg
view ( {gameState,simState,eventModel} as model ) =
    let
        gameView = GameView.view gameState
                   |> Html.map (always Noop) 

        simulationView = SimulationView.view model
                       |> Html.map simulationViewToMsg  
    in
        div []
            [
             h1 [] [text "Basketball Gen"]
            ,gameView
            ,simulationView
            ]

simulationViewToMsg : SimulationView.Msg -> Msg
simulationViewToMsg msg =
    case msg of
        SimulationView.Jumpball ->
            Jumpball

-- consoleView : Model -> Html Msg 
-- consoleView model =
--     let
--         adaptor : View.Console.ModelAdaptor Model
--         adaptor = always {playState = model.playState
--                          ,simState = model.simState
--                          ,eventModel = model.eventModel
--                          }

--         (position,player) = GM.possession model.playState

--         translator : View.Console.TranslatorDict Msg
--         translator =
--             {
--                 -- onDone = always Noop
--                 onTip = always Jumpball
--                 ,onPass =always <| Pass player 
--             }
--     in
--         View.Console.view (adaptor model) translator


-- setupView : Model -> Html Msg
-- setupView model =
--     let
--         transfn : View.Setup.Translator Msg
--         transfn = always (StateTransition GameState.ToSetup)
--     in
--         View.Setup.view { onTip = always (StateTransition GameState.ToPlay) } 


-- initView : Model -> Html Msg
-- initView model =
--     let
--         adaptor : View.Init.ModelAdaptor Model
--         adaptor {teamDefinition, playState} =
--             {
--                  homeTeam = teamDefinition.homeTeam
--                 ,awayTeam = teamDefinition.awayTeam
--                 ,homeLineup = playState.homeLineup
--                 ,awayLineup = playState.awayLineup
--             }

--         translator : View.Init.TranslatorDict Msg 
--         translator =
--             let
--                 transfn = always Noop

--             in
--                 {
--                   onChooseHomeTeam = transfn
--                 , onChooseAwayTeam = transfn
--                 , onChooseHomeLineup = transfn
--                 , onChooseAwayLineup = transfn
--                 -- , onDone = always JumpballAndTransition () 
--                 , onDone = always (StateTransition GameState.ToSetup)
--                 }
--     in
--        View.Init.view (adaptor model) translator

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    let
        { playModel } = SimState.untag model.simState
    in
    case msg of
        Noop ->
            (model,Cmd.none) 
        -- Delay ->
        --     (model, Cmd.none)
        Jumpball  ->
            (model
            , (Cmd.map SimResult <| Simulation.jumpball playModel )
            )
        Pass player ->
           (model
           , ( Cmd.map SimResult <| Simulation.pass playModel  )
           )

        -- StateTransition stateTransition ->
        Done ->
            {model |
                 gameState = GameState.update model.gameState
            } ! []

            -- case (model.state, stateTransition) of
            --     (GameState.Init initState, GameState.ToSetup) ->
            --         {model | state = GameState.toSetupWithModel
            --                              model
            --                              initState
            --         } ! []

            --     -- when going to play from setup do a jumpball
            --     (GameState.Setup setupState, GameState.ToPlay) ->
            --         { model | state = GameState.toPlayWithModel
            --              model
            --              setupState
            --         }
            --     ! [Cmd.map SimResult <| Simulation.jumpball model.playState] 

            --     _ ->
            --         (model, Cmd.none)

        SimResult ((GameEvent.Event  play) as event) ->
            { model |
                  simState = SimState.update event model.simState
                  ,eventModel = model.eventModel ++ [event]
            } ! []
                        

                -- Simulation.Pass playerPosTuple ->
                --     updateSimulationAfterPass playerPosTuple model

                -- Simulation.Turnover player ->
                --     Debug.crash "Simulation.Turnover not implemented"

                -- Simulation.Foul player ->
                --     Debug.crash "Simulation.Foul not implemented"

                -- Simulation.Injury player ->
                --     Debug.crash "Simulation.Injury not implemented"

                -- Simulation.Special ->
                --     Debug.crash "Simulation.Special not implemented"


-- updateSimulationAfterJumpball : (Side,Position) -> Model -> (Model, Cmd Msg)
-- updateSimulationAfterJumpball (side, pos) model =
--     let
--         lineup = case side of
--                      Home -> model.playState.homeLineup
--                      Away -> model.playState.awayLineup

--         player = Lineup.position lineup pos

--         nextPossession =
--             { onBall = (pos, player)
--             , side = side
--             , passCount = model.playState.possessionModel.passCount
--             , minPasses = 2 -- 2 passes after tip
--             }


--         nextPlayState =
--             { homeLineup = model.playState.homeLineup
--             , awayLineup = model.playState.awayLineup
--             , possessionModel = nextPossession
--             }

--         nextModel =
--                   { model | playState = nextPlayState}

--         event = GameEvent.jumpball (side,pos) 

--         nextEventModel = model.eventModel ++ [event]
--     in
--         case model.simState of
--             SimState.Tip state ->
--                 { model |
--                       simState =
--                            SimState.toPassOnly
--                            <| (SimState.updatePossession
--                                    (always nextPossession)
--                                    state)
--                       ,playState = nextPlayState

--                       ,eventModel = nextEventModel
--                 } ! []
--             _ ->
                -- Debug.crash "jumpball simulation in wrong state. Check to see if you have the correct simulation state when running a jumpball"


-- updateSimulationAfterPass : (Player,Position) -> Model -> (Model, Cmd msg)
-- updateSimulationAfterPass (player,receiverPos) model =
--     let
--         playerPos = GM.possession model.playState |> Tuple.first

--         receiver = GM.offensePlayer receiverPos model.playState

--         possessionModel = model.playState.possessionModel

--         playState = model.playState

--         nextPossession =
--             { possessionModel
--                 | onBall = (receiverPos, receiver)
--                 , passCount = possessionModel.passCount + 1
--             }

--         nextPlaystate =
--             { playState
--                 | possessionModel = nextPossession
--             }

--         event = GameEvent.pass (playerPos, player) (receiverPos, receiver)
--     in
--         {model
--             | playState = nextPlaystate
--             , eventModel = model.eventModel ++ [event]
--         } ! []
    

{--
handleMainMessage : Msg -> Model -> (Model, Cmd Msg)
handleMainMessage msg model =
    case msg of
        Initialize ->
--}


main : Program Never Model Msg
main = Html.program
       {   view = view
          ,init = init
          ,update = update
          ,subscriptions = always Sub.none
       }


