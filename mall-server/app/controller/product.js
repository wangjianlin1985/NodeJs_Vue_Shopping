const { Controller } = require('egg');

module.exports = class extends Controller {

  async list() {
    const { ctx } = this
    ctx.validate({ page: 'int', limit: 'int' })
    const { page = 1, limit = 10 } = ctx.request.body
    const body = await ctx.service.common.list('Product', {
      page,
      limit,
      order: [['id', 'desc']],
      option: {
        include: [
          {
            model: ctx.model.Perfume,
            attributes: ['title']
          }, {
            model: ctx.model.Spicer,
            attributes: ['title']
          }, {
            model: ctx.model.Company,
            attributes: ['title']
          }
        ]
      }
    })
    Object.assign(ctx, { status: 200, body })
  }

  async show() {
    const { ctx } = this
    ctx.validate({ page: 'int', limit: 'int', category: { type: 'enum', values: ['perfume', 'spicer', 'company'] }, id: 'string' })
    const { page = 1, limit = 10, category, id } = ctx.request.body
    const body = await ctx.service.common.list('Product', {
      page,
      limit,
      order: [['id', 'desc']],
      where: { [category + '_id']: id, status: true },
      option: {
        include: [
          {
            model: ctx.model.Perfume,
            attributes: ['title']
          }, {
            model: ctx.model.Spicer,
            attributes: ['title']
          }, {
            model: ctx.model.Company,
            attributes: ['title']
          }
        ]
      }
    })
    Object.assign(ctx, { status: 200, body })
  }

  async create() {
    const { ctx } = this
    ctx.validate({ image_url: 'string', title: 'string', brief: 'string', price: 'number', perfumeId: { type: 'int', required: false }, spicerId: { type: 'int', required: false }, companyId: { type: 'int', required: false } });
    const { image_url, title, brief, price, perfumeId, spicerId, companyId } = ctx.request.body
    await ctx.service.common.create('Product', { image_url, title, brief, price, perfumeId, spicerId, companyId });
    ctx.status = 200;
  }

  async update() {
    const { ctx } = this
    ctx.validate({ id: 'int', image_url: 'string', title: 'string', brief: 'string', price: 'number', perfumeId: { type: 'int', required: false }, spicerId: { type: 'int', required: false }, companyId: { type: 'int', required: false } });
    const { id, image_url, title, brief, price, perfumeId, spicerId, companyId } = ctx.request.body
    await ctx.service.common.update('Product', { id, image_url, title, brief, price, perfumeId, spicerId, companyId });
    ctx.status = 200;
  }

  async remove() {
    const { ctx } = this;
    ctx.validate({ id: 'int' });
    const { id } = ctx.request.body
    await ctx.service.common.removeById('Product', [id])
    ctx.status = 200
  }

  async operation() {
    const { ctx } = this;
    ctx.validate({ id: 'int', status: 'boolean' });
    const { id, status } = ctx.request.body
    await ctx.service.common.update('Product', { id, status })
    ctx.status = 200
  }

  async detail() {
    const { ctx } = this, { col } = ctx.app.Sequelize
    ctx.validate({ id: 'string' })
    const { id } = ctx.request.body
    const body = await ctx.service.common.findOneByWhere('Product', { id }, {
      include: [
        {
          model: ctx.model.Perfume,
          attributes: ['title']
        }, {
          model: ctx.model.Spicer,
          attributes: ['title']
        }, {
          model: ctx.model.Company,
          attributes: ['title']
        }, {
          model: ctx.model.Comment,
          include: [
            {
              model: ctx.model.User,
              attributes: ['username', 'name']
            }
          ]
        }
      ],
      order: [[col('Comments.id'), 'DESC']]
    })
    Object.assign(ctx, { status: 200, body })
  }

  async hot() {
    const { ctx } = this;
    ctx.validate({ id: 'int', hot: 'boolean' });
    const { id, hot } = ctx.request.body
    await ctx.service.common.update('Product', { id, hot })
    ctx.status = 200
  }

  async newlist() {
    const { ctx } = this
    const body = await ctx.model.Product.findAll({
      page: 1,
      limit: 8,
      order: [['id', 'desc']]
    })
    Object.assign(ctx, { status: 200, body })
  }

  async hotlist() {
    const { ctx } = this
    const body = await ctx.model.Product.findAll({
      page: 1,
      limit: 8,
      order: [['id', 'desc']],
      where: { hot: true },
    })
    Object.assign(ctx, { status: 200, body })
  }
}
