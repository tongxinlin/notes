/************************************************************************
**
** antialiased version of squircle.qml
** (https://doc.qt.io/qt-5.12/qtquick-canvas-squircle-squircle-qml.html)
**
** all round functions are removed in order to increase precision
**
************************************************************************/
import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    visible: true
    width: 500
    height: 500

    Canvas {
        id: canvas
        anchors.fill: parent

        antialiasing: true

        property color strokeStyle: Qt.darker(fillStyle, 1.2)
        property color fillStyle: "#6400aa"

        property int lineWidth: 2
        property int nSize: nCtrl.value
        property real radius: rCtrl.value
        property bool fill: true
        property bool stroke: false
        property real px: width/2
        property real py: height/2 //+ 10
        property real alpha: 1.0

        onRadiusChanged: requestPaint();
        onLineWidthChanged: requestPaint();
        onNSizeChanged: requestPaint();
        onFillChanged: requestPaint();
        onStrokeChanged: requestPaint();

        onPaint: squircle();

        function squircle() {
            var ctx = canvas.getContext("2d");
            var N = canvas.nSize;
            var R = canvas.radius;

            var M=N;
            if (N>100) M=100;
            if (N<0.00000000001) M=0.00000000001;

            ctx.save();
            ctx.globalAlpha =canvas.alpha;
            ctx.fillStyle = "white";
            ctx.fillRect(0, 0, canvas.width, canvas.height);

            ctx.strokeStyle = canvas.strokeStyle;
            ctx.fillStyle = canvas.fillStyle;
            ctx.lineWidth = canvas.lineWidth;

            ctx.beginPath();
            var i = 0, x, y;
            for (i=0; i<(2*R+1); i++) {
                x = (i-R) + canvas.px;
                y = (Math.pow(Math.abs(Math.pow(R,M)-Math.pow(Math.abs(i-R),M)),1/M)) + canvas.py;

                if (i == 0)
                    ctx.moveTo(x, y);
                else
                    ctx.lineTo(x, y);
            }

            for (i=(2*R); i<(4*R+1); i++) {
                x = (3*R-i) + canvas.px;
                y = (-Math.pow(Math.abs(Math.pow(R,M)-Math.pow(Math.abs(3*R-i),M)),1/M)) + canvas.py;
                ctx.lineTo(x, y);
            }

            ctx.closePath();
            if (canvas.stroke) {
                ctx.stroke();
            }

            if (canvas.fill) {
                ctx.fill();
            }
            ctx.restore();
        }
    }

    Window {
        visible: true
        width: 200
        height: 100
        Column {
            width: parent.width
            Slider {
                id: nCtrl
                from: 1
                to: 100
                value: 3
            }
            Slider {
                id: rCtrl
                from: 30
                to: 230
                value: 150
            }
        }
    }
}
