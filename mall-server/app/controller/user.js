'use strict';

const { Controller } = require('egg');

module.exports = class extends Controller {
  async login() {
    const { ctx } = this
    const { username, password } = ctx.request.body
    const user = await ctx.service.user.getUserInfo("User", { username, isAdmin: 0 })
    if (!user) return ctx.throw(400, "用户名或密码错误!")
    if (user.password !== password) ctx.throw(400, "用户名或密码错误!")
    Object.assign(ctx, {
      status: 200,
      body: { token: ctx.service.jwt.issue({ id: user.id }) }
    })
  }

  async register() {
    const { ctx } = this
    ctx.validate({ username: 'string', password: 'string' });
    const { username, password } = ctx.request.body
    if(username === 'admin' || username === 'administrator') return ctx.throw("该用户名无法注册！")
    const exist = await ctx.service.common.check("User", { username }, { username })
    if (exist) ctx.throw(400, `用户名 ${exist[1]} 已存在`)
    await ctx.service.common.create('User', { username, password });
    ctx.status = 200;
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

  async modifyInfo() {
    const { ctx } = this, { id } = ctx.state.user
    ctx.validate({ name: { type: 'string', required: false }, gender: { type: 'string', required: false }, password: { type: 'string', required: false } });
    const { name, gender, password } = ctx.request.body
    await ctx.service.common.update('User', { id, name, gender, password });
    ctx.status = 200
  }

  async list() {
    const { ctx } = this, { service } = ctx
    ctx.validate({ page: 'int', limit: 'int' });
    const { page = 1, limit = 10 } = ctx.request.body
    const body = await service.common.list('User', {
      page,
      limit,
      where: { isAdmin: 0 },
      option: { attributes: { exclude: ['password'] } }
    })
    Object.assign(ctx, {
      status: 200,
      body
    })
  }

  async remove() {
    const { ctx } = this;
    ctx.validate({ id: 'int' });
    const { id } = ctx.request.body
    await ctx.service.common.removeById('User', [id])
    ctx.status = 200
  }
}

