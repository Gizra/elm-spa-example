module Pages.PageNotFound.View exposing (view)

import Html exposing (a, i, div, h2, text, Html)
import Html.Attributes exposing (class, id, href, style)


-- VIEW


view : Html a
view =
    div [ class "wrapper text-center" ]
        [ div [ class "box" ]
            [ h2 [] [ text "This is a 404 page!" ]
            , a [ href "#!/" ] [ text "Back to safety" ]
            ]
        ]
