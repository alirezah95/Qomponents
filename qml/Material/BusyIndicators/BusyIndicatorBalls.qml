import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15

BusyIndicator {
    id: idBusy

    implicitHeight: 64

    contentItem: RowLayout {
        spacing: 0

        Repeater {
            id: idBallsRepeater

            model: 4

            delegate: Item {
                id: idDel

                required property var model
                required property int index

                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom

                implicitWidth: idBouncingBall.implicitWidth
                implicitHeight: idBouncingBall.implicitHeight

                Rectangle {
                    id: idBouncingBall

                    property real phase
                    property real bouncePos: 0

                    implicitWidth: 14
                    implicitHeight: 14

                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: bouncePos
                    anchors.horizontalCenter: parent.horizontalCenter

                    color: Material.primary
                    radius: 8

                    scale: (Math.sin(phase) + 1.4) / 2

                    NumberAnimation {
                        target: idBouncingBall
                        loops: Animation.Infinite
                        running: true
                        property: "phase"

                        from: (idBallsRepeater.count - idDel.index) * 0.65
                        to: Math.PI * 2 + from

                        duration: 750
                    }
                }
            }
        }
    }
}
