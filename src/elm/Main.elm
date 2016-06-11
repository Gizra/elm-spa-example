module Main exposing (..)

import App.Model exposing (Model)
import App.Update exposing (init, update, Msg)
import App.View exposing (view)
import Html.App as Html


main : Program Never
main =
    Html.program
        { init = App.Update.init
        , update = App.Update.update
        , view = App.View.view
        , subscriptions = subscriptions
        }



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
