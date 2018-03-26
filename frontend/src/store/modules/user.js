import { loginByUsername, logout, getUserInfo } from '@/api/login'
import { getAuthentication, setAuthentication, removeAuthentication } from '@/utils/auth'
import { Message } from 'element-ui'

const user = {
  state: {
    authentication: getAuthentication(),
    account: '',
    phone: ''
  },

  mutations: {
    SET_AUTHENTICATION: (state, authentication) => {
      state.authentication = authentication
    },
    SET_ACCOUNT: (state, account) => {
      state.account = account
    },
    SET_PHONE: (state, phone) => {
      state.phone = phone
    }
  },

  actions: {
    // 用户名登录
    LoginByUsername({ commit }, userInfo) {
      const account = userInfo.account.trim()
      return new Promise((resolve, reject) => {
        loginByUsername(account, userInfo.password).then(response => {
          const data = response.data
          console.log(data)
          if (data.code !== 200) {
            Message.error(data.error)
            return resolve()
          }
          commit('SET_AUTHENTICATION', data.authentication)
          setAuthentication(response.data.authentication)
          resolve()
        }).catch(error => {
          reject(error)
        })
      })
    },

    // 获取用户信息
    GetUserInfo({ commit, state }) {
      return new Promise((resolve, reject) => {
        getUserInfo(state.token).then(response => {
          if (!response.data) { // 由于mockjs 不支持自定义状态码只能这样hack
            reject('error')
          }
          const data = response.data
          commit('SET_ROLES', data.roles)
          commit('SET_NAME', data.name)
          commit('SET_AVATAR', data.avatar)
          commit('SET_INTRODUCTION', data.introduction)
          resolve(response)
        }).catch(error => {
          reject(error)
        })
      })
    },

    // 登出
    LogOut({ commit, state }) {
      return new Promise((resolve, reject) => {
        logout(state.authentication).then(() => {
          commit('SET_AUTHENTICATION', '')
          commit('SET_ROLES', [])
          removeAuthentication()
          resolve()
        }).catch(error => {
          reject(error)
        })
      })
    },

    // 前端 登出
    FedLogOut({ commit }) {
      return new Promise(resolve => {
        commit('SET_AUTHENTICATION', '')
        removeAuthentication()
        resolve()
      })
    }

  }
}

export default user
