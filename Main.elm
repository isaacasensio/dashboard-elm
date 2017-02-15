module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import RemainingDaysWidget as Widget
import Date exposing (Month(..))
import Date.Extra as Date


-- MODEL


type alias AppModel =
    { widgetModel : Widget.Model
    }


todayWidgetModel : Widget.Model
todayWidgetModel =
    { startDate = Nothing
    , endDate = Just (Date.fromCalendarDate 2017 Feb 18)
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
    = WidgetMsg Widget.Msg



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
                                [ Html.map WidgetMsg (Widget.view model.widgetModel) ]
                            , div [ class "tile is-child notification is-warning" ]
                                []
                            ]
                        , div [ class "tile is-parent" ]
                            [ div [ class "tile is-child notification is-info" ]
                                []
                            ]
                        ]
                    , div [ class "tile is-parent" ]
                        [ div [ class "tile is-child notification is-danger" ]
                            []
                        ]
                    ]
                , div [ class "tile is-parent" ]
                    [ div [ class "tile is-child notification is-success" ]
                        []
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
                    Widget.update subMsg model.widgetModel
            in
                ( { model | widgetModel = updatedWidgetModel }, Cmd.map WidgetMsg widgetCmd )



-- SUBSCRIPTIONS


subscriptions : AppModel -> Sub Msg
subscriptions model =
    Sub.batch
        [ Sub.map WidgetMsg (Widget.subscriptions model.widgetModel) ]



-- APP


main : Program Never AppModel Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
