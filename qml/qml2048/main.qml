import QtQuick 1.1
import com.nokia.meego 1.0
import "storage.js" as Storage

PageStackWindow {
    id: appWindow
    initialPage: mainPage
    Component.onCompleted: mainPage.newGameRequest()

    MainPage {
        id: mainPage
    }
    About {
        id: about
        version: "v.0.2.1"
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
                    minimumValue: 2
                    maximumValue: 10
                    value: 4
                    stepSize: 1
                    valueIndicatorVisible: true
                    width: parent.width
                    onValueChanged: mainPage.newGameRequest(value)
                }
            }
            MenuItem {
                ButtonRow {
                    anchors.fill: parent
                    anchors.margins: 5
                    Button {
                        text: "Slow"
                        height: parent.height
                        onClicked: Storage.animation_speed = 400
                    }
                    Button {
                        text: "Normal"
                        height: parent.height
                        checked: true
                        onClicked: Storage.animation_speed = 200
                    }
                    Button {
                        text: "Fast"
                        height: parent.height
                        onClicked: Storage.animation_speed = 100
                    }
                }
            }
            MenuItem {
                text: qsTr("About")
                onClicked: about.open()
            }
        }
    }
}
