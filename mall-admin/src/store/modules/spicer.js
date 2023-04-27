import { action } from '@/utils/action'

const state = {}
const mutations = {}

const actions = {
  all: ({ commit, state }) => action({ url: '/spicer', method: 'get' }),
  list: ({ commit, state }, data) => action({ url: '/spicer/list', data }),
  create: ({ commit, state }, data) => action({ url: '/spicer/create', data }),
  update: ({ commit, state }, data) => action({ url: '/spicer/update', data }),
  remove: ({ commit, state }, data) => action({ url: '/spicer/remove', data }),
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}

