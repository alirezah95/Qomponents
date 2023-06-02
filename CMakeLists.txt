cmake_minimum_required(VERSION 3.24.1)

find_package(QT NAMES Qt6 Qt5)

set(PROJECT_NAME "Qomponents")
set(PROJECT_VERSION_MAJOR 1)
set(PROJECT_VERSION_MINOR 2)
set(PROJECT_VERSION_PATCH 0)
set(PROJECT_VERSION_TWEAK 0)
if (PROJECT_VERSION_TWEAK EQUAL 0)
    set(PROJECT_VERSION ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH})
else()
    set(PROJECT_VERSION ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}.${PROJECT_VERSION_PATCH}.${PROJECT_VERSION_TWEAK})
endif()
set(PROJECT_VERSION_TYPE "alpha")
set(PROJECT_LICENSE_TYPE "MIT")
set(PROJECT_CREATOR "Alireza Hasani")
set(PROJECT_LANGUAGES "QML")
set(PROJECT_DESCRIPTION "Contains components that is common in most QML applications")
set(PROJECT_HOMEPAGE_URL "https://github.com/alirezah95/Qomponents")

if(QT_VERSION_MAJOR EQUAL 6)
#    find_package(Qt6 REQUIRED COMPONENTS Core5Compat Quick)

    qt_add_qml_module(${PROJECT_NAME}
        URI "Qomponents"
        SHARED
        RESOURCES

        VERSION ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
        QML_FILES
            qml/BusyIndicator/BusyIndicatorPopup.qml
            qml/BusyIndicator/BusyIndicatorBalls.qml
            qml/BusyIndicator/BusyIndicatorDotCircle.qml

            qml/MessagePopup.qml

            qml/Utils/RoundImage.qml
            qml/Utils/ItemHintContainer.qml

            qml/Date/PersianDateTumbler.qml
            qml/Date/GregorianDateTumbler.qml
        )

    target_link_libraries(${PROJECT_NAME} PUBLIC
        Qt6::Quick
    )
endif()
