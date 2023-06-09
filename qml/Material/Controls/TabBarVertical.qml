import QtQuick 2.15
import QtQuick.Templates 2.15 as T
import QtQuick.Controls.Material 2.15
import QtQuick.Controls.Material.impl 2.15

T.TabBar {
    id: _control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentItem.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentItem.implicitHeight + topPadding + bottomPadding)

    spacing: 1

    contentItem: ListView {
        model: _control.contentModel
        currentIndex: _control.currentIndex

        spacing: _control.spacing
        orientation: ListView.Vertical
        boundsBehavior: Flickable.StopAtBounds
        flickableDirection: Flickable.AutoFlickIfNeeded
        snapMode: ListView.SnapToItem

        highlightMoveDuration: 250
        highlightResizeDuration: 0
        highlightFollowsCurrentItem: true
        highlightRangeMode: ListView.ApplyRange
        preferredHighlightBegin: 48
        preferredHighlightEnd: height - 48

        highlight: Item {
            z: 2
            Rectangle {
                width: 2
                height: parent.height
                x: _control.position === TabBar.Footer ? 0 : parent.width - width
                color: _control.Material.accentColor
            }
        }
    }

    background: Rectangle {
        color: _control.Material.backgroundColor

        layer.enabled: _control.Material.elevation > 0
        layer.effect: ElevationEffect {
            elevation: _control.Material.elevation
            fullWidth: true
        }
    }
}
