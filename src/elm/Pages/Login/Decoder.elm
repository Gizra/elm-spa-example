module Pages.Login.Decoder exposing (decode)

import Json.Decode exposing ((:=))
import Json.Decode.Extra exposing ((|:))
import Pages.Login.Model exposing (Github)


decode : Json.Decode.Decoder Github
decode =
    Json.Decode.succeed Github
        |: ("avatar_url" := Json.Decode.string)
        |: ("login" := Json.Decode.string)
