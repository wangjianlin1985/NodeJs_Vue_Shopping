module.exports = app => {
  const { INTEGER, TEXT } = app.Sequelize;

  const Comment = app.model.define('comment', {
    score: {
      type: INTEGER,
      comment: '评分'
    },
    content: {
      type: TEXT,
      comment: '内容'
    }
  });
  Comment.associate = _ => {
    Comment.belongsTo(app.model.Order)
    Comment.belongsTo(app.model.Product)
    Comment.belongsTo(app.model.User)
  }
  return Comment;
};