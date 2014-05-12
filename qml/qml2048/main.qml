import QtQuick 1.1
import com.nokia.meego 1.0
import "storage.js" as Storage
import "speed.js" as Speed

PageStackWindow {
    id: appWindow
    initialPage: mainPage
    Component.onCompleted: {
        slider.maximumValue = 10
        var ls = Storage.getState("lastBoardSize")
        if (ls == null)
            ls = 4
        slider.value = ls
        slider.minimumValue = 2
    }

    MainPage {
        id: mainPage
    }
    About {
        id: about
        version: "v.0.5.0"
        height: parent.height
        width: parent.width
    }

    ToolBarLayout {
        id: commonTools
        visible: true
        ToolIcon {
            platformIconId: "toolbar-view-menu"
            anchors.right: (parent === undefined) ? undefined : parent.right
            onClicked: (myMenu.status === DialogStatus.Closed) ? myMenu.open() : myMenu.close()
        }
    }

    Menu {
        id: myMenu
        visualParent: pageStack
        MenuLayout {
            MenuItem {
                text: qsTr("New game")
                onClicked: mainPage.newGameRequest()
            }
            MenuItem {
                Slider {
                    id: slider
                    stepSize: 1
                    valueIndicatorVisible: true
                    width: parent.width
                    onValueChanged: mainPage.startGame(value)
                    Component.onDestruction: Storage.setState("lastBoardSize",value)
                }
            }
            MenuItem {
                ButtonRow {
                    id: speedButton
                    anchors.fill: parent
                    anchors.margins: 5
                    onCheckedButtonChanged: Storage.animation_speed =
                                            speedButton.checkedButton.speed
                    Button {
                        property int speed: 400
                        id: slowSpeedButton
                        text: "Slow"
                        height: parent.height
                    }
                    Button {
                        property int speed: 200
                        id: normalSpeedButton
                        text: "Normal"
                        height: parent.height
                    }
                    Button {
                        property int speed: 100
                        id: fastSpeedButton
                        text: "Fast"
                        height: parent.height
                    }
                }
                Component.onCompleted: Speed.loadSpeed()
                Component.onDestruction: Speed.saveSpeed()
            }
            MenuItem {
                text: qsTr("About")
                onClicked: about.open()
            }
        }
    }
}
