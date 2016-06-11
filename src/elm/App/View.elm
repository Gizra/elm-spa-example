module App.View exposing (..)

import Html exposing (..)
import Html.App as Html
import App.Model as App exposing (Model, Page)
import App.Update exposing (Msg)
import Pages.Login.View exposing (view)


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
            Html.map App.Update.PageLogin (Pages.Login.View.view model.pageLogin)

        App.PageNotFound ->
            div [] [ text "PageNotFound page" ]
