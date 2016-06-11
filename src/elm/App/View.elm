module App.View exposing (..)

import Exts.RemoteData exposing (..)
import Html exposing (..)
import Html.Attributes exposing (class, classList, src)
import Html.App as Html
import Html.Events exposing (onClick)
import App.Model exposing (..)
import App.Update exposing (..)
import Pages.Login.Model exposing (Github)
import Pages.Login.View exposing (view)


view : Model -> Html Msg
view model =
    div [ class "ui container" ]
        [ viewHeader model
        , viewMainContent model
        , pre [] [ text <| toString model ]
        ]


viewHeader : Model -> Html Msg
viewHeader model =
    div [ class "ui secondary pointing menu" ] (navbarLoggedIn model)


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
            [ viewAvatar model.pageLogin.github
            , a
                [ class "ui item"
                , onClick <| Logout
                ]
                [ text "Logout" ]
            ]
        ]


viewAvatar : WebData Github -> Html Msg
viewAvatar github =
    case github of
        Success github' ->
            a
                [ onClick <| SetActivePage Login
                , class "ui item"
                ]
                [ img
                    [ class "ui avatar image"
                    , src github'.avatar_url
                    ]
                    []
                ]

        _ ->
            div [] []


viewMainContent : Model -> Html Msg
viewMainContent model =
    case model.activePage of
        Article ->
            div [] [ text "Article page" ]

        Login ->
            Html.map App.Update.PageLogin (Pages.Login.View.view model.pageLogin)

        PageNotFound ->
            div [] [ text "PageNotFound page" ]
