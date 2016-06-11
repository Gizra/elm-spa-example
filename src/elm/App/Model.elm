module App.Model exposing (emptyModel, Model, Page(..))

import Pages.Login.Model exposing (emptyModel, Model)


type Page
    = Article
    | Login
    | PageNotFound


type alias Model =
    { activePage :
        Page
        -- , article : Article.Model
        -- If the user is anonymous, we want to know where to redirect them.
    , nextPage : Maybe Page
    , pageLogin : Pages.Login.Model.Model
    }


emptyModel : Model
emptyModel =
    { activePage = Login
    , nextPage = Nothing
    , pageLogin = Pages.Login.Model.emptyModel
    }
