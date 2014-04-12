// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

MouseArea {
    id: area

    property bool capture: false

    property int start_x
    property int start_y

    signal swipeUp
    signal swipeDown
    signal swipeLeft
    signal swipeRight

    onPressed: {
        if (!capture) {
            capture = true
            start_x = mouseX
            start_y = mouseY
        }
    }

    onMousePositionChanged: {
        if (capture) {
            var x_diff = mouseX - start_x
            var y_diff = mouseY - start_y

            var abs_x_diff = Math.abs(x_diff)
            var abs_y_diff = Math.abs(y_diff)

            if (abs_x_diff != abs_y_diff) {
                if (abs_x_diff > abs_y_diff) {
                    if (abs_x_diff > 50) {
                        if (x_diff > 0) {
                            swipeRight()
                        } else if (x_diff < 0) {
                            swipeLeft()
                        }
                        capture = false
                    }
                } else if (abs_y_diff > abs_x_diff) {
                    if (abs_y_diff > 50) {
                        if (y_diff > 0) {
                            swipeDown()
                        } else if (y_diff < 0) {
                            swipeUp()
                        }
                        capture = false
                    }
                }
            }
        }
    }

    onReleased: {
        capture = false
    }
}
