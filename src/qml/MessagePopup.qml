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

    property int type: MessagePopup.Type.Ok
    property string message: ""
    property string description: ""
    property color messageColor: Material.primaryTextColor
    property color descriptionColor: Material.secondaryTextColor
    property int descriptionTextFormat: Text.MarkdownText
    property int layoutDirection: Qt.LeftToRight

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
            readonly property var colors: [
                "green", // Ok
                "yellow", // Warning
                "blue", // Info
                "red", // Error
            ]

            textFormat: "RichText"
            color: colors[type]
            text: "<qt style=\"font-size:20pt;font-weight:bold;\">"
                  + icons[type] + "</qt>"
        }

        ColumnLayout {
            Layout.fillWidth: true

            Label {
                Layout.fillWidth: true

                font.bold: true

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
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter

            Button {
                Layout.leftMargin: implicitWidth
                Layout.rightMargin: implicitWidth

                Material.accent: _root.Material.accent

                text: "باشه"
                highlighted: true

                onClicked: _root.close()
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
            easing.overshoot: 3
        }
    }

    exit: Transition {
        NumberAnimation {
            duration: 250
            property: "scale"
            from: 1
            to: 0
            easing.type: Easing.InBack
            easing.overshoot: 3
        }
    }
}
