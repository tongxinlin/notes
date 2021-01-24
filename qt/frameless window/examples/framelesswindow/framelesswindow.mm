#include "framelesswindow.h"
#include <Cocoa/Cocoa.h>
#include <QDebug>

FramelessWindow::FramelessWindow(QWindow *parent) : QQuickWindow(parent)
{

}

void FramelessWindow::setupWindow(){
    NSView* view = (NSView*)winId();
    NSWindow *window = view.window;
    window.titleVisibility = NSWindowTitleHidden;
    window.titlebarAppearsTransparent = YES;
    window.styleMask |= NSWindowStyleMaskFullSizeContentView;
    [[window standardWindowButton:NSWindowCloseButton] setHidden:YES];
    [[window standardWindowButton:NSWindowMiniaturizeButton] setHidden:YES];
    [[window standardWindowButton:NSWindowZoomButton] setHidden:YES];
    [window setMovable:NO];
}

void FramelessWindow::cppMinimizeWindow(){
    NSView* view = (NSView*)winId();
    NSWindow *window = view.window;
    [window miniaturize:nil];
}

#if (QT_VERSION < QT_VERSION_CHECK(6, 0, 0))
bool FramelessWindow::nativeEvent(const QByteArray &eventType, void *message, long *result){
#else
bool FramelessWindow::nativeEvent(const QByteArray &eventType, void *message, qintptr *result){
#endif
    return false;
}
