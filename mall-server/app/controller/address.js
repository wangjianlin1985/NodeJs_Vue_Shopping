const { Controller } = require('egg');

module.exports = class extends Controller {

  async once() {
    const { ctx } = this, { id } = ctx.state.user
    const body = await ctx.model.Address.findOne({
      where: { user_id: id, isDefault: true }
    })
    Object.assign(ctx, { status: 200, body: body ? body : {} })
  }

  async list() {
    const { ctx } = this
    ctx.validate({ page: 'int', limit: 'int' })
    const { page = 1, limit = 10 } = ctx.request.body
    const body = await ctx.service.common.list('Address', {
      page,
      limit,
      order: [['id', 'desc']],
      option: {
        include: [
          {
            model: ctx.model.User
          }
        ],
        distinct: true,
      }
    })
    Object.assign(ctx, { status: 200, body })
  }

  async show() {
    const { ctx } = this, { id } = ctx.state.user
    const body = await ctx.model.Address.findAll({
      where: { user_id: id },
      order: [['isDefault', 'desc'], ['id', 'desc']],
    })
    Object.assign(ctx, { status: 200, body })
  }

  async create() {
    const { ctx } = this, { id } = ctx.state.user
    ctx.validate({ name: "string", phone: "string", address: "string", isDefault: "boolean" });
    const { name, phone, address, isDefault } = ctx.request.body
    if (isDefault) {
      await this.ctx.model['Address'].update({ isDefault: false }, { where: { userId: id } })
    }
    const exist = await ctx.model.Address.count({ where: { user_id: id } })
    await ctx.service.common.create('Address', { name, phone, address, isDefault: exist === 0 ? true : isDefault, userId: id });
    ctx.status = 200;
  }

  async update() {
    const { ctx } = this
    ctx.validate({ id: "int", name: "string", phone: "string", address: "string", isDefault: "boolean" });
    const { id, name, phone, address, isDefault } = ctx.request.body
    if (isDefault) {
      await this.ctx.model['Address'].update({ isDefault: false }, { where: { userId: ctx.state.user.id } })
    }
    await ctx.service.common.update('Address', { id, name, phone, address, isDefault });
    ctx.status = 200;
  }

  async remove() {
    const { ctx } = this;
    ctx.validate({ id: 'int' });
    const { id } = ctx.request.body
    await ctx.service.common.removeById('Address', [id])
    ctx.status = 200
  }
}
