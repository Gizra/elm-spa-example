module Utils.WebData exposing (sendWithHandler, viewError)

import HttpBuilder exposing (..)
import Json.Decode exposing (Decoder)
import RemoteData exposing (RemoteData(..), WebData)
import Html exposing (..)
import Http
import Task


{-| Provide some `Html` to view an error message.
-}
viewError : Http.Error -> Html any
viewError error =
    case error of
        Http.BadUrl message ->
            div [] [ text "URL is not valid." ]

        Http.BadPayload message _ ->
            div []
                [ p [] [ text "The server responded with data of an unexpected type." ]
                , p [] [ text message ]
                ]

        Http.NetworkError ->
            div [] [ text "There was a network error." ]

        Http.Timeout ->
            div [] [ text "The network request timed out." ]

        Http.BadStatus response ->
            div []
                [ div [] [ text "The server indicated the following error:" ]
                , div [] [ text response.status.message ]
                ]


{-| This is a convenience for the common pattern where we build a request with
`HttpBuilder` and want to handle the result as a `WebData a`.
-}
sendWithHandler : Decoder a -> (WebData a -> msg) -> RequestBuilder b -> Cmd msg
sendWithHandler decoder tagger builder =
    builder
        |> withExpect (Http.expectJson decoder)
        |> toRequest
        |> RemoteData.sendRequest
        |> Cmd.map tagger
