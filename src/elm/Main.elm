module Main exposing (..)

import App.Model exposing (Flags, Model, Msg)
import App.Update exposing (init, update)
import App.View exposing (view)
import Html


main : Program Flags Model Msg
main =
    Html.programWithFlags
        { init = App.Update.init
        , update = App.Update.update
        , view = App.View.view
        , subscriptions = subscriptions
        }



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
