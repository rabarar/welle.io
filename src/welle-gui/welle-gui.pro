include(../backend.pri)

TEMPLATE = app
TARGET = welle-io
QT += network qml quick charts multimedia

RC_ICONS   =    icon/icon.ico
RESOURCES +=    resources.qrc
DISTFILES +=    \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat \
    android/java/io/welle/welle/DabMediaService.java \
    android/java/io/welle/welle/DabService.java \
    android/java/io/welle/welle/DabDelegate.java \
    QML/MainView.qml \
    QML/RadioView.qml \
    QML/ExpertView.qml \
    QML/texts/TextStyle.qml \
    QML/texts/TextTitle.qml \
    QML/texts/TextStandart.qml \
    QML/texts/TextStation.qml \
    QML/texts/TextRadioInfo.qml \
    QML/texts/TextRadioStation.qml \
    QML/texts/TextExpert.qml \
    QML/InfoPage.qml \
    QML/settingpages/ExpertSettings.qml \
    QML/settingpages/GlobalSettings.qml \
    QML/settingpages/ChannelSettings.qml \
    QML/settingpages/RTLSDRSettings.qml \
    QML/settingpages/RTLTCPSettings.qml \
    QML/settingpages/SoapySDRSettings.qml \
    QML/settingpages/ExpertSettings.qml \
    QML/settingpages/NullSettings.qml \
    QML/components/MessagePopup.qml \
    QML/components/SettingSection.qml \
    QML/components/StationDelegate.qml \
    QML/components/Units.qml \
    QML/expertviews/ImpulseResponseGraph.qml \
    QML/expertviews/ConstellationGraph.qml \
    QML/expertviews/NullSymbolGraph.qml \
    QML/expertviews/SpectrumGraph.qml \
    QML/expertviews/TextOutputView.qml \
    QML/expertviews/RawRecorder.qml \
    QML/components/StationListModel.qml \
    QML/MotView.qml \
    QML/components/ViewBaseFrame.qml \
    QML/GeneralView.qml \
    QML/settingpages/RawFileSettings.qml \
    QML/components/WComboBox.qml \
    QML/components/WButton.qml \
    QML/components/WPopup.qml \
    QML/components/WSwitch.qml \
    QML/components/WTumbler.qml \
    QML/expertviews/ServiceDetails.qml

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android

TRANSLATIONS = i18n/de_DE.ts \
    i18n/it_IT.ts \
    i18n/hu_HU.ts \
    i18n/nb_NO.ts \
    i18n/fr_FR.ts \
    i18n/pl_PL.ts \
    i18n/ru_RU.ts

lupdate_only{ # Workaround for lupdate to scan QML files
SOURCES += QML/*.qml \
    QML/texts/*.qml \
    QML/settingpages/*.qml \
    QML/components/*.qml \
    QML/expertviews/*.qml \
}

HEADERS += \
    audio_output.h \
    debug_output.h \
    gui_helper.h \
    mot_image_provider.h \
    radio_controller.h

SOURCES += \
    main.cpp \
    audio_output.cpp \
    debug_output.cpp \
    gui_helper.cpp \
    mot_image_provider.cpp \
    radio_controller.cpp

android {
    QT += androidextras
#    QT += remoteobjects
#    LIBS += -ljnigraphics

#    HEADERS      += android_jni.h
#    SOURCES      += android_jni.cpp
#    REPC_SOURCE  += radio_controller.rep
#    REPC_REPLICA += radio_controller.rep
}

# Include git hash into build
unix:!macx { # macOS is not tested, exclude it
    GITHASHSTRING = $$system(git rev-parse --short HEAD)
}

win32 {
    GITHASHSTRING = $$system(git.exe rev-parse --short HEAD)
} else:macx {
    ICON = icon/icon.icns
}

!isEmpty(GITHASHSTRING) {
    message("Current git hash = $$GITHASHSTRING")
    DEFINES += GITHASH=\\\"$$GITHASHSTRING\\\"
}
else {
    warning("Can't get git hash.")
}
