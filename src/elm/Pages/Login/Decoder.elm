module Pages.Login.Decoder exposing (..)

import Base64 exposing (encode)
import Json.Decode as Decode
import Pages.Login.Model exposing (AccessToken)
import User.Decoder as UserDecoder exposing (decodeUser)
import User.Model exposing (User)


decodeUser : Decode.Decoder User
decodeUser =
    Decode.at [ "data", "0" ] <| UserDecoder.decodeUser


decodeAccessToken : Decode.Decoder AccessToken
decodeAccessToken =
    Decode.at [ "access_token" ] <| Decode.string


decodeError : Decode.Decoder String
decodeError =
    Decode.at [ "data", "error" ] <| Decode.string


encodeCredentials : ( String, String ) -> String
encodeCredentials ( name, pass ) =
    let
        base64 =
            Base64.encode (name ++ ":" ++ pass)
    in
        case base64 of
            Ok result ->
                result

            Err err ->
                ""
