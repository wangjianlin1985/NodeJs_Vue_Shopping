module.exports = app => {
  const { INTEGER, STRING, FLOAT } = app.Sequelize;

  const OrderGood = app.model.define('order_good', {
    good_title: {
      type: STRING,
      comment: '产品标题'
    },
    good_image_url: {
      type: STRING,
      comment: '产品主图'
    },
    good_price: {
      type: FLOAT,
      comment: '产品价格'
    },
    good_num: {
      type: INTEGER,
      comment: '产品数量'
    },
  });

  OrderGood.associate = _ => {
    OrderGood.belongsTo(app.model.Order)
    OrderGood.belongsTo(app.model.Product)
  }
  return OrderGood;
};