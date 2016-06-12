module App.Router exposing (delta2url, location2messages)

import App.Model exposing (..)
import App.Update exposing (..)
import Navigation exposing (Location)
import RouteUrl exposing (HistoryEntry(..), UrlChange)


delta2url : Model -> Model -> Maybe UrlChange
delta2url previous current =
    case current.activePage of
        Login ->
            Just <| UrlChange NewEntry "/#login"

        MyAccount ->
            Just <| UrlChange NewEntry "/#my-account"

        PageNotFound ->
            Nothing


location2messages : Location -> List Msg
location2messages location =
    case Debug.log "location" location.hash of
        "#login" ->
            [ SetActivePage Login ]

        "#my-account" ->
            [ SetActivePage MyAccount ]

        "#404" ->
            [ SetActivePage PageNotFound ]

        _ ->
            []
