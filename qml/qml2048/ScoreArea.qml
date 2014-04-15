// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
//import "topscore.js" as Topscore

Row {
    spacing: 6

    property int score;
    property int topscore;

    function __db()
    {
        var _db = openDatabaseSync("QmlTwoKTopscore", "1.0", "Database for qml2048 scores", 100);
        _db.transaction(__ensureTables);
        return _db;
    }


    function __ensureTables(__tx)
    {
        __tx.executeSql('CREATE TABLE IF NOT EXISTS highscores(score INT, size INT)', []);
    }

    function addScore(toAddScore, size)
    {
        score += toAddScore;
        lblcurrentscore.text = score;

        if(topscore < score)
        {
            console.log("Saving highscore of size " + size);
            topscore = score;
            lbltopscore.text = topscore;
            __db().transaction(function(tx){
                                   tx.executeSql("DELETE FROM highscores WHERE size=?",[size]); // Keep the db clean
                                   var rs = tx.executeSql('INSERT INTO highscores(score,size) VALUES (?,?)',[topscore, size]);
                                   console.debug("Rows affected: " + rs.rowsAffected);
            })
            //Topscore.saveScore(topscore, size);
        }
    }
    function reset(size)
    {
        console.log("Starting new game of size " + size);
        score = 0;
        lblcurrentscore.text = score;

        __db().transaction(function(tx){
                           var rs = tx.executeSql("SELECT score FROM highscores WHERE size=? ORDER BY score DESC LIMIT 1",[size]);
                           if(rs.rows.length === 0)
                           {
                               topscore = 0;
                           }
                           else
                           {
                               topscore = rs.rows.item(0).score;
                           }
                           lbltopscore.text = topscore;
                       })
    }

    Item {
        width: (parent.width - parent.spacing)*.5
        height:parent.height
        Rectangle {
            width: parent.width*.8
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            radius: 8
            height: 70
            color: "#bbada0"
            Column {
                width: parent.width
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: "Clear Sans"
                    font.pointSize: 16
                    color: "#eee4da"
                    text: "SCORE"
                }
                Text {
                    id: lblcurrentscore
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: "Clear Sans"
                    font.pointSize: 24
                    font.bold: true
                    color: "#ffffff"
                    text: "0"
                }
            }
        }
    }

    Item {
        width: (parent.width - parent.spacing)*.5
        height:parent.height
        Rectangle {
            width: parent.width * 0.8
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            radius: 8
            height: 70
            color: "#bbada0"
            Column {
                width: parent.width
                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: "Clear Sans"
                    font.pointSize: 16
                    color: "#eee4da"
                    text: "BEST"
                }
                Text {
                    id: lbltopscore
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.family: "Clear Sans"
                    font.pointSize: 24
                    font.bold: true
                    color: "#ffffff"
                    text: "0"
                }
            }
        }
    }
}
