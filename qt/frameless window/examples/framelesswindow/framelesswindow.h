#ifndef FRAMELESSWINDOW_H
#define FRAMELESSWINDOW_H

#include <QQuickWindow>

class FramelessWindow : public QQuickWindow
{
    Q_OBJECT
public:
    explicit FramelessWindow(QWindow *parent = nullptr);
    Q_INVOKABLE void setupWindow();
    Q_INVOKABLE void cppMinimizeWindow();

signals:
    void windowMinimized();
    void windowRestored();

public slots:

protected:
#if (QT_VERSION < QT_VERSION_CHECK(6, 0, 0))
    bool nativeEvent(const QByteArray &eventType, void *message, long *result);
#else
    bool nativeEvent(const QByteArray &eventType, void *message, qintptr *result);
#endif

};

#endif // FRAMELESSWINDOW_H
