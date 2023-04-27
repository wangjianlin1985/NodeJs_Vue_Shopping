const { Controller } = require("egg")
module.exports = class extends Controller {
  async show(){
    const {ctx} = this
    ctx.validate({type: 'int'})
    const { type } = ctx.request.body
    const body = await ctx.model.News.findAll({
      where: {
        type
      },
      order: [['updated_at','desc']]
    })
    Object.assign(ctx, { status: 200, body})
  }
  async list() {
    const { ctx } = this
    ctx.validate({ page: 'int', limit: 'int' })
    const { page = 1, limit = 10 } = ctx.request.body
    const body = await ctx.service.common.list('News', {
      page,
      limit,
      order: [['id', 'desc']],
      option:{
        include: [
          {
            model: ctx.model.Newslist
          }
        ],
      }
    })
    Object.assign(ctx, { status: 200, body })
  }
  async create() {
    const { ctx } = this
    ctx.validate({ img_url: 'string', title: 'string', publisher: 'string', newslist: { type: 'int', required: true }});
    const { img_url, title, publisher, newslist } = ctx.request.body
    await ctx.service.common.create('News', { img_url, title, publisher, type:newslist });
    ctx.status = 200;
  }

  async update() {
    const { ctx } = this
    ctx.validate({ id: 'int',img_url: 'string', title: 'string', publisher: 'string', newslist: { type: 'int', required: true } });
    const { id, img_url, title, publisher, newslist } = ctx.request.body
    await ctx.service.common.update('News', { id, img_url, title, publisher, type:newslist });
    ctx.status = 200;
  }

  async remove() {
    const { ctx } = this;
    ctx.validate({ id: 'int' });
    const { id } = ctx.request.body
    await ctx.service.common.removeById('News', [id])
    ctx.status = 200
  }
}