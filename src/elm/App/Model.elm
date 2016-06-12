module App.Model exposing (emptyModel, Model, Page(..))

import Pages.Login.Model exposing (emptyModel, Model)


type Page
    = Article
    | Login
    | PageNotFound


type alias Model =
    { activePage : Page
    , pageLogin : Pages.Login.Model.Model
    }


emptyModel : Model
emptyModel =
    { activePage = Login
    , pageLogin = Pages.Login.Model.emptyModel
    }
