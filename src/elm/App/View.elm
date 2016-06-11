module App.View exposing (..)

import Html exposing (..)
import Html.App as Html
import Html.Events exposing (onClick)
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
    div []
        [ text "Main app"
        , navbarLoggedIn model
        ]


navbarLoggedIn : Model -> Html Msg
navbarLoggedIn model =
    ul []
        [ li [ onClick <| App.Update.SetActivePage App.Login ] [ text "Login" ]
        , li [ onClick <| App.Update.SetActivePage App.PageNotFound ] [ text "Page not found (404)" ]
        ]


viewMainContent : Model -> Html Msg
viewMainContent model =
    case model.activePage of
        App.Article ->
            div [] [ text "Article page" ]

        App.Login ->
            Html.map App.Update.PageLogin (Pages.Login.View.view model.pageLogin)

        App.PageNotFound ->
            div [] [ text "PageNotFound page" ]
