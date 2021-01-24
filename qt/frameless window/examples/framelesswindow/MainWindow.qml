import QtQuick 2.12
import QtQuick.Window 2.12
import Com.Tongxinlin.GUI 1.0

FramelessWindow {
    id: window
    visible: true
    //init
    width: 640
    height: 480
    color: 'transparent'

    Component.onCompleted: window.setupWindow()
    onWindowMinimized: minimizeWindow()
    onWindowRestored: restoreWindow()
    property var minimizeWindow: function(){
        if(Qt.platform.os === 'osx'){
            cppMinimizeWindow()
        } else {
            showMinimized()
        }
    }
    property var restoreWindow: function(){
        if(isMaximized){
            showMaximized()
        } else {
            showNormal()
        }
    }
    property var maximizeWindow: function(){
        //root.visibility === 2
        if(isMaximized){
            isMaximized = false
        } else {
            isMaximized = true
        }
    }
    property bool isMaximized: false
    onIsMaximizedChanged: restoreWindow()
}
