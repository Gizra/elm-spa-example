module Pages.Login.Model exposing (..)

import Exts.RemoteData exposing (..)


type alias Github =
    { avatar_url : String
    , login : String
    }


type alias Model =
    { name : String
    , github : WebData Github
    }


emptyModel : Model
emptyModel =
    { name = ""
    , github = NotAsked
    }
