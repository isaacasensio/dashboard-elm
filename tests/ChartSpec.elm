module ChartSpec exposing (..)

import Test exposing (..)
import Expect
import Chart exposing (initialModel)
import List exposing (length)


all : Test
all =
    describe "Chart Spec"
        [ test "Initial chart data should be empty" <|
            \() ->
                Expect.equal 0 (length initialModel.dataSet)
        , test "Initial chart size should be 100x50" <|
            \() ->
                Expect.equal { width = 100, height = 50 } initialModel.canvas
        ]
