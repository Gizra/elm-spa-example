var elmApp = Elm.Main.fullscreen({
    accessToken : localStorage.getItem('accessToken') || '',
    hostname : window.location.hostname
});

elmApp.ports.accessTokenPort.subscribe(function(accessToken) {
    localStorage.setItem('accessToken', accessToken);
});
