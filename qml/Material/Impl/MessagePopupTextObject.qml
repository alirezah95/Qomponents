import QtQuick 2.15

QtObject {
    property bool visible: true
    property color color: "black"
    property string text: ""
    property int textFormat: Text.StyledText
    property font font
    property int horizontalAlignment: Text.AlignJustify
    property int verticalAlignment: Text.AlignJustify
    property int wrapMode: Text.NoWrap
    property int style: Text.Normal
}
