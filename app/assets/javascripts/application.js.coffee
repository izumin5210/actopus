$ = require 'jquery'
_ = require 'lodash'

global.jQuery = $

require 'jquery-ujs'
require 'bootstrap'
require './reschedulings.js.coffee'

$ ->
  $('[data-toggle="popover"]').popover()
  $('[data-toggle="tooltip"]').tooltip()
