module Pages.Login.Update exposing (update, Msg(..))

import Exts.RemoteData exposing (RemoteData(..), WebData)
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

        SetName login ->
            let
                -- Remove spaces from login.
                noSpacesName =
                    replace All (regex " ") (\_ -> "") login

                userStatus =
                    getUserStatusFromNameChange user model.login noSpacesName
            in
                ( { model | login = noSpacesName }, Cmd.none, userStatus )

        TryLogin ->
            let
                ( cmd, userStatus ) =
                    getCmdAndUserStatusForTryLogin user model.login
            in
                ( model, cmd, userStatus )


{-| Try to fetch the user from GitHub only if it was not asked yet.
In case we are still loading, error or a succesful fetch we don't want to repeat
it.
-}
getCmdAndUserStatusForTryLogin : WebData User -> String -> ( Cmd Msg, WebData User )
getCmdAndUserStatusForTryLogin user login =
    case user of
        NotAsked ->
            if isEmpty login then
                -- login was not asked, however it is empty.
                ( Cmd.none, NotAsked )
            else
                -- Fetch the login from GitHub, and indicate we are
                -- in the middle of "Loading".
                ( fetchFromGitHub login, Loading )

        _ ->
            -- We are not in "NotAsked" state, so return the existing
            -- value
            ( Cmd.none, user )


{-| Determine if the user status should change after setting a new name.
When there is a valid name change, status should change to NotAsked.
However if for example a user just tried to add a space to the name, so after
triming it's actually the same. Thus, we avoid changing the user status to
prevent from re-fetching a possibly wrong name.
For example. if the user status would have been Failure, the existing name is
"foo" and user tried to pass "foo " (notice the trailing space), then in fact no
change should happen.
-}
getUserStatusFromNameChange : WebData User -> String -> String -> WebData User
getUserStatusFromNameChange user currentName newName =
    if currentName == newName then
        user
    else
        NotAsked


{-| Get data from GitHub.
-}
fetchFromGitHub : String -> Cmd Msg
fetchFromGitHub login =
    let
        url =
            "https://api.github.com/users/" ++ login
    in
        Task.perform FetchFail FetchSucceed (Http.get decodeFromGithub url)
