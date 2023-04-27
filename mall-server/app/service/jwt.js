const Service = require('egg').Service;
const jwt = require('jsonwebtoken');

const defaultJwtOptions = { expiresIn: '1d' };
module.exports = class extends Service {
  getToken(ctx) {
    const params = Object.assign({}, ctx.request.body, ctx.request.query);
    let token = '';
    if (ctx.request && ctx.request.header && ctx.request.header.authorization) {
      const parts = ctx.request.header.authorization.split(' ');
      if (parts.length === 2) {
        const scheme = parts[0];
        const credentials = parts[1];
        if (/^Bearer$/i.test(scheme)) {
          token = credentials;
        }
      } else {
        throw new Error('Invalid authorization header format. Format is Authorization: Bearer [token]');
      }
    } else if (params.token) {
      token = params.token;
    } else {
      throw new Error('No authorization header was found');
    }
    return this.verify(token);
  }

  issue(payload, jwtOptions = {}) {
    return jwt.sign(payload, this.config.jwtSecret || "default jwt secret", Object.assign(jwtOptions, defaultJwtOptions))
  }

  verify(token) {
    return new Promise((resolve, reject) => {
      jwt.verify(
        token,
        this.config.jwtSecret || "default jwt secret",
        {},
        function (err, tokenPayload = {}) {
          if (err) {
            return reject(new Error('Invalid token'));
          }
          resolve(tokenPayload);
        }
      );
    });
  }
};
