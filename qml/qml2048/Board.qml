// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "board.js" as Board

Rectangle {
    id: container

    property int start_count: 2

    property int grid_size: 4
    property int max_index: grid_size * grid_size

    property real grid_spacing: 4
    property real cell_size: (width - grid_spacing * (grid_size + 1)) / grid_size

    property bool listenActions: false

    signal merged(int value)
    //onMerged: console.log("Merging " + value)

    function newGame(size) {
        Board.newGame(size)
    }

    function moveTilesUp() {
        if (listenActions) {
            listenActions = false
            Board.moveTilesUp()
        }
    }

    function moveTilesDown() {
        if (listenActions) {
            listenActions = false
            Board.moveTilesDown()
        }
    }

    function moveTilesLeft() {
        if (listenActions) {
            listenActions = false
            Board.moveTilesLeft()
        }
    }

    function moveTilesRight() {
        if (listenActions) {
            listenActions = false
            Board.moveTilesRight()
        }
    }

    color: "#bbada0"
    radius: 6
    height: width
}
