module Pages.Login.Update exposing (..)

import Exts.RemoteData exposing (..)
import Http
import Task
import Pages.Login.Decoder exposing (decode)
import Pages.Login.Model as Login exposing (emptyModel, Github, Model)


type Msg
    = FetchFail Http.Error
    | FetchSucceed Github
    | SetName String
    | TryLogin


init : ( Model, Cmd Msg )
init =
    emptyModel ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of
        FetchSucceed github ->
            { model | github = Success github } ! []

        FetchFail _ ->
            model ! []

        SetName name ->
            model ! []

        TryLogin ->
            model ! [ tryLogin model.name ]


tryLogin : String -> Cmd Msg
tryLogin name =
    let
        url =
            "https://api.github.com/users/" ++ name
    in
        Task.perform FetchFail FetchSucceed (Http.get decode url)
