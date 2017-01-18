module Pages.Login.Model exposing (..)

import Http
import User.Model exposing (User)
import RemoteData exposing (WebData)


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
    = HandleFetchedAccessToken (WebData AccessToken)
    | HandleFetchedUser AccessToken (WebData User)
    | SetName String
    | SetPassword String
    | TryLogin


emptyModel : Model
emptyModel =
    { loginForm = LoginForm "demo" "1234"
    }
