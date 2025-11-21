<template>
  <div class="heatmap-container">
    <div class="heatmap-chart">
      <ECharts :options="options" ref="heatmap" auto-resize></ECharts>
    </div>
  </div>
</template>

<script>
  import api from '@oj/api'
  import moment from 'moment'

  export default {
    name: 'SubmissionHeatmap',
    props: {
      username: {
        type: String,
        required: true
      }
    },
    data () {
      return {
        options: {
          tooltip: {
            position: 'top',
            formatter: function (p) {
              var format = p.data[0]
              return format + ': ' + p.data[1] + ' submissions'
            }
          },
          visualMap: {
            min: 0,
            max: 10,
            calculable: false,
            orient: 'horizontal',
            left: 'center',
            top: 'top',
            inRange: {
              color: ['#ebedf0', '#c6e48b', '#7bc96f', '#239a3b', '#196127']
            },
            show: false // Hide the legend to look more like GitHub
          },
          calendar: {
            top: 30,
            left: 30,
            right: 30,
            cellSize: ['auto', 13],
            range: [moment().subtract(1, 'year').format('YYYY-MM-DD'), moment().format('YYYY-MM-DD')],
            itemStyle: {
              borderWidth: 0.5
            },
            yearLabel: { show: false },
            dayLabel: {
              firstDay: 1, // Start week on Monday
              nameMap: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
            },
            monthLabel: {
              nameMap: 'en'
            },
            splitLine: {
              show: false
            }
          },
          series: [{
            type: 'heatmap',
            coordinateSystem: 'calendar',
            data: []
          }]
        }
      }
    },
    mounted () {
      this.fetchData()
    },
    methods: {
      fetchData () {
        api.getSubmissionHeatmap(this.username).then(res => {
          let data = res.data.data
          // ECharts expects data in [date, value] format
          this.options.series[0].data = data
          
          // Dynamic range adjustment if needed, but fixed last year is standard
          // this.options.calendar.range = ...
          
          // Adjust max value for visual map based on user's max submissions
          let maxVal = 0
          data.forEach(item => {
            if (item[1] > maxVal) maxVal = item[1]
          })
          if (maxVal > 0) {
             // Scale colors: 0 is empty, max is darkest
             this.options.visualMap.max = Math.max(5, maxVal) 
          }
        })
      }
    },
    watch: {
      username () {
        this.fetchData()
      }
    }
  }
</script>

<style lang="less" scoped>
  .heatmap-container {
    width: 100%;
    height: 200px;
    margin-top: 20px;
    background: #fff;
    border-radius: 4px;
    padding: 10px;
    /* Dark mode support via global overrides or scoped check */
  }
  .heatmap-chart {
    width: 100%;
    height: 100%;
  }
</style>
