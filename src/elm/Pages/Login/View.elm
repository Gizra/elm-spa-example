module Pages.Login.View exposing (..)

import Exts.RemoteData exposing (..)
import Html exposing (..)
import Html.Attributes exposing (action, class, disabled, height, hidden, placeholder, required, src, type', width)
import Html.Events exposing (onClick, onInput, onSubmit)
import Pages.Login.Model exposing (..)
import Pages.Login.Update exposing (..)


view : Model -> Html Msg
view model =
    let
        spinner =
            i [ class "fa fa-spinner fa-spin" ] []

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
            ]
            [ input [ type' "text", placeholder "Name", onInput SetName ] []
              -- Submit button
            , button
                [ onClick TryLogin
                  -- , class "btn btn-lg btn-primary btn-block"
                  -- , disabled (isFetchStatus || isFormEmpty)
                ]
                [ span [ hidden <| not isLoading ] [ spinner ]
                , span [ hidden isLoading ] [ text "Login" ]
                ]
            , viewAvatar model.github
            , pre [] [ text <| toString model ]
            ]


viewAvatar : WebData Github -> Html Msg
viewAvatar github =
    case github of
        Success github' ->
            img
                [ height 100
                , width 100
                , src github'.avatar_url
                ]
                []

        _ ->
            div [] []
