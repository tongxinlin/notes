import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 500
    height: 500
    Image {
        id: img
        anchors.fill: parent
        source: "qrc:/qt-logo.png"
    }
    MyFastBlur {
        source: img
        anchors.fill: img
        radius: 40
    }
}
