var backGroundCells = new Array
var tiles = new Array

// tile index from row and column
function index(row,column) {
    return column + row * grid_size
}

// tile row position from index
function row(index) {
    return Math.floor(index / grid_size)
}

// tile column position from index
function column(index) {
    return index % grid_size
}

// get cell position in grid for row and column
function cellPosition(row,column) {
    return Qt.point(grid_spacing + column * (cell_size + grid_spacing),
                    grid_spacing + row * (cell_size + grid_spacing))
}

// start new game
function newGame(size) {
    grid_size = size
    updateBackground()
    addStartTiles()
}

// build new board
function updateBackground() {
    // delete all tiles
    for (var i = 0; i < tiles.length; i++) {
        if (tiles[i] != null) {
            if (tiles[i].merged_cell)
                tiles[i].merged_cell.kill()
            tiles[i].destroy()
        }
    }
    tiles = new Array(max_index)

    // delete old background cells
    for (var i = 0; i < backGroundCells.length; i++) {
        if (backGroundCells[i] != null) {
            backGroundCells[i].destroy()
        }
    }
    backGroundCells = new Array(max_index)

    // create new background cells
    for (var i = 0; i < max_index; i++) {
        var comp = Qt.createComponent("Cell.qml")
        if (comp.status == Component.Ready) {
            var cellObj = comp.createObject(container)
            if (cellObj == null) {
                console.log("error creating cell")
                console.log(comp.errorString())
                return
            }

            cellObj.width = cell_size
            cellObj.height = cell_size
            cellObj.x = grid_spacing + column(i) * (cell_size + grid_spacing)
            cellObj.y = grid_spacing + row(i) * (cell_size + grid_spacing)
            backGroundCells[i] = cellObj

        } else {
            console.log("error loading cell component")
            console.log(comp.errorString())
            return
        }
    }
}

// add some random tiles
function addStartTiles() {
    for (var i = 0; i < start_count; i++) {
        addRandomTile()
    }
}

// add one random tile
function addRandomTile() {
    listenActions = true
    if (cellsAvailable()) {
        var value = Math.random() < 0.9 ? 2 : 4
        var comp = Qt.createComponent("Tile.qml")
        if (comp.status == Component.Ready) {
            var tileObj = comp.createObject(board)
            if (tileObj == null) {
                console.log("error creating tile")
                console.log(comp.errorString())
                return
            }

            tileObj.moved.connect(addRandomTile)

            tileObj.value = value
            var avIndex = randomAvailableCell()
            var position = cellPosition(row(avIndex),column(avIndex))
            tileObj.show(position,cell_size)
            tiles[avIndex] = tileObj
        } else {
            console.log("error loading tile component")
            console.log(comp.errorString())
            return
        }
    }
}

// check for empty cells
function cellsAvailable() {
    return !!availableCells().length
}

// get list with empty cells
function availableCells() {
    var avcells = []
    for (var i = 0; i < max_index; i++) {
        if (tiles[i] == null) {
            avcells.push(i)
        }
    }
    return avcells
}

// get random empty cell
function randomAvailableCell() {
    var avc = availableCells()
    if (avc.length) {
        return avc[Math.floor(Math.random() * avc.length)]
    }
}

// check if tiles can be merged
function canMergeTiles(from,to) {
    return  (tiles[from] != null)                   &&
            (tiles[to] != null)                     &&
            (tiles[from].merged == false)           &&
            (tiles[to].merged == false)             &&
            (tiles[from].value == tiles[to].value)
}

// move tile from index to index
function moveTile(from,to) {
    tiles[to] = tiles[from]
    tiles[from] = null
    var dest = cellPosition(row(to),column(to))
    tiles[to].new_x = dest.x
    tiles[to].new_y = dest.y
}

// prepare tile for merging
function prepareTileMerging(from,to) {
    tiles[from].merged = true
    tiles[from].merged_cell = tiles[to]
    tiles[from].merged_cell.z = 1
    tiles[from].value += tiles[from].value
}

