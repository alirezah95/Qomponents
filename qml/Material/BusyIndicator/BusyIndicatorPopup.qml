import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Popup {
    id: idPopup
    anchors.centerIn: parent

    property color color: Material.color(Material.Lime)
    property string message: ""

    modal: true
    dim: true
    closePolicy: Popup.NoAutoClose

    background: Rectangle {
        color: "transparent"
    }

    Label {
        anchors.top: idBusy.bottom
        anchors.topMargin: 16
        anchors.horizontalCenter: idBusy.horizontalCenter
        text: idPopup.message
        color: idPopup.color
        font.pixelSize: 26
    }

    BusyIndicator {
        id: idBusy
        anchors.centerIn: parent
        width: 72
        height: 72

        running: idPopup.opened

        contentItem: Item {
            id: idBusyDelegate
            implicitWidth: idBusy.width
            implicitHeight: idBusy.height

            Item {
                id: idRotatingItem
                anchors.fill: parent

                RotationAnimator {
                    target: idRotatingItem
                    from: 0
                    to: 360
                    duration: 2200
                    running: idPopup.opened
                    loops: Animation.Infinite
                }

                Repeater {
                    model: 8
                    x: 30
                    y: 0
                    delegate: Rectangle {
                        id: idCircle
                        width: 10
                        height: 10
                        color: idPopup.color
                        radius: 5

                        required property int index

                        state: "come"
                        states: [
                            State {
                                name: "come"
                                PropertyChanges {
                                    target: idRotationTransform
                                    angle: index * 45
                                }
                                StateChangeScript {
                                    name: "runAnima"
                                    script: {
                                        idCirclesSequAngleAnima.from
                                                = -index * 45
                                        idCirclesSequAngleAnima.to = 0
                                        idCirclesSequAngleAnima.duration = 700

                                        idCirclesSequPause.duration = 100
                                        idCirclesSequAnima.running = true
                                    }
                                }
                            },
                            State {
                                name: "go"
                                PropertyChanges {
                                    target: idRotationTransform
                                    angle: 0
                                }
                                StateChangeScript {
                                    name: "runAnima"
                                    script: {
                                        idCirclesSequAngleAnima.from
                                                = idRotationTransform.angle
                                        idCirclesSequAngleAnima.to
                                                = index * 45
                                        idCirclesSequAngleAnima.duration = 1000

                                        idCirclesSequPause.duration = 400
                                        idCirclesSequAnima.running = true
                                    }
                                }
                            }
                        ]

                        Component.onCompleted: {
                            state = "go"
                        }

                        SequentialAnimation {
                            id: idCirclesSequAnima
                            PauseAnimation {
                                id: idCirclesSequPause
                            }
                            NumberAnimation {
                                id: idCirclesSequAngleAnima
                                target: idRotationTransform
                                property: "angle"
                                duration: 2000
                            }
                            onFinished: {
                                if (idCircle.state === "come") {
                                    idCircle.state = "go"
                                } else if (idCircle.state === "go") {
                                    idCircle.state = "come"
                                }
                            }
                        }


                        transform: [
                            Translate {
                                y: idRotatingItem.height / 2 - 5
                                x: -5
                            },
                            Rotation {
                                id: idRotationTransform
                                angle: index * 45
                                origin.x: idRotatingItem.width / 2
                                origin.y: idRotatingItem.height / 2
                            }
                        ]
                    }
                }
            }
        }
    }
}
