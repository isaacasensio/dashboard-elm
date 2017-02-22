module Tests exposing (..)

import Test exposing (..)
import RemainingDaysSpec
import CounterSpec
import ChartSpec


all : Test
all =
    describe "All"
        [ RemainingDaysSpec.all
        , CounterSpec.all
        , ChartSpec.all
        ]
