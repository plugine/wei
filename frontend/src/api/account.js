import request from '@/utils/request'

export function fetchAccountList() {
  return request({
    url: '/admin/public_accounts',
    method: 'get'
  })
}
