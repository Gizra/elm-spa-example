var elmApp = Elm.Main.fullscreen({
    accessToken : localStorage.getItem('accessToken') || '',
    hostname : window.location.hostname
});
