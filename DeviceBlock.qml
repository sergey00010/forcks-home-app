import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

/*
Button{
                width: smartDevicesList.width
                height: width * 0.2
                text: model.nameDevice
                onClicked: {
                    client.sendMessage("rele1 on")
                }
            }
            */
Rectangle{
    id:mainDeviceBlock
    property string srcImage: "qrc:/images/socket.png"
    property string nameDevice: "123"
    property string deviceType: "123"
    property int arduinoPort: 12
    property int index: -1
    property StackView stackview


    Dialog{
        id:warningDeleteFile
        width: mainDeviceBlock.width
        height: mainDeviceBlock.height

        header: Text {
                    text: "Are you want to delete "+nameDevice+" ?"
                    font.pointSize: standartFontSize
                    color: fontColor
                    anchors.top: parent.top
                    horizontalAlignment: Text.AlignHCenter
                    wrapMode: Text.WordWrap
                }


        font.pointSize: standartFontSize
        standardButtons: Dialog.Ok | Dialog.Cancel

        onAccepted:{
            device.deleteDevice(nameDevice,arduinoPort,index)
        }

        onRejected: console.log("Cancel clicked")
    }

    MouseArea {
               id: mouseArea
               anchors.fill: parent

               Timer {
                   id: longPressTimer
                   interval: 2000  // 2 seconds
                   repeat: false
                   onTriggered: {
                       //stackview.push(removeDevice)
                       warningDeleteFile.open()
                   }
               }

               onPressed: {
                   longPressTimer.start();
               }

               onReleased: {
                   longPressTimer.stop();
               }

               onCanceled: {
                   longPressTimer.stop();
               }
           }


    color: secondColor
    radius: standartRadius

    RowLayout{
        anchors.centerIn: parent
        width: parent.width * 0.95
        height: parent.height * 0.95
        ColumnLayout{
            Layout.fillWidth: true
            Layout.fillHeight: true
            Text {
                id: nameDeviceText
                text: "Name device: "+nameDevice
                font.pointSize: standartFontSize
            }
            Text {
                id: typeDeviceText
                text: "Type device: "+deviceType
                font.pointSize: typeDeviceText
            }
            RowLayout{
                Layout.fillWidth: true
                Layout.preferredHeight: parent.height * 0.3
                CustomButton{
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    cornerRadius: standartRadius
                    textButton: "on"
                    onButtonClicked: {
                        client.sendMessage(arduinoPort+"_off")
                    }
                }
                CustomButton{
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    cornerRadius: standartRadius
                    textButton: "off"
                    onButtonClicked: {
                        client.sendMessage(arduinoPort+"_on")
                    }
                }
            }
        }

        Image {
            id: icon
            Layout.preferredWidth: parent.width * 0.2
            Layout.fillHeight: true
            fillMode: Image.PreserveAspectFit
            source: srcImage
        }
    }
}
