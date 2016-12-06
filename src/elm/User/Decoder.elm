module User.Decoder exposing (decodeFromGithub)

import Json.Decode exposing (nullable, string, Decoder)
import Json.Decode.Pipeline exposing (decode, required)
import User.Model exposing (..)


decodeFromGithub : Decoder User
decodeFromGithub =
    decode User
        |> required "avatar_url" string
        |> required "login" string
        |> required "name" (nullable string)
