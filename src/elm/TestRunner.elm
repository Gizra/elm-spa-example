module Main exposing (..)

import ElmTest exposing (..)
import App.Test as App exposing (..)
import Pages.Login.Test as PagesLogin exposing (..)


allTests : Test
allTests =
    suite "All tests"
        [ App.all
        , PagesLogin.all
        ]


main : Program Never
main =
    runSuiteHtml allTests
