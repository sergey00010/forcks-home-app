#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "client.h"
#include "listdevicesmodel.h"

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

    listDevicesModel listDeviceModel;
    listDeviceModel.addDevice({"socket1","socket","C://",12});
    listDeviceModel.addDevice({"socket2","socket","C://",11});
    listDeviceModel.addDevice({"socket3","socket","C://",10});
    engine.rootContext()->setContextProperty("listDeviceModel", &listDeviceModel);

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
