#ifndef CLIENT_H
#define CLIENT_H

#include <QObject>
#include <QCoreApplication>
#include <QTcpSocket>
#include <QDebug>

class Client : public QObject
{
    Q_OBJECT
public:
    Client(QObject *parent = nullptr) : QObject(parent) {
        socket = new QTcpSocket(this);
        connect(socket, &QTcpSocket::connected, this, &Client::onConnected);
        connect(socket, &QTcpSocket::readyRead, this, &Client::onReadyRead);
        connect(socket, &QTcpSocket::errorOccurred, this, &Client::onError);
    }
    void connectToServer() {
        socket->connectToHost("10.13.13.2", 1234);
    }
    Q_INVOKABLE void sendMessage(const QByteArray &message);

private slots:
    void onConnected() {
        qDebug() << "Connected to server";
        socket->write("Hello from client");
        socket->flush();
    }

    void onReadyRead() {
        QByteArray data = socket->readAll();
        qDebug() << "Received from server:" << data <<"\n";
    }

    void onError(QAbstractSocket::SocketError socketError) {
        qDebug() << "Socket error:" << socket->errorString()<<"\n";
    }

private:
    QTcpSocket *socket;

};

#endif // CLIENT_H
