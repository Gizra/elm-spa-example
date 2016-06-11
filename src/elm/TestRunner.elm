module Main exposing (..)

import ElmTest exposing (..)
import App.Test as App exposing (..)


allTests : Test
allTests =
    suite "All tests"
        [ App.all
        ]


main : Program Never
main =
    runSuiteHtml allTests
