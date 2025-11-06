import Vue from 'vue'
import VueRouter from 'vue-router'
import routes from './routes'
import storage from '@/utils/storage'
import {STORAGE_KEY} from '@/utils/constants'
import {sync} from 'vuex-router-sync'
import {types, default as store} from '../../../store'

Vue.use(VueRouter)

const router = new VueRouter({
  mode: 'history',
  scrollBehavior (to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition
    } else {
      return {x: 0, y: 0}
    }
  },
  routes
})

// 全局身份确认
router.beforeEach((to, from, next) => {
  Vue.prototype.$Loading.start()
  // Contest lock: restrict navigation while a contest is started
  const locked = store.state && store.state.contest && store.state.contest.started
  if (locked) {
    const toPath = to.path || ''
    // Allow navigating to contest-details to view overview
    if (to.name === 'contest-details') {
      return next()
    }
    // Block navigating to global submission pages
    if (to.name === 'submission-list' || to.name === 'submission-details' || toPath.startsWith('/status')) {
      Vue.prototype.$Message && Vue.prototype.$Message.warning('During the contest, open Submissions from the problem page only.')
      return next(false)
    }
    // Block leaving contest area unless going to the same contest subtree
    const inContest = toPath.startsWith('/contest/')
    if (!inContest) {
      Vue.prototype.$Message && Vue.prototype.$Message.warning('Contest in progress. Navigation is limited.')
      return next(false)
    }
  }
  if (to.matched.some(record => record.meta.requiresAuth)) {
    if (!storage.get(STORAGE_KEY.AUTHED)) {
      Vue.prototype.$error('Please login first')
      store.commit(types.CHANGE_MODAL_STATUS, {mode: 'login', visible: true})
      next({
        name: 'home'
      })
    } else {
      next()
    }
  } else {
    next()
  }
})

router.afterEach((to, from, next) => {
  Vue.prototype.$Loading.finish()
})

sync(store, router)

export default router
