import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Pane {
    id: _root

    readonly property int year: _yearTum.currentIndex + yearStart
    readonly property int month: _monthTum.currentIndex + 1
    readonly property int day: _dayTum.currentIndex + 1
    readonly property string date: `${year}/${month}/${day}`

    readonly property bool leapYear: _internal.leapYearRemainder.includes(year % 33)

    property int yearStart: 1350
    property int yearEnd: 1450
    property bool useMonthName: true

    QtObject {
        id: _internal

        readonly property var leapYearRemainder: [1, 5, 9, 13, 17, 22, 26, 30]

        property var monthDayCount: [
            31, 31, 31, 31, 31, 31, 30, 30, 30, 30, 30, 29
        ]

        property var monthNamesModel: [
            "فروردین",
            "اردیبهشت",
            "خرداد",
            "تیر",
            "مرداد",
            "شهریور",
            "مهر",
            "آبان",
            "آذر",
            "دی",
            "بهمن",
            "اسفند",
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
    }

    FontMetrics {
        id: _metric
    }

    Component {
        id: _tumsDelegate

        Label {
            font.weight: opacity > 0.9 ? Font.ExtraBold : Font.Normal

            opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 1.6)
            scale: Math.max(opacity, 0.75)

            text: modelData
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    RowLayout {
        anchors.fill: parent

        spacing: 12

        Tumbler {
            id: _yearTum

            wrap: false
            model: _internal.yearModel

            delegate: _tumsDelegate
        }

        Tumbler {
            id: _monthTum

            wrap: true
            model: useMonthName ? _internal.monthNamesModel
                                : _internal.monthNumberModel

            delegate: _tumsDelegate
        }

        Tumbler {
            id: _dayTum

            wrap: true
            model: _internal.daysModel

            delegate: _tumsDelegate

            Connections {
                target: _root

                function onLeapYearChanged()
                {
                    if (_monthTum.currentIndex === 11) {
                        var daysCount = leapYear ? 30 : 29
                        if (_internal.daysModel.length > daysCount) {
                            for (var i = 0; i < _internal.daysModel.length - daysCount; ++i) {
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
            }

            Connections {
                target: _monthTum

                function onCurrentIndexChanged()
                {
                    if (_monthTum.currentIndex < 6) {
                        for (var i = _internal.daysModel.length; i < 31; ++i) {
                            _internal.daysModel.push(i + 1)
                            _internal.daysModelChanged()
                        }
                    } else {
                        var daysCount = _monthTum.currentIndex === 11 && !leapYear
                                ? 29 : 30
                        if (_internal.daysModel.length > daysCount) {
                            for (i = 0; i < _internal.daysModel.length - daysCount; ++i) {
                                _internal.daysModel.pop()
                                _internal.daysModelChanged()
                            }
                        }
                    }
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
}