// clean information about merge in all tiles
function cleanMergedFlags() {
    for (var i = 0; i < max_index; i++) {
        if (tiles[i] != null) {
            tiles[i].merged = false
        }
    }
}

// update all tiles
function updateTiles(moved) {
    listenActions = !moved
    for (var i = 0; moved && (i < max_index); i++) {
        if (tiles[i] != null) {
            tiles[i].move()
        }
    }
    cleanMergedFlags()
}

// try to move all tiles up
function moveTilesUp() {
    var moved = false
    var captured = false
    for (var column = 0; column < grid_size; column++) {
        for (var row = 0; row < grid_size; row++) {
            if (row > 0) {
                var ind = index(row,column)
                if (tiles[ind] != null) {
                    var preind = index(row - 1,column)

                    if (tiles[preind] == null) {

                        moved = true
                        moveTile(ind,preind)
                        row = 0

                    } else if (canMergeTiles(ind,preind)) {

                        moved = true
                        prepareTileMerging(ind,preind)
                        container.merged(tiles[ind].value);
                        moveTile(ind,preind)
                        row = 0

                    }

                    if (moved && !captured) {
                        tiles[preind].emitMoved = true
                        captured = true
                    }
                }
            } // if row > 0
        } // for row < grid_size
    } // for column < grid_size
    updateTiles(moved)
}

// try to move all tiles down
function moveTilesDown() {
    var moved = false
    var captured = false
    for (var column = 0; column < grid_size; column++) {
        var row = grid_size
        while (row--) {
            if (grid_size - row > 1) {
                var ind = index(row,column)
                if (tiles[ind] != null) {
                    var preind = index(row + 1,column)

                    if (tiles[preind] == null) {

                        moved = true
                        moveTile(ind,preind)
                        row = grid_size

                    } else if (canMergeTiles(ind,preind)) {

                        moved = true
                        prepareTileMerging(ind,preind)
                        container.merged(tiles[ind].value);
                        moveTile(ind,preind)
                        row = grid_size

                    }

                    if (moved && !captured) {
                        tiles[preind].emitMoved = true
                        captured = true
                    }
                }
            } // if grid_size - row > 1
        } // while row--
    } // for column < grid_size
    updateTiles(moved)
}

// try to move all tile left
function moveTilesLeft() {
    var moved = false
    var captured = false
    for (var row = 0; row < grid_size; row++) {
        for (var column = 0; column < grid_size; column++) {
            if (column > 0) {
                var ind = index(row,column)
                if (tiles[ind] != null) {
                    var preind = index(row,column - 1)
                    var prePosition = cellPosition(row,column - 1)

                    if (tiles[preind] == null) {

                        moved = true
                        moveTile(ind,preind)
                        column = 0

                    } else if (canMergeTiles(ind,preind)) {

                        moved = true
                        prepareTileMerging(ind,preind)
                        container.merged(tiles[ind].value);
                        moveTile(ind,preind)
                        column = 0

                    }

                    if (moved && !captured) {
                        tiles[preind].emitMoved = true
                        captured = true
                    }
                }
            } // if column > 0
        } // for column < grid_size
    } // for row < grid_size
    updateTiles(moved)
}

// try to move all tiles right
function moveTilesRight() {
    var moved = false
    var captured = false
    for (var row = 0; row < grid_size; row++) {
        var column = grid_size
        while (column--) {
            if (grid_size - column > 1) {
                var ind = index(row,column)
                if (tiles[ind] != null) {
                    var preind = index(row,column + 1)
                    var prePosition = cellPosition(row,column + 1)

                    if (tiles[preind] == null) {

                        moved = true
                        moveTile(ind,preind)
                        column = grid_size

                    } else if (canMergeTiles(ind,preind)) {

                        moved = true
                        prepareTileMerging(ind,preind)
                        container.merged(tiles[ind].value);
                        moveTile(ind,preind)
                        column = grid_size

                    }

                    if (moved && !captured) {
                        tiles[preind].emitMoved = true
                        captured = true
                    }
                }
            } // if grid_size - column > 1
        } // while column--
    } // for row < grid_size
    updateTiles(moved)
}
