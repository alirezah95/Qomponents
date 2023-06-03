import QtQuick
import Qt5Compat.GraphicalEffects

Item {
    id: _root

    property url source: ""
    property int fillMode: Image.PreserveAspectFit

    Image {
        id: _selfImage

        anchors.fill: parent
        anchors.margins: 2

        visible: false

        source: _root.source
        fillMode: _root.fillMode
    }

    Rectangle {
        id: _selfImageMask

        anchors.fill: _selfImage
        visible: false

        radius: width / 2 - 1
    }

    OpacityMask {
        anchors.fill: _selfImage

        source: _selfImage
        maskSource: _selfImageMask
    }
}
