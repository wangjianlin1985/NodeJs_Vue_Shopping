import { action } from '@/utils/action'

const state = {}
const mutations = {}

const actions = {
  all: ({ commit, state }) => action({ url: '/perfume', method: 'get' })
}

export default {
  namespaced: true,
  state,
  mutations,
  actions
}

