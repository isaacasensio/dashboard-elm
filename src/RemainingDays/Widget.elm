module RemainingDays.Widget exposing (..)

import Time exposing (Time, minute, second)
import RemainingDays.Model exposing (Model, initialModel, remaining, updateTodayDate)
import RemainingDays.Msg exposing (Msg)


-- MODEL


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RemainingDays.Msg.Tick newTime ->
            ( updateTodayDate model newTime, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every Time.second RemainingDays.Msg.Tick
