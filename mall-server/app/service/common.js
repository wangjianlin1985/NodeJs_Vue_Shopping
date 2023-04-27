const Service = require('egg').Service;

const check = {
  data: () => { throw new Error('请传递有效数据') },
  modelName: () => { throw new Error('请传递模型名称') },
  where: () => { throw new Error('请传递查询条件') }
}
module.exports = class extends Service {
  async check(modelName = check.modelName(), data = check.data(), where = check.where()) {
    const { ctx } = this;
    const exist = await ctx.service.common.findOneByWhere(modelName, where)
    if (exist) {
      ctx.status = 412
      for (const item of Object.entries(data)) {
        if (item[1] === exist[item[0]]) return item
      }
    } else return false
  }

  async findOneByWhere(modelName = check.modelName(), where = check.where(), option = {}) {
    return await this.ctx.model[modelName].findOne({ where, ...option })
  }

  async list(modelName = check.modelName(), { page, limit, order, where, option }) {
    return await this.ctx.model[modelName].findAndCountAll({ offset: (page - 1) * limit, limit, order, where, ...option })
  }

  async create(modelName = check.modelName(), data = check.data()) {
    return await this.ctx.model[modelName].create(data, { raw: true })
  }

  async update(modelName = check.modelName(), data = check.data()) {
    return await this.ctx.model[modelName].update(data, { where: { id: data.id } })
  }

  async removeById(modelName = check.modelName(), ids = check.data()) {
    return await this.ctx.model[modelName].destroy({ where: { id: ids }, raw: true })
  }

  async bulkCreate(modelName = check.modelName(), datas = check.data()) {
    return await this.ctx.model[modelName].bulkCreate(datas)
  }
  // async all(modelName = check.modelName(), options = {}) {
  //   return await this.ctx.model[modelName].findAll(options)
  // }

  // async countByWhere(modelName = check.modelName(), where = check.where()) {
  //   return await this.ctx.model[modelName].count({ where })
  // }


  // async findByWhere(modelName = check.modelName(), where = check.where(), option = {}) {
  //   return await this.ctx.model[modelName].findAll({ where, ...option, raw: true })
  // }


  // async deleteByWhere(modelName = check.modelName(), where = check.where()) {
  //   return await model.destroy({ where })
  // }
};