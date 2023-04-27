module.exports = app => {
  const Collection = app.model.define('collection');

  Collection.associate = _ => {
    Collection.belongsTo(app.model.User)
    Collection.belongsTo(app.model.Product)
  }
  return Collection;
};