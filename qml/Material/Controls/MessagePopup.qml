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
        Error,
        None
    }

    signal accepted()
    signal rejected()

    QtObject {
        id: _informative

        property color color: Material.foreground
        property int textFormat: Text.MarkdownText
        property string text: ""
        property alias font: _informativeLbl.font
        property alias horizontalAlignment: _informativeLbl.horizontalAlignment
        property alias verticalAlignment: _informativeLbl.verticalAlignment
    }

    QtObject {
        id: _detailed

        property color color: Material.foreground
        property int textFormat: Text.MarkdownText
        property string text: ""
        property alias font: _detailedLbl.font
        property alias horizontalAlignment: _detailedLbl.horizontalAlignment
        property alias verticalAlignment: _detailedLbl.verticalAlignment

        font.weight: Font.Light
    }

    QtObject {
        id: _colors

        property color ok: "green"
        property color warning: "yellow"
        property color info: "blue"
        property color error: "red"
    }

    QtObject {
        id: _icons

        property alias font: _iconLbl.font
        property string ok: "\u2611"
        property string warning: "\u26a0"
        property string info: "\u24d8"
        property string error: "\u2a02"
    }

    property alias informative: _informative
    property alias detailed: _detailed
    property alias colors: _colors
    property alias icons: _icons

    property int type: MessagePopup.Type.Ok

    property string acceptText: "Ok"
    property string rejectText: "Cancle"
    readonly property alias acceptButton: _acceptBtn
    readonly property alias rejectButton: _rejectBtn
    property int layoutDirection: Qt.LeftToRight

    readonly property RowLayout buttonsRow: _buttonsRow

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            _contentLay.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             _contentLay.implicitHeight + topPadding + bottomPadding)

    dim: true
    modal: true
    closePolicy: Popup.CloseOnPressOutside

    leftPadding: 20
    rightPadding: 20
    topPadding: 12
    bottomPadding: 12

    ColumnLayout {
        id: _contentLay

        anchors.fill: parent

        layoutDirection: _root.layoutDirection
        spacing: 4

        Label {
            id: _iconLbl

            Layout.alignment: Qt.AlignRight | Qt.AlignTop

            textFormat: "RichText"
            color: {
                switch(type) {
                case MessagePopup.Type.Ok:
                    return colors.ok
                case MessagePopup.Type.Warning:
                    return colors.warning
                case MessagePopup.Type.Info:
                    return colors.info
                case MessagePopup.Type.Error:
                    return colors.error
                default:
                    return "transparent"
                }
            }
            text: {
                var icon = ""

                switch(type) {
                case MessagePopup.Type.Ok:
                    icon = icons.ok
                    break
                case MessagePopup.Type.Warning:
                    icon = icons.warning
                    break
                case MessagePopup.Type.Info:
                    icon = icons.info
                    break
                case MessagePopup.Type.Error:
                    icon = icons.error
                    break
                default:
                    icon = ""
                    break
                }

                return `<qt style="font-size:${icons.pointSize}pt;font-weight:bold;">${icon}</qt>`
            }
        }

        ColumnLayout {
            layoutDirection: parent.layoutDirection
            spacing: 8

            Label {
                id: _informativeLbl

                Layout.fillWidth: true

                font.weight: Font.DemiBold

                color: informative.color
                textFormat: informative.textFormat
                text: informative.text
                wrapMode: Text.Wrap
                verticalAlignment: "AlignTop"
            }

            Label {
                id: _detailedLbl

                Layout.fillWidth: true

                font.weight: Font.Light

                color: detailed.color
                textFormat: detailed.textFormat
                text: detailed.text
                wrapMode: Text.Wrap
                verticalAlignment: "AlignTop"
            }
        }

        RowLayout {
            id: _buttonsRow

            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight

            layoutDirection: parent.layoutDirection

            Button {
                id: _acceptBtn

                text: acceptText
                highlighted: true

                onClicked: {
                    _root.accepted()
                    _root.close()
                }
            }

            Button {
                id: _rejectBtn

                text: rejectText
                highlighted: true

                onClicked: {
                    _root.rejected()
                    _root.close()
                }
            }
        }
    }
}
