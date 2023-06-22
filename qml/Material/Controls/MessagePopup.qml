import QtQuick 2.15
import QtQuick.Templates 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15

Popup {
    id: _root

    enum Type {
        Ok,
        Warning,
        Info,
        Error
    }

    signal accepted()
    signal rejected()

    property int type: MessagePopup.Type.Ok

    property string message: ""
    property color messageColor: Material.primaryTextColor
    property int messageTextFormat: Text.MarkdownText

    property string description: ""
    property color descriptionColor: Material.secondaryTextColor
    property int descriptionTextFormat: Text.MarkdownText

    property string acceptText: "Ok"
    property string rejectText: "Cancle"
    readonly property alias acceptButton: _acceptBtn
    readonly property alias rejectButton: _rejectBtn
    property int layoutDirection: Qt.LeftToRight

    property color colorOk: "green"
    property color colorWarning: "yellow"
    property color colorInfo: "blue"
    property color colorError: "red"

    readonly property RowLayout buttonsRow: _buttonsRow

    anchors.centerIn: parent

    dim: true
    modal: true
    closePolicy: Popup.CloseOnPressOutside

    leftPadding: 20
    rightPadding: 20
    topPadding: 12
    bottomPadding: 12

    background: Rectangle {
        color: Material.background
        radius: 8
    }

    contentItem: ColumnLayout {
        layoutDirection: _root.layoutDirection
        Label {
            Layout.alignment: Qt.AlignRight | Qt.AlignTop

            readonly property var icons: [
                "\u2611", // Ok
                "\u26a0", // Warning
                "\u24d8", // Info
                "\u2A02", // Error
            ]

            textFormat: "RichText"
            color: {
                switch(type) {
                case 0:
                    return colorOk
                case 1:
                    return colorWarning
                case 2:
                    return colorInfo
                case 3:
                    return colorError
                }
            }
            text: "<qt style=\"font-size:20pt;font-weight:bold;\">"
                  + icons[type] + "</qt>"
        }

        ColumnLayout {
            Layout.fillWidth: true

            Label {
                Layout.fillWidth: true

                font.bold: true

                textFormat: messageTextFormat
                text: message
                color: messageColor
                wrapMode: Text.Wrap
            }

            Label {
                Layout.fillWidth: true
                Layout.minimumHeight: 12

                textFormat: descriptionTextFormat
                text: description
                color: descriptionColor
            }
        }

        RowLayout {
            id: _buttonsRow

            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter

            Button {
                id: _acceptBtn

                text: acceptText
                highlighted: true

                onClicked: _root.accepted()
            }

            Button {
                id: _rejectBtn

                text: rejectText
                highlighted: true

                onClicked: _root.rejected()
            }
        }
    }

    enter: Transition {
        NumberAnimation {
            duration: 250
            property: "scale"
            from: 0
            to: 1
            easing.type: Easing.OutBack
        }
    }

    exit: Transition {
        NumberAnimation {
            duration: 250
            property: "scale"
            from: 1
            to: 0
            easing.type: Easing.InBack
        }
    }
}
