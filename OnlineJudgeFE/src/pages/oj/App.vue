<template>
  <div>
    <component
      :is="isContestRoute ? 'ContestNavBar' : 'NavBar'"
      v-bind="contestNavBarProps"
    />
    <div class="content-app">
      <transition name="fadeInUp" mode="out-in">
        <router-view></router-view>
      </transition>
      <div class="footer"></div>
    </div>
    <BackTop></BackTop>
  </div>
</template>

<script>
  import { mapActions, mapState, mapGetters } from 'vuex'
  import NavBar from '@oj/components/NavBar.vue'
  import ContestNavBar from '@oj/components/ContestNavBar.vue'

  export default {
    name: 'app',
    components: {
      NavBar,
      ContestNavBar
    },
    data () {
      return {
        version: process.env.VERSION
      }
    },
    created () {
      try {
        document.body.removeChild(document.getElementById('app-loader'))
      } catch (e) {
      }
    },
    mounted () {
      this.getWebsiteConfig()
    },
    methods: {
      ...mapActions(['getWebsiteConfig', 'changeDomTitle'])
    },
    computed: {
      ...mapState(['website']),
      ...mapGetters([
        'contest',
        'OIContestRealTimePermission',
        'isContestAdmin',
        'contestRuleType'
      ]),
      isContestRoute () {
        // Only show ContestNavBar for contest-details and its children, not for contest-list
        const name = this.$route.name
        return name === 'contest-details' || (name && name.startsWith('contest-') && name !== 'contest-list')
      },
      contestNavBarProps () {
        if (!this.isContestRoute) return {}
        return {
          contestTitle: (this.contest && this.contest.title) ? this.contest.title : '',
          showSubmissions: this.OIContestRealTimePermission,
          showRank: this.OIContestRealTimePermission,
          showAdminHelper: this.isContestAdmin && this.contestRuleType === 'ACM'
        }
      }
    },
    watch: {
      'website' () {
        this.changeDomTitle()
      },
      '$route' () {
        this.changeDomTitle()
      }
    }
  }
</script>

<style lang="less">

  * {
    -webkit-box-sizing: border-box;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
  }

  a {
    text-decoration: none;
    background-color: transparent;
    &:active, &:hover {
      outline-width: 0;
    }
  }


  @media screen and (max-width: 1200px) {
  .content-app {
    margin-top: 100px;
    padding: 0 2%;
  }
}

@media screen and (min-width: 1200px) {
  .content-app {
    margin-top: 100px;
    padding: 0 2%;
  }
}

  .footer {
    margin-top: 20px;
    margin-bottom: 10px;
    text-align: center;
    font-size: small;
  }

  .fadeInUp-enter-active {
    animation: fadeInUp .8s;
  }


</style>
