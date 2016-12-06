module Config.View exposing (..)

import Html exposing (div, h2, text, Html)
import Html.Attributes exposing (class)


-- A plain function that always returns the error message


view : Html msg
view =
    div
        [ class "config-error" ]
        [ h2 [] [ text "Configuration error" ]
        , div [] [ text "Check your Config.elm file and make sure you have defined the enviorement properly" ]
        ]
