module RemainingDaysWidget exposing (..)

import Html exposing (..)
import Time exposing (Time, minute, second)
import Date exposing (..)
import Date exposing (Month(..))
import Date.Extra exposing (..)


-- MODEL


type alias Model =
    { startDate : Maybe Date
    , endDate : Maybe Date
    }


initialModel : Model
initialModel =
    Model Nothing Nothing


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



-- UPDATE


type Msg
    = Tick Time


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick newTime ->
            ( updateTodayDate model newTime, Cmd.none )


updateTodayDate : Model -> Time -> Model
updateTodayDate model time =
    { model | startDate = Just (Date.fromTime time) }



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every Time.second Tick



-- VIEW


remainingDays : Model -> Int
remainingDays model =
    case model.endDate of
        Nothing ->
            0

        Just endDate ->
            case model.startDate of
                Nothing ->
                    0

                Just startDate ->
                    Date.Extra.diff Day startDate endDate


view : Model -> Html Msg
view model =
    div []
        [ p []
            [ h2 [] [ text (toString (remainingDays model)) ]
            ]
        ]
