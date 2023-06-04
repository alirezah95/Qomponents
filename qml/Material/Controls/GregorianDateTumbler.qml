import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtQuick.Layouts 1.15

Pane {
    id: _root

    readonly property int year: _yearTum.currentIndex + yearStart
    readonly property int month: _monthTum.currentIndex + 1
    readonly property int day: _dayTum.currentIndex + 1
    readonly property string date: {
        var dt = `${year}/`

        if (month < 10) {
            dt += '0'
        }
        dt += `${month}/`

        if (day < 10) {
            dt += '0'
        }
        dt += `${day}`

        return dt
    }

    readonly property bool leapYear: {
        if (year % 400 === 0)
            return true
        else if (year % 100 === 0)
            return false
        else if (year % 4 === 0)
            return true
        else
            return false
    }

    property int yearStart: 1900
    property int yearEnd: 2100
    property bool useMonthName: true
    property bool useMonthAbbrev: false

    width: implicitWidth
    height: implicitHeight

    QtObject {
        id: _internal

        property var monthDayCount: [
            31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31
        ]
        property var monthNamesModel: [
            "January",
            "February",
            "March",
            "April",
            "May",
            "June",
            "July",
            "August",
            "September",
            "October",
            "November",
            "December"
        ]

        property var yearModel: []
        property var monthNumberModel: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
        property var daysModel: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
            15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30]


        Component.onCompleted: {
            updateYearModel()
        }

        function updateYearModel()
        {
            var years = []
            for (var i = yearStart; i <= yearEnd; ++i) {
                years.push(i)
            }

            _internal.yearModel = years
        }

        function updateMonthDayCount()
        {
            var daysCount = _monthTum.currentIndex === 1 && leapYear === true
                    ? 29 : _internal.monthDayCount[_monthTum.currentIndex]

            if (_internal.daysModel.length > daysCount) {
                var toPop = _internal.daysModel.length - daysCount
                for (var i = 0; i < toPop; ++i) {
                    _internal.daysModel.pop()
                }
                _internal.daysModelChanged()
            } else if (_internal.daysModel.length < daysCount){
                for (i = _internal.daysModel.length; i < daysCount; ++i) {
                    _internal.daysModel.push(i + 1)
                }
                _internal.daysModelChanged()
            }
        }
    }

    FontMetrics {
        id: _metric
    }

    Component {
        id: _tumsDelegate

        Label {
            font.weight: opacity > 0.9 ? Font.ExtraBold : Font.Normal

            opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 1.6)
            scale: Math.min(1, Math.max(opacity, 0.75))

            text: modelData
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    GridLayout {
        anchors.fill: parent

        rowSpacing: 6
        columns: 4

        Tumbler {
            id: _yearTum

            Layout.fillWidth: true

            wrap: false
            model: _internal.yearModel

            delegate: _tumsDelegate
        }

        Tumbler {
            id: _monthTum

            Layout.fillWidth: true
            Layout.columnSpan: 2

            wrap: true
            model: useMonthName ? _internal.monthNamesModel
                                : _internal.monthNumberModel

            delegate: Label {
                font.weight: opacity > 0.9 ? Font.ExtraBold : Font.Normal

                opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 1.6)
                scale: Math.min(1, Math.max(opacity, 0.75))

                text: useMonthName && useMonthAbbrev ? modelData.toString().slice(0, 3)
                                                     : modelData
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }
        }

        Tumbler {
            id: _dayTum

            Layout.fillWidth: true

            wrap: true
            model: _internal.daysModel

            delegate: _tumsDelegate

            Connections {
                target: _root

                function onLeapYearChanged()
                {
                    _internal.updateMonthDayCount()
                }
            }

            Connections {
                target: _monthTum

                function onCurrentIndexChanged()
                {
                    _internal.updateMonthDayCount()
                }
            }
        }
    }

    onYearStartChanged: {
        if (yearEnd <= yearStart) {
            yearEnd = yearStart + 1
        }
    }

    onYearEndChanged: {
        if (yearEnd <= yearStart) {
            yearEnd = yearStart + 1
        }
    }

    function setDate(dateString, separator='/')
    {
        var dateValues = dateString.split(separator)

        var year = Number(dateValues[0])
        var month = Number(dateValues[1])
        var day = Number(dateValues[2])

        var yearIsLeap = false
        if (year % 400 === 0)
            yearIsLeap = true
        else if (year % 100 === 0)
            yearIsLeap = false
        else if (year % 4 === 0)
            yearIsLeap = true
        else
            yearIsLeap = false

        if (month < 1 || month > 12 || year < yearStart || year > yearEnd || day < 1) {
            return
        }

        var monthDayCount = (month === 2 && yearIsLeap)
                ? 29 : _internal.monthDayCount[month - 1]
        if (day > monthDayCount) {
            return
        }

        _yearTum.currentIndex = year - yearStart
        _monthTum.currentIndex = month - 1
        _dayTum.currentIndex = day - 1
    }
}
