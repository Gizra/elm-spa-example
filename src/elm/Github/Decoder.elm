module Github.Decoder exposing (..)

import Json.Encode
import Json.Decode exposing ((:=))
import Json.Decode.Extra exposing ((|:))
import Github.Model exposing (Model)


decodeGithubUser : Json.Decode.Decoder Model
decodeGithubUser =
    Json.Decode.succeed Model
        |: ("avatar_url" := Json.Decode.string)
        |: ("login" := Json.Decode.string)


encodeGithubUser : Model -> Json.Encode.Value
encodeGithubUser record =
    Json.Encode.object
        [ ( "avatar_url", Json.Encode.string <| record.avatar_url )
        , ( "login", Json.Encode.string <| record.login )
        ]
