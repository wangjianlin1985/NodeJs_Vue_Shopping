const RateLimit = require('koa2-ratelimit').RateLimit;

module.exports = (ctx, next) => {
  return RateLimit.middleware({
    interval: 60 * 1000,
    max: 2000000,
    handler: async ctx => {
      ctx.status = 429
      ctx.body = { message: "请求过于频繁,请稍后尝试" };
    }
  })
}
