module.exports = () => {
  return async function errorHandler(ctx, next) {
    try {
      await next();
    } catch (err) {
      const status = err.status || 500;
      Object.assign(ctx, {
        status,
        body: {
          message: err.errors ? '参数验证失败' : err.message,
          ...err.errors ? { detail: err.errors } : {}
        }
      })
    }
  };
};