// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0

Dialog {

    property string version: "<empty>"

    title: [
        Text {
            text: qsTr("About")
            color: "white"
            font.pixelSize: 24
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        },
        Rectangle {
            height: 1
            width: parent.width
            anchors.bottom: parent.bottom
            color: "white"
        }
    ]

    content: [
        Rectangle {
            id: image
            width: parent.width / 3
            height: width
            x: 20
            y: 20
            color: "gold"

            Text {
                anchors.centerIn: parent
                text: "2048"
                color: "white"
                font.pixelSize: parent.height / 3
                font.bold: true
            }
        },
        Column {
            x: image.x + image.height + 20
            y:20
            Text { text: qsTr("qml2048"); color: "white"; font.pixelSize: 42; font.bold: true; }
            Text { text: qsTr(version); color: "white"; font.pixelSize: 18; }
            Text { text: qsTr("by raandoom"); color: "white"; font.pixelSize: 24; }
            Text { text: qsTr("(Savkin Sergey)"); color: "white"; font.pixelSize: 24; }
        },
        Text {
            x: 20
            y: image.y + image.height + 20
            width: parent.width - 40
            wrapMode: Text.WordWrap
            font.pixelSize: 24
            color: "white"
            text:
                "Sources can be found at: " +
                "<a href=https://github.com/raandoom/qml2048>https://github.com/raandoom/qml2048</a>" +
                "<br><br>" +
                "This application is based on the 2048 game created by Gabriele Cirulli: " +
                "<a href=http://git.io/2048>http://git.io/2048</a>"

            onLinkActivated: Qt.openUrlExternally(link)
        }
    ]
}
