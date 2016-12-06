port module App.Update exposing (init, update)

import App.Model exposing (..)
import Config
import Dict
import Pages.Login.Update
import RemoteData exposing (RemoteData(..), WebData)
import User.Model exposing (..)


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        ( config, cmds ) =
            case (Dict.get flags.hostname Config.configs) of
                Just config ->
                    let
                        cmd =
                            if (String.isEmpty flags.accessToken) then
                                -- Check if we have already an access token.
                                Cmd.none
                            else
                                Cmd.map PageLogin <| Pages.Login.Update.fetchUserFromBackend config.backendUrl flags.accessToken
                    in
                        ( Success config, cmd )

                Nothing ->
                    ( Failure "No config found", Cmd.none )
    in
        { emptyModel | accessToken = flags.accessToken, config = config } ! [ cmds ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        backendUrl =
            case model.config of
                Success config ->
                    config.backendUrl

                _ ->
                    ""
    in
        case msg of
            Logout ->
                ( { emptyModel | accessToken = "", config = model.config }
                , accessTokenPort ""
                )

            PageLogin msg ->
                let
                    ( val, cmds, ( webDataUser, accessToken ) ) =
                        Pages.Login.Update.update backendUrl msg model.pageLogin

                    modelUpdated =
                        { model
                            | pageLogin = val
                            , accessToken = accessToken
                            , user = webDataUser
                        }

                    ( modelWithRedirect, setActivePageCmds ) =
                        case webDataUser of
                            -- If user was successfuly fetched, reditect to my
                            -- account page.
                            Success _ ->
                                update (SetActivePage MyAccount) modelUpdated

                            _ ->
                                modelUpdated ! []
                in
                    ( modelWithRedirect
                    , Cmd.batch
                        [ Cmd.map PageLogin cmds
                        , accessTokenPort accessToken
                        , setActivePageCmds
                        ]
                    )

            SetActivePage page ->
                { model | activePage = setActivePageAccess model.user page } ! []


{-| Determine is a page can be accessed by a user (anonymous or authenticated),
and if not return a access denied page.

If the user is authenticated, don't allow them to revisit Login page. Do the
opposite for anonumous user - don't allow them to visit the MyAccount page.
-}
setActivePageAccess : WebData User -> Page -> Page
setActivePageAccess user page =
    case user of
        Success _ ->
            if page == Login then
                AccessDenied
            else
                page

        _ ->
            if page == MyAccount then
                AccessDenied
            else
                page


{-| Send access token to JS.
-}
port accessTokenPort : String -> Cmd msg
