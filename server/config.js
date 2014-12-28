'use strict';
var path = require('path');

module.exports = {
  defaults: {
    development: {
      host: "http://jaeh:80/404"
    , PORT: 80
    }
  , production: {
      host: "https://jaeh.at/404"
    , PORT: 80
    }
  , staging: {
      host: "https://staging.jaeh.at/404"
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
