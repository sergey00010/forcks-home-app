#include "client.h"


void Client::sendMessage(const QByteArray &message)
{
    //qDebug()<<message;
    if (socket->state() == QTcpSocket::ConnectedState) {
        socket->write(message);
        socket->flush();
    } else {
        qDebug() << "Not connected to server";
    }
}
