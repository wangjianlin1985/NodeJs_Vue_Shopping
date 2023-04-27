const Service = require('egg').Service;
module.exports = class extends Service {

  async getUserInfo(modelName, where, option = {}) {
    return await this.ctx.model[modelName].findOne({ where, raw: true, ...option })
  }
}