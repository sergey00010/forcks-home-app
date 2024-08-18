#include "devicetypesmodel.h"

deviceTypesModel::deviceTypesModel(QObject *parent)
    : QAbstractListModel(parent)
{}

int deviceTypesModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return m_data.count();
}

QVariant deviceTypesModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_data.count())
        return QVariant();

    const deviceTypes &deviceTypeStruct = m_data[index.row()];

    switch (role) {
    case TypeDeviceRole:
        return deviceTypeStruct.typeDevice;
    case PathToIconRole:
        return deviceTypeStruct.pathToIcon;
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> deviceTypesModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[TypeDeviceRole] = "typeDevice";
    roles[PathToIconRole] = "pathToIcon";
    return roles;
}

void deviceTypesModel::addType(const deviceTypes &typeDevice)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_data.append(typeDevice);
    endInsertRows();
}

QString deviceTypesModel::getIconPath(const int index)
{
    return m_data[index].pathToIcon;
}
