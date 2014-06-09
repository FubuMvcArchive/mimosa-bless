"use strict"
_ = require 'lodash'
logger = require 'logmimosa'

trackCompletion = (title, initial, cb) ->
  remaining = [].concat initial
  done = (dir) ->
    remaining = _.without remaining, dir
    if remaining.length == 0
      logger.debug "calling callback for #{title}"
      cb()
  done

module.exports = {trackCompletion}
