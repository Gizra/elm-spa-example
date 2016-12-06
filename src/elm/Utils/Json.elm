module Utils.Json
    exposing
        ( decodeInt
        , decodeError
        )

import Json.Decode as Decode exposing (int, string, Decoder)
import String


{-| Cast String to Int.
-}
decodeInt : Decoder Int
decodeInt =
    Decode.oneOf
        [ Decode.int
          -- @todo: Needs to be re-added
          -- , Decode.customDecoder Decode.string String.toInt
        ]


decodeError : Decoder String
decodeError =
    Decode.field "title" Decode.string
