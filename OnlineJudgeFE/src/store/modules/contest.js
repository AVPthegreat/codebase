import moment from 'moment'
import types from '../types'
import api from '@oj/api'
import { CONTEST_STATUS, USER_TYPE, CONTEST_TYPE } from '@/utils/constants'
import storage from '@/utils/storage'

// Helper functions for localStorage persistence
const CONTEST_STATE_KEY = 'contest_state'

const saveContestStateToLocal = (contestID, state) => {
  const key = `${CONTEST_STATE_KEY}_${contestID}`
  const contestState = {
    started: state.started,
    fullscreenExitCount: state.fullscreenExitCount,
    attempt: state.attempt,
    startTime: state.started ? new Date().toISOString() : null,
    submissions: storage.get(`${key}_submissions`) || [],
    problemStats: storage.get(`${key}_problem_stats`) || {}
  }
  storage.set(key, contestState)
}

const loadContestStateFromLocal = (contestID) => {
  const key = `${CONTEST_STATE_KEY}_${contestID}`
  return storage.get(key) || null
}

const clearContestStateFromLocal = (contestID) => {
  const key = `${CONTEST_STATE_KEY}_${contestID}`
  storage.remove(key)
  storage.remove(`${key}_submissions`)
  storage.remove(`${key}_problem_stats`)
}

const saveSubmissionToLocal = (contestID, submissionData) => {
  const key = `${CONTEST_STATE_KEY}_${contestID}_submissions`
  const submissions = storage.get(key) || []
  submissions.push({
    ...submissionData,
    timestamp: new Date().toISOString()
  })
  storage.set(key, submissions)
}

const updateProblemStatsLocal = (contestID, problemID, stats) => {
  const key = `${CONTEST_STATE_KEY}_${contestID}_problem_stats`
  const allStats = storage.get(key) || {}
  allStats[problemID] = {
    ...allStats[problemID],
    ...stats,
    lastUpdated: new Date().toISOString()
  }
  storage.set(key, allStats)
}

const state = {
  now: moment(),
  access: false,
  rankLimit: 30,
  forceUpdate: false,
  // Contest lock state
  started: false,
  fullscreenExitCount: 0,
  attempt: null,
  contest: {
    created_by: {},
    contest_type: CONTEST_TYPE.PUBLIC
  },
  contestProblems: [],
  itemVisible: {
    menu: true,
    chart: true,
    realName: false
  }
}

const getters = {
  // Check if contest is loaded
  contestLoaded: (state) => {
    return !!state.contest.status
  },
  contestStatus: (state, getters) => {
    if (!getters.contestLoaded) return null
    let startTime = moment(state.contest.start_time)
    let endTime = moment(state.contest.end_time)
    let now = state.now

    if (startTime > now) {
      return CONTEST_STATUS.NOT_START
    } else if (endTime < now) {
      return CONTEST_STATUS.ENDED
    } else {
      return CONTEST_STATUS.UNDERWAY
    }
  },
  contestRuleType: (state) => {
    return state.contest.rule_type || null
  },
  isContestAdmin: (state, getters, _, rootGetters) => {
    return rootGetters.isAuthenticated &&
      (state.contest.created_by.id === rootGetters.user.id || rootGetters.user.admin_type === USER_TYPE.SUPER_ADMIN)
  },
  contestMenuDisabled: (state, getters) => {
    if (getters.isContestAdmin) return false
    if (state.contest.contest_type === CONTEST_TYPE.PUBLIC) {
      return getters.contestStatus === CONTEST_STATUS.NOT_START
    }
    return !state.access
  },
  OIContestRealTimePermission: (state, getters, _, rootGetters) => {
    if (getters.contestRuleType === 'ACM' || getters.contestStatus === CONTEST_STATUS.ENDED) {
      return true
    }
    return state.contest.real_time_rank === true || getters.isContestAdmin
  },
  problemSubmitDisabled: (state, getters, _, rootGetters) => {
    if (getters.contestStatus === CONTEST_STATUS.ENDED) {
      return true
    } else if (getters.contestStatus === CONTEST_STATUS.NOT_START) {
      return !getters.isContestAdmin
    }
    return !rootGetters.isAuthenticated
  },
  passwordFormVisible: (state, getters) => {
    return state.contest.contest_type !== CONTEST_TYPE.PUBLIC && !state.access && !getters.isContestAdmin
  },
  contestStartTime: (state) => {
    return moment(state.contest.start_time)
  },
  contestEndTime: (state) => {
    return moment(state.contest.end_time)
  },
  countdown: (state, getters) => {
    if (getters.contestStatus === CONTEST_STATUS.NOT_START) {
      let duration = moment.duration(getters.contestStartTime.diff(state.now, 'seconds'), 'seconds')
      // time is too long
      if (duration.weeks() > 0) {
        return 'Start At ' + duration.humanize()
      }
      let texts = [Math.floor(duration.asHours()), duration.minutes(), duration.seconds()]
      return '-' + texts.join(':')
    } else if (getters.contestStatus === CONTEST_STATUS.UNDERWAY) {
      let duration = moment.duration(getters.contestEndTime.diff(state.now, 'seconds'), 'seconds')
      let texts = [Math.floor(duration.asHours()), duration.minutes(), duration.seconds()]
      return '-' + texts.join(':')
    } else {
      return 'Ended'
    }
  }
}

