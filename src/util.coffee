"use strict"
_ = require 'lodash'

trackCompletion = (title, initial, cb) ->
  remaining = [].concat initial
  done = (dir) ->
    remaining = _.without remaining, dir
    if remaining.length == 0
      cb()
  done

module.exports = {trackCompletion}
