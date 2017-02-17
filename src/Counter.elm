module Counter exposing (Model, initialModel, Msg(SetNum, NoOp), view, update)

import Html exposing (..)
import Html.Attributes exposing (..)


type alias Model =
    { count : Int, description : String }


type Msg
    = SetNum Int
    | NoOp



-- MODEL


initialModel : Model
initialModel =
    Model 0 "Counter"


init : ( Model, Cmd Msg )
init =
    ( initialModel, Cmd.none )



-- UPDATE


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model

        SetNum num ->
            { model | count = num }



-- VIEWS


view : Model -> Html Msg
view model =
    div []
        [ p []
            [ h2 [ class "title is-2" ] [ text (model.description) ]
            , p [ class "days-left" ] [ text (toString (model.count)) ]
            ]
        ]
