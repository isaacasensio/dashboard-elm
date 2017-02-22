module Chart exposing (Model, initialModel, Msg(GetData, NoOp), view, update)

import Html exposing (..)
import Html.Attributes exposing (..)
import Date exposing (Month(..))
import Time exposing (Time, minute, hour, second)


type alias Model =
    { dataSet : List Int
    , canvas : { width : Int, height : Int }
    }


type Msg
    = GetData Time
    | NoOp


initialModel : Model
initialModel =
    Model [] { width = 100, height = 50 }


addDataElement : Model -> Int -> Model
addDataElement model value =
    let
        newDataSet =
            if List.length model.dataSet < 50 then
                model.dataSet ++ [ value ]
            else
                List.drop 1 model.dataSet ++ [ value ]
    in
        { model | dataSet = newDataSet }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetData time ->
            let
                value =
                    Date.second (Date.fromTime time)
            in
                ( addDataElement model value, Cmd.none )

        NoOp ->
            ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ canvas
            [ width model.canvas.width
            , height model.canvas.height
            , id "updating-chart"
            ]
            []
        ]
