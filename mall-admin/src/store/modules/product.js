import { action } from '@/utils/action'

const state = {}
const mutations = {}

const actions = {
  operation: ({ commit, state }, data) => action({ url: '/product/operation', data }),
  list: ({ commit, state }, data) => action({ url: '/product/list', data }),
  create: ({ commit, state }, data) => action({ url: '/product/create', data }),
  update: ({ commit, state }, data) => action({ url: '/product/update', data }),
  remove: ({ commit, state }, data) => action({ url: '/product/remove', data }),
  hot: ({ commit, state }, data) => action({ url: '/product/hot', data }),
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}

