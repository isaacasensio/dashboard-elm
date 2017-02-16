module RemainingDays.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import RemainingDays.Model exposing (Model, initialModel, remaining)
import RemainingDays.Msg exposing (Msg)


view : Model -> Html Msg
view model =
    div []
        [ p []
            [ h2 [ class "title is-2" ] [ text (model.description) ]
            , p [ class "days-left" ] [ text (toString (remaining model) |> String.toUpper) ]
            ]
        ]
