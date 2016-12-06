module Utils.WebData exposing (WebData, viewError, sendWithHandler)

import HttpBuilder exposing (..)
import Json.Decode exposing (Decoder)
import RemoteData exposing (RemoteData(..), WebData)
import Html exposing (..)
import Http
import Task


{-| Provide some `Html` to view an error message.
-}
viewError : Http.Error String -> Html any
viewError error =
    case error of
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
                , div [] [ text response.data ]
                ]


{-| This is a convenience for the common pattern where we build a request with
`HttpBuilder` and want to handle the result as a `WebData a`. So, consider someting
like this:

    type alias Model =
        -- Amongst other fields ...
        { liveSessionId : WebData LiveSessionId
        }

    type Msg
        -- Amongst other messages
        = HandleFetchedId (WebData LiveSessionId)

    -- The point is that the `update` method can now be very simple, since what
    -- is passed to `HandleFetchedId` will already be the `WebData ...` we want
    update : Msg -> Model -> (Model, Cmd Msg)
    update msg model =
        case msg of
            HandleFetchedId id ->
                { model | liveSessionId = id } ! []

    -- Given the format of the JSON returned by the server, this picks out the
    -- thing of the type we're interested in
    decodeLiveSessionId : Decode.Decoder LiveSessionId
    decodeLiveSessionId =
        Decode.at [ "data", "live_session" ] decodeInt

    -- You just need to build the `RequestBuilder`, and then call `sendWithHandler`
    fetchFromBackend =
        HttpBuilder.post
            |> -- whatever you need to finish the `RequestBuilder`
            |> sendWithHandler decodeLiveSessionId HandleFetchedId
-}
sendWithHandler : Decoder a -> (WebData a -> msg) -> RequestBuilder -> Cmd msg
sendWithHandler decoder tagger builder =
    builder
        -- First, constract the `Task` from the `RequestBuilder`
        |>
            send (jsonReader decoder) stringReader
        -- Then, on success, extract the decoded data that `HttpBuilder`
        -- wraps in a `Response`.
        |>
            Task.map .data
        -- Then, use `RemoteData` to turn success or failure into the
        -- appropriate kind of `WebData`
        |>
            RemoteData.asCmd
        -- Finally, feed it back into our app with the appropriate `Msg`
        |>
            Cmd.map tagger
