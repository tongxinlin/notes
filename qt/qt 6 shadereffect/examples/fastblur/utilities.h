#ifndef UTILITIES_H
#define UTILITIES_H

#include <QObject>

class Utilities : public QObject
{
    Q_OBJECT
public:
    explicit Utilities(QObject *parent = nullptr);
    Q_INVOKABLE bool isQt6OrAbove(){
#if QT_VERSION >= 0x060000
        return true;
#else
        return false;
#endif
    }

signals:

};

#endif // UTILITIES_H
