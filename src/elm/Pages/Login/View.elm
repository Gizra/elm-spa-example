module Pages.Login.View exposing (..)

import Html exposing (..)
import Pages.Login.Model exposing (Model)
import Pages.Login.Update exposing (Msg)


view : Model -> Html Msg
view model =
    div []
        [ text "Login page"
        ]
