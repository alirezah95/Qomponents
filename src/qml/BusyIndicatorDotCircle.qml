import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import Qt5Compat.GraphicalEffects

BusyIndicator {
    id: idBusy

    implicitWidth: 64
    implicitHeight: 64

    contentItem: Item {
        Rectangle {
            id: idBackCircle

            width: Math.min(parent.width, parent.height)
            height: width
            anchors.centerIn: parent

            radius: width / 2
            color: "transparent"

            border.width: 1
            border.color: Material.color(Material.Grey)

            Rectangle {
                id: idRotatingCircle

                width: 10
                height: 10

                anchors.top: parent.top
                anchors.topMargin: -(height >> 1) + 1
                anchors.horizontalCenter: parent.horizontalCenter

                color: Material.primary
                radius: width / 2

                    layer.enabled: true
                    layer.effect: DropShadow {
                        color: idRotatingCircle.color.alpha(0.4)
                        transparentBorder: true
                        samples: 14
                        radius: 8
                        spread: 0.25
                        verticalOffset: 2
                    }

                transform: [
                    Rotation {
                        id: idRotationTransform
                        origin.x: (idRotatingCircle.width >> 1)
                        origin.y: (idBackCircle.height >> 1) + (idRotatingCircle.height >> 1) - 2
                    }
                ]

                NumberAnimation {
                    target: idRotationTransform
                    property: "angle"

                    loops: Animation.Infinite
                    running: idBusy.running
                    duration: 2200

                    easing.type: Easing.InOutCubic

                    from: 0
                    to: 360
                }

            }
        }
    }
}
