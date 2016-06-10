module App.Model exposing (..)


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
    }


emptyModel : Model
emptyModel =
    { activePage =
        Login
        -- , article = Article.initialModel
    , nextPage = Nothing
    }
