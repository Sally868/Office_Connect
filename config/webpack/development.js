process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')

// const workbox = require('./plugins/workbox');
// environment.plugins.append('workbox', workbox);
// console.log('development.js', environment);
module.exports = environment.toWebpackConfig()
