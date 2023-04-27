import { action } from '@/utils/action'

const state = {}
const mutations = {}

const actions = {
  all: ({ commit, state }) => action({ url: '/newslist', method: 'get' }),
  list: ({ commit, state }, data) => action({ url: '/newslist/list', data }),
  create: ({ commit, state }, data) => action({ url: '/newslist/create', data }),
  update: ({ commit, state }, data) => action({ url: '/newslist/update', data }),
  remove: ({ commit, state }, data) => action({ url: '/newslist/remove', data }),
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}

