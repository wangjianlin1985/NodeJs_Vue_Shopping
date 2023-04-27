module.exports = app => {
  const { INTEGER, STRING, BOOLEAN, FLOAT, ARRAY } = app.Sequelize;

  const Address = app.model.define('address', {
    name: {
      type: STRING,
      comment: '收件人姓名'
    },
    phone: {
      type: STRING,
      comment: '收件人电话'
    },
    address: {
      type: STRING,
      comment: '收件人详细地址'
    },
    isDefault: {
      type: BOOLEAN,
      defaultValue: true,
      comment: '是否是默认地址'
    }
  });

  Address.associate = _ => {
    Address.belongsTo(app.model.User)
  }
  return Address;
};