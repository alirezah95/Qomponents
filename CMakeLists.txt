cmake_minimum_required(VERSION 3.24.1)

set(PROJECT_NAME "QmlCommonComponents")
set(PROJECT_VERSION_MAJOR 1)
set(PROJECT_VERSION_MINOR 1)
set(PROJECT_VERSION_PATCH 0)
set(PROJECT_VERSION_TWEAK 1)
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
set(PROJECT_HOMEPAGE_URL "https://github.com/alirezah95/QmlCommonComponents")


if(QT_VERSION_MAJOR EQUAL 6)
    # For Qt 6.2.x and Qt 6.3.x, major version in qt_add_qml_module() must be
    # greater than zero otherwise module is not registered
    qt_add_qml_module(${PROJECT_NAME}
        URI "QmlCommonComponents"
        SHARED
        OUTPUT_DIRECTORY
            ${CMAKE_BINARY_DIR}/${PROJECT_NAME}
        VERSION ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
        QML_FILES
            src/qml/BusyIndicatorPopup.qml
            src/qml/MessagePopup.qml
            src/qml/BusyIndicatorBalls.qml
            src/qml/BusyIndicatorDotCircle.qml
        )
endif()
