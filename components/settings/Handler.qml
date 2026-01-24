import QtQuick
import Rift 1.0

Item {
    property var keys: [
        'bgMusic', 'navSounds', 'buttonGuide', 'twelveHour',
        'smallFont', 'preferBox', 'gameListVideo', 'gameDetailsVideo', 'quietVideo',
        'quickVideo', 'dropShadow', 'resetNameFilter', 'attractTitle',
        'favoritesOnTop', 'delayedImage'
    ];

    function title(key) { return titles[key]; }
    function toggle(key) { set(key, !values[key]); }

    function get(key) {
        if (values[key] === null) {
            // Use Rift.themeSetting() with fallback to default
            var riftValue = Rift.themeSetting(key);
            set(key, riftValue !== undefined ? riftValue : defaults[key]);
        }

        return values[key];
    }

    function saveAll() {
        for (const key of keys) {
            Rift.setThemeSetting(key, get(key));
        }
    }

    function set(key, value) {
        if (values[key] === undefined) return;

        values[key] = value;
        Rift.setThemeSetting(key, value);
        callback(key);
    }

    function addCallback(key, callback) {
        if (callbacks[key] === undefined) return;

        callbacks[key].push(callback);
    }

    function callback(key) {
        if (callbacks[key] === undefined) return;

        for (let i = 0; i < callbacks[key].length; i++) {
            callbacks[key][i](values[key]);
        }
    }

    // Listen for real-time theme setting changes from Rift
    Connections {
        target: Rift
        function onThemeSettingChanged(key, value) {
            if (values[key] !== undefined && values[key] !== value) {
                values[key] = value;
                callback(key);
            }
        }
    }

    property var defaults: {
        'bgMusic': true,
        'navSounds': true,
        'buttonGuide': false,
        'twelveHour': false,
        'smallFont': false,
        'preferBox': true,
        'gameListVideo': true,
        'gameDetailsVideo': true,
        'quietVideo': false,
        'quickVideo': false,
        'dropShadow': true,
        'resetNameFilter': false,
        'attractTitle': true,
        'favoritesOnTop': false,
        'delayedImage': false
    }

    property var values: {
        'bgMusic': null,
        'navSounds': null,
        'buttonGuide': null,
        'twelveHour': null,
        'smallFont': null,
        'preferBox': null,
        'gameListVideo': null,
        'gameDetailsVideo': null,
        'quietVideo': null,
        'quickVideo': null,
        'dropShadow': null,
        'resetNameFilter': null,
        'attractTitle': null,
        'favoritesOnTop': null,
        'delayedImage': null
    }

    property var callbacks: {
        'bgMusic': [],
        'navSounds': [],
        'buttonGuide': [],
        'twelveHour': [],
        'smallFont': [],
        'preferBox': [],
        'gameListVideo': [],
        'gameDetailsVideo': [],
        'quietVideo': [],
        'quickVideo': [],
        'dropShadow': [],
        'resetNameFilter': [],
        'attractTitle': [],
        'favoritesOnTop': [],
        'delayedImage': []
    }

    property var titles: {
        'bgMusic': 'Background Music',
        'navSounds': 'Navigation Sounds',
        'buttonGuide': 'XBox Button Guide',
        'twelveHour': 'Twelve Hour Clock',
        'smallFont': 'Use Smaller Font',
        'preferBox': 'Prefer Box to Poster',
        'gameListVideo': 'Video on Game List',
        'gameDetailsVideo': 'Video on Game Details',
        'quietVideo': 'Silent Videos',
        'quickVideo': 'Shorter Video Delay',
        'dropShadow': 'Enable Video/Image Shadow',
        'resetNameFilter': 'Clear Name Filter on Reload',
        'attractTitle': 'Game Title on Attract Mode',
        'favoritesOnTop': 'Favorites on Top',
        'delayedImage': 'Delayed Images'
    }
}
