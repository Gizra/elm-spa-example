module Pages.Login.View exposing (view)

import Exts.RemoteData exposing (RemoteData(..), WebData)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput, onSubmit)
import User.Model exposing (..)
import Pages.Login.Model exposing (..)
import Pages.Login.Update exposing (..)


view : WebData User -> Model -> Html Msg
view user model =
    let
        spinner =
            i [ class "notched circle loading icon" ] []

        isLoading =
            case user of
                Loading ->
                    True

                _ ->
                    False
    in
        Html.form
            [ onSubmit TryLogin
            , action "javascript:void(0);"
            , class "ui form stacked segment"
            ]
            [ div [ class "ui action input" ]
                [ input
                    [ type' "text"
                    , placeholder "Github name"
                    , onInput SetLogin
                    , value model.login
                    ]
                    []
                  -- Submit button
                , button
                    [ onClick TryLogin
                    , disabled isLoading
                    , class "ui primary button"
                    ]
                    [ span [ hidden <| not isLoading ] [ spinner ]
                    , span [ hidden isLoading ] [ text "Login" ]
                    ]
                ]
            ]
