module Pages.Login.Model exposing (..)

import Http
import User.Model exposing (User)


type alias AccessToken =
    String


type alias LoginForm =
    { name : String
    , pass : String
    }


type UserMessage
    = None
    | Error String


type alias Model =
    { loginForm : LoginForm
    }


type Msg
    = FetchFail (Http.Error String)
    | FetchSucceed (Http.Response AccessToken)
    | FetchUserSucceed AccessToken (Http.Response User)
    | SetName String
    | SetPassword String
    | TryLogin


emptyModel : Model
emptyModel =
    { loginForm = LoginForm "admin" "admin"
    }
