module RemainingDays.Model exposing (remaining, Model, initialModel, updateTodayDate)

import Date exposing (..)
import Date exposing (Month(..))
import Date.Extra exposing (..)
import Time exposing (Time, minute, second)


type alias Model =
    { startDate : Maybe Date
    , endDate : Maybe Date
    , description : String
    }


initialModel : Model
initialModel =
    Model Nothing Nothing "Title"


updateTodayDate : Model -> Time -> Model
updateTodayDate model time =
    { model | startDate = Just (Date.fromTime time) }


remaining : Model -> Int
remaining model =
    case model.startDate of
        Nothing ->
            0

        Just startDate ->
            case model.endDate of
                Nothing ->
                    0

                Just endDate ->
                    Date.Extra.diff Day startDate endDate
