port module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Counter
import RemainingDays
import Chart
import Time exposing (Time, minute, hour, second)
import Date.Extra as Date
import Date exposing (Month(..))
import Task exposing (..)


port toJs : List Int -> Cmd msg



-- MODEL


type alias AppModel =
    { counterModel : Counter.Model
    , remainingDaysModel : RemainingDays.Model
    , chartModel : Chart.Model
    }


counterModel : Counter.Model
counterModel =
    Counter.Model 1 "My Counter"


remainingDatesModel : RemainingDays.Model
remainingDatesModel =
    RemainingDays.Model
        Nothing
        (Just (Date.fromCalendarDate 2017 Mar 31))
        "My Remaining days"


initialModel : AppModel
initialModel =
    { counterModel = counterModel
    , remainingDaysModel = remainingDatesModel
    , chartModel = Chart.initialModel
    }


init : ( AppModel, Cmd Msg )
init =
    ( initialModel
    , Task.perform UpdateRemainingDaysMsg Time.now
    )



-- MESSAGES


type Msg
    = InitCounterMsg Counter.Msg
    | UpdateCounterMsg Time
    | InitRemainingDaysMsg RemainingDays.Msg
    | UpdateRemainingDaysMsg Time
    | ChartMsg Time
    | InitChartMsg Chart.Msg



-- VIEW


view : AppModel -> Html Msg
view model =
    div [ class "container" ]
        [ div [ class "container" ]
            [ div [ class "tile is-ancestor" ]
                [ div [ class "tile is-vertical is-8" ]
                    [ div [ class "tile" ]
                        [ div [ class "tile is-parent is-vertical" ]
                            [ div [ class "tile is-child notification is-primary" ]
                                [ Html.map InitCounterMsg (Counter.view model.counterModel) ]
                            , div [ class "tile is-child notification is-warning" ]
                                [ Html.map InitRemainingDaysMsg (RemainingDays.view model.remainingDaysModel) ]
                            ]
                        , div [ class "tile is-parent" ]
                            [ div [ class "tile is-child notification is-info" ]
                                [ Html.map InitCounterMsg (Counter.view model.counterModel) ]
                            ]
                        ]
                    , div [ class "tile is-parent" ]
                        [ div [ class "tile is-child notification is-danger" ]
                            [ Html.map InitChartMsg (Chart.view model.chartModel) ]
                        ]
                    ]
                , div [ class "tile is-parent" ]
                    [ div [ class "tile is-child notification is-success" ]
                        [ Html.map InitCounterMsg (Counter.view model.counterModel) ]
                    ]
                ]
            ]
        ]



-- UPDATE


update : Msg -> AppModel -> ( AppModel, Cmd Msg )
update message model =
    case message of
        ChartMsg time ->
            let
                ( chartModel, cmdMsg ) =
                    Chart.update (Chart.GetData time) model.chartModel
            in
                ( { model | chartModel = chartModel }, toJs (model.chartModel.dataSet) )

        UpdateCounterMsg _ ->
            let
                counter =
                    (model.counterModel.count + 1)
            in
                ( { model | counterModel = Counter.update (Counter.SetNum counter) model.counterModel }, Cmd.none )

        UpdateRemainingDaysMsg time ->
            ( { model | remainingDaysModel = RemainingDays.update (RemainingDays.Update time) model.remainingDaysModel }, Cmd.none )

        InitCounterMsg _ ->
            ( { model | counterModel = Counter.update Counter.NoOp model.counterModel }, Cmd.none )

        InitRemainingDaysMsg _ ->
            ( { model | remainingDaysModel = RemainingDays.update (RemainingDays.NoOp) model.remainingDaysModel }, Cmd.none )

        InitChartMsg _ ->
            let
                ( chartModel, cmdMsg ) =
                    Chart.update Chart.NoOp model.chartModel
            in
                ( { model | chartModel = chartModel }, Cmd.none )



-- SUBSCRIPTIONS


fiveSeconds : Time
fiveSeconds =
    5 * second


subscriptions : AppModel -> Sub Msg
subscriptions model =
    Sub.batch
        [ Time.every minute UpdateCounterMsg
        , Time.every minute UpdateRemainingDaysMsg
        , Time.every fiveSeconds ChartMsg
        ]



-- APP


main : Program Never AppModel Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
