import QtQuick 1.1
import com.nokia.meego 1.0

Page {
    tools: commonTools
    orientationLock: PageOrientation.LockPortrait

    Rectangle {
        anchors.fill: parent
        color: "#faf8ef"

        Column {
            spacing: 2
            width: parent.width - 10
            anchors.horizontalCenter: parent.horizontalCenter

            ScoreArea {
                id: score
                width: parent.width
                height: 130
            }

            Board {
                id: board
                width: parent.width

                onMerged: score.addScore(value)

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
    }

    function newGameRequest(size) {
        board.newGame(size)
    }
}
