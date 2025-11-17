let date = require('moment')().format('YYYYMMDD')
let commit = 'local'
try {
  commit = require('child_process').execSync('git rev-parse HEAD').toString().slice(0, 5)
} catch (e) {
  // Not a git repo inside container or git not installed; fallback to 'local'
}
let version = `"${date}-${commit}"`

console.log(`current version is ${version}`)

module.exports = {
  NODE_ENV: '"development"',
  VERSION: version,
  USE_SENTRY: '0'
}
