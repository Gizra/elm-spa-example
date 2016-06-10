module App.View exposing (..)

import Html exposing (..)
import App.Model as App exposing (Model)
import App.Update exposing (Msg)


view : Model -> Html Msg
view model =
    div []
        [ text "Main app"
        ]
