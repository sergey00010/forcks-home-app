import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

Item {
        ColumnLayout{
            anchors.fill: parent;
            spacing: 10

            ColumnLayout{
                id:deviceNameBlock
                Layout.fillWidth: true
                Layout.preferredHeight: parent.height * 0.2
                spacing:3
                Text{
                    text: "device name: "
                    Layout.fillWidth: true
                    font.pointSize: 20
                }
                TextField{
                    id:deviceNameField
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    placeholderText: "device name"
        
                }
            }

            ColumnLayout{
                id:devicePortBlock
                Layout.fillWidth: true
                Layout.preferredHeight: parent.height * 0.2
                spacing:3
                Text{
                    text: "device port: "
                    Layout.fillWidth: true
                    font.pointSize: 20
                }
                TextField{
                    id:devicePortField
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    placeholderText: "device port"
                }
            }

            ColumnLayout{
                id:devicetypeBlock
                Layout.fillWidth: true
                Layout.preferredHeight: parent.height * 0.2
                spacing:3
                Text{
                    text: "device type: "
                    Layout.fillWidth: true
                    font.pointSize: 20
                }
                RowLayout{
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    ComboBox{
                        id:deviceTypeBox
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        model:["socket","lamp"]
                    }
                    Image {
                        id: deviceIcon
                        Layout.preferredWidth: parent.width * 0.3
                        Layout.preferredHeight: width
                        source: "qrc:/images/socket.png"
                        fillMode: Image.PreserveAspectFit
                    }
                }
            }

            RowLayout{
                id:actionsButtonsLayout
                Layout.fillWidth: true
                Layout.preferredHeight: parent.height * 0.2
                spacing:3
                CustomButton {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    textButton: "create"
                    onButtonClicked: {

                    }
                }
                CustomButton {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    textButton: "back"
                    onButtonClicked: {
                    }
                }
            }
            Item {
                id: empty
                Layout.fillWidth : true
                Layout.preferredHeight: parent.height * 0.4
            }
        }

}
