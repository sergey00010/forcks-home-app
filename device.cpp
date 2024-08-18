#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QDebug>
#include <QFile>
#include <QDir>

#include "device.h"

device::device(QObject *parent)
    : QObject{parent}
{}

void device::saveNewDevice(QString nameDevice, QString typeDevice, QString pathToIcon, int portInArduino)
{
    QJsonObject jsonObject;
    jsonObject["nameDevice"] = nameDevice;
    jsonObject["typeDevice"] = typeDevice;
    jsonObject["pathToIcon"] = pathToIcon;
    jsonObject["portInArduino"] = portInArduino;

    QJsonDocument document(jsonObject);
    QByteArray jsonData = document.toJson();

    QString pathToFile = filePath +"/"+ nameDevice +"~"+QString::number(portInArduino)+".json";
    QFile file(pathToFile);
    if (!file.open(QIODevice::WriteOnly)) {
        qDebug() << "Failed to open file for writing";
        return;
    }

    file.write(jsonData);
    file.close();

    qDebug() << "JSON data saved to" << pathToFile;
    listDevicesModel *listDeviceModel = listDevicesModel::instance();
    listDeviceModel->addDevice({nameDevice,  typeDevice,  pathToIcon,  portInArduino});
}

void device::loadDevices()
{
    QDir dir(filePath);
    QStringList filters;
    filters << "*.json";
    QStringList files = dir.entryList(filters, QDir::Files);
    listDevicesModel *listDeviceModel = listDevicesModel::instance();
    listDeviceModel->cleanModel();
    foreach (QString filename, files) {
        listDeviceModel->addDevice(loadJsonFromFile(filename));
    }
}

void device::deleteDevice(QString nameDevice, int portInArduino, int index)
{
    QString pathToDeleteFile = filePath + "/"+nameDevice+"~"+QString::number(portInArduino)+".json";
    QFile file(pathToDeleteFile);
    if (!file.remove()) {
        qDebug() << "Failed to delete file:" << pathToDeleteFile;
    } else {
        qDebug() << "File deleted successfully:" << pathToDeleteFile;
        listDevicesModel *listDeviceModel = listDevicesModel::instance();
        listDeviceModel->removeDevice(index);
    }
}

Device device::loadJsonFromFile(QString fileName)
{
    QString pathToFile = filePath +"/"+fileName;
    qDebug()<<pathToFile;
    QFile file(pathToFile);
    if (!file.open(QIODevice::ReadOnly)) {
        qDebug() << "Failed to open file for reading";
        return Device();
    }
    QByteArray jsonData = file.readAll();
    file.close();
    return parseJSon(jsonData);
}

Device device::parseJSon(const QByteArray &jsonData)
{
    QJsonDocument document = QJsonDocument::fromJson(jsonData);

    if (document.isNull() || !document.isObject()) {
        qDebug() << "Failed to parse JSON";
        return Device();
    }

    QJsonObject jsonObject = document.object();

    QString nameDevice = jsonObject["nameDevice"].toString();
    QString typeDevice = jsonObject["typeDevice"].toString();
    QString pathToIcon = jsonObject["pathToIcon"].toString();
    int portInArduino = jsonObject["portInArduino"].toInt();

    //qDebug()<<nameDevice<<typeDevice<<pathToIcon<<portInArduino;

    return {nameDevice,typeDevice,pathToIcon,portInArduino};
    /*
    QJsonArray coursesArray = jsonObject["devices"].toArray();
    QStringList devices;
    for (const QJsonValue &value : coursesArray) {
        devices << value.toString();
    }
*/
}
