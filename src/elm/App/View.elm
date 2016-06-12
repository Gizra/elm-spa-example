module App.View exposing (..)

import Exts.RemoteData exposing (..)
import Html exposing (..)
import Html.Attributes exposing (class, classList, href, src, style, target)
import Html.App as Html
import Html.Events exposing (onClick)
import App.Model exposing (..)
import App.Update exposing (..)
import Pages.Login.Model exposing (Github)
import Pages.Login.View exposing (..)
import Pages.PageNotFound.View exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ div [ class "ui container" ]
            [ viewHeader model
            , viewMainContent model
            , pre [] [ text <| toString model ]
            ]
        , viewFooter
        ]


viewHeader : Model -> Html Msg
viewHeader model =
    let
        navbar =
            case model.pageLogin.github of
                Success _ ->
                    navbarAuthenticated

                _ ->
                    navbarAnonymous
    in
        div [ class "ui secondary pointing menu" ] (navbar model)


navbarAnonymous : Model -> List (Html Msg)
navbarAnonymous model =
    [ a
        [ classByPage Login model.activePage
        , onClick <| SetActivePage Login
        ]
        [ text "Login" ]
    , viewPageNotFoundItem model.activePage
    ]


navbarAuthenticated : Model -> List (Html Msg)
navbarAuthenticated model =
    [ a
        [ classByPage Login model.activePage
        , onClick <| SetActivePage Login
        ]
        [ text "My Account" ]
    , viewPageNotFoundItem model.activePage
    , div [ class "right menu" ]
        [ viewAvatar model.pageLogin.github
        , a
            [ class "ui item"
            , onClick <| Logout
            ]
            [ text "Logout" ]
        ]
    ]


viewPageNotFoundItem : Page -> Html Msg
viewPageNotFoundItem activePage =
    a
        [ classByPage PageNotFound activePage
        , onClick <| SetActivePage PageNotFound
        ]
        [ text "404 page" ]


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
            Html.map PageLogin (Pages.Login.View.view model.pageLogin)

        PageNotFound ->
            -- We don't need to pass any cmds, so we can call the view directly
            Pages.PageNotFound.View.view


viewFooter : Html Msg
viewFooter =
    div
        [ class "ui inverted vertical footer segment form-page"
        , style
            [ ( "position", "absolute" )
            , ( "bottom", "0" )
            , ( "width", "100%" )
            ]
        ]
        [ div [ class "ui container" ]
            [ a
                [ href "http://gizra.com"
                , target "_blank"
                ]
                [ text "Gizra" ]
            , span [] [ text " // " ]
            , a
                [ href "https://github.com/amitaibu/elm-spa-exmple"
                , target "_blank"
                ]
                [ text "Github" ]
            ]
        ]


{-| Get menu items classes. This function gets the active page and checks if
it is indeed the page used.
-}
classByPage : Page -> Page -> Attribute a
classByPage page activePage =
    classList
        [ ( "item", True )
        , ( "active", page == activePage )
        ]
