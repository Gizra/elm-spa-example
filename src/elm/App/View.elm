module App.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, classList)
import Html.App as Html
import Html.Events exposing (onClick)
import App.Model exposing (..)
import App.Update exposing (..)
import Pages.Login.View exposing (view)


view : Model -> Html Msg
view model =
    div []
        [ viewHeader model
        , viewMainContent model
        ]


viewHeader : Model -> Html Msg
viewHeader model =
    div [ class "ui secondary pointing menu" ] (navbarLoggedIn model)



-- div []
--     [ text "Main app"
--     , navbarLoggedIn model
--     ]


navbarLoggedIn : Model -> List (Html Msg)
navbarLoggedIn model =
    let
        classByPage page =
            classList
                [ ( "item", True )
                , ( "active", page == model.activePage )
                ]
    in
        [ a
            [ classByPage Login
            , onClick <| SetActivePage Login
            ]
            [ text "My Account" ]
        , a
            [ classByPage PageNotFound
            , onClick <| SetActivePage PageNotFound
            ]
            [ text "404 page" ]
        , div [ class "right menu" ]
            [ a
                [ class "ui item"
                , onClick <| Logout
                ]
                [ text "Logout" ]
            ]
        ]


viewMainContent : Model -> Html Msg
viewMainContent model =
    case model.activePage of
        Article ->
            div [] [ text "Article page" ]

        Login ->
            Html.map App.Update.PageLogin (Pages.Login.View.view model.pageLogin)

        PageNotFound ->
            div [] [ text "PageNotFound page" ]
