module Pages.Login.Model exposing (..)

import HttpBuilder
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
    = FetchFail (HttpBuilder.Error String)
    | FetchSucceed (HttpBuilder.Response AccessToken)
    | FetchUserSucceed AccessToken (HttpBuilder.Response User)
    | SetName String
    | SetPassword String
    | TryLogin


emptyModel : Model
emptyModel =
    { loginForm = LoginForm "admin" "admin"
    }
