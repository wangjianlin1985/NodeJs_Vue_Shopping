import { action } from '@/utils/action'

const state = {}
const mutations = {}

const actions = {
  all: ({ commit, state }) => action({ url: '/news', method: 'get' }),
  list: ({ commit, state }, data) => action({ url: '/news/list', data }),
  create: ({ commit, state }, data) => action({ url: '/news/create', data }),
  update: ({ commit, state }, data) => action({ url: '/news/update', data }),
  remove: ({ commit, state }, data) => action({ url: '/news/remove', data }),
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}

