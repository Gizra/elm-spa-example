module App.Model exposing (emptyModel, Flags, Msg(..), Model, Page(..))

import Config.Model
import Pages.Login.Model exposing (emptyModel, Model)
import RemoteData exposing (RemoteData(..), WebData)
import User.Model exposing (..)


type Page
    = AccessDenied
    | Login
    | MyAccount
    | PageNotFound


type Msg
    = Logout
    | PageLogin Pages.Login.Model.Msg
    | SetActivePage Page


type alias Model =
    { accessToken : String
    , activePage : Page
    , config : RemoteData String Config.Model.Model
    , pageLogin : Pages.Login.Model.Model
    , user : WebData User
    }


type alias Flags =
    { accessToken : String
    , hostname : String
    }


emptyModel : Model
emptyModel =
    { accessToken = ""
    , activePage = Login
    , config = NotAsked
    , pageLogin = Pages.Login.Model.emptyModel
    , user = NotAsked
    }
