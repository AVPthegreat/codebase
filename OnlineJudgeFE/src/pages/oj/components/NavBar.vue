<template>
  <div id="header">
    <Menu theme="light" mode="horizontal" @on-select="handleRoute" :active-name="activeMenu" class="oj-menu">
      <div class="logo"><span>NEXUSCODE</span></div>
      <Menu-item name="/">
        <Icon type="home"></Icon>
        {{$t('m.Home')}}
      </Menu-item>
      <Menu-item name="/problem">
        <Icon type="ios-keypad"></Icon>
        {{$t('m.NavProblems')}}
      </Menu-item>
      <Menu-item name="/contest">
        <Icon type="trophy"></Icon>
        {{$t('m.Contests')}}
      </Menu-item>
      <Menu-item name="/status">
        <Icon type="ios-pulse-strong"></Icon>
        {{$t('m.NavStatus')}}
      </Menu-item>
      <template v-if="isAdminRole">
        <Submenu name="rank">
          <template slot="title">
            <Icon type="podium"></Icon>
            {{$t('m.Rank')}}
          </template>
          <Menu-item name="/acm-rank">
            {{$t('m.ACM_Rank')}}
          </Menu-item>
          <Menu-item name="/oi-rank">
            {{$t('m.OI_Rank')}}
          </Menu-item>
        </Submenu>
        <Submenu name="about">
          <template slot="title">
            <Icon type="information-circled"></Icon>
            {{$t('m.About')}}
          </template>
          <Menu-item name="/about">
            {{$t('m.Judger')}}
          </Menu-item>
          <Menu-item name="/FAQ">
            {{$t('m.FAQ')}}
          </Menu-item>
        </Submenu>
      </template>
      <template v-if="!isAuthenticated">
        <div class="btn-menu">
          <Button type="ghost"
                  shape="circle"
                  @click="toggleTheme"
                  :icon="isDarkMode ? 'ios-sunny' : 'ios-moon'"
                  style="margin-right: 5px;"
                  :title="isDarkMode ? 'Light Mode' : 'Dark Mode'">
          </Button>
          <Button type="ghost"
                  ref="loginBtn"
                  shape="circle"
                  @click="handleBtnClick('login')">{{$t('m.Login')}}
          </Button>
          <Button v-if="website.allow_register"
                  type="ghost"
                  shape="circle"
                  @click="handleBtnClick('register')"
                  style="margin-left: 5px;">{{$t('m.Register')}}
          </Button>
        </div>
      </template>
      <template v-else>
        <div class="user-section">
          <Button type="ghost"
                  class="theme-toggle-btn"
                  shape="circle"
                  @click="toggleTheme"
                  :icon="isDarkMode ? 'ios-sunny' : 'ios-moon'"
                  :title="isDarkMode ? 'Light Mode' : 'Dark Mode'">
          </Button>
          <Dropdown class="drop-menu" @on-click="handleRoute" placement="bottom" trigger="click">
            <Button type="text" class="drop-menu-title">{{ user.username }}
              <Icon type="arrow-down-b"></Icon>
            </Button>
            <Dropdown-menu slot="list">
              <Dropdown-item name="/user-home">{{$t('m.MyHome')}}</Dropdown-item>
              <Dropdown-item name="/status?myself=1">{{$t('m.MySubmissions')}}</Dropdown-item>
              <Dropdown-item name="/setting/profile">{{$t('m.Settings')}}</Dropdown-item>
              <Dropdown-item v-if="isAdminRole" name="/admin">{{$t('m.Management')}}</Dropdown-item>
              <Dropdown-item divided name="/logout">{{$t('m.Logout')}}</Dropdown-item>
            </Dropdown-menu>
          </Dropdown>
        </div>
      </template>
    </Menu>
    <Modal v-model="modalVisible" :width="400">
      <div slot="header" class="modal-title">{{$t('m.Welcome_to')}} {{website.website_name_shortcut}}</div>
      <component :is="modalStatus.mode" v-if="modalVisible"></component>
      <div slot="footer" style="display: none"></div>
    </Modal>
  </div>
