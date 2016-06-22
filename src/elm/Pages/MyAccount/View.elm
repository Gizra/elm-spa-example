module Pages.MyAccount.View exposing (view)

import Exts.RemoteData exposing (RemoteData(..), WebData)

import Html exposing (a, div, h2, i, p, text, img, Html)
import Html.Attributes exposing (class, href, src)
import User.Model exposing (..)


-- VIEW


view : WebData User -> Html a
view user =
    let
        name =
            case user of
                Success user' ->
                    user'.name

                _ ->
                    ""
        login =
            case user of
                Success user' ->
                    user'.login

                _ ->
                    ""
        avatar =
            case user of
                Success user' ->
                    img
                        [ class "ui medium circular image"
                        , src user'.avatarUrl
                        ]
                        []

                _ ->
                    i [ class "user icon" ]
                      []
    in
        div [ class "ui icon message" ]
            [ avatar
            , div [ class "ui label content" ]
                [ text <| "Welcome " ++ name ++ " (" ++ login ++ ")"
                , p [] [ text "This is an account page" ]
                ]
            ]
