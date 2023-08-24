import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Item {
    id: _root

    readonly property alias errorImplicitHeight: _errorLabel.implicitHeight

    property alias contentItem: _containterItem.contentItem
    property alias errorText: _errorLabel.text
    property alias errorColor: _errorLabel.color
    property alias errorWrapMode: _errorLabel.wrapMode
    property alias errorTextFormat: _errorLabel.textFormat
    property alias errorTextElide: _errorLabel.elide
    property alias spacing: _containerLay.spacing

    property bool errorVisible: false

    implicitWidth: _containerLay.implicitWidth
    implicitHeight: _containerLay.implicitHeight

    ColumnLayout {
        id: _containerLay

        anchors.fill: parent

        Control {
            id: _containterItem

            Layout.fillWidth: true
            Layout.fillHeight: true

            padding: 0
            background: null
            focusPolicy: "NoFocus"
        }

        Label {
            id: _errorLabel

            property real currentHeight: errorVisible ? implicitHeight : 0

            Layout.fillWidth: true
            Layout.leftMargin: 8
            Layout.rightMargin: 8
            Layout.preferredHeight: currentHeight

            clip: true
            visible: currentHeight > 1
            wrapMode: Text.Wrap

            Behavior on currentHeight {
                NumberAnimation { duration: 150 }
            }
        }
    }
}
