module RemainingDays exposing (Model, Msg(Update, NoOp), view, update, remaining, updateTodayDate)

import Html exposing (..)
import Html.Attributes exposing (..)
import Date exposing (..)
import Date exposing (Month(..))
import Date.Extra exposing (..)
import Time exposing (Time, minute, second)


type alias Model =
    { startDate : Maybe Date
    , endDate : Maybe Date
    , description : String
    }


type Msg
    = Update Time
    | NoOp



-- MODEL


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



-- UPDATE


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model

        Update time ->
            { model | startDate = Just (Date.fromTime time) }



-- VIEWS


view : Model -> Html Msg
view model =
    div []
        [ p []
            [ h2 [ class "title is-2" ] [ text (model.description) ]
            , p [ class "days-left" ] [ text (toString (remaining model)) ]
            ]
        ]
