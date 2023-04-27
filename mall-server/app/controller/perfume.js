const { Controller } = require('egg');

module.exports = class extends Controller {

  async all() {
    const { ctx } = this
    const body = await ctx.model.Perfume.findAll()
    Object.assign(ctx, { status: 200, body })
  }
}
