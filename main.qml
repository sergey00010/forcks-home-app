import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

ApplicationWindow  {
    width: 720 * 0.5
    height: 1280 * 0.5
    visible: true
    title: qsTr("Hello World")

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
        initialItem: createNewDevice

        ListView{
            id:smartDevicesList
            visible: false
            width: parent.width * 0.9
            height: parent.height * 0.9
            anchors.top:parent.top
            anchors.left: parent.left
            anchors.topMargin: height * 0.02
            anchors.leftMargin: (parent.width - width) * 0.5
            model:listDeviceModel
            delegate: Button{
                width: smartDevicesList.width
                height: width * 0.2
                text: model.nameDevice
                onClicked: {
                    client.sendMessage("rele1 on")
                }
            }
        }
        CreateNewDeviceForm {
            id:createNewDevice
            visible: true
        }
    }
}