</template>

<script>
  import { mapGetters, mapActions } from 'vuex'
  import login from '@oj/views/user/Login'
  import register from '@oj/views/user/Register'

  export default {
    components: {
      login,
      register
    },
    data () {
      return {
        isDarkMode: false
      }
    },
    mounted () {
      this.getProfile()
      // Load theme preference from localStorage
      const savedTheme = localStorage.getItem('theme')
      if (savedTheme === 'dark') {
        this.isDarkMode = true
        document.documentElement.classList.add('dark-mode')
        document.body.classList.add('dark-mode')
      }
    },
    methods: {
      ...mapActions(['getProfile', 'changeModalStatus']),
      handleRoute (route) {
        if (route && route.indexOf('admin') < 0) {
          this.$router.push(route)
        } else {
          window.open('/admin/')
        }
      },
      handleBtnClick (mode) {
        this.changeModalStatus({
          visible: true,
          mode: mode
        })
      },
      toggleTheme () {
        this.isDarkMode = !this.isDarkMode
        if (this.isDarkMode) {
          document.documentElement.classList.add('dark-mode')
          document.body.classList.add('dark-mode')
          localStorage.setItem('theme', 'dark')
        } else {
          document.documentElement.classList.remove('dark-mode')
          document.body.classList.remove('dark-mode')
          localStorage.setItem('theme', 'light')
        }
      }
    },
    computed: {
      ...mapGetters(['website', 'modalStatus', 'user', 'isAuthenticated', 'isAdminRole']),
      // Follow route changes
      activeMenu () {
        return '/' + this.$route.path.split('/')[1]
      },
      modalVisible: {
        get () {
          return this.modalStatus.visible
        },
        set (value) {
          this.changeModalStatus({visible: value})
        }
      }
    }
  }
</script>

