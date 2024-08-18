#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "client.h"
#include "listdevicesmodel.h"
#include "devicetypesmodel.h"
#include "device.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    Client client = new Client();
    client.connectToServer();

    engine.rootContext()->setContextProperty("client",&client);

    listDevicesModel *listDeviceModel = listDevicesModel::instance();
    engine.rootContext()->setContextProperty("listDeviceModel", listDeviceModel);

    deviceTypesModel deviceModel;
    deviceModel.addType({"socket","qrc:/images/socket.png"});
    deviceModel.addType({"lamp","qrc:/images/lamp.png"});
    engine.rootContext()->setContextProperty("deviceModel", &deviceModel);

    device device;
    device.loadDevices();
    engine.rootContext()->setContextProperty("device", &device);

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
