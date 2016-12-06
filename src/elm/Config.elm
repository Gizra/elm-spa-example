module Config exposing (..)

import Config.Model as Config exposing (Model)
import Dict exposing (..)


local : Model
local =
    { backendUrl = "https://example.io"
    , name = "local"
    }


production : Model
production =
    { backendUrl = "https://api.example.io"
    , name = "gh-pages"
    }


configs : Dict String Model
configs =
    Dict.fromList
        [ ( "localhost", local )
        , ( "example", production )
        ]
