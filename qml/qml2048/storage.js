var db = null;

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
}

function setHighscore(score, size)
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
    openDb();
    var topscore = 0;
    db.transaction(function(tx){
                       var rs = tx.executeSql("SELECT score FROM highscores WHERE size=? ORDER BY score DESC LIMIT 1",[size])

                       if(rs.rows.length == 0)
                           topscore = 0
                       else
                           topscore = rs.rows.item(0).score
                   })
    return topscore;
}