const mutations = {
  [types.CHANGE_CONTEST] (state, payload) {
    state.contest = payload.contest
  },
  [types.CHANGE_CONTEST_ITEM_VISIBLE] (state, payload) {
    state.itemVisible = {...state.itemVisible, ...payload}
  },
  [types.CHANGE_RANK_FORCE_UPDATE] (state, payload) {
    state.forceUpdate = payload.value
  },
  [types.CHANGE_CONTEST_PROBLEMS] (state, payload) {
    state.contestProblems = payload.contestProblems
  },
  [types.CHANGE_CONTEST_RANK_LIMIT] (state, payload) {
    state.rankLimit = payload.rankLimit
  },
  [types.CONTEST_ACCESS] (state, payload) {
    state.access = payload.access
  },
  [types.CLEAR_CONTEST] (state) {
    state.contest = {created_by: {}}
    state.contestProblems = []
    state.access = false
    state.itemVisible = {
      menu: true,
      chart: true,
      realName: false
    }
    state.forceUpdate = false
  },
  [types.NOW] (state, payload) {
    state.now = payload.now
  },
  [types.NOW_ADD_1S] (state) {
    state.now = moment(state.now.add(1, 's'))
  },
  // Contest lock mutations
  [types.CONTEST_SET_STARTED] (state, payload) {
    state.started = payload.started
    if (payload.resetCount) {
      state.fullscreenExitCount = 0
    }
    // Save to localStorage
    if (payload.contestID) {
      saveContestStateToLocal(payload.contestID, state)
    }
  },
  [types.CONTEST_INCREMENT_FULLSCREEN_EXIT] (state, payload) {
    state.fullscreenExitCount += 1
    // Save to localStorage
    if (payload && payload.contestID) {
      saveContestStateToLocal(payload.contestID, state)
    }
  },
  [types.CONTEST_RESET_LOCK] (state, payload) {
    state.started = false
    state.fullscreenExitCount = 0
    state.attempt = null
    // Clear localStorage
    if (payload && payload.contestID) {
      clearContestStateFromLocal(payload.contestID)
    }
  },
  [types.CONTEST_SAVE_SUBMISSION] (state, payload) {
    // Save submission to localStorage
    if (payload.contestID && payload.submissionData) {
      saveSubmissionToLocal(payload.contestID, payload.submissionData)
    }
  },
  [types.CONTEST_UPDATE_PROBLEM_STATS] (state, payload) {
    // Update problem stats in localStorage
    if (payload.contestID && payload.problemID && payload.stats) {
      updateProblemStatsLocal(payload.contestID, payload.problemID, payload.stats)
    }
  },
  [types.CONTEST_RESTORE_STATE] (state, payload) {
    // Restore contest state from localStorage
    if (payload.contestState) {
      state.started = payload.contestState.started || false
      state.fullscreenExitCount = payload.contestState.fullscreenExitCount || 0
      state.attempt = payload.contestState.attempt || null
    }
  }
}

