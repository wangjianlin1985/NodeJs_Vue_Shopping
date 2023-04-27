import { action } from '@/utils/action'

const state = {}
const mutations = {}

const actions = {
  all: ({ commit, state }) => action({ url: '/company', method: 'get' }),
  list: ({ commit, state }, data) => action({ url: '/company/list', data }),
  create: ({ commit, state }, data) => action({ url: '/company/create', data }),
  update: ({ commit, state }, data) => action({ url: '/company/update', data }),
  remove: ({ commit, state }, data) => action({ url: '/company/remove', data }),
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}

