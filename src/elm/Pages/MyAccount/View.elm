module Pages.MyAccount.View exposing (view)

import Exts.RemoteData exposing (..)
import Html exposing (a, div, h2, i, p, text, Html)
import Html.Attributes exposing (class, href)
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
    in
        div [ class "ui icon message" ]
            [ i [ class "user icon" ]
                []
            , div [ class "content" ]
                [ text <| "Welcome " ++ name
                , p [] [ text "This is an account page" ]
                ]
            ]
