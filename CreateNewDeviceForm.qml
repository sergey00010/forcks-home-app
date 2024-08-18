import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts

Item {
    property StackView stackView
        ColumnLayout{
            width: parent.width
            height: parent.height
            spacing: 10

            ColumnLayout{
                id:deviceNameBlock
                Layout.fillWidth: true
                Layout.preferredHeight: parent.height * 0.2
                spacing:3
                Text{
                    text: "device name: "
                    Layout.fillWidth: true
                    font.pointSize: standartFontSize
                    color: fontColor
                }
                TextField{
                    id:deviceNameField
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    placeholderText: "device name"
                    font.pointSize: standartFontSize
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
                    font.pointSize: standartFontSize
                    color: fontColor
                }
                TextField{
                    id:devicePortField
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    placeholderText: "device port"
                    font.pointSize: standartFontSize
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
                    font.pointSize: standartFontSize
                    color: fontColor
                }
                RowLayout{
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    ComboBox{
                        id:deviceTypeBox
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        model:deviceModel
                        textRole: "typeDevice"
                        font.pointSize: standartFontSize
                        onCurrentIndexChanged: {
                            //deviceIcon.source = deviceModel.get(currentIndex).pathToIcon
                            deviceIcon.source = deviceModel.getIconPath(currentIndex)
                        }
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
                Layout.preferredHeight: parent.height * 0.1
                spacing:3
                CustomButton {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    cornerRadius: standartRadius
                    textButton: "create"
                    onButtonClicked: {
                        device.saveNewDevice(deviceNameField.text,deviceTypeBox.currentText,deviceIcon.source,devicePortField.text);
                        stackView.pop()
                    }
                }
                CustomButton {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    cornerRadius: standartRadius
                    textButton: "back"
                    onButtonClicked: {
                        stackView.pop()
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
