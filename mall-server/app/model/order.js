module.exports = app => {
  const { STRING, FLOAT } = app.Sequelize;

  const Order = app.model.define('order', {
    order_num: {
      type: STRING,
      unique: true,
      comment: '订单号'
    },
    total_price: {
      type: FLOAT,
      comment: '总价格'
    },
    username: {
      type: STRING,
      comment: '收货人姓名'
    },
    user_phone: {
      type: STRING,
      comment: '收货人手机'
    },
    user_addr: {
      type: STRING,
      comment: '收货人地址'
    },
  });

  Order.associate = _ => {
    Order.belongsTo(app.model.User)
    Order.hasMany(app.model.OrderGood)
    Order.hasMany(app.model.Comment)
  }
  
  return Order;
};