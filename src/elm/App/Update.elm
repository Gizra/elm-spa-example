module App.Update exposing (..)

import App.Model as App exposing (emptyModel, Model)
import Pages.Login.Update exposing (Msg)


type Msg
    = NoOp
    | PageLogin Pages.Login.Update.Msg


init : ( Model, Cmd Msg )
init =
    emptyModel ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of
        NoOp ->
            model ! []

        PageLogin msg ->
            let
                ( val, cmds ) =
                    Pages.Login.Update.update msg model.pageLogin
            in
                ( { model | pageLogin = val }
                , Cmd.map PageLogin cmds
                )
