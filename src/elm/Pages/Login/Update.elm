module Pages.Login.Update exposing (..)

import Pages.Login.Model as Login exposing (emptyModel, Model)


type Msg
    = GetAvatar
    | SetName String
    | UpdateAvatar


init : ( Model, Cmd Msg )
init =
    emptyModel ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of
        GetAvatar ->
            model ! []

        SetName name ->
            model ! []

        UpdateAvatar ->
            model ! []
