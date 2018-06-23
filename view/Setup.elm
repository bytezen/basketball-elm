module View.Setup exposing
    (view, Msg(..), Msg, Translator, TranslatorDict )

import Html exposing (..)
import Html.Events exposing (onClick)

 
type Msg = Done 

type alias Translator msg = (Msg -> msg)

type alias TranslatorDict msg =
    {
    onTip :  Translator msg
    }

{--
type alias Model =
    {
        homeTeam : Team
        ,homeLineup : Lineup
        ,awayTeam : Team
        ,awayLineup : Lineup
    }

type alias ModelAdaptor a =
    a -> Model
--}

--view : {m | definition: TeamDefinition } -> Translator msg -> Html msg
view : TranslatorDict msg -> Html msg
view {onTip} =
    div []
        [
         h1 [] [text "View.Setup"]
        ,h1 [] [text "all setup now it is time for tip off"]
        ,button [onClick <| onTip Done] [text "Play (jumpball)!"]]


{--       
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
                     show (Player.positionToLabel pos) name 
                )
    in
        div [] (mapLineupNames <| Lineup.names lineup)

viewTeam : Team -> Html msg
viewTeam (Team.Team {abbr}) =
    h4 [] [text abbr]

--}
