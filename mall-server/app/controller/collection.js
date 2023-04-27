const { Controller } = require('egg');

module.exports = class extends Controller {

  async list() {
    const { ctx } = this, { id } = ctx.state.user
    const body = await ctx.model.Collection.findAll({
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
    ctx.validate({ product_id: 'int' });
    const { product_id } = ctx.request.body

    const exist = await ctx.model.Collection.count({ where: { product_id, user_id: id } })
    if (exist > 0) {
      return ctx.throw("该商品已收藏!")
    }
    await ctx.service.common.create('Collection', { productId: product_id, userId: id });
    ctx.status = 200;
  }

  async remove() {
    const { ctx } = this
    ctx.validate({ id: 'int' });
    const { id } = ctx.request.body
    // await ctx.service.common.removeById('Collection', [id])
    await ctx.model['Collection'].destroy({
      where: { id, user_id: ctx.state.user.id }
    })
    ctx.status = 200
  }
}