<style lang="less" scoped>
  #header {
    position: sticky;
    top: 16px;
    left: 0;
    width: 100%;
    z-index: 9999;
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 0 16px;
    margin-bottom: 24px;
    overflow: visible;
    
    .oj-menu {
      max-width: 1200px;
      width: 100%;
      background: rgba(255, 255, 255, 0.8);
      backdrop-filter: blur(12px);
      -webkit-backdrop-filter: blur(12px);
      border-radius: 9999px;
      border: 1px solid rgba(0, 0, 0, 0.08);
      box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
      padding: 8px 24px;
      transition: all 0.3s ease;
      will-change: transform;
      transform: translateZ(0);
      backface-visibility: hidden;
      perspective: 1000px;
      display: flex !important;
      align-items: center;
      height: auto;
      line-height: normal;
      overflow: visible;
      
      &:hover {
        box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
      }
    }

    .logo {
      margin-right: 32px;
      font-size: 20px;
      font-weight: 700;
      letter-spacing: 0.05em;
      line-height: 48px;
      color: #e78a53;
      flex-shrink: 0;
      
      span {
        background: linear-gradient(135deg, #e78a53 0%, #d4693f 100%);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
        background-clip: text;
      }
    }

    .drop-menu {
      margin-left: auto;
      position: relative;
      flex-shrink: 0;
      
      &-title {
        font-size: 14px;
        font-weight: 500;
        padding: 6px 16px;
        border-radius: 8px;
        border: 1px solid rgba(0, 0, 0, 0.08);
        background: rgba(255, 255, 255, 0.6);
        backdrop-filter: blur(12px);
        transition: all 0.2s ease;
        
        &:hover {
          background: rgba(255, 255, 255, 0.9);
          border-color: rgba(0, 0, 0, 0.12);
        }
      }
    }
    
    .user-section {
      margin-left: auto;
      display: flex;
      align-items: center;
      gap: 8px;
      flex-shrink: 0;
    }
    
    .btn-menu {
      margin-left: auto;
      display: flex;
      align-items: center;
      gap: 8px;
      flex-shrink: 0;
      
      .ivu-btn {
        font-size: 14px;
        font-weight: 500;
        transition: all 0.2s ease;
        
        &:hover {
          transform: translateY(-1px);
        }
      }
    }
    
    .theme-toggle-btn {
      margin-left: 0;
      transition: all 0.2s ease;
      flex-shrink: 0;
      
      &:hover {
        transform: translateY(-1px);
      }
    }
  }

  // Menu item styles
  :deep(.ivu-menu-item),
  :deep(.ivu-menu-submenu-title) {
    font-size: 14px;
    font-weight: 500;
    padding: 8px 16px;
    border-radius: 12px;
    transition: all 0.2s ease;
    color: rgba(0, 0, 0, 0.6);
    float: none !important;
    display: inline-flex;
    align-items: center;
    line-height: normal;
    height: auto;
    
    &:hover {
      background: rgba(0, 0, 0, 0.04);
      color: rgba(0, 0, 0, 0.9);
    }
    
    .ivu-icon {
      margin-right: 6px;
      font-size: 16px;
    }
  }
  
  :deep(.ivu-menu-item-active),
  :deep(.ivu-menu-item-selected) {
    background: rgba(231, 138, 83, 0.1);
    color: #e78a53;
    border-bottom: none !important;
    
    &:after {
      display: none !important;
    }
    
    &:before {
      display: none !important;
    }
  }
  
  :deep(.ivu-menu-horizontal) {
    border-bottom: none !important;
    display: flex;
    align-items: center;
    flex-wrap: nowrap;
    height: auto;
    line-height: normal;
    
    &:after {
      display: none !important;
    }
    
    &:before {
      display: none !important;
    }
    
    .ivu-menu-item,
    .ivu-menu-submenu {
      float: none;
      position: relative;
      border-bottom: none !important;
      
      &:after {
        display: none !important;
      }
    }
  }
  
  :deep(.ivu-menu-submenu) {
    float: none !important;
    display: inline-block;
  }

  // Dropdown menu styling
  :deep(.ivu-select-dropdown),
  :deep(.ivu-dropdown-menu) {
    border-radius: 12px;
    border: 1px solid rgba(0, 0, 0, 0.08);
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(20px);
    box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
    margin-top: 8px;
    z-index: 10000 !important;
  }
  
  :deep(.ivu-dropdown) {
    z-index: 10000 !important;
  }
  
  :deep(.ivu-select-dropdown) {
    z-index: 10000 !important;
  }
  
  :deep(.ivu-dropdown-item) {
    font-size: 14px;
    padding: 10px 16px;
    transition: all 0.2s ease;
    
    &:hover {
      background: rgba(0, 0, 0, 0.04);
      color: rgba(0, 0, 0, 0.9);
    }
  }

  .modal {
    &-title {
      font-size: 18px;
      font-weight: 600;
    }
  }
  
  // Dark mode adjustments
  :global(.dark-mode) #header {
    .oj-menu {
      background: rgba(15, 23, 42, 0.8);
      border-color: rgba(255, 255, 255, 0.1);
    }
    
    .logo {
      color: #e78a53;
    }
    
    .drop-menu-title {
      background: rgba(15, 23, 42, 0.6);
      border-color: rgba(255, 255, 255, 0.1);
      color: #eee;
      
      &:hover {
        background: rgba(15, 23, 42, 0.9);
      }
    }
    
    :deep(.ivu-menu-item),
    :deep(.ivu-menu-submenu-title) {
      color: rgba(255, 255, 255, 0.6);
      
      &:hover {
        background: rgba(255, 255, 255, 0.08);
        color: rgba(255, 255, 255, 0.9);
      }
    }
    
    :deep(.ivu-select-dropdown),
    :deep(.ivu-dropdown-menu) {
      background: rgba(15, 23, 42, 0.95);
      border-color: rgba(255, 255, 255, 0.1);
    }
  }
</style>
