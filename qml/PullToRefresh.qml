import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15

Item {
    id: _root

    signal action()

    property Flickable view
    property color color: "black"
    property int actionHeight: 80
    property bool actOnDragRelease: true
    property int refreshIconSize: 32

    readonly property real position: _root.height / _root.actionHeight

    width: view ? view.width : 0
    height: view && view.contentY < 0 && view.draggingVertically ? Math.min(actionHeight, -view.contentY) : 0

    Item {
        anchors.centerIn: parent
        anchors.verticalCenterOffset: Math.min(position - 0.5, 0) * (refreshIconSize * 1.5)
        width: refreshIconSize * 2
        height: refreshIconSize * 2
        opacity: position < 0.2 ? 0 : position
        scale: 1. + Math.min(position - 0.5, 0) * 1.2
        layer.enabled: true
        layer.samples: 8
        layer.smooth: true
        antialiasing: true

        Shape {
            id: _circleSh

            anchors.centerIn: parent
            width: refreshIconSize
            height: refreshIconSize

            ShapePath {
                id: _circleShP

                property int availableWidth: _circleSh.width / 2 - strokeWidth
                property int availableHeight: _circleSh.height/ 2 - strokeWidth

                startX: _circleSh.width / 2
                startY: _circleSh.height / 2
                fillColor: "transparent"
                strokeColor: _root.color
                strokeWidth: 4

                PathAngleArc {
                    id: _arc

                    centerX: _circleShP.startX
                    centerY: _circleShP.startY
                    startAngle: 0
                    sweepAngle: _root.position * 300
                    radiusX: _circleShP.availableWidth
                    radiusY: _circleShP.availableHeight
                }
            }

        }

        Shape {
            id: _triaSh

            anchors.centerIn: _circleSh
            rotation: _arc.sweepAngle

            ShapePath {
                id: _triaShP

                property int side: _circleShP.strokeWidth * 3 * (1 + Math.min(position - 0.5, 0))

                fillColor: _root.color
                strokeColor: "transparent"

                startY: 0
                startX: _circleShP.startX - _circleShP.strokeWidth - side / 2

                PathLine {
                    relativeX: _triaShP.side
                    relativeY: 0
                }
                PathLine {
                    relativeX: -_triaShP.side / 2
                    relativeY: _triaShP.side * 0.7
                }
            }
        }
    }

    Connections {
        target: _root.view
        enabled: target && _root.actOnDragRelease

        function onDraggingVerticallyChanged() {
            if (!_root.view.draggingVertically && _root.height === _root.actionHeight) {
                action()
            }
        }
    }

    onHeightChanged: {
        if (height === actionHeight && !actOnDragRelease) {
            action()
        }
    }
}
