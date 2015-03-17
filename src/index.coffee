"use strict"

config = require './config'
blesser = require './blesser'

registration = (mimosaConfig, register) ->
  register ['preClean'], 'init', blesser.cleanBlessed
  register ['add', 'update', 'remove'], 'afterWrite', blesser.checkForBless
  register ['postBuild'], 'init', blesser.blessAll

registerCommand = (program, retrieveConfig) ->
  program
    .command('bless')
    .description('invokes bless compiler using config settings')
    .action () ->
      blesser.blessCommand retrieveConfig

module.exports =
  registration:    registration
  defaults:        config.defaults
  validate:        config.validate
  registerCommand: registerCommand
