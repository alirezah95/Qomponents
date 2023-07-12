import QtQuick 2.15
import QtQuick.Templates 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15

import "../Impl"

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

    property MessagePopupTextObject informative: MessagePopupTextObject {
        color: Material.foreground
        text: ""
        font: _root.font
    }
    property MessagePopupTextObject detailed: MessagePopupTextObject {
        color: Material.foreground
        text: ""
        font: _root.font
    }

    property MessagePopupColorsObject colors: MessagePopupColorsObject {
        ok: Material.color(Material.Green)
        warning: Material.color(Material.Orange)
        info: Material.color(Material.Blue)
        error: Material.color(Material.Red)
    }
    property MessagePopupIconsObject icons: MessagePopupIconsObject {
        font {
            family: _root.font.family
            pointSize: 24
        }
    }

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
        spacing: 16

        Label {
            id: _iconLbl

            Layout.alignment: Qt.AlignRight | Qt.AlignTop

            visible: type !== MessagePopup.Type.None

            font: icons.font
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
                switch(type) {
                case MessagePopup.Type.Ok:
                    return icons.ok
                case MessagePopup.Type.Warning:
                    return icons.warning
                case MessagePopup.Type.Info:
                    return icons.info
                case MessagePopup.Type.Error:
                    return icons.error
                default:
                    return ""
                }
            }
        }

        ColumnLayout {
            layoutDirection: parent.layoutDirection
            spacing: 16

            Label {
                id: _informativeLbl

                Layout.fillWidth: true

                visible: informative.visible
                font: informative.font

                color: informative.color
                textFormat: informative.textFormat
                text: informative.text
                horizontalAlignment: informative.horizontalAlignment
                verticalAlignment: informative.verticalAlignment
                wrapMode: informative.wrapMode
                style: informative.style
            }

            Label {
                id: _detailedLbl

                Layout.fillWidth: true

                visible: detailed.visible
                font: detailed.font

                color: detailed.color
                textFormat: detailed.textFormat
                text: detailed.text
                horizontalAlignment: detailed.horizontalAlignment
                verticalAlignment: detailed.verticalAlignment
                wrapMode: detailed.wrapMode
                style: detailed.style
            }
        }

        RowLayout {
            id: _buttonsRow

            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter | Qt.AlignRight
            Layout.topMargin: 8

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
