module.exports = app => {
  const { STRING, BOOLEAN, FLOAT } = app.Sequelize;

  const Product = app.model.define('product', {
    image_url: {
      type: STRING,
      comment: '产品主图'
    },
    title: {
      type: STRING,
      comment: '产品标题'
    },
    price: {
      type: FLOAT,
      comment: '产品价格'
    },
    brief: {
      type: STRING,
      comment: '产品简介'
    },
    status: {
      type: BOOLEAN,
      defaultValue: false,
      comment: '产品状态true上架false下架'
    },
    hot: {
      type: BOOLEAN,
      defaultValue: false,
      comment: '首页热门'
    }
  });

  Product.associate = _ => {
    Product.hasMany(app.model.Cart)
    Product.belongsTo(app.model.Company)
    Product.belongsTo(app.model.Perfume)
    Product.belongsTo(app.model.Spicer)
    Product.hasMany(app.model.Comment)
    Product.hasMany(app.model.Collection)
    Product.hasMany(app.model.OrderGood)
  }
  return Product;
};