module User.Model exposing (..)


type alias User =
    { avatarUrl : String
    , login : String
    , name : Maybe.Maybe String
    }
