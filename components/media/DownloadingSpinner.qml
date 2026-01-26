import QtQuick

// Spinner overlay shown when artwork is being downloaded for a game
// Also handles reloading the parent image when download completes

Rectangle {
    id: root

    property var gameData: null
    property Image targetImage: null  // Image to reload when download completes
    property var sourceBinding: null  // Function that returns the image source

    readonly property int gameId: gameData?.extra?.id ?? -1
    readonly property bool isDownloading: typeof Rift !== "undefined" &&
        Rift.backgroundArtworkCurrentGameId === gameId

    anchors.fill: parent
    color: "#000"
    opacity: 0.7
    visible: isDownloading

    // Listen to Rift signal when artwork download completes
    Connections {
        target: typeof Rift !== "undefined" ? Rift : null
        function onGameArtworkUpdated(updatedGameId) {
            if (updatedGameId === root.gameId && root.targetImage) {
                root.targetImage.cache = false
                root.targetImage.source = ""

                Qt.callLater(function() {
                    if (root.sourceBinding) {
                        root.targetImage.source = root.sourceBinding()
                    }
                    Qt.callLater(function() {
                        if (root.targetImage) {
                            root.targetImage.cache = true
                        }
                    })
                })
            }
        }
    }

    // Spinning circle indicator
    Item {
        id: spinner
        anchors.centerIn: parent
        width: 40
        height: 40

        RotationAnimation on rotation {
            from: 0
            to: 360
            duration: 1000
            loops: Animation.Infinite
            running: root.isDownloading
        }

        Repeater {
            model: 8
            Rectangle {
                width: 6
                height: 6
                radius: 3
                color: "#fff"
                opacity: 1 - (index * 0.1)
                x: spinner.width / 2 - 3 + Math.cos(index * Math.PI / 4) * 14
                y: spinner.height / 2 - 3 + Math.sin(index * Math.PI / 4) * 14
            }
        }
    }
}
