module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import RemainingDays.Widget as RemainingDaysWidget
import RemainingDays.Model as RemainingDaysModel exposing (..)
import RemainingDays.Msg as RemainingDaysMsg exposing (..)
import RemainingDays.View as RemainingDaysView exposing (..)
import Date exposing (Month(..))
import Date.Extra as Date


-- MODEL


type alias AppModel =
    { widgetModel : RemainingDaysModel.Model
    }


todayWidgetModel : RemainingDaysModel.Model
todayWidgetModel =
    { startDate = Nothing
    , endDate = Just (Date.fromCalendarDate 2017 Mar 31)
    , description = "Days since last incident"
    }


initialModel : AppModel
initialModel =
    { widgetModel = todayWidgetModel
    }


init : ( AppModel, Cmd Msg )
init =
    ( initialModel, Cmd.none )



-- MESSAGES


type Msg
    = WidgetMsg RemainingDaysMsg.Msg



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
                                [ Html.map WidgetMsg (RemainingDaysView.view model.widgetModel) ]
                            , div [ class "tile is-child notification is-warning" ]
                                [ Html.map WidgetMsg (RemainingDaysView.view model.widgetModel) ]
                            ]
                        , div [ class "tile is-parent" ]
                            [ div [ class "tile is-child notification is-info" ]
                                [ Html.map WidgetMsg (RemainingDaysView.view model.widgetModel) ]
                            ]
                        ]
                    , div [ class "tile is-parent" ]
                        [ div [ class "tile is-child notification is-danger" ]
                            [ Html.map WidgetMsg (RemainingDaysView.view model.widgetModel) ]
                        ]
                    ]
                , div [ class "tile is-parent" ]
                    [ div [ class "tile is-child notification is-success" ]
                        [ Html.map WidgetMsg (RemainingDaysView.view model.widgetModel) ]
                    ]
                ]
            ]
        ]



-- UPDATE


update : Msg -> AppModel -> ( AppModel, Cmd Msg )
update message model =
    case message of
        WidgetMsg subMsg ->
            let
                ( updatedWidgetModel, widgetCmd ) =
                    RemainingDaysWidget.update subMsg model.widgetModel
            in
                ( { model | widgetModel = updatedWidgetModel }, Cmd.map WidgetMsg widgetCmd )



-- SUBSCRIPTIONS


subscriptions : AppModel -> Sub Msg
subscriptions model =
    Sub.batch
        [ Sub.map WidgetMsg (RemainingDaysWidget.subscriptions model.widgetModel) ]



-- APP


main : Program Never AppModel Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
