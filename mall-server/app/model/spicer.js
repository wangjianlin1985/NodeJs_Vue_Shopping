module.exports = app => {
  const { STRING } = app.Sequelize;

  const Spicer = app.model.define('spicer', {
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
  Spicer.associate = _ => {
    Spicer.hasMany(app.model.Product)
  }
  return Spicer;
};