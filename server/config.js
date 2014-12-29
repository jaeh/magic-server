'use strict';
var path = require('path');

module.exports = {
  defaults: {
    development: {
      host: "http://jaeh/404"
    , PORT: 5000
    }
  , production: {
      host: "https://jaeh.at/404"
    , PORT: 5000
    }
  , staging: {
      host: "https://jaeh.at:5000/404"
    , PORT: 5000
    }
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
