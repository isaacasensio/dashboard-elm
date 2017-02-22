module CounterSpec exposing (..)

import Test exposing (..)
import Expect
import Counter exposing (Model, initialModel, Msg(SetNum, NoOp), update)


all : Test
all =
    describe "Counter Spec"
        [ test "Initial counter should be set to zero at the startup" <|
            \() ->
                Expect.equal 0
                    (update NoOp initialModel).count
        , test "Any update message should set the count value" <|
            \() ->
                Expect.equal 11
                    (update (SetNum 11) initialModel).count
        ]
