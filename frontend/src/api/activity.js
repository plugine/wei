import request from '@/utils/request'

export function fetchActivityList(query) {
  return request({
    url: '/admin/activities',
    method: 'get',
    params: query
  })
}

export function fetchActivity(id) {
  return request({
    url: '/admin/activities/' + id,
    method: 'get'
  })
}

export function createActivity(data) {
  return request({
    url: '/admin/activities',
    method: 'post',
    data
  })
}


export function updateActivity(id, data) {
  return request({
    url: '/admin/activities/' + id,
    method: 'put',
    data
  })
}
