// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "storage.js" as Storage

Text {
    id: container
    function fade() {
        fade_opac.duration = Storage.animation_speed
        fade_y.duration = Storage.animation_speed
        fade_anim.start()
    }

    ParallelAnimation {
        id: fade_anim
        PropertyAnimation {
            id: fade_opac
            target: container
            property: "opacity"
            duration: 200
            from: 1
            to: 0
        }
        PropertyAnimation {
            id: fade_y
            target: container
            property: "y"
            duration: 200
            from: 0
            to: - height
        }
        onRunningChanged: {
            if (!running) { // animation completed
                container.destroy()
            }
        }
    }
}
