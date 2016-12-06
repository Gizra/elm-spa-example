module Pages.Login.Model exposing (emptyModel, Model)


type alias Model =
    { name : String
    , pass : String
    }


type Msg
    = FetchFail Http.Error
    | FetchSucceed User
    | SetLogin String
    | TryLogin


emptyModel : Model
emptyModel =
    { name = "admin"
    , pass = "admin"
    }
