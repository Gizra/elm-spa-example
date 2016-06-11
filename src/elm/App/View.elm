module App.View exposing (..)

import Html exposing (..)
import App.Model as App exposing (Model, Page)
import App.Update exposing (Msg)


view : Model -> Html Msg
view model =
    div []
        [ viewHeader model
        , viewMainContent model
        ]


viewHeader : Model -> Html Msg
viewHeader model =
    div [] [ text "Main app" ]


viewMainContent : Model -> Html Msg
viewMainContent model =
    case model.activePage of
        App.Article ->
            div [] [ text "Article page" ]

        App.Login ->
            div [] [ text "Login page" ]

        App.PageNotFound ->
            div [] [ text "PageNotFound page" ]
