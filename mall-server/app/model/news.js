module.exports = app => {
  const { INTEGER, STRING } = app.Sequelize;

  const news = app.model.define('news', {
    id: {
      type: INTEGER,
      comment: '新闻ID',
      primaryKey: true
    },
    type: {
      type: INTEGER,
      comment: '新闻类型'
    },
    title: {
      type: STRING,
      comment: '标题'
    },
    publisher: {
      type: STRING,
      comment: '发布者'
    },
    img_url: {
      type: STRING,
      comment: '图片URL'
    }
  });
  news.associate = _ => {
    news.belongsTo(app.model.Newslist,{foreignKey:'type',targetKey:'id'})
  }
  return news;
};
