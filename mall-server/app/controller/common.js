const { Controller } = require('egg');
const sendToWormhole = require('stream-wormhole');
const awaitWriteStream = require('await-stream-ready').write;
const uuid = require('uuid/v1')
const fs = require('fs-extra');
const upath = require('upath')
const dayjs = require('dayjs')

module.exports = class extends Controller {

  constructor(...args) {
    super(...args);
    this.publicDir = upath.join(this.app.baseDir, 'app/public/')
  }

  async upload() {
    const { ctx } = this
    const stream = await ctx.getFileStream();
    const filename = uuid() + upath.extname(stream.filename).toLowerCase();
    const fileDir = upath.join('upload', dayjs().format("YYYYMMDD"))
    fs.ensureDirSync(upath.join(this.publicDir, fileDir))
    const fullDir = upath.join(this.publicDir, fileDir, filename)
    fs.ensureFileSync(fullDir)
    const writeStream = fs.createWriteStream(fullDir);
    try {
      await awaitWriteStream(stream.pipe(writeStream));
    } catch (err) {
      await sendToWormhole(stream);
      throw err;
    }
    ctx.status = 200
    ctx.body = { status: "done", path: `/${upath.join(fileDir, filename)}` }
  }

  async category() {
    const { ctx } = this
    const body = []
    const perfumes = await ctx.model.Perfume.findAll({ order: [['id', 'desc']] })
    const spicers = await ctx.model.Spicer.findAll({ order: [['id', 'desc']] })
    const companys = await ctx.model.Company.findAll({ order: [['id', 'desc']] })
    const dict = [{ title: '香水', type: 'perfume', data: perfumes }, { title: '香料', type: 'spicer', data: spicers }, { title: '公司', type: 'company', data: companys }]
    dict.forEach(e => {
      body.push({ title: e.title, type: e.type, data: e.data })
    })
    Object.assign(ctx, { status: 200, body })
  }
}