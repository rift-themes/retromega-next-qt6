import QtQuick
import Rift 1.0

Item {
    property Item current: Rift.darkMode ? darkTheme : lightTheme
    property Item buttonGuide: switchButtons;
    property double fontScale: 1.0;

    function setFontScale(smallFont) {
        if (smallFont) {
            fontScale = 0.5;
        } else {
            fontScale = 1.0;
        }
    }

    function setButtonGuide(value) {
        if (value) {
            buttonGuide = xboxButtons;
        } else {
            buttonGuide = switchButtons;
        }
    }

    Component.onCompleted: {
        settings.addCallback('buttonGuide', setButtonGuide);
        settings.addCallback('smallFont', setFontScale);
    }

    // Listen for Rift.darkMode changes
    Connections {
        target: Rift
        function onDarkModeChanged() {
            current = Rift.darkMode ? darkTheme : lightTheme;
        }
    }

    LightTheme { id: lightTheme; }
    DarkTheme { id: darkTheme; }
    SwitchButtons { id: switchButtons; }
    XboxButtons { id: xboxButtons; }
}
