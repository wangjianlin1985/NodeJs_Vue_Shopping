const { Controller } = require("egg")
module.exports = class extends Controller {
  async all(){
    const {ctx} = this
    const body = await ctx.model.Newslist.findAll()
    Object.assign(ctx, { status: 200, body})
  }
  async list() {
    const { ctx } = this
    ctx.validate({ page: 'int', limit: 'int' })
    const { page = 1, limit = 10 } = ctx.request.body
    const body = await ctx.service.common.list('Newslist', {
      page,
      limit,
      order: [['id', 'desc']]
    })
    Object.assign(ctx, { status: 200, body })
  }
  async create() {
    const { ctx } = this
    ctx.validate({ title: 'string'});
    const { title } = ctx.request.body
    await ctx.service.common.create('Newslist', {title});
    ctx.status = 200;
  }

  async update() {
    const { ctx } = this
    ctx.validate({ id: 'int', title: 'string' });
    const { id, title } = ctx.request.body
    await ctx.service.common.update('Newslist', { id, title });
    ctx.status = 200;
  }

  async remove() {
    const { ctx } = this;
    ctx.validate({ id: 'int' });
    const { id } = ctx.request.body
    await ctx.service.common.removeById('Newslist', [id])
    ctx.status = 200
  }
}