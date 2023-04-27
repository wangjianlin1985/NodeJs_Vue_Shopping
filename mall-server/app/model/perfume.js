module.exports = app => {
  const { STRING } = app.Sequelize;

  const Perfume = app.model.define('perfume', {
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
  Perfume.associate = _ => {
    Perfume.hasMany(app.model.Product)
  }
  return Perfume;
};