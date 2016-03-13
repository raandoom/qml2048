// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0

Rectangle {

    signal newGameClicked()

    Column {
        anchors.centerIn: parent
        width: parent.width - 40
        spacing: 10

        Text {
            text: ":("
            color: "white"
            font.pixelSize: parent.width / 2
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Text {
            color: "white"
            font.pixelSize: 48
            width: parent.width
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: "It looks like there are no more moves available"

        }

        Button {
            text: "New game"
            anchors.horizontalCenter: parent.horizontalCenter
            onClicked: newGameClicked()
        }
    }

    function show() {
        show_anim.start()
    }

    function hide() {
        hide_anim.start()
    }

    PropertyAnimation {
        id: show_anim
        target: loseScreen
        property: "y"
        duration: 1000
        easing.type: Easing.OutBounce
        from: - height
        to: 0
    }

    PropertyAnimation {
        id: hide_anim
        target: loseScreen
        property: "y"
        duration: 500
        from: 0
        to: - height
    }
}
