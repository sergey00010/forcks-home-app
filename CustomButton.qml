import QtQuick 2.15
import QtQuick.Controls 2.15


Rectangle {
    id: button
    property string textButton: "click"
    property color normalColor:  mainColor // Primary color
    property color rippleColor: variantColor // Darker color for ripple effect
    property color textColor: "white"
    property int cornerRadius: standartRadius
    property int elevation: 2
    signal buttonClicked

    width: 200
    height: 48
    color: normalColor
    radius: cornerRadius
    border.color: rippleColor// Transparent border

    // Shadow for elevation effect
    Rectangle {
        anchors.fill: parent
        color: "#00000000" // Transparent shadow
        radius: parent.radius
        z: -1
        border.color: "#000000"
        border.width: elevation
        opacity: 0.9
    }

    // Button text
    Text {
        text: textButton
        color: textColor
        anchors.centerIn: parent
        font.pointSize: standartFontSize
    }


    // Ripple effect on click
    Rectangle {
        id: ripple
        width: 0
        height: 0
        color: rippleColor
        radius: parent.radius
        anchors.centerIn: parent
        z: 1
        opacity: 0
        Behavior on width {
            NumberAnimation { duration: 200 }
        }
        Behavior on height {
            NumberAnimation { duration: 200 }
        }
        Behavior on opacity {
            NumberAnimation { duration: 200 }
        }
        onOpacityChanged: {
            if (opacity === 0) {
                width = 0
                height = 0
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            ripple.width = parent.width
            ripple.height = parent.height
            ripple.opacity = 0.3
            ripple.radius = parent.radius
            ripple.color = rippleColor
            ripple.opacity = 0
            ripple.width = 0
            ripple.height = 0
            buttonClicked()
        }
        onPressedChanged: {
            if (pressed) {
                button.color = rippleColor // Darker color for pressed state
            } else {
                button.color = normalColor
            }
        }
    }
}
