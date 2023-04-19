import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15

Popup {
    id: idRoot

    enum Type {
        Ok,
        Warning,
        Info,
        Error
    }

    property int type: MessageDialog.Type.Ok

    property alias buttonsRow: idButtonsLayout
    property alias messageLabel: idTextLbl
    property alias text: idTextLbl.text
    property alias description: idDescrTextLbl.text
    property alias messageColor: idTextLbl.color
    property alias descriptionColor: idDescrTextLbl.color
    property alias descriptionTextFormat: idDescrTextLbl.textFormat
    property alias buttonText: idOkBtn.text

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

    TextMetrics {
        id: idMetric
        text: "0"
    }

    contentItem: Item {
        implicitWidth: Math.max(idOkBtn.implicitWidth * 3,
                                idContentLayout.implicitWidth)
        implicitHeight: idContentLayout.implicitHeight

        ColumnLayout {
            id: idContentLayout
            anchors.fill: parent

            RowLayout {
                spacing: 12

                Label {
                    id: idIconLbl

                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignLeft | Qt.AlignTop

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
                    horizontalAlignment: "AlignLeft"
                }

                ColumnLayout {
                    Item {
                        Layout.preferredHeight: idIconLbl.implicitHeight * 0.7
                    }

                    Label {
                        id: idTextLbl
                        Layout.fillWidth: true

                        font.bold: true
                    }

                    Label {
                        id: idDescrTextLbl
                        Layout.fillWidth: true
                        Layout.minimumHeight: 12

                        opacity: 0.90

                        font.italic: true

                        textFormat: "MarkdownText"
                    }
                }
            }

            RowLayout {
                id: idButtonsLayout

                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter

                Button {
                    id: idOkBtn

                    Material.accent: idRoot.Material.accent

                    text: "باشه"
                    highlighted: true

                    onClicked: idRoot.close()
                }
            }
        }
    }
}
