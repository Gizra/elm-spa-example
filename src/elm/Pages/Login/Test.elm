module Pages.Login.Test exposing (all)

import ElmTest exposing (..)
import Pages.Login.Model exposing (..)
import Pages.Login.Update exposing (..)


setName : Test
setName =
    suite "setName msg"
        [ test "set name without spaces"
            (assertEqual "noSpaces" (getName "noSpaces"))
        , test "set name wit space"
            (assertEqual "withSpaces" (getName "with Spaces"))
        , test "set name with multiple spaces"
            (assertEqual "withSpaces" (getName "  with   Spaces  "))
        ]


getName : String -> String
getName name =
    let
        ( model, _, _ ) =
            update (SetName name) emptyModel
    in
        model.name


all : Test
all =
    suite "Pages.Login tests"
        [ setName
        ]
