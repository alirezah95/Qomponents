import QtQuick
import QtQuick.Templates as T
import QtQuick.Controls.impl
import QtQuick.Controls.Material
import QtQuick.Controls.Material.impl

T.Button {
    id: control

    property int borderWidth: 1

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    topInset: 6
    bottomInset: 6
    verticalPadding: 14
    leftPadding: !flat ? (!hasIcon ? 24 : 16) : 12
    rightPadding: !flat ? 24 : (!hasIcon ? 12 : 16)
    spacing: 8

    icon.width: 24
    icon.height: 24
    icon.color: !enabled ? Material.hintTextColor :
        (control.flat && control.highlighted) || (control.checked && !control.highlighted) ? Material.accentColor :
        highlighted ? Material.primaryHighlightedTextColor : Material.foreground

    readonly property bool hasIcon: icon.name.length > 0 || icon.source.toString().length > 0

    Material.elevation: control.down ? 8 : 2
    Material.roundedScale: Material.FullScale

    contentItem: IconLabel {
        spacing: control.spacing
        mirrored: control.mirrored
        display: control.display

        icon: control.icon
        text: control.text
        font: control.font
        color: !control.enabled ? control.Material.hintTextColor :
            (control.flat && control.highlighted) || (control.checked && !control.highlighted) ? control.Material.accentColor :
            control.highlighted ? background.border.color : control.Material.color(Material.Grey, Material.theme === Material.Dark ? Material.Shade100 : Material.Shade800)
    }

    background: Rectangle {
        implicitWidth: 64
        implicitHeight: control.Material.buttonHeight

        color: control.Material.backgroundColor
        radius: control.Material.roundedScale === Material.FullScale ? height / 2 : control.Material.roundedScale
        border.width: borderWidth
        border.color: control.Material.buttonColor(control.Material.theme, control.Material.background,
            control.Material.accent, control.enabled, control.flat, control.highlighted, control.checked)

        // The layer is disabled when the button color is transparent so you can do
        // Material.background: "transparent" and get a proper flat button without needing
        // to set Material.elevation as well
        layer.enabled: control.enabled && border.color.a > 0 && !control.flat
        layer.effect: RoundedElevationEffect {
            elevation: control.Material.elevation
            roundedScale: control.background.radius
        }

        Ripple {
            clip: true
            clipRadius: parent.radius
            width: parent.width
            height: parent.height
            pressed: control.pressed
            anchor: control
            active: enabled && (control.down || control.visualFocus || control.hovered)
            color: control.flat || control.highlighted ? control.Material.highlightedRippleColor : control.Material.rippleColor
        }
    }
}
