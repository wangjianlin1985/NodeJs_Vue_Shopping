module.exports = app => {
  const { INTEGER, STRING } = app.Sequelize;

  const Newslist = app.model.define('newslist', {
    id: {
      type: INTEGER,
      comment: 'id',
      primaryKey: true
    },
    title: {
      type: STRING,
      comment: '标题'
    }
  });
  Newslist.associate = _ => {
    Newslist.hasMany(app.model.News,{foreignKey:'id',targetKey:'type'})
  }
  return Newslist;
};