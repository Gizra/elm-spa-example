module App.Model exposing (emptyModel, Model, Page(..))

import Exts.RemoteData exposing (..)
import User.Model exposing (..)
import Pages.Login.Model exposing (emptyModel, Model)


type Page
    = Login
    | MyAccount
    | PageNotFound


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
