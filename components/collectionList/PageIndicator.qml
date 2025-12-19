import QtQuick
import Qt5Compat.GraphicalEffects

Item {
    id: pageIndicator;

    property int currentIndex: 0;
    property int pageCount: 1;
    property double itemSpacing: {
        return Math.min(
            pageIndicator.width * .028 - pageIndicator.height,
            pageIndicator.width / pageCount - pageIndicator.height,
        );
    }

    Row {
        spacing: itemSpacing;
        anchors.horizontalCenter: parent.horizontalCenter;

        Repeater {
            model: pageCount;

            Rectangle {
                width: pageIndicator.height;
                height: pageIndicator.height;
                radius: pageIndicator.height / 2;

                color: theme.current.titleColor;
                opacity: currentIndex === index ? 1 : 0.2;
            }
        }
    }
}
