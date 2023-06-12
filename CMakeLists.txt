cmake_minimum_required(VERSION 3.24.1)

find_package(QT NAMES Qt6 Qt5)

set(PROJECT_NAME "Qomponents")
set(PROJECT_VERSION_MAJOR 1)
set(PROJECT_VERSION_MINOR 3)
set(PROJECT_VERSION_PATCH 1)
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

    # Qomponents module
    qt_add_qml_module(${PROJECT_NAME}
        URI "${PROJECT_NAME}"
        SHARED
        OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
        RESOURCES

        VERSION ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
        QML_FILES
            qml/RoundImage.qml
            qml/ItemHintContainer.qml
        )

    qt_add_qml_module(${PROJECT_NAME}Material
        URI "${PROJECT_NAME}.Material"
        OUTPUT_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/Material
        RESOURCES

        VERSION 1.0
        QML_FILES
            qml/Material/BusyIndicators/BusyIndicatorPopup.qml
            qml/Material/BusyIndicators/BusyIndicatorBalls.qml
            qml/Material/BusyIndicators/BusyIndicatorDotCircle.qml
            qml/Material/BusyIndicators/BusyIndicatorTwoCircles.qml

            qml/Material/Controls/MessagePopup.qml
            qml/Material/Controls/PersianDateTumbler.qml
            qml/Material/Controls/GregorianDateTumbler.qml
            qml/Material/Controls/ButtonBordered.qml
            qml/Material/Controls/TabBarVertical.qml
            qml/Material/Controls/SwitchTheme.qml
        )

    target_link_libraries(${PROJECT_NAME} PUBLIC
        Qt6::Quick
        ${PROJECT_NAME}Material
    )
endif()
