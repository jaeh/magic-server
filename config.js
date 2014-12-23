'use strict';
var path = require('path');

module.exports = {
  defaults: {
    development: {
      host: "http://localhost:5000"
    , PORT: 5000
    }
  , production: {
      host: "https://production.com"
    , PORT: 5000
    }
  , staging: {
      host: "https://staging.production.com"
    , PORT: 5000
    }
  }
  , heroku: {
      remote: "production"
    , staging: "staging"
  }
  /*, mail: 'mail@mail.mail'
  , mailTransport: {
      host: 'localhost'
    , port: 465
    , secure: true
    , auth: {
        user: 'username'
      , pass: 'password'
    }
  }*/
}
