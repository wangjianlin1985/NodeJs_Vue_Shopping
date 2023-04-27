import { action } from '@/utils/action'

const state = {}
const mutations = {}

const actions = {
  list: ({ commit, state }, data) => action({ url: '/address/list', data }),
  remove: ({ commit, state }, data) => action({ url: '/address/remove', data }),
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}

