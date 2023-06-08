import QtQuick 2.15
import QtQuick.Controls.Material 2.15

Switch {
    id: _control

    property bool expanded: false
    property string lightThemeText: "Light"
    property string darkThemeText: "Dark"

    property font collapsedFont
    property string collapsedLightText: "\u263c"
    property string collapsedDarkText: "\u263d"
    property color expandedLightColor: Qt.alpha(Material.accentColor, 0.35)
    property color expandedDarkColor: Material.color(Material.Grey, Material.Shade500)

    indicator: Rectangle {
        x: _control.text ? (_control.mirrored ? _control.width - width - _control.rightPadding : _control.leftPadding) : _control.leftPadding + (_control.availableWidth - width) / 2
        y: _control.topPadding + (_control.availableHeight - height) / 2
        implicitWidth: 64
        implicitHeight: 40

        width: expanded ? parent.availableWidth: implicitWidth
        height: _control.availableHeight

        radius: expanded ? 6 : height / 2
        color: _lightLbl.visible ? (parent.checked ? expandedDarkColor
                                                   : expandedLightColor)
                                 : (parent.checked ? Material.foreground
                                                   : Material.background)
        border.width: 2
        border.color: _lightLbl.visible ? color:
                                          Material.switchUncheckedHandleColor

        Behavior on color {
            ColorAnimation { duration: 200 }
        }

        Label {
            x: _control.checked ? parent.width - width - 12 : 6
            anchors.verticalCenter: parent.verticalCenter
            visible: !_lightLbl.visible
            width: 20
            height: 20

            font: collapsedFont

            color: _control.checked ? Material.background
                                     : Material.accent
            textFormat: "RichText"
            text: _control.checked ? collapsedDarkText
                                   : collapsedLightText
            verticalAlignment: "AlignVCenter"
            horizontalAlignment: "AlignHCenter"

            Behavior on x {
                NumberAnimation { duration: 200 }
            }
        }

        Rectangle {
            id: _rc
            anchors {
                fill: parent
                margins: -2
            }

            parent: _control.checked ? _darkLbl : _lightLbl
            z: -1

            radius: 6
        }

        Label {
            id: _lightLbl
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 6
            }

            visible: width > implicitWidth
            height: parent.height - 12
            width: parent.width / 2

            padding: 0
            background: null

            text: lightThemeText
            elide: "ElideRight"
            verticalAlignment: "AlignVCenter"
            horizontalAlignment: "AlignHCenter"
        }

        Label {
            id: _darkLbl
            anchors {
                verticalCenter: parent.verticalCenter
                right: parent.right
                rightMargin: 6
            }

            visible: width > implicitWidth
            height: parent.height - 12
            width: parent.width / 2

            padding: 0
            background: null

            text: darkThemeText
            elide: "ElideRight"
            verticalAlignment: "AlignVCenter"
            horizontalAlignment: "AlignHCenter"
        }
    }
}

