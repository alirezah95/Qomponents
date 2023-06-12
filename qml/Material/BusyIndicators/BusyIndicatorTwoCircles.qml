import QtQuick 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Shapes 1.15

BusyIndicator {
    id: _control

    property int duration: 1200
    property int strokeWidth: 8

    contentItem: Item {
        implicitHeight: 64
        implicitWidth: 64

        layer.enabled: true
        layer.samples: 16

        Shape {
            id: _shape

            anchors.fill: parent
            anchors.margins: _shapePath.strokeWidth

            ShapePath {
                id: _shapePath
                startX: _shape.width / 2
                startY: _shape.height / 2
                strokeColor: _control.Material.accent
                strokeWidth: _control.strokeWidth
                capStyle: ShapePath.RoundCap
                fillColor: "transparent"

                PathAngleArc {
                    id: _arc
                    centerX: _shapePath.startX
                    centerY: _shapePath.startY
                    startAngle: 0
                    sweepAngle: 300
                    radiusX: _shape.width / 2
                    radiusY: _shape.width / 2
                }
            }

            ParallelAnimation {
                loops: Animation.Infinite
                running: _control.running

                SequentialAnimation {
                    ParallelAnimation {
                        RotationAnimation {
                            duration: _control.duration
                            target: _shape
                            property: "rotation"
                            from: -85
                            to: 285
                        }

                        NumberAnimation {
                            target: _arc
                            property: "sweepAngle"
                            from: 2
                            to: 360
                            duration: _control.duration
                        }
                    }

                    PauseAnimation { duration: 300 }

                    ParallelAnimation {
                        NumberAnimation {
                            target: _arc
                            property: "sweepAngle"
                            to: -360
                            duration: 0
                        }

                        RotationAnimation {
                            duration: _control.duration * 0.8
                            target: _shape
                            property: "rotation"
                            from: 45
                            to: 270
                            easing.type: Easing.OutSine
                        }
                        NumberAnimation {
                            target: _arc
                            property: "sweepAngle"
                            to: -2
                            duration: _control.duration * 0.8 + 200
                            easing.type: Easing.OutSine
                        }
                    }
                    PauseAnimation { duration: 150}
                }
            }
        }

        Shape {
            id: _shape2

            anchors.centerIn: parent
            width: parent.width / 2 - 8
            height: parent.height / 2 - 8
            transformOrigin: Item.Center

            ShapePath {
                id: _shapePath2

                startX: _shape2.width / 2
                startY: _shape2.height / 2
                strokeColor: _control.Material.accent
                strokeWidth: _control.strokeWidth
                capStyle: ShapePath.RoundCap
                fillColor: "transparent"

                PathAngleArc {
                    id: _arc2
                    centerX: _shapePath2.startX
                    centerY: _shapePath2.startY
                    startAngle: 2
                    radiusX: _shape2.width / 2
                    radiusY: _shape2.width / 2
                }
            }

            ParallelAnimation {
                loops: Animation.Infinite
                running: _control.running

                SequentialAnimation {
                    ParallelAnimation {
                        RotationAnimation {
                            duration: _control.duration
                            target: _shape2
                            property: "rotation"
                            from: -30
                            to: 330
                        }

                        NumberAnimation {
                            target: _arc2
                            property: "sweepAngle"
                            from: -360
                            to: 2
                            duration: _control.duration
                        }
                    }

                    RotationAnimation {
                        duration: 300
                        target: _shape2
                        property: "rotation"
                        from: -30
                        to: 100
                    }

                    ParallelAnimation {
                        RotationAnimation {
                            duration: _control.duration * 0.8
                            target: _shape2
                            property: "rotation"
                            to: 270
                        }

                        NumberAnimation {
                            target: _arc2
                            property: "sweepAngle"
                            to: 360
                            duration: _control.duration * 0.8 + 200
                        }
                    }

                    PauseAnimation { duration: 150 }
                }
            }
        }
    }
}
