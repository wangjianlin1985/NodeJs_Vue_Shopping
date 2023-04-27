import request from '@/utils/request'

export function action({ url, method = 'post', data = {}}) {
  return new Promise((resolve, reject) => request({ url, method, ...method === 'post' ? { data } : { params: data }}).then(res => resolve(res)).catch(error => reject(error)))
}