module.exports = app => {
  const { INTEGER, STRING, BOOLEAN, FLOAT, ARRAY } = app.Sequelize;

  const Cart = app.model.define('cart', {
    count: {
      type: INTEGER,
      defaultValue: 1,
      comment: '商品数量'
    }
  });

  Cart.associate = _ => {
    Cart.belongsTo(app.model.User)
    Cart.belongsTo(app.model.Product)
  }
  return Cart;
};