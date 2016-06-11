module Pages.Login.Model exposing (..)


type alias Model =
    { avatar : String
    , name : String
    }


emptyModel : Model
emptyModel =
    { avatar = ""
    , name = ""
    }
