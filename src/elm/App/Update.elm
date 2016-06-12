module App.Update exposing (init, update, Msg(..))

import App.Model as App exposing (..)
import Pages.Login.Update exposing (Msg)


type Msg
    = Logout
    | NoOp
    | PageLogin Pages.Login.Update.Msg
    | SetActivePage App.Page


init : ( Model, Cmd Msg )
init =
    emptyModel ! []


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
    case action of
        Logout ->
            init

        NoOp ->
            model ! []

        PageLogin msg ->
            let
                ( val, cmds, user ) =
                    Pages.Login.Update.update msg model.pageLogin
            in
                ( { model
                    | nextPage = Just MyAccount
                    , pageLogin = val
                    , user = user
                  }
                , Cmd.map PageLogin cmds
                )

        SetActivePage page ->
            { model
                | activePage = page
                , nextPage = Nothing
            }
                ! []
