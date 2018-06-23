module Player exposing (..)


type alias Shooting =
    {
      fg2 : Rating
    , fg3 : Rating
    , ft  : Rating
    , fg3Max : Rating
    }

type alias Ratings =
    {
      block : Rating
    , defense : Rating
    , foul : Rating
    , injury : Rating
    , pass : Rating
    , rebound : Rating
    , stamina : Rating
    , steal : Rating
    }

type Rating = Range Int Int
            | Rating Int

type alias Player =
    {
     name : String
    ,position : String 
    ,rating : Ratings
    ,shooting : Shooting
    ,team : String
    }

type Position = 
              PG | SG | PF | SF | C  

intRating : Rating -> Int
intRating  = minRating

minRating : Rating -> Int
minRating r =
    case r of
        Range x y ->
            x
        Rating x ->
            x

maxRating : Rating -> Int
maxRating r =
    case r of
        Range x y ->
            y
        Rating x ->
            x

defaultShooting : { fg2 : Rating, fg3 : Rating, fg3Max : Rating, ft : Rating }
defaultShooting =
    { fg2 = Rating 50
    , fg3 = Rating 50
    , ft = Rating 50
    , fg3Max = Rating 5
    }

defaultRatings :
    { block : Rating
    , defense : Rating
    , foul : Rating
    , injury : Rating
    , pass : Rating
    , rebound : Rating
    , stamina : Rating
    , steal : Rating
    }
defaultRatings =
    {
      pass = Rating 50
    , steal = Rating 50
    , rebound = Rating 50
    , block = Rating 50
    , defense = Rating 50
    , stamina = Rating 50
    , foul = Rating 50
    , injury = Rating 50
    }
{--
type alias Stats =
    { games : Int
    , starts : Int
    , points : Float
    , rebound : Float
    , assists : Float
    , steals : Float
    , blocks : Float
    , fouls : Float
    , minutes : Float
    }
--}

positionToString : Position -> String
positionToString p =
    case p of
        PG -> "PG"
        SG -> "SG"
        SF -> "SF"
        PF -> "PF"
        C -> "C"

anon : Player
anon = { name = "John Doe"
       , position = "guard"
       , team = "Development Celtics"
       , rating = defaultRatings
       , shooting = defaultShooting
       }

name : Player -> String
name = .name 

team : Player -> String
team = .team

position : Player -> String
position = .position

passRating : Player -> Int
passRating  =
    .rating >> .pass >> intRating 

stealRating : Player -> Int
stealRating  =
    .rating >> .steal >> intRating 

reboundRating : Player -> Int
reboundRating  =
    .rating >> .rebound >> intRating 

blockRating : Player -> Int
blockRating  =
    .rating >> .block >> intRating 

defenseRating : Player -> Int
defenseRating  =
    .rating >> .defense >> intRating 

staminaRating : Player -> Int
staminaRating  =
    .rating >> .stamina >> intRating 

foulRating : Player -> Int
foulRating  =
    .rating >> .foul >> intRating 

injuryRating : Player -> Int
injuryRating  =
    .rating >> .injury  >> intRating

fg2Rating : Player -> Int
fg2Rating =
    .shooting >> .fg2 >> intRating

fg3Rating : Player -> Int
fg3Rating =
    .shooting >> .fg3 >> intRating

ftRating : Player -> Int
ftRating =
    .shooting >> .ft >> intRating

fg3MaxRating : Player -> Int
fg3MaxRating =
    .shooting >> .fg3Max >> intRating

{--
createPlayer : { a |  name:String, team:String, position:String, rating: Rating, shooting: Shooting} -> Player
createPlayer info =
    Player {
            name = info.name
           ,team = info.team
           ,position = info.position
           ,rating = info.rating
           ,shooting = info.shooting
        }
--}

{--
shooting : Player -> Shooting
shooting (Player {shooting}) = shooting

rating : Player -> Ratings
rating (Player {rating}) = rating
--}

