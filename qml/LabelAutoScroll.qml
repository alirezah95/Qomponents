import QtQuick 2.15
import QtQuick.Controls 2.15

Label {
    id: _root

    property Item viewport: parent
    property int beginPause: 1200
    property int endPause: 1200
    property int pixelPerSecond: 100
    readonly property int scrollDuration: (implicitWidth - viewport.width) * 1000 / pixelPerSecond

    onImplicitWidthChanged: {
        if (implicitWidth <= viewport.width || text.length === 0) {
            state = "stop"
        } else {
            if (state === "stop") {
                state = "begining"
            }
        }
    }

    Connections {
        target: viewport

        function onWidthChanged()
        {
            if (viewport.width > width) {
                state = "stop"
            } else if (state === "stop") {
                state = "begining"
            }
        }
    }

    onTextChanged: {
        state = "stop"
        state = "begining"
    }

    state: "stop"
    states: [
        State {
            name: "stop"
            AnchorChanges {
                target: _root
                anchors.left: _root.parent.left
                anchors.right: undefined
            }
        },

        State {
            name: "begining"
            AnchorChanges {
                target: _root
                anchors.left: _root.parent.left
                anchors.right: undefined
            }
        },

        State {
            name: "end"
            AnchorChanges {
                target: _root
                anchors.right: _root.parent.right
                anchors.left: undefined
            }
        }
    ]

    transitions: [
        Transition {
            from: "stop"
            to: "begining"

            SequentialAnimation {
                PauseAnimation { duration: beginPause }
                PropertyAnimation {
                    target: _root
                    property: "state"
                    to: "end"
                }
            }
        },
        Transition {
            from: "begining"
            to: "end"

            SequentialAnimation {
                AnchorAnimation { duration: Math.max(250, scrollDuration) }
                PauseAnimation { duration: endPause }
                PropertyAnimation {
                    target: _root
                    property: "state"
                    to: "begining"
                }
            }
        },

        Transition {
            from: "end"
            to: "begining"

            SequentialAnimation {
                AnchorAnimation { duration: 0 }
                PauseAnimation { duration: beginPause }
                PropertyAnimation {
                    target: _root
                    property: "state"
                    to: "end"
                }
            }
        }
    ]
}
