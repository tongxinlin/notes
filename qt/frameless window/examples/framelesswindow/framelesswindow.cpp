#include "framelesswindow.h"
#ifdef Q_OS_WIN32
#include <Windows.h>
#include <windowsx.h>
#endif

FramelessWindow::FramelessWindow(QWindow *parent) : QQuickWindow(parent)
{
    this->setFlags(Qt::FramelessWindowHint|Qt::Window|Qt::WindowMinMaxButtonsHint);
}

void FramelessWindow::setupWindow(){
#ifdef Q_OS_WIN32
    HWND hwnd = (HWND)this->winId();
    //add WS_CAPTION style to regain default window minimize/restore animation
    SetWindowLong(hwnd, GWL_STYLE, ::GetWindowLong(hwnd, GWL_STYLE) | WS_CAPTION);
#endif
}

void FramelessWindow::cppMinimizeWindow(){

}

#if (QT_VERSION < QT_VERSION_CHECK(6, 0, 0))
bool FramelessWindow::nativeEvent(const QByteArray &eventType, void *message, long *result){
#else
bool FramelessWindow::nativeEvent(const QByteArray &eventType, void *message, qintptr *result){
#endif
#ifdef Q_OS_WIN32
    MSG* msg = (MSG*) message;
    switch(msg->message) {
        case WM_SYSCOMMAND:
        {
            //intercept restore and minimize message and handle minimize/restore manually
            //we can add custom animation in qml when these signals emitted
            if(msg->wParam == SC_RESTORE){
                emit windowRestored();
                return true;
            } else if(msg->wParam == SC_ICON){
                emit windowMinimized();
                return true;
            }
            break;
        }
        case WM_NCCALCSIZE:
        {
            //remove frame (WS_CAPTION)
            return true;
        }
        case WM_NCHITTEST:
        {
            //resizable window
            *result = 0;
            const LONG border_width = 5;
            RECT winrect;
            GetWindowRect(reinterpret_cast<HWND>(winId()), &winrect);

            long x = GET_X_LPARAM(msg->lParam);
            long y = GET_Y_LPARAM(msg->lParam);

            auto resizeWidth = minimumWidth() != maximumWidth();
            auto resizeHeight = minimumHeight() != maximumHeight();

            if (resizeWidth) {
                if (x >= winrect.left && x < winrect.left + border_width){
                    *result = HTLEFT;
                }
                if (x < winrect.right && x >= winrect.right - border_width){
                    *result = HTRIGHT;
                }
            }
            if (resizeHeight){
                if (y < winrect.bottom && y >= winrect.bottom - border_width){
                    *result = HTBOTTOM;
                }
                if (y >= winrect.top && y < winrect.top + border_width){
                    *result = HTTOP;
                }
            }
            if (resizeWidth && resizeHeight){
                if (x >= winrect.left && x < winrect.left + border_width &&
                    y < winrect.bottom && y >= winrect.bottom - border_width){
                    *result = HTBOTTOMLEFT;
                }
                if (x < winrect.right && x >= winrect.right - border_width &&
                    y < winrect.bottom && y >= winrect.bottom - border_width){
                    *result = HTBOTTOMRIGHT;
                }
                if (x >= winrect.left && x < winrect.left + border_width &&
                    y >= winrect.top && y < winrect.top + border_width){
                    *result = HTTOPLEFT;
                }
                if (x < winrect.right && x >= winrect.right - border_width &&
                    y >= winrect.top && y < winrect.top + border_width){
                    *result = HTTOPRIGHT;
                }
            }
            if (*result != 0)
                return true;
            break;
        }
    }
#endif
    return QQuickWindow::nativeEvent(eventType, message, result);
}
