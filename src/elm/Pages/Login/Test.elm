module Pages.Login.Test exposing (all)

import ElmTest exposing (..)
import Exts.RemoteData exposing (RemoteData(..), WebData)
import Pages.Login.Model exposing (..)
import Pages.Login.Update exposing (..)
import User.Model exposing (..)


setName : Test
setName =
    suite "setName msg"
        [ test "set name without spaces"
            (assertEqual "noSpaces" (getName "noSpaces"))
        , test "set name with space"
            (assertEqual "withSpaces" (getName "with Spaces"))
        , test "set name with multiple spaces"
            (assertEqual "withSpaces" (getName "  with   Spaces  "))
        , test "set name should result with NotAsked user status"
            (assertEqual NotAsked getUserStatusAfterSetName)
        ]


dummyUser : User
dummyUser =
    { name = "foo", avatarUrl = "https://example.com" }


getName : String -> String
getName name =
    let
        ( model, _, _ ) =
            update NotAsked (SetName name) emptyModel
    in
        model.name


getUserStatusAfterSetName : WebData User
getUserStatusAfterSetName =
    let
        ( _, _, user ) =
            update NotAsked (SetName "someName") emptyModel
    in
        user



{- Test the returned status after TryLogin msg. -}


tryLogin : Test
tryLogin =
    suite "TryLogin msg"
        [ test "Fetch empty name"
            (assertEqual NotAsked (getTryLogin NotAsked { name = "" }))
        ]


getTryLogin : WebData User -> Model -> WebData User
getTryLogin user model =
    let
        ( _, _, userStatus ) =
            update user TryLogin model
    in
        userStatus


all : Test
all =
    suite "Pages.Login tests"
        [ setName
        , tryLogin
        ]
