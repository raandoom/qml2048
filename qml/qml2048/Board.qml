// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "board.js" as Board
import "storage.js" as Storage

Rectangle {
    id: container

    property int start_count: 2

    property int grid_size: 0
    property int max_index: grid_size * grid_size

    property real grid_spacing: 4
    property real cell_size: (width - grid_spacing * (grid_size + 1)) / grid_size

    property bool listenActions: true

    signal merged(int value)
    signal end()

    function newGame(size) {
        if (size == null)
            size = grid_size
        Board.newGame(size)
    }

    function updateBackground(size) {
        grid_size = size
        Board.updateBackground(size)
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

    function loadTiles() {
        var t = Storage.getTiles(grid_size)
        if (t) {
            Board.array2tiles(t.split(':'))
        } else {
            Board.addStartTiles()
        }
    }

    function storeTiles() {
        Storage.setTiles(Board.tiles2array().join(':'),grid_size)
    }

    color: "#bbada0"
    radius: 6
    height: width
}
