module App.Update exposing (init, update, Msg(..))

import App.Model exposing (..)
import RemoteData exposing (RemoteData(..))
import Utils.WebData exposing (WebData)
import User.Model exposing (..)
import Pages.Login.Update exposing (Msg)


init : Flags -> ( Model, Cmd Msg )
init flags =
    let
        cmds =
            case (Dict.get flags.hostname Config.configs) of
                Just val ->
                    -- Check if we have already an access token.
                    if (String.isEmpty flags.accessToken) then
                        Cmd.none
                    else
                        Cmd.map PageLogin <| Pages.Login.Update.fetchUserFromBackend val.backendUrl flags.accessToken

                Nothing ->
                    Cmd.none
    in
        { emptyModel | accessToken = flags.accessToken } ! [ cmds ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Logout ->
            ( { emptyModel | accessToken = "", config = model.config }
            , accessTokenPort ""
            )

        PageLogin msg ->
            let
                ( val, cmds, user ) =
                    Pages.Login.Update.update model.user msg model.pageLogin

                model_ =
                    { model
                        | pageLogin = val
                        , user = user
                    }

                model__ =
                    case user of
                        -- If user was successfuly fetched, reditect to my
                        -- account page.
                        Success _ ->
                            update (SetActivePage MyAccount) model_
                                |> Tuple.first

                        _ ->
                            model_
            in
                ( model__, Cmd.map PageLogin cmds )

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
