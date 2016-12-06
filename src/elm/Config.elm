module Config exposing (..)

import Config.Model as Config exposing (Model)
import Dict exposing (..)


local : Model
local =
    { backendUrl = "https://live-hedley-elm.pantheonsite.io"
    , name = "local"
    }


production : Model
production =
    { backendUrl = "https://live-hedley-elm.pantheonsite.io"
    , name = "gh-pages"
    }


configs : Dict String Model
configs =
    Dict.fromList
        [ ( "localhost", local )
        , ( "example", production )
        ]
