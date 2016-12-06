module Pages.Login.Update exposing (fetchUserFromBackend, update)

import Config.Model exposing (BackendUrl)
import HttpBuilder exposing (..)
import Task
import User.Model exposing (..)
import Pages.Login.Model as Login exposing (..)
import Pages.Login.Decoder exposing (..)
import RemoteData exposing (RemoteData(..), WebData)
import Utils.WebData exposing (sendWithHandler)


update : BackendUrl -> Msg -> Model -> ( Model, Cmd Msg, ( WebData User, AccessToken ) )
update backendUrl msg model =
    case msg of
        HandleFetchedAccessToken webDataAccessToken ->
            let
                accessToken =
                    Maybe.withDefault "" <| RemoteData.toMaybe webDataAccessToken
            in
                ( model
                , fetchUserFromBackend backendUrl accessToken
                , ( NotAsked, accessToken )
                )

        HandleFetchedUser accessToken webDataUser ->
            ( model
            , Cmd.none
            , ( webDataUser, accessToken )
            )

        SetName name ->
            let
                loginForm =
                    model.loginForm

                loginForm_ =
                    { loginForm | name = name }
            in
                ( { model | loginForm = loginForm_ }
                , Cmd.none
                , ( NotAsked, "" )
                )

        SetPassword pass ->
            let
                loginForm =
                    model.loginForm

                loginForm_ =
                    { loginForm | pass = pass }
            in
                ( { model | loginForm = loginForm_ }
                , Cmd.none
                , ( NotAsked, "" )
                )

        TryLogin ->
            ( model
            , fetchAccessTokenFromBackend backendUrl model.loginForm
            , ( Loading, "" )
            )


{-| Get access token from backend.
-}
fetchAccessTokenFromBackend : BackendUrl -> LoginForm -> Cmd Msg
fetchAccessTokenFromBackend backendUrl loginForm =
    let
        credentials =
            encodeCredentials ( loginForm.name, loginForm.pass )
    in
        HttpBuilder.get (backendUrl ++ "/api/login-token")
            |> withHeader "Authorization" ("Basic " ++ credentials)
            |> sendWithHandler decodeAccessToken HandleFetchedAccessToken


{-| Get user data from backend.
-}
fetchUserFromBackend : BackendUrl -> String -> Cmd Msg
fetchUserFromBackend backendUrl accessToken =
    let
        url =
            HttpBuilder.url (backendUrl ++ "/api/me") [ ( "access_token", accessToken ) ]
    in
        HttpBuilder.get url
            |> sendWithHandler decodeUser HandleFetchedUser
