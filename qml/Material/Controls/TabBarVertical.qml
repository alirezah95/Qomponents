import QtQuick 2.15
import QtQuick.Controls.Material 2.15

TabBar {
    id: _control

    Material.elevation: 1

    implicitWidth: 64
    implicitHeight: 300

    leftPadding: 8
    rightPadding: 8

    contentItem: ListView {
        model: _control.contentModel
        currentIndex: _control.currentIndex

        spacing: _control.spacing
        orientation: ListView.Vertical
        boundsBehavior: Flickable.StopAtBounds
        flickableDirection: Flickable.AutoFlickIfNeeded
        snapMode: ListView.SnapToItem

        highlightMoveDuration: 400
        highlightFollowsCurrentItem: true
        highlightRangeMode: ListView.ApplyRange
        preferredHighlightBegin: 40
        preferredHighlightEnd: height - 40

        highlight: Item {
            Rectangle {
                anchors {
                    right: parent.right
                    top: parent.top
                }

                width: 2
                height: currentItem.height

                color: Material.accent
            }
        }
    }
}
