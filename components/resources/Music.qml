import QtQuick
import QtMultimedia

Item {
    property var videos: [];

    // Qt6: Playlist and Audio have been removed/changed
    // Background music is disabled for Qt6 compatibility

    function volumeCheck() {
        // Disabled for Qt6
    }

    function registerVideo(video) {
        videos.push(video);
    }

    property bool isPlaying: false

    Component.onCompleted: {
        // Background music disabled for Qt6 compatibility
    }
}
