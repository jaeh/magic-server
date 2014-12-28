'use strict';
var path = require('path');

module.exports = {
  defaults: {
    development: {
      host: "http://localhost:80"
    , PORT: 80
    }
  , production: {
      host: "https://production.com"
    , PORT: 80
    }
  , staging: {
      host: "https://staging.production.com"
    , PORT: 80
    }
  }
  , heroku: {
      remote: "production"
    , staging: "staging"
  }
  , mail: 'mail@mail.mail'
  , mailTransport: {
      host: 'localhost'
    , port: 465
    , secure: true
    , auth: {
        user: 'username'
      , pass: 'password'
    }
  }
}
