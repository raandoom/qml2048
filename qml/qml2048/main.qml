import QtQuick 1.1
import com.nokia.meego 1.0

PageStackWindow {
    id: appWindow
    initialPage: mainPage
    Component.onCompleted: {
        mainPage.newGameRequest(slider.value)
    }

    MainPage {
        id: mainPage
    }
    About {
        id: about
        version: "v.0.1.3"
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
                onClicked: {
                    mainPage.newGameRequest(slider.value)
                }
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
                    onValueChanged: {
                        mainPage.newGameRequest(slider.value)
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
