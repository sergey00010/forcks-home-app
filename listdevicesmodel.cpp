#include "listdevicesmodel.h"




int listDevicesModel::rowCount(const QModelIndex& parent) const {
    Q_UNUSED(parent);
    return m_data.count();
}

QVariant listDevicesModel::data(const QModelIndex& index, int role) const {
    if (!index.isValid() || index.row() >= m_data.count())
        return QVariant();

    const Device &device = m_data[index.row()];

    switch (role) {
    case NameDeviceRole:
        return device.nameDevice;
    case TypeDeviceRole:
        return device.typeDevice;
    case PathToIconRole:
        return device.pathToIcon;
    case PortInArduinoRole:
        return device.portInArduino;
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> listDevicesModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[NameDeviceRole] = "nameDevice";
    roles[TypeDeviceRole] = "typeDevice";
    roles[PathToIconRole] = "pathToIcon";
    roles[PortInArduinoRole] = "portInArduino";
    return roles;
}

void listDevicesModel::addDevice(const Device &device) {
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_data.append(device);
    endInsertRows();
}

void listDevicesModel::removeDevice(int index)
{
    if (index < 0 || index >= m_data.count())
        return;

    beginRemoveRows(QModelIndex(), index, index);
    m_data.removeAt(index);
    endRemoveRows();
}

void listDevicesModel::editDevice(const Device &device, int index)
{
    if (index < 0 || index >= m_data.count())
        return;

    Device &editDevice = m_data[index];
    editDevice.nameDevice = device.nameDevice;
    editDevice.typeDevice = device.typeDevice;
    editDevice.pathToIcon = device.pathToIcon;
    editDevice.portInArduino = device.portInArduino;

    emit dataChanged(this->index(index), this->index(index), {NameDeviceRole,TypeDeviceRole,PathToIconRole,PortInArduinoRole});
}

void listDevicesModel::cleanModel()
{
    beginResetModel();
    m_data.clear();
    endResetModel();
}
