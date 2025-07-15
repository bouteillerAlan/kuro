import QtQuick
import QtQuick.Window

Rectangle {
    id: root
    color: "#000000"
    property int stage

    onStageChanged: {
        if (stage == 1) {
            introAnimation.running = true;
        } else if (stage == 5) {
            introAnimation.target = busyIndicator;
            introAnimation.from = 1;
            introAnimation.to = 0;
            introAnimation.running = true;
        }
    }

    Item {
        id: content
        anchors.fill: parent
        opacity: 0
        TextMetrics {
            id: units
            text: "M"
            property int gridUnit: boundingRect.height
            property int largeSpacing: units.gridUnit
            property int smallSpacing: Math.max(2, gridUnit/4)
        }

        Rectangle {

        //property int sizeAnim: 500

        id: imageSource
        width:  800
        height: 600
        color:  "transparent"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        clip: true;

        AnimatedImage {
            id: face
            source: "images/kuro_oled.gif"
            paused: false
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width:  798
            height: 598
            smooth: true
            visible: true
         }
    }

       Image {
            id: busyIndicator
            y: parent.height - 200
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.margins: units.gridUnit
            source: "images/loading.svgz"
            sourceSize.height: units.gridUnit * 2
            sourceSize.width: units.gridUnit * 2
            RotationAnimator on rotation {
                id: rotationAnimator
                from: 0
                to: 360
                duration: 1500
                loops: Animation.Infinite
            }
        }
        Row {
            opacity: 1
            spacing: units.smallSpacing*3
            anchors {
                bottom: parent.bottom
                margins: units.gridUnit
            }
            anchors.horizontalCenter: parent.horizontalCenter

        }
    }

    OpacityAnimator {
        id: introAnimation
        running: false
        target: content
        from: 0
        to: 1
        duration: 1000
        easing.type: Easing.InOutQuad
    }
}
