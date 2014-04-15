var db = null;

// Opens the sqlite database for the topscores.
function openDb()
{
    if(db !== null) return;
    db = openDatabaseSync("QmlTwoKTopscore", "1.0", "Database for qml2048 scores", 100);
    db.transaction(ensureTablesExist);
}

// This ensures that the table exists.
// When updating, keep in mind there are users using an old version!
function ensureTablesExist(tx)
{
    tx.executeSql('CREATE TABLE IF NOT EXISTS highscores(score INT, size INT UNIQUE)', []);
}

// Called when a block is merged and a score has to be added.
function setHighscore(score, size)
{
    console.log("Saving highscore of size " + size);
    openDb();
    db.transaction(function(tx){
        var rs = tx.executeSql('INSERT OR REPLACE INTO highscores(score,size) VALUES (?,?)',[score, size]);
        console.debug("Rows affected: " + rs.rowsAffected);
    })
}

// Called when the field is to be reset with the new gridsize specified.
function getHighscore(size)
{
    openDb();
    var topscore = 0;
    db.transaction(
        function(tx){
            var rs = tx.executeSql("SELECT score FROM highscores WHERE size=? ORDER BY score DESC LIMIT 1",[size]);
            if(rs.rows.length === 0)
            {
                topscore = 0;
            }
            else
            {
                topscore = rs.rows.item(0).score;
            }
        })
    return topscore;
}
