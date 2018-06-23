module Temp exposing (..)

type Result a b = Result a b

type Pass = Pass 
type Shot = Shot

biz : Result Pass b -> b
biz (Result Pass x) =
    x 

bas : x -> y -> Result x y
bas x y =
    Result x y 

bar : y -> x -> Result x y
bar y x =
    Result x y
