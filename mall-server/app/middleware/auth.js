module.exports = async (ctx, next) => {
  ctx.status = 401
  const { model } = ctx
  try {
    var { id } = await ctx.service.jwt.getToken(ctx)
  } catch (error) {
    console.log(error)
  }
  if (id == null) ctx.throw("Invalid Token")

  const user = await model.User.findOne({ where: { id }, raw: true })
  if (!user) ctx.throw(400, '用户不存在')
  ctx.state.user = user
  await next();
};
