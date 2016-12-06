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
        , Decode.string
            |> Decode.andThen
                (\val ->
                    case String.toInt val of
                        Ok int ->
                            Decode.succeed int

                        Err _ ->
                            Decode.fail "Cannot convert string to integer"
                )
        ]


decodeError : Decoder String
decodeError =
    Decode.field "title" Decode.string
