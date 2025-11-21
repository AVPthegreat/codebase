<template>
  <Panel shadow class="daily-challenge">
    <div slot="title" class="panel-title">
      <Icon type="fireball" class="icon-fire"></Icon> Daily Challenge
    </div>
    <div class="content" v-if="challenge">
      <div class="challenge-info">
        <h2 class="problem-title">{{ challenge.title }}</h2>
        <div class="badges">
          <Tag :color="difficultyColor" class="difficulty-tag">{{ challenge.difficulty }}</Tag>
          <Tag color="gold" class="xp-tag">⚡ Double XP</Tag>
        </div>
        <div class="date-info">
          <Icon type="calendar"></Icon> {{ challenge.date }}
        </div>
      </div>
      <div class="action-area">
        <Button type="primary" size="large" shape="circle" icon="play" @click="solveChallenge" long>Solve Now</Button>
      </div>
    </div>
    <div class="loading" v-else>
      <Spin size="large"></Spin>
    </div>
  </Panel>
</template>

<script>
  import api from '@oj/api'

  export default {
    name: 'DailyChallenge',
    data () {
      return {
        challenge: null
      }
    },
    mounted () {
      this.getDailyChallenge()
    },
    computed: {
      difficultyColor () {
        if (!this.challenge) return 'default'
        if (this.challenge.difficulty === 'Low') return 'green'
        if (this.challenge.difficulty === 'Mid') return 'blue'
        if (this.challenge.difficulty === 'High') return 'red'
        return 'default'
      }
    },
    methods: {
      getDailyChallenge () {
        api.getDailyChallenge().then(res => {
          this.challenge = res.data.data
        })
      },
      solveChallenge () {
        if (this.challenge) {
          this.$router.push({name: 'problem-details', params: {problemID: this.challenge.problem_id}})
        }
      }
    }
  }
</script>

<style lang="less" scoped>
  .daily-challenge {
    margin-bottom: 20px;
    .panel-title {
      font-size: 18px;
      font-weight: bold;
      color: #ed3f14; 
      .icon-fire {
        margin-right: 5px;
      }
    }
    .content {
      padding: 10px;
      text-align: center;
      
      .problem-title {
        font-size: 24px;
        margin-bottom: 15px;
        color: #333;
        font-weight: 600;
        animation: pulse 2s infinite;
      }

      .badges {
        margin-bottom: 20px;
        .difficulty-tag {
          font-size: 14px;
          padding: 5px 10px;
        }
        .xp-tag {
          font-size: 14px;
          padding: 5px 10px;
          font-weight: bold;
        }
      }

      .date-info {
        color: #888;
        margin-bottom: 25px;
        font-size: 14px;
      }

      .action-area {
        padding: 0 20px;
      }
    }
    
    .loading {
      padding: 30px;
      text-align: center;
    }
  }

  @keyframes pulse {
    0% { transform: scale(1); }
    50% { transform: scale(1.05); }
    100% { transform: scale(1); }
  }
  
  /* Dark mode overrides */
  .dark-mode {
    .daily-challenge {
      .problem-title {
        color: #f0f0f0;
      }
      .date-info {
        color: #aaa;
      }
    }
  }
</style>
