import QtQuick 2.6
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import Qt.labs.settings 1.0

import "../texts"
import "../components"

Item {
    id: expertSettings
    implicitHeight: layout.implicitHeight
    implicitWidth:  layout.implicitWidth


    Settings {
        property alias enableExpertModeState : enableExpertMode.checked
        property alias enableStationInfoDisplayState: enableStationInfoDisplay.checked
        property alias enableSpectrumDisplayState: enableSpectrumDisplay.checked
        property alias enableImpulseResponseDisplayState: enableImpulseResponseDisplay.checked
        property alias enableConstellationDisplayState: enableConstellationDisplay.checked
        property alias enableNullSymbolDisplayState: enableNullSymbolDisplay.checked
    }

    property alias enableExpertModeState : enableExpertMode.checked
    property alias enableStationInfoDisplayState : enableStationInfoDisplay.checked
    property alias enableSpectrumDisplayState: enableSpectrumDisplay.checked
    property alias enableImpulseResponseDisplayState: enableImpulseResponseDisplay.checked
    property alias enableConstellationDisplayState: enableConstellationDisplay.checked
    property alias enableNullSymbolDisplayState: enableNullSymbolDisplay.checked

    ColumnLayout{
        id: layout
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: Units.dp(20)

        SettingSection {
            id: settingsFrame
            isNotFirst: false
            text: qsTr("Global")

            SettingSwitch {
                id: enableExpertMode
                text: qsTr("Expert mode")
                checked: false
            }
        }

        SettingSection {
            text: qsTr("Modules")
            enabled: enableExpertMode.checked

            SettingSwitch {
                id: enableStationInfoDisplay
                text: qsTr("Display station info")
                checked: true
            }

            SettingSwitch {
                id: enableSpectrumDisplay
                text: qsTr("Display spectrum")
                checked: true
            }

            SettingSwitch {
                id: enableImpulseResponseDisplay
                text: qsTr("Display impulse response")
                checked: false
            }

            SettingSwitch {
                id: enableConstellationDisplay
                text: qsTr("Display constellation diagram")
                checked: false
            }

            SettingSwitch {
                id: enableNullSymbolDisplay
                text: qsTr("Display null symbol")
                checked: false
            }
        }

        SettingSection {
            text: qsTr("Backend")
            enabled: enableExpertMode.checked

            SettingSwitch {
                id: disableCoarse
                text: qsTr("Disable Coarse Corrector (for receivers with <1kHz error)")
                checked: true
                onClicked: {
                    cppGUI.inputDisableCoarseCorrector(checked)
                }
            }

            SettingSwitch {
                id: decodeTII
                text: qsTr("Enable TII decoding to console log (increases CPU usage)")
                checked: false
                onClicked: {
                    cppGUI.inputEnableTIIDecode(checked)
                }
            }

            SettingSwitch {
                id: oldFFTWindow
                text: qsTr("Select old FFT placement algorithm (experimental)")
                checked: false
                onClicked: {
                    cppGUI.inputEnableOldFFTWindowPlacement(checked)
                }
            }

            ComboBox {
                id: freqSyncMethodBox
                font.pixelSize: TextStyle.textStandartSize
                font.family: TextStyle.textFont
                model: [ "GetMiddle", "CorrelatePRS", "PatternOfZeros" ];
                Layout.preferredHeight: Units.dp(25)
                Layout.preferredWidth: Units.dp(330)
                onActivated: {
                    cppGUI.inputSetFreqSyncMethod(index)
                }
            }
        }
    }
}