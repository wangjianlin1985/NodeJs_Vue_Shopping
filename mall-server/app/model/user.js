module.exports = app => {
  const { STRING, BOOLEAN } = app.Sequelize;

  const User = app.model.define('user', {
    username: {
      type: STRING(30),
      unique: true,
      comment: '用户名'
    },
    password: {
      type: STRING(100),
      comment: '用户密码'
    },
    name: {
      type: STRING(100),
      comment: '姓名'
    },
    gender: {
      type: STRING(30),
      comment: '性别'
    },
    isAdmin: {
      type: BOOLEAN,
      defaultValue: false,
      comment: '是否为管理员'
    }
  });

  User.associate = _ => {
    User.hasMany(app.model.Cart)
    User.hasMany(app.model.Order)
    User.hasMany(app.model.Comment)
    User.hasMany(app.model.Collection)
    User.hasMany(app.model.Address)
  }
  return User;
};