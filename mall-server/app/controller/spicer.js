const { Controller } = require('egg');

module.exports = class extends Controller {
  async all() {
    const { ctx } = this
    const body = await ctx.model.Spicer.findAll({ order: [['id', 'desc']] })
    Object.assign(ctx, { status: 200, body })
  }

  async list() {
    const { ctx } = this
    ctx.validate({ page: 'int', limit: 'int' })
    const { page = 1, limit = 10 } = ctx.request.body
    const body = await ctx.service.common.list('Spicer', {
      page,
      limit,
      order: [['id', 'desc']]
    })
    Object.assign(ctx, { status: 200, body })
  }

  async create() {
    const { ctx } = this
    ctx.validate({ image_url: 'string', title: 'string', brief: 'string', });
    const { image_url, title, brief } = ctx.request.body
    await ctx.service.common.create('Spicer', { image_url, title, brief });
    ctx.status = 200;
  }

  async update() {
    const { ctx } = this
    ctx.validate({ id: 'int', image_url: 'string', title: 'string', brief: 'string', });
    const { id, image_url, title, brief } = ctx.request.body
    await ctx.service.common.update('Spicer', { id, image_url, title, brief });
    ctx.status = 200;
  }

  async remove() {
    const { ctx } = this;
    ctx.validate({ id: 'int' });
    const { id } = ctx.request.body
    await ctx.service.common.removeById('Spicer', [id])
    ctx.status = 200
  }
}
