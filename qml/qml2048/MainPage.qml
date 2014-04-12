import QtQuick 1.1
import com.nokia.meego 1.0

Page {
    tools: commonTools
    orientationLock: PageOrientation.LockPortrait

    Rectangle {
        anchors.fill: parent
        color: "#faf8ef"

        Board {
            id: board
            anchors.centerIn: parent
            width: parent.width - 10

            SwipeArea {
                id: swipe
                anchors.fill: parent

                onSwipeUp: board.moveTilesUp()
                onSwipeDown: board.moveTilesDown()
                onSwipeLeft: board.moveTilesLeft()
                onSwipeRight: board.moveTilesRight()
            }
        }
    }

    function newGameRequest(size) {
        board.newGame(size)
    }
}
