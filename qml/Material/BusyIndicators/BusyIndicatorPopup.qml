import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Popup {
    id: _root

    property BusyIndicator busyIndicator: null
    property color messageColor: "green"
    property string message: "Please wait ..."

    modal: true
    dim: true
    closePolicy: Popup.NoAutoClose

    background: null

    ColumnLayout {
        anchors.centerIn: parent

        Label {
            visible: text.length > 0
            font: _root.font

            text: _root.message
            color: _root.messageColor
        }

        Control {
            contentItem: busyIndicator
        }
    }
}
