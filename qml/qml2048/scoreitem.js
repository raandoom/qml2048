function fade() {
    var comp = Qt.createComponent("FadeText.qml")
    if (comp.status == Component.Ready) {
        var fadeObj = comp.createObject(score)
        if (fadeObj == null) {
            console.log("error creating fade object")
            console.log(comp.errorString())
            return
        }

        fadeObj.width = score.width
        fadeObj.height = score.height
        fadeObj.x = 0
        fadeObj.y = 0
        fadeObj.text = score.text
        fadeObj.font.pixelSize = score.font.pixelSize
        fadeObj.font.bold = score.font.bold
        fadeObj.color = score.color
        fadeObj.fade()
    } else {
        console.log("error loading fade component")
        console.log(comp.errorString())
        return
    }
}
