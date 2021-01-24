import QtQuick 2.12

MouseArea {
    id: draggableTitleBar
    width: parent.width
    height: 30
    property point clickPos;
    onPressed: clickPos = Qt.point(mouse.x,mouse.y)
    onPositionChanged: {
        root.x += mouse.x - clickPos.x
        root.y += mouse.y - clickPos.y
    }
    onDoubleClicked: root.maximizeWindow()
    Row {
        anchors.fill: parent
        Item { width: 3; height: parent.height }
        MouseArea {
            width: height * 9/10
            height: parent.height
            onClicked: root.close()
            Rectangle {
                width: height
                height: parent.height * 2/5
                anchors.centerIn: parent
                radius: 10
                color: 'red'
            }
        }
        MouseArea {
            width: height * 9/10
            height: parent.height
            onClicked: root.minimizeWindow()
            Rectangle {
                width: height
                height: parent.height * 2/5
                anchors.centerIn: parent
                radius: 10
                color: 'pink'
            }
        }
        MouseArea {
            width: height * 9/10
            height: parent.height
            onClicked: root.maximizeWindow()
            Rectangle {
                width: height
                height: parent.height * 2/5
                anchors.centerIn: parent
                radius: 10
                color: 'green'
            }
        }
    }
}
