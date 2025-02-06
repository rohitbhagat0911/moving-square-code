function toggleFullScreen() {
    let elem = document.documentElement; 
    if (!document.fullscreenElement) {
        elem.requestFullscreen().catch(err => {
            console.error("Fullscreen request failed:", err);
        });
    } else {
        document.exitFullscreen();
    }
}

function enterFullScreen() {
    let elem = document.documentElement; 
    if (!document.fullscreenElement) {
        elem.requestFullscreen().catch(err => {
            console.error("Fullscreen request failed:", err);
        });
    }
}

function exitFullScreen() {
    if (document.fullscreenElement) {
        document.exitFullscreen();
    }
}
