import request from '@/utils/request'

export function fetchAccountButton() {
  return request({
    url: '/admin/account_buttons',
    method: 'get'
  })
}

export function createAccountButton(data) {
  return request({
    url: '/admin/account_buttons',
    method: 'post',
    data
  })
}
