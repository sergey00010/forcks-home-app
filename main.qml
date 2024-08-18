import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

ApplicationWindow  {
    width: 720 * 0.5
    height: 1280 * 0.5
    visible: true
    title: qsTr("Hello World")

    Material.theme: Material.Dark
    Material.accent: Material.DeepPurple

    property int standartRadius: 10
    property int standartFontSize: 20
    property color mainColor: "#d1c4e9"
    property color variantColor: "#b39ddb"

    property color secondColor: "#ede7f6"
    property color secondVariantColor: "#3700B3"

    property color fontColor: "#FFFFFF"


        /*
        Button{
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "off"
            onClicked: {
                client.sendMessage("rele1 off")
            }
        }
        Button{
            Layout.fillWidth: true
            Layout.fillHeight: true
            text: "on"
            onClicked: {
                client.sendMessage("rele1 on")
            }
        }
        */

    menuBar: MenuBar {
           Menu {
               title: qsTr("&Device")
               Action {
                   text: qsTr("&New...")
                   onTriggered: {
                        mainStackView.push(createNewDevice)
                    }
                   }
               MenuSeparator { }
               Action {
                text: qsTr("&Quit")
                onTriggered: {
                    Qt.quit()
                }
            }
        }
    }
    StackView{
        id: mainStackView
        visible: true
        anchors.fill: parent
        initialItem: smartDevicesList

        ListView{
            id:smartDevicesList
            visible: true
            width: parent.width * 0.9
            height: parent.height * 0.9
            anchors.top:parent.top
            anchors.left: parent.left
            anchors.topMargin: height * 0.02
            anchors.leftMargin: (parent.width - width) * 0.5
            model:listDeviceModel
            delegate: Item {
                width: smartDevicesList.width
                height: width * 0.3
                    DeviceBlock {
                        id:deviceBlock
                        anchors.centerIn: parent
                        width: smartDevicesList.width *0.95
                        height: parent.height * 0.9
                        nameDevice: model.nameDevice
                        deviceType:model.typeDevice
                        srcImage: model.pathToIcon
                        arduinoPort: model.portInArduino
                        stackview:  mainStackView
                        index: model.index
                }
            }
        }
        CreateNewDeviceForm {
            id:createNewDevice
            visible: false
            stackView: mainStackView
        }
    }
}
