module App.Update exposing (..)

import App.Model as App exposing (emptyModel, Model)


type Msg
    = NoOp


init : ( Model, Cmd Msg )
init =
    emptyModel ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of
        NoOp ->
            model ! []
