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
        , test "set name should result with NotAsked user status if name changed"
            (assertEqual NotAsked (getUserStatusAfterSetName Loading "someName" emptyModel))
        , test "set name should result with existing user status if name didn't change"
            (assertEqual Loading (getUserStatusAfterSetName Loading "  someName  " { name = "someName" }))
        ]


dummyUser : User
dummyUser =
    { name = "Foo", login = "foo", avatarUrl = "https://example.com" }


getName : String -> String
getName name =
    let
        ( model, _, _ ) =
            update NotAsked (SetName name) emptyModel
    in
        model.name


getUserStatusAfterSetName : WebData User -> String -> Model -> WebData User
getUserStatusAfterSetName user name model =
    let
        ( _, _, user ) =
            update user (SetName name) model
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
