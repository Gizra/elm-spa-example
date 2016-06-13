module Pages.Login.Update exposing (update, Msg(..))

import Exts.RemoteData exposing (..)
import Http
import String exposing (isEmpty)
import Task
import User.Decoder exposing (..)
import User.Model exposing (..)
import Pages.Login.Model as Login exposing (..)


type Msg
    = FetchFail Http.Error
    | FetchSucceed User
    | SetName String
    | TryLogin


init : ( Model, Cmd Msg )
init =
    emptyModel ! []


update : Msg -> Model -> ( Model, Cmd Msg, WebData User )
update action model =
    case action of
        FetchSucceed github ->
            ( model, Cmd.none, Success github )

        FetchFail err ->
            ( model, Cmd.none, Failure err )

        SetName name ->
            ( { model | name = name }, Cmd.none, NotAsked )

        TryLogin ->
            if isEmpty model.name then
                ( model, Cmd.none, NotAsked )
            else
                ( model, tryLogin model.name, Loading )


tryLogin : String -> Cmd Msg
tryLogin name =
    let
        url =
            "https://api.github.com/users/" ++ name
    in
        Task.perform FetchFail FetchSucceed (Http.get decodeFromGithub url)
