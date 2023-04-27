const { Controller } = require('egg');

module.exports = class extends Controller {

  async count() {
    const { ctx } = this, { id } = ctx.state.user
    const body = await ctx.model.Cart.count({ where: { user_id: id } })
    Object.assign(ctx, { status: 200, body })
  }

  async list() {
    const { ctx } = this, { id } = ctx.state.user
    const body = await ctx.model.Cart.findAll({
      where: { user_id: id },
      order: [['id', 'desc']],
      include: [
        {
          model: ctx.model.Product
        }]
    })
    Object.assign(ctx, { status: 200, body })
  }

  async create() {
    const { ctx } = this, { id } = ctx.state.user
    ctx.validate({ product_id: 'int', count: { type: 'int', required: false } });
    const { product_id, count = 1 } = ctx.request.body
    const exist = await ctx.model.Cart.count({ where: { product_id, user_id: id } })
    if (exist > 0) {
      return ctx.throw(400, "购物车已存在该商品!")
    }

    await ctx.service.common.create('Cart', { productId: product_id, count, userId: id });
    ctx.status = 200;
  }

  async remove() {
    const { ctx } = this;
    ctx.validate({ id: 'int' });
    const { id } = ctx.request.body
    await ctx.service.common.removeById('Cart', [id])
    ctx.status = 200
  }
}
