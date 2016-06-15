module Pages.Login.Update exposing (update, Msg(..))

import Exts.RemoteData exposing (..)
import Http
import Regex exposing (regex, replace, HowMany(All))
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


update : WebData User -> Msg -> Model -> ( Model, Cmd Msg, WebData User )
update user msg model =
    case msg of
        FetchSucceed github ->
            ( model, Cmd.none, Success github )

        FetchFail err ->
            ( model, Cmd.none, Failure err )

        SetName name ->
            let
                noSpacesName =
                    replace All (regex " ") (\_ -> "") name
            in
                ( { model | name = noSpacesName }, Cmd.none, NotAsked )

        TryLogin ->
            -- Try to fetch the user from GitHub only if it was not asked yet.
            -- In case we are still loading, error or a succesful fetch we don't
            -- want to repeat it.
            case user of
                NotAsked ->
                    if isEmpty model.name then
                        -- Name was not asked, however it is empty.
                        ( model, Cmd.none, NotAsked )
                    else
                        -- Fetch the name from GitHub, and indicate we are
                        -- in the middle of "Loading".
                        ( model, tryLogin model.name, Loading )

                _ ->
                    -- We are not in "NotAsked" state, so return the existing
                    -- value
                    ( model, Cmd.none, user )


tryLogin : String -> Cmd Msg
tryLogin name =
    let
        url =
            "https://api.github.com/users/" ++ name
    in
        Task.perform FetchFail FetchSucceed (Http.get decodeFromGithub url)
