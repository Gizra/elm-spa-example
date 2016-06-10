module Counter exposing (..)

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)


-- MODEL


type alias Model =
    Int


initialModel : Model
initialModel =
    0


init : ( Model, Cmd Msg )
init =
    ( initialModel
    , Cmd.none
    )



-- UPDATE


type Msg
    = Decrement
    | Increment


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of
        Decrement ->
            ( model - 1
            , Cmd.none
            )

        Increment ->
            ( model + 1
            , Cmd.none
            )



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ button [ onClick Decrement ] [ text "-" ]
        , div [ countStyle ] [ text (toString model) ]
        , button [ onClick Increment ] [ text "+" ]
        ]


countStyle : Attribute msg
countStyle =
    style
        [ ( "font-size", "20px" )
        , ( "font-family", "monospace" )
        , ( "display", "inline-block" )
        , ( "width", "50px" )
        , ( "text-align", "center" )
        ]
