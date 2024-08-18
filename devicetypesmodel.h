#ifndef DEVICETYPESMODEL_H
#define DEVICETYPESMODEL_H

#include <QAbstractListModel>

struct deviceTypes
{
    QString typeDevice;
    QString pathToIcon;
};
class deviceTypesModel : public QAbstractListModel
{
    Q_OBJECT

public:
    explicit deviceTypesModel(QObject *parent = nullptr);
    enum Roles {
        TypeDeviceRole = Qt::UserRole +1,
        PathToIconRole
    };

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;
    void addType(const deviceTypes &typeDevice);
    Q_INVOKABLE QString getIconPath(const int index);

private:
    QList<deviceTypes> m_data;
};

#endif // DEVICETYPESMODEL_H
