module App.Model exposing (emptyModel, Model, Page(..))

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
    | PageLogin Pages.Login.Update.Msg
    | SetActivePage Page


type alias Model =
    { activePage : Page
    , pageLogin : Pages.Login.Model.Model
    , user : WebData User
    }


emptyModel : Model
emptyModel =
    { activePage = Login
    , pageLogin = Pages.Login.Model.emptyModel
    , user = NotAsked
    }
