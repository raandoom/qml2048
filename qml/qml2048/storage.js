.pragma library

var db = null
var animation_speed = 200

function openDb()
{
    if(db !== null) return
    db = openDatabaseSync("qml2048","1.0","qml2048 game data",100)
    db.transaction(ensureTablesExist)
}

// This ensures that the table exists.
// When updating, keep in mind there are users using an old version!
function ensureTablesExist(tx)
{
    tx.executeSql('CREATE TABLE IF NOT EXISTS highscores(score INT, size INT UNIQUE)',[])
    tx.executeSql('CREATE TABLE IF NOT EXISTS scores(score INT, size INT UNIQUE)',[])
    tx.executeSql('CREATE TABLE IF NOT EXISTS games(tiles TEXT, size INT UNIQUE)',[])
    tx.executeSql('CREATE TABLE IF NOT EXISTS state(key TEXT UNIQUE, value TEXT)',[])
}

function setHighscore(score,size)
{
    openDb()
    db.transaction(function(tx){
                       var rs = tx.executeSql(
                                   'INSERT OR REPLACE INTO highscores(score,size) VALUES (?,?)',
                                   [score,size])
                   })
}

function getHighscore(size)
{
    openDb()
    var topscore = 0
    db.transaction(function(tx){
                       var rs = tx.executeSql(
                                   'SELECT score FROM highscores WHERE size=? ORDER BY score DESC LIMIT 1',
                                   [size])
                       if(rs.rows.length > 0) {
                           topscore = rs.rows.item(0).score
                       }
                   })
    return topscore
}

function setScore(score,size)
{
    openDb()
    db.transaction(function(tx){
                       var rs = tx.executeSql(
                                   'INSERT OR REPLACE INTO scores(score,size) VALUES (?,?)',
                                   [score,size])
                   })
}

function getScore(size)
{
    openDb()
    var score = 0
    db.transaction(function(tx){
                       var rs = tx.executeSql(
                                   'SELECT score FROM scores WHERE size=? ORDER BY score DESC LIMIT 1',
                                   [size])
                       if(rs.rows.length > 0) {
                           score = rs.rows.item(0).score
                       }
                   })
    return score
}

function setTiles(tiles,size) {
    openDb()
    db.transaction(function(tx){
                       var rs = tx.executeSql(
                                   'INSERT OR REPLACE INTO games(tiles,size) VALUES (?,?)',
                                   [tiles,size])
                   })
}

function getTiles(size) {
    openDb()
    var tiles = 0
    db.transaction(function(tx){
                       var rs = tx.executeSql(
                                   'SELECT tiles FROM games WHERE size=?',
                                   [size])
                       if(rs.rows.length > 0) {
                           tiles = rs.rows.item(0).tiles
                       }
                   })
    return tiles
}

function setState(key,value) {
    openDb()
    db.transaction(function(tx){
                       var rs = tx.executeSql('INSERT OR REPLACE INTO state VALUES (?,?)',
                                              [key,value.toString()]);
                   })
}

function getState(key) {
    openDb()
    var value = null
    db.transaction(function(tx){
                       var rs = tx.executeSql("SELECT value FROM state WHERE key=?",[key])
                       if(rs.rows.length > 0) {
                           value = rs.rows.item(0).value
                       }
                   })
    return value
}
