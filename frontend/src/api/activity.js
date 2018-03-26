import request from '@/utils/request'

export function fetchActivityList(query) {
  return request({
    url: '/admin/activities',
    method: 'get',
    params: query
  })
}
