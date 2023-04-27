'use strict';

const { Controller } = require('egg');

module.exports = class extends Controller {
  async login() {
    const { ctx } = this
    ctx.validate({ username: 'string', password: 'string' });
    const { username, password } = ctx.request.body
    const user = await ctx.service.user.getUserInfo("User", { username, isAdmin: 1 })
    if (!user) return ctx.throw(400, "用户名或密码错误!")
    if (user.password !== password) ctx.throw(400, "用户名或密码错误!")
    Object.assign(ctx, {
      status: 200,
      body: { token: ctx.service.jwt.issue({ id: user.id }) }
    })
  }

  async logout() {
    const { ctx } = this
    ctx.status = 200
  }

  async info() {
    const { ctx } = this, { id } = ctx.state.user
    const body = await ctx.service.user.getUserInfo("User", { id }, { attributes: { exclude: ['password'] } })
    Object.assign(ctx, { status: 200, body })
  }

  async changepwd() {
    const { ctx } = this, { op = ctx.throw('缺少原始密码'), np = ctx.throw('缺少新密码') } = ctx.request.body, { user } = ctx.state
    if (!user) return ctx.throw('获取用户信息失败')
    const data = await ctx.model.User.findOne({ where: { id: user.id } })
    if (data.password !== op) return ctx.throw(400, '原始密码不正确')
    await data.update({ password: np })
    ctx.status = 200
  }
}

