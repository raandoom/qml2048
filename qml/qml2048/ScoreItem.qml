// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Item {
    id: container

    property string text
    property int value

    Rectangle {
        width: parent.width * 0.9
        height: parent.height * 0.6
        radius: 6
        anchors.centerIn: parent
        color: "#bbada0"
        Column {
            anchors.fill: parent
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: parent.height * 0.25
                font.bold: true
                color: "#eee4da"
                text: container.text
            }
            Text {
                anchors.horizontalCenter: parent.horizontalCenter
                font.pixelSize: parent.height * 0.6
                font.bold: true
                color: "#ffffff"
                text: container.value

                onTextChanged: {
                    if (width > parent.width)
                        scale = parent.width / width * 0.9
                    else
                        scale = 1
                }
            }
        }
    }
}
