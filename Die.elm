module Die exposing (..)

import Random


type alias Pair = (Int, Int)
type Set =
    Single Int
    | Set Pair
    | Set2 Pair Pair
    | Set3 Pair Pair Pair
    | Set4 Pair Pair Pair Pair

type DiceSet = DiceSet Pair
type DiceSet2 = DiceSet2 Pair Pair
type DiceSet3 = DiceSet3 Pair Pair Pair
type DiceSet4 = DiceSet4 Pair Pair Pair Pair



type Dice = Dice Int Int
          | Die Int

type alias Model =
    {
     dice : Dice
    }

throwSingle : ( Set -> msg ) -> Cmd msg
throwSingle msg =
    Random.generate msg randomSingleGenerator


throw : Int -> ( Set -> msg ) -> Cmd msg
throw n msg =
     case n of
        2 ->
            Random.generate msg (randomThrowGenerator 2) 
        3 ->
            Random.generate msg (randomThrowGenerator 3)
        4 ->
            Random.generate msg (randomThrowGenerator 4)
        _ ->
            Random.generate msg ( Random.map Set randomPairGenerator )

throw1Pair : (DiceSet -> msg) -> Cmd msg
throw1Pair msg =
    let
        generator = Random.map
                        DiceSet
                        randomPairGenerator
    in
        Random.generate msg generator

throw2Pair : (DiceSet2 -> msg) -> Cmd msg
throw2Pair msg =
    let
        generator = Random.map2
                        DiceSet2
                        randomPairGenerator
                        randomPairGenerator
    in
        Random.generate msg generator


throw3Pair : (DiceSet3 -> msg) -> Cmd msg
throw3Pair msg =
    let
        generator = Random.map3
                        DiceSet3
                        randomPairGenerator
                        randomPairGenerator
                        randomPairGenerator
    in
        Random.generate msg generator


throw4Pair : (DiceSet4 -> msg) -> Cmd msg
throw4Pair msg =
    let
        generator = Random.map4
                        DiceSet4
                        randomPairGenerator
                        randomPairGenerator
                        randomPairGenerator
                        randomPairGenerator
    in
        Random.generate msg generator






randomPairGenerator : Random.Generator Pair
randomPairGenerator =
    let
        a = Random.int 0 9
        b = Random.int 0 9
    in
        (Random.pair a b)

randomSingleGenerator : Random.Generator Set
randomSingleGenerator =
    Random.map Single (Random.int 0 9)

randomThrowGenerator : Int -> Random.Generator Set
randomThrowGenerator n =
    case n of
        1 ->
            Random.map Set randomPairGenerator
        2 ->
            Random.map2 Set2 randomPairGenerator randomPairGenerator
        3 ->
            Random.map3
                Set3
                randomPairGenerator
                randomPairGenerator
                randomPairGenerator
        4 ->
            Random.map4
                Set4
                randomPairGenerator
                randomPairGenerator
                randomPairGenerator
                randomPairGenerator
        _ ->
            Random.map Set randomPairGenerator



roll1 : ( Dice   -> msg ) -> Cmd msg
roll1 msg =
    let
        whiteDie = Random.int 0 9 
    in
    --Random.generate Roll <| Random.int 0 9
    Random.generate msg (Random.map Die whiteDie)
        

--roll2 : Random.Generator (Int,Int)
roll2 : ( Dice -> msg ) -> Cmd msg
roll2 msg =
    let
        a = Random.int 0 9
        b = Random.int 0 9

        foo : (Int,Int) -> Dice
        foo (r,w) =
            Dice r w
    in
        Random.generate msg (Random.map foo (Random.pair a b))


init : Model
init =
    {dice = Dice 0 0}


redDie : Model -> Maybe Int
redDie {dice} =
    case dice of
        Dice r w ->
            Just r
        _ ->
            Nothing

whiteDie : Model -> Int
whiteDie {dice} =
    case dice of
        Dice r w ->
            w
        Die w ->
            w

setDie : Int -> Model -> Model
setDie d model =
    { model | dice = Die  d }

setDice : Int -> Int -> Model -> Model
setDice r w model =
    { model | dice = Dice r w }


toInt : Model -> Int
toInt {dice} =
    case dice of
        Die w ->
            w
        Dice r w ->
            10 * r + w
