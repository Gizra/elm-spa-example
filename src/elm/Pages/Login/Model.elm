module Pages.Login.Model exposing (emptyModel, Model)


type alias Model =
    { name : String
    }


emptyModel : Model
emptyModel =
    { name = ""
    }
