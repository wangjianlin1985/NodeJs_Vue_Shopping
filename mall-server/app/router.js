'use strict';

/**
 * @param {Egg.Application} app - egg application
 */
module.exports = app => {
  const { router, controller, middleware } = app;
  const { auth } = middleware;
  router.get('/auth/info', auth, controller.auth.info);

  router.post('/auth/login', controller.auth.login);
  router.post('/auth/logout', auth, controller.auth.logout);
  router.post('/auth/changepwd', auth, controller.auth.changepwd);


  router.post('/user/login', controller.user.login);
  router.post('/user/logout', auth, controller.user.logout);
  router.post('/user/register', controller.user.register);
  router.get('/user/info', auth, controller.user.info);
  router.post('/user/info', auth, controller.user.modifyInfo);


  router.post('/user/list', auth, controller.user.list);
  router.post('/user/remove', auth, controller.user.remove);


  router.get('/product/hotlist', controller.product.hotlist);
  router.get('/product/newlist', controller.product.newlist);
  router.post('/product/show', controller.product.show);
  router.post('/product/detail', controller.product.detail);
  router.post('/product/list', auth, controller.product.list);
  router.post('/product/operation', auth, controller.product.operation);
  router.post('/product/create', auth, controller.product.create);
  router.post('/product/update', auth, controller.product.update);
  router.post('/product/remove', auth, controller.product.remove);
  router.post('/product/hot', auth, controller.product.hot);


  router.get('/company', controller.company.all);
  router.post('/company/list', controller.company.list);
  router.post('/company/create', auth, controller.company.create);
  router.post('/company/update', auth, controller.company.update);
  router.post('/company/remove', auth, controller.company.remove);


  router.get('/perfume', controller.perfume.all);
  router.get('/spicer', controller.spicer.all);
  router.post('/spicer/list', controller.spicer.list);
  router.post('/spicer/create', auth, controller.spicer.create);
  router.post('/spicer/update', auth, controller.spicer.update);
  router.post('/spicer/remove', auth, controller.spicer.remove);


  router.get('/cart/count', auth, controller.cart.count);
  router.get('/cart', auth, controller.cart.list);
  router.post('/cart/create', auth, controller.cart.create);
  router.post('/cart/remove', auth, controller.cart.remove);


  router.post('/order/list', auth, controller.order.list);
  router.post('/order/show', auth, controller.order.show);
  router.post('/order/create', auth, controller.order.create);
  router.post('/order/remove', auth, controller.order.remove);


  router.post('/comment/list', auth, controller.comment.list);
  router.post('/comment/create', auth, controller.comment.create);
  router.post('/comment/remove', auth, controller.comment.remove);


  router.get('/collection', auth, controller.collection.list);
  router.post('/collection/create', auth, controller.collection.create);
  router.post('/collection/remove', auth, controller.collection.remove);


  router.get('/address/once', auth, controller.address.once);
  router.post('/address/list', auth, controller.address.list);
  router.get('/address', auth, controller.address.show);
  router.post('/address/create', auth, controller.address.create);
  router.post('/address/update', auth, controller.address.update);
  router.post('/address/remove', auth, controller.address.remove);

  router.post('/upload', auth, controller.common.upload);
  router.get('/category', controller.common.category);

  router.get('/newslist', controller.newslist.all);
  router.post('/newslist/list', controller.newslist.list);
  router.post('/newslist/create', auth, controller.newslist.create);
  router.post('/newslist/update', auth, controller.newslist.update);
  router.post('/newslist/remove', auth, controller.newslist.remove);

  router.post("/news",controller.news.show);
  router.post('/news/list',  controller.news.list);
  router.post('/news/create', auth, controller.news.create);
  router.post('/news/update', auth, controller.news.update);
  router.post('/news/remove', auth, controller.news.remove);
};
