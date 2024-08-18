#ifndef DEVICE_H
#define DEVICE_H

#include <QObject>
#include <QStandardPaths>

#include "listdevicesmodel.h"

class device : public QObject
{
    Q_OBJECT
public:
    explicit device(QObject *parent = nullptr);
    Q_INVOKABLE void saveNewDevice(QString nameDevice, QString typeDevice, QString pathToIcon, int portInArduino);
    Q_INVOKABLE void loadDevices();
    Q_INVOKABLE void deleteDevice(QString nameDevice,int portInArduino,int index);
    Device loadJsonFromFile(QString fileName);


protected:
    Device parseJSon(const QByteArray &jsonData);
    QString filePath = QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
};

#endif // DEVICE_H
