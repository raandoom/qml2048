// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "tile.js" as Tile
import "storage.js" as Storage

Rectangle {

    id: cell

    property int value
    // position for move
    property variant new_x: null
    property variant new_y: null
    // if tile merged with some other
    property bool merged: false
    // tile which merged with this (used for kill animation)
    property variant merged_cell
    // signal for board
    property bool emitMoved: false
    signal moved

    radius: 3
    width: 0
    height: 0
    color: "#00000000"

    function show(pos,size) {
        x = pos.x
        y = pos.y
        width = size
        height = size
        Tile.show()
    }

    function move() {
        Tile.move()
    }

    function kill() {
        kill_scale.duration = Storage.animation_speed
        kill_opac.duration = Storage.animation_speed
        kill_anim.start()
    }

    PropertyAnimation {
        id: show_anim
        target: labelContainer
        properties: "width,height"
        duration: 200
        from: 0
        easing.type: Easing.OutBack
        onRunningChanged: {
            if (!running) { // animation completed
                label.text = value
                Tile.updateTextSize()
            }
        }
    }

    PropertyAnimation {
        id: move_anim
        target: cell
        properties: "pos"
        duration: 200
        onRunningChanged: {
            if (!running) { // animation completed
                label.text = value
                if (merged_cell) {
                    merged_cell.kill()
                    merged_cell = null
                }
                if (emitMoved) {
                    emitMoved = false
                    moved()
                }
            }
        }
    }

    ParallelAnimation {
        id: kill_anim
        PropertyAnimation { id: kill_scale; target: cell; property: "scale"; duration: 200; from: 1; to: 2; }
        PropertyAnimation { id: kill_opac; target: cell; property: "opacity"; duration: 200; from: 1; to: 0; }
        onRunningChanged: {
            if (!running) { // animation completed
                cell.destroy()
            }
        }

    }

    Rectangle {
        id: labelContainer

        // cell center point (used for show animation)
        property int center_x
        property int center_y

        // keep container center at tile center
        onWidthChanged: x = cell.width / 2 - width / 2
        onHeightChanged: y = cell.height / 2 - height / 2

        width: 0
        height: 0
        color: "#eee4da"
        radius: 3

        Text {
            id: label
            anchors.centerIn: parent
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            color: "#776e65"
            font.bold: true
            font.pixelSize: cell.height / 2
            onTextChanged: {
                Tile.updateTextSize()
                Tile.updateColor()
            }
        }
    }
}
