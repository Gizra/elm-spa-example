module Pages.Login.View exposing (view)

import Exts.RemoteData exposing (..)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput, onSubmit)
import User.Model exposing (..)
import Pages.Login.Model exposing (..)
import Pages.Login.Update exposing (..)


view : WebData User -> Model -> Html Msg
view user model =
    case user of
        Success _ ->
            viewAuthenticated user model

        _ ->
            viewAnonymous user model


viewAnonymous : WebData User -> Model -> Html Msg
viewAnonymous user model =
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


viewAuthenticated : WebData User -> Model -> Html Msg
viewAuthenticated user model =
    let
        name =
            case user of
                Success user' ->
                    user'.name

                _ ->
                    ""
    in
        div [ class "ui icon message" ]
            [ i [ class "user icon" ]
                []
            , div [ class "content" ]
                [ text <| "Welcome " ++ name
                , p [] [ text "This is an account page" ]
                ]
            ]
