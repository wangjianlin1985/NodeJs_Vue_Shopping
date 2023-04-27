const { Controller } = require('egg');

module.exports = class extends Controller {

  async list() {
    const { ctx } = this
    ctx.validate({ page: 'int', limit: 'int' })
    const { page = 1, limit = 10 } = ctx.request.body
    const body = await ctx.service.common.list('Comment', {
      page,
      limit,
      order: [['id', 'desc']],
      option: {
        include: [
          { model: ctx.model.Product },
          { model: ctx.model.User }
        ]
      }
    })
    Object.assign(ctx, { status: 200, body })
  }

  async create() {
    const { ctx } = this, { id } = ctx.state.user
    ctx.validate({ score: 'int', oid: 'int', pid: 'int', content: 'string' });
    const { score, content, oid, pid } = ctx.request.body
    await ctx.service.common.create('Comment', { score, content, orderId: oid, productId: pid, userId: id });
    ctx.status = 200;
  }

  async remove() {
    const { ctx } = this;
    ctx.validate({ id: 'int' });
    const { id } = ctx.request.body
    await ctx.service.common.removeById('Comment', [id])
    ctx.status = 200
  }
}
