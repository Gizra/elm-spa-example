module App.View exposing (..)

import RemoteData exposing (RemoteData(..), WebData)
import Html exposing (..)
import Html.Attributes exposing (class, classList, href, src, style, target)
import Html.App as Html
import Html.Events exposing (onClick)
import App.Model exposing (..)
import App.Update exposing (..)
import User.Model exposing (..)
import Pages.Login.View exposing (..)
import Pages.MyAccount.View exposing (..)
import Pages.PageNotFound.View exposing (..)


view : Model -> Html Msg
view model =
    div []
        [ div [ class "ui container main" ]
            [ viewHeader model
            , viewMainContent model
            , pre [ class "ui padded secondary segment" ]
                [ div [] [ text <| "activePage: " ++ toString model.activePage ]
                , div [] [ text <| "pageLogin: " ++ toString model.pageLogin ]
                , div [] [ text <| "user: " ++ toString model.user ]
                ]
            ]
        , viewFooter
        ]


viewHeader : Model -> Html Msg
viewHeader model =
    let
        navbar =
            case model.user of
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
        [ classByPage MyAccount model.activePage
        , onClick <| SetActivePage MyAccount
        ]
        [ text "My Account" ]
    , viewPageNotFoundItem model.activePage
    , div [ class "right menu" ]
        [ viewAvatar model.user
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


viewAvatar : WebData User -> Html Msg
viewAvatar user =
    case user of
        Success user_ ->
            a
                [ onClick <| SetActivePage MyAccount
                , class "ui item"
                ]
                [ img
                    [ class "ui avatar image"
                    , src user_.avatarUrl
                    ]
                    []
                ]

        _ ->
            div [] []


viewMainContent : Model -> Html Msg
viewMainContent model =
    case model.activePage of
        AccessDenied ->
            div [] [ text "Access denied" ]

        Login ->
            Html.map PageLogin (Pages.Login.View.view model.user model.pageLogin)

        MyAccount ->
            Pages.MyAccount.View.view model.user

        PageNotFound ->
            -- We don't need to pass any cmds, so we can call the view directly
            Pages.PageNotFound.View.view


viewFooter : Html Msg
viewFooter =
    div
        [ class "ui inverted vertical footer segment form-page"
        ]
        [ div [ class "ui container" ]
            [ a
                [ href "http://gizra.com"
                , target "_blank"
                ]
                [ text "Gizra" ]
            , span [] [ text " // " ]
            , a
                [ href "https://github.com/Gizra/elm-spa-example"
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
