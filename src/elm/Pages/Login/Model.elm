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
    = HandleFetchedAccessToken (Result Http.Error AccessToken)
    | HandleFetchedUser AccessToken (Result Http.Error User)
    | SetName String
    | SetPassword String
    | TryLogin


emptyModel : Model
emptyModel =
    { loginForm = LoginForm "demo" "1234"
    }
