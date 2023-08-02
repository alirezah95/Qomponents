import QtQuick 2.15
import QtQuick.Controls.Material 2.15

Drawer {
    id: _control

    property string message: ""
    property int messageTextFormat: Text.StyledText
    property int timeout: 4000

    Material.roundedScale: Material.NotRounded

    implicitWidth: edge === Qt.LeftEdge || edge === Qt.RightEdge
                   ? 200 : parent.width
    implicitHeight: edge === Qt.LeftEdge || edge === Qt.RightEdge
                    ? parent.height
                    : _messageLbl.implicitHeight + topPadding + bottomPadding

    leftPadding: 16
    rightPadding: 16
    topPadding: 16
    bottomPadding: 16

    dim: false
    modal: false

    interactive: false
    edge: Qt.BottomEdge

    Label {
        id: _messageLbl

        anchors.fill: parent

        wrapMode: Text.Wrap
        textFormat: messageTextFormat
        text: _control.message
        horizontalAlignment: "AlignHCenter"
        verticalAlignment: "AlignVCenter"
    }

    Timer {
        interval: _control.timeout
        repeat: false
        running: _control.visible

        onTriggered: {
            _control.close()
        }
    }
}
