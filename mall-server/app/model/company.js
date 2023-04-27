module.exports = app => {
  const { STRING } = app.Sequelize;

  const Company = app.model.define('company', {
    image_url: {
      type: STRING,
      comment: '主图'
    },
    title: {
      type: STRING,
      comment: '标题'
    },
    brief: {
      type: STRING,
      comment: '产品简介'
    }
  });
  Company.associate = _ => {
    Company.hasMany(app.model.Product)
  }
  return Company;
};