import { action } from '@/utils/action'

const state = {}
const mutations = {}

const actions = {
  list: ({ commit, state }, data) => action({ url: '/order/list', data }),
  remove: ({ commit, state }, data) => action({ url: '/order/remove', data }),
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}

