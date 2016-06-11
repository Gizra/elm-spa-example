module App.Test exposing (all)

import ElmTest exposing (..)
import App.Model exposing (..)
import App.Update exposing (..)


setActivePage : Test
setActivePage =
    suite "SetActivePage msg"
        [ test "set new active page" (assertEqual PageNotFound (getPage PageNotFound))
        ]


getPage : Page -> Page
getPage page =
    update (SetActivePage page) emptyModel |> fst |> .activePage


all : Test
all =
    suite "App tests"
        [ setActivePage
        ]
