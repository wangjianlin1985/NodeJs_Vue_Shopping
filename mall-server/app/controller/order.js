const { Controller } = require('egg');
const dayjs = require("dayjs");

module.exports = class extends Controller {

  async list() {
    const { ctx } = this
    ctx.validate({ page: 'int', limit: 'int' })
    const { page = 1, limit = 10 } = ctx.request.body
    const body = await ctx.service.common.list('Order', {
      page,
      limit,
      order: [['id', 'desc']],
      option: {
        include: [
          {
            model: ctx.model.OrderGood
          }
        ],
        distinct: true,
      }
    })
    Object.assign(ctx, { status: 200, body })
  }

  async show() {
    const { ctx } = this, { id } = ctx.state.user
    ctx.validate({ page: 'int', limit: 'int' })
    const { page = 1, limit = 10 } = ctx.request.body
    const body = await ctx.service.common.list('Order', {
      page,
      limit,
      order: [['id', 'desc']],
      where: {
        user_id: id
      },
      option: {
        include: [
          {
            model: ctx.model.OrderGood
          }
        ],
        distinct: true,
      }
    })
    Object.assign(ctx, { status: 200, body })
  }

  async create() {
    const { ctx } = this
    ctx.validate({ list: { type: 'array', itemType: 'object' }, addr: { type: 'object' } });
    ctx.validate({ name: 'string', phone: 'string', address: 'string' }, ctx.request.body.addr);
    const { list, addr } = ctx.request.body
    const { name, phone, address } = addr
    const order_num = "" + new Date().getTime() + Math.floor(Math.random() * 999999);// 订单号
    const total_price = list.map(e => e.count * e.product.price).reduce((t, c) => (t += Number(c)), 0).toFixed(2)
    try {
      const orderResult = await ctx.service.common.create('Order', { order_num, total_price, username: name, user_phone: phone, user_addr: address, userId: ctx.state.user.id });
      const goods = list.map(e => ({
        good_title: e.product.title,
        good_image_url: e.product.image_url,
        good_price: e.product.price,
        good_num: e.count,
        orderId: orderResult.id,
        productId: e.product.id
      }))
      await ctx.service.common.bulkCreate('OrderGood', goods);
    } catch (error) {
      ctx.throw("订单创建失败！")
    }
    await this.ctx.model['Cart'].destroy({ where: { userId: ctx.state.user.id } }) // 清空购物车
    ctx.status = 200;
  }

  async remove() {
    const { ctx } = this;
    ctx.validate({ id: 'int' });
    const { id } = ctx.request.body
    await ctx.model['OrderGood'].destroy({ where: { order_id: id } })
    await ctx.model['Order'].destroy({ where: { id } })
    ctx.status = 200
  }
}