const actions = {
  getContest ({commit, rootState, dispatch}) {
    return new Promise((resolve, reject) => {
      api.getContest(rootState.route.params.contestID).then((res) => {
        resolve(res)
        let contest = res.data.data
        commit(types.CHANGE_CONTEST, {contest: contest})
        commit(types.NOW, {now: moment(contest.now)})
        if (contest.contest_type === CONTEST_TYPE.PRIVATE) {
          dispatch('getContestAccess')
        }
      }, err => {
        reject(err)
      })
    })
  },
  getContestProblems ({commit, rootState}) {
    return new Promise((resolve, reject) => {
      api.getContestProblemList(rootState.route.params.contestID).then(res => {
        res.data.data.sort((a, b) => {
          if (a._id === b._id) {
            return 0
          } else if (a._id > b._id) {
            return 1
          }
          return -1
        })
        commit(types.CHANGE_CONTEST_PROBLEMS, {contestProblems: res.data.data})
        resolve(res)
      }, () => {
        commit(types.CHANGE_CONTEST_PROBLEMS, {contestProblems: []})
      })
    })
  },
  getContestAccess ({commit, rootState}) {
    return new Promise((resolve, reject) => {
      api.getContestAccess(rootState.route.params.contestID).then(res => {
        commit(types.CONTEST_ACCESS, {access: res.data.data.access})
        resolve(res)
      }).catch()
    })
  },
  loadContestOverview ({commit, state, rootState}) {
    const contestID = rootState.route.params.contestID
    return new Promise((resolve, reject) => {
      api.getContestUserOverview(contestID).then(res => {
        const attempt = res.data.data
        if (attempt) {
          commit(types.CONTEST_SET_STARTED, { started: true, contestID })
          state.fullscreenExitCount = attempt.fullscreen_exit_count || 0
          state.attempt = attempt
        }
        resolve(res)
      }).catch(err => reject(err))
    })
  },
  restoreContestState ({commit, rootState}) {
    // Restore contest state from localStorage on page load
    const contestID = rootState.route.params.contestID
    if (contestID) {
      const savedState = loadContestStateFromLocal(contestID)
      if (savedState && savedState.started) {
        commit(types.CONTEST_RESTORE_STATE, { contestState: savedState })
        // Re-enable fullscreen if contest was active
        if (savedState.started) {
          const el = document.documentElement
          if (el.requestFullscreen) {
            el.requestFullscreen().catch(() => {})
          } else if (el.webkitRequestFullscreen) {
            el.webkitRequestFullscreen()
          } else if (el.mozRequestFullScreen) {
            el.mozRequestFullScreen()
          } else if (el.msRequestFullscreen) {
            el.msRequestFullscreen()
          }
          // Ensure scrolling
          document.documentElement.style.overflow = 'auto'
          document.body.style.overflow = 'auto'
        }
      }
    }
  },
  saveSubmissionLocal ({commit}, payload) {
    // Save submission to localStorage
    commit(types.CONTEST_SAVE_SUBMISSION, payload)
  },
  updateProblemStatsLocal ({commit}, payload) {
    // Update problem stats in localStorage
    commit(types.CONTEST_UPDATE_PROBLEM_STATS, payload)
  },
  async submitContestFromLocal ({state, rootState}, contestID) {
    // Submit all localStorage data to backend
    const key = `${CONTEST_STATE_KEY}_${contestID}`
    const contestState = storage.get(key)
    const submissions = storage.get(`${key}_submissions`) || []
    const problemStats = storage.get(`${key}_problem_stats`) || {}
    
    if (!contestState || !contestState.started) {
      throw new Error('No active contest state found')
    }

    // Prepare data for submission
    const submissionData = {
      contest_id: contestID,
      fullscreen_exit_count: state.fullscreenExitCount,
      submissions: submissions,
      problem_stats: Object.keys(problemStats).map(problemID => ({
        problem_id: problemID,
        ...problemStats[problemID]
      })),
      start_time: contestState.startTime,
      end_time: new Date().toISOString()
    }

    try {
      // Call API to submit contest with all data
      if (contestState.attempt && contestState.attempt.id) {
        await api.contestStop(contestState.attempt.id, submissionData)
      }
      // Clear localStorage after successful submission
      clearContestStateFromLocal(contestID)
      return submissionData
    } catch (error) {
      console.error('Failed to submit contest data:', error)
      throw error
    }
  }
}

export default {
  state,
  mutations,
  getters,
  actions
}
