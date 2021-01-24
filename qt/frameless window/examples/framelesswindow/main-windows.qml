import QtQuick 2.12

MainWindow {
    id: root
    width: 640
    height: 480
    Rectangle {
        width: parent.width - 4
        height: parent.height -4
        anchors.centerIn: parent
        radius: 10
        //Qt Graphical Effects are not ready in Qt 6.0
        //layer.enabled: true
        //layer.effect: DropShadow { ... }
        TitleBar {}
    }
}
