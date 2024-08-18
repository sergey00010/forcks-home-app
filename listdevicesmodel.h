#ifndef LISTDEVICESMODEL_H
#define LISTDEVICESMODEL_H

#include <QAbstractListModel>

struct Device{
    QString nameDevice; //local name
    QString typeDevice; //socket, lamp, etc.
    QString pathToIcon;
    int portInArduino;
};

class listDevicesModel : public QAbstractListModel
{
    Q_OBJECT

public:
    enum Roles {
        NameDeviceRole = Qt::UserRole +1,
        TypeDeviceRole,
        PathToIconRole,
        PortInArduinoRole
    };

    static listDevicesModel* instance(QObject *parent = nullptr) {
        static listDevicesModel instance(parent);
        return &instance;
    }
    int rowCount(const QModelIndex& parent = QModelIndex()) const override;
    QVariant data(const QModelIndex& index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    Q_INVOKABLE void addDevice(const Device &device);
    Q_INVOKABLE void removeDevice(int index);
    Q_INVOKABLE void editDevice(const Device &device, int index);

    void cleanModel();

private:
    explicit listDevicesModel(QObject *parent = nullptr){

    }
    QList<Device> m_data;

};

#endif // LISTDEVICESMODEL_H
