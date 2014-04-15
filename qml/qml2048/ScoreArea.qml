// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "storage.js" as Storage

Row {
    spacing: 6

    property int score;
    property int highscore;

    function reset(gridSize)
    {
        console.log("Starting new game of size " + gridSize);
        score = 0;
        scoretext.text = score;

        highscore = Storage.getHighscore(gridSize);
        highscoretext.text = highscore;
    }

    function addScore(scoreToAdd, gridSize)
    {
        score += scoreToAdd;
        scoretext.text = score;

        if(highscore < score)
        {
            Storage.setHighscore(score,gridSize);
            highscore = score;
            highscoretext.text = highscore;
        }

        Storage.addScore(score,gridSize);
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
                    id: scoretext
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
                    id: highscoretext
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
