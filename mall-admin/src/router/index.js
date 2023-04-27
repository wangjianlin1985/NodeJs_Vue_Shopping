import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

/* Layout */
import Layout from '@/layout'

export const constantRoutes = [
  {
    path: '/login',
    component: () => import('@/views/login/index'),
    hidden: true
  },

  {
    path: '/404',
    component: () => import('@/views/404'),
    hidden: true
  },

  {
    path: '/',
    component: Layout,
    children: [{
      path: '',
      name: 'Dashboard',
      component: () => import('@/views/dashboard/index'),
      meta: { title: '主页', icon: 'dashboard' }
    }]
  },

  {
    path: '/user',
    component: Layout,
    children: [{
      path: '',
      name: 'User',
      component: () => import('@/views/user/index'),
      meta: { title: '用户管理', icon: 'user' }
    }]
  },

  {
    path: '/product',
    component: Layout,
    children: [{
      path: '',
      name: 'Product',
      component: () => import('@/views/product/index'),
      meta: { title: '商品管理', icon: 'user' }
    }]
  },

  {
    path: '/company',
    component: Layout,
    children: [{
      path: '',
      name: 'Company',
      component: () => import('@/views/company/index'),
      meta: { title: '公司管理', icon: 'user' }
    }]
  },

  {
    path: '/spicer',
    component: Layout,
    children: [{
      path: '',
      name: 'Spicer',
      component: () => import('@/views/spicer/index'),
      meta: { title: '香料管理', icon: 'user' }
    }]
  },

  {
    path: '/order',
    component: Layout,
    children: [{
      path: '',
      name: 'Order',
      component: () => import('@/views/order/index'),
      meta: { title: '订单管理', icon: 'user' }
    }]
  },

  {
    path: '/comment',
    component: Layout,
    children: [{
      path: '',
      name: 'Comment',
      component: () => import('@/views/comment/index'),
      meta: { title: '评论管理', icon: 'user' }
    }]
  },

  {
    path: '/address',
    component: Layout,
    children: [{
      path: '',
      name: 'Address',
      component: () => import('@/views/address/index'),
      meta: { title: '地址管理', icon: 'user' }
    }]
  },

  {
    path: '/newslist',
    component: Layout,
    children: [{
      path: '',
      name: 'Newslist',
      component: () => import('@/views/newslist/index'),
      meta: { title: '新闻分类管理', icon: 'user'}
    }]
  },

  {
    path: '/news',
    component: Layout,
    children: [{
      path: '',
      name: 'News',
      component: () => import('@/views/news/index'),
      meta: { title: '新闻管理', icon: 'user'}
    }]
  },

  // 404 page must be placed at the end !!!
  { path: '*', redirect: '/404', hidden: true }
]

const createRouter = () => new Router({
  // mode: 'history', // require service support
  scrollBehavior: () => ({ y: 0 }),
  routes: constantRoutes
})

const router = createRouter()

// Detail see: https://github.com/vuejs/vue-router/issues/1234#issuecomment-357941465
export function resetRouter() {
  const newRouter = createRouter()
  router.matcher = newRouter.matcher // reset router
}

export default router
