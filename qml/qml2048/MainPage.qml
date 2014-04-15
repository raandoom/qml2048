import QtQuick 1.1
import com.nokia.meego 1.0

Page {
    tools: commonTools
    orientationLock: PageOrientation.LockPortrait

    Rectangle {
        anchors.fill: parent
        color: "#faf8ef"

        ScoreArea {
            id: score
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - 10
            height: board.y - 10
            y: 5
        }

        Board {
            id: board
            anchors.centerIn: parent
            width: parent.width - 10

            onMerged: score.addScore(value, board.grid_size)

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
        score.reset(size)
        board.newGame(size)
    }
}
