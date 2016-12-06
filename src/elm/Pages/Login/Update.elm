module Pages.Login.Update exposing (fetchUserFromBackend, update)

import Config.Model exposing (BackendUrl)
import HttpBuilder exposing (..)
import Task
import User.Model exposing (..)
import Pages.Login.Model as Login exposing (..)
import Pages.Login.Decoder exposing (..)
import RemoteData exposing (RemoteData(..), WebData)


update : BackendUrl -> Msg -> Model -> ( Model, Cmd Msg, ( WebData User, AccessToken ) )
update backendUrl msg model =
    case msg of
        FetchSucceed response ->
            let
                accessToken =
                    response.data
            in
                ( model, fetchUserFromBackend backendUrl accessToken, ( NotAsked, accessToken ) )

        FetchUserSucceed accessToken response ->
            ( model
            , Cmd.none
            , ( Success response.data, accessToken )
            )

        FetchFail err ->
            ( model
            , Cmd.none
            , ( Failure err, "" )
            )

        SetName name ->
            let
                loginForm =
                    model.loginForm

                loginForm' =
                    { loginForm | name = name }
            in
                ( { model | loginForm = loginForm' }
                , Cmd.none
                , ( NotAsked, "" )
                )

        SetPassword pass ->
            let
                loginForm =
                    model.loginForm

                loginForm' =
                    { loginForm | pass = pass }
            in
                ( { model | loginForm = loginForm' }
                , Cmd.none
                , ( NotAsked, "" )
                )

        TryLogin ->
            ( model
            , fetchFromBackend backendUrl model.loginForm
            , ( Loading, "" )
            )


{-| Get data from backend.
-}
fetchFromBackend : BackendUrl -> LoginForm -> Cmd Msg
fetchFromBackend backendUrl loginForm =
    let
        credentials =
            encodeCredentials ( loginForm.name, loginForm.pass )

        httpTask =
            HttpBuilder.get (backendUrl ++ "/api/login-token")
                |> withHeader "Authorization" ("Basic " ++ credentials)
                |> send (jsonReader decodeAccessToken) (jsonReader decodeError)
    in
        Task.perform FetchFail FetchSucceed httpTask


{-| Get data from backend.
-}
fetchUserFromBackend : BackendUrl -> String -> Cmd Msg
fetchUserFromBackend backendUrl accessToken =
    let
        url =
            HttpBuilder.url (backendUrl ++ "/api/me") [ ( "access_token", accessToken ) ]

        httpTask =
            HttpBuilder.get url
                |> send (jsonReader decodeUser) stringReader
    in
        Task.perform FetchFail (FetchUserSucceed accessToken) httpTask
