"use strict"

config = require './config'
blesser = require './blesser'

registration = (mimosaConfig, register) ->
  register ['preClean'], 'init', blesser.cleanBlessed
  register ['add', 'update', 'remove'], 'afterWrite', blesser.checkForBless
  register ['postBuild'], 'init', blesser.blessAll

module.exports =
  registration:    registration
  defaults:        config.defaults
  placeholder:     config.placeholder
  validate:        config.validate
