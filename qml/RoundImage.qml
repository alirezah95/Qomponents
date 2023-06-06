import QtQuick
import QtCore
import Qt5Compat.GraphicalEffects

Item {
    id: _root

    property int radius: 4

    property alias asynchronous:        _selfImage.asynchronous
    property alias autoTransform:       _selfImage.autoTransform
    property alias cache:               _selfImage.cache
    property alias currentFrame:        _selfImage.currentFrame
    property alias fillMode:            _selfImage.fillMode
    property alias frameCount:          _selfImage.frameCount
    property alias horizontalAlignment: _selfImage.horizontalAlignment
    property alias mipmap:              _selfImage.mipmap
    property alias mirror:              _selfImage.mirror
    property alias mirrorVertically:    _selfImage.mirrorVertically
    property alias paintedHeight:       _selfImage.paintedHeight
    property alias paintedWidth:        _selfImage.paintedWidth
    property alias progress:            _selfImage.progress
    property alias smooth:              _selfImage.smooth
    property alias source:              _selfImage.source
    property alias sourceClipRect:      _selfImage.sourceClipRect
    property alias sourceSize:          _selfImage.sourceSize
    property alias status:              _selfImage.status
    property alias verticalAlignment:   _selfImage.verticalAlignment

    Image {
        id: _selfImage

        anchors.fill: parent
        anchors.margins: 2

        visible: false
    }

    Rectangle {
        id: _selfImageMask

        anchors.fill: _selfImage
        visible: false

        radius: Math.min(_root.radius, width / 2)
    }

    OpacityMask {
        anchors.fill: _selfImage

        source: _selfImage
        maskSource: _selfImageMask
    }
}
