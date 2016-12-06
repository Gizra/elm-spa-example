module Pages.Login.View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput, onSubmit)
import Pages.Login.Model exposing (..)
import RemoteData exposing (RemoteData(..), WebData)
import User.Model exposing (..)


view : WebData User -> Model -> Html Msg
view user model =
    let
        spinner =
            i [ class "notched circle loading icon" ] []

        ( isLoading, isError ) =
            case user of
                Loading ->
                    ( True, False )

                Failure _ ->
                    ( False, True )

                _ ->
                    ( False, False )

        inputClasses =
            classList
                [ ( "ui action input", True )
                , ( "error", isError )
                ]
    in
        Html.form
            [ onSubmit TryLogin
            , action "javascript:void(0);"
            , class "ui stacked segment"
            ]
            [ div [ inputClasses ]
                [ input
                    [ type_ "text"
                    , placeholder "Name"
                    , onInput SetName
                    , value model.loginForm.name
                    ]
                    []
                , input
                    [ type_ "password"
                    , placeholder "Password"
                    , onInput SetPassword
                    , value model.loginForm.pass
                    ]
                    []
                  -- Submit button
                , button
                    [ disabled isLoading
                    , class "ui primary button"
                    ]
                    [ span [ hidden <| not isLoading ] [ spinner ]
                    , span [ hidden isLoading ] [ text "Login" ]
                    ]
                ]
            ]
