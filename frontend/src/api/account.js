import request from '@/utils/request'

export function fetchAccountList() {
  return request({
    url: '/admin/public_accounts',
    method: 'get'
  })
}

export function fetchAccount(id) {
  return request({
    url: '/admin/public_accounts/' + id,
    method: 'get'
  })
}

export function deleteAccount(id) {
  return request({
    url: '/admin/public_accounts/' + id,
    method: 'delete'
  })
}

export function createAccount(data) {
  return request({
    url: '/admin/public_accounts',
    method: 'post',
    data
  })
}

export function updateAccount(id, data) {
  return request({
    url: '/admin/public_accounts/' + id,
    method: 'put',
    data
  })
}
