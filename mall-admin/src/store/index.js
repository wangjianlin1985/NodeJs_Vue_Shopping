import Vue from 'vue'
import Vuex from 'vuex'
import getters from './getters'
Vue.use(Vuex)

const modulesFiles = require.context('./modules', true, /\.js$/)
const modules = modulesFiles.keys().reduce((modules, path) => {
  const name = path.replace(/.*?([^\/\.]+)\.\w+$/, '$1')
  const value = modulesFiles(path)
  modules[name] = value.default
  return modules
}, {})
export default new Vuex.Store({
  modules,
  getters
})
