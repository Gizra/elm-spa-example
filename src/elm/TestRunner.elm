module Main exposing (..)

import ElmTest exposing (..)
import CounterTest exposing (all)


allTests : Test
allTests =
    suite "All tests"
        [ CounterTest.all
        ]


main : Program Never
main =
    runSuiteHtml allTests
