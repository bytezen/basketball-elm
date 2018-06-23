module GameModel exposing (..)

import Lineup exposing (..)
import Player exposing (Position,Player )
import Team exposing (Side, Side(..), Team)
import GameEvent exposing (Event)

type alias PlayModel =
    {
      homeLineup : Lineup
    , awayLineup : Lineup
    , possessionModel: PossessionModel
    }

type alias PossessionModel =
    {
      onBall : (Position, Player)
    , side : Side  
    , passCount : Int
    , minPasses : Int
    }


type alias GameModel =
    {
      plays : Int
    , quarterLength : Int
    , quarter : Int
    , homeTimeouts : Int
    , awayTimeouts : Int
    , homeFouls : Int
    , awayFouls : Int
    , homeScore : Int
    , awayScore : Int
    , homeTeam : Team
    , awayTeam : Team
    }


type alias EventModel = List GameEvent.Event  


-- update functions

mapPossession : (a -> b) -> {m| possessionModel : a } -> {m| possessionModel : b }
mapPossession fn =
    \model ->
        { model | possessionModel = fn model.possessionModel }


mapPlayModel : (a -> b) -> {m| playModel : a } -> { m| playModel : b }
mapPlayModel fn model =
        { model | playModel = fn model.playModel }


mapGamemodel : (a -> b) -> {m| gameModel : a } -> { m| gameModel : b }
mapGamemodel fn =
    \model ->
        { model | gameModel = fn model.gameModel }


updatePlayModel : (PlayModel -> PlayModel)
                  -> {m| playModel:PlayModel}
                  -> {m| playModel:PlayModel}
updatePlayModel = mapPlayModel


updatePossession : (PossessionModel -> PossessionModel)
                    -> {m| playModel:PlayModel}
                    -> {m| playModel:PlayModel}
updatePossession fn model =
    let
        oldPlayModel = model.playModel
        newPlayModel = { oldPlayModel
                           | possessionModel = fn oldPlayModel.possessionModel
                       }

    in
        updatePlayModel (always newPlayModel) model



-- utility functions
-- pass : Position -> PlayModel -> PlayModel
-- pass pos =
--     let
--         newOnBall (position,player) model = { model | onBall = (pos, player) }
--     in
--         \{playModel} ->
--             updatePossession
--                 (newOnBall (pos, offensePlayer pos oldmodel))
--                 oldmodel

possessionModel : Position -> Player -> Side -> Int -> PossessionModel
possessionModel pos player side passThreshold =
    {
      onBall = (pos,player)
    , side = side
    , passCount = 0
    , minPasses = passThreshold 
    }


sideToLineup : Side -> PlayModel -> Lineup
sideToLineup side {homeLineup,awayLineup,possessionModel} =
    case side of
        Home -> homeLineup
        Away -> awayLineup

possession : PlayModel -> ( Position, Player )
possession {possessionModel} =
    .onBall possessionModel

pass : Position -> PlayModel -> PlayModel
pass pos ( {possessionModel,homeLineup, awayLineup} as playModel ) =
    let
        player = Lineup.player pos ( offenseLineup playModel )

        newModel =
            updatePossession
                (\model ->
                   { model | onBall = (pos, player)}
                )
                { playModel=playModel }
    in
        .playModel newModel

offenseLineup : PlayModel -> Lineup
offenseLineup ( {possessionModel} as playModel ) =
    sideToLineup possessionModel.side playModel

offensePlayer : Position -> PlayModel -> Player
offensePlayer pos playModel =
    let
        lineup = offenseLineup playModel
    in
        Lineup.player pos lineup 

defenseLineup : PlayModel -> Lineup
defenseLineup ( {possessionModel} as playModel )=
    case possessionModel.side of
        Home ->
            sideToLineup Away playModel
        Away ->
            sideToLineup Home playModel


defensePlayer : Position -> PlayModel -> Player
defensePlayer pos playModel =
    let
        lineup = defenseLineup playModel
    in
        Lineup.player pos lineup



