module Pages.Login.View exposing (..)

import Exts.RemoteData exposing (..)
import Html exposing (..)
import Html.Attributes exposing (action, class, disabled, height, hidden, placeholder, required, type', value, width)
import Html.Events exposing (onClick, onInput, onSubmit)
import Pages.Login.Model exposing (..)
import Pages.Login.Update exposing (..)


view : Model -> Html Msg
view model =
    let
        spinner =
            i [ class "notched circle loading icon" ] []

        isLoading =
            case model.github of
                Loading ->
                    True

                _ ->
                    False

        avatar_url =
            case model.github of
                Success github ->
                    github.avatar_url

                _ ->
                    ""
    in
        Html.form
            [ onSubmit TryLogin
            , action "javascript:void(0);"
            , class "ui form"
            ]
            [ div [ class "field" ]
                [ label [] [ text "GitHub Name" ]
                , input
                    [ type' "text"
                    , placeholder "Name"
                    , onInput SetName
                    , value model.name
                    ]
                    []
                ]
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
