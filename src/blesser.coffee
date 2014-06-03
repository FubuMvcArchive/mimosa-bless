bless = require 'bless'
fs = require 'fs'
path = require 'path'
logger = require 'logmimosa'
color = require('ansi-color').set
_ = require 'lodash'
wrench = require 'wrench'
{printObj, trackCompletion} = require './util'

blessFile = (input, output, options, next) ->
  unless fs.existsSync input
    return logger.warn "mimosa-bless: bless file [[ #{input} ]] does not exist"

  logger.info "Blessing [[ #{input} ]]"

  fs.readFile input, 'utf-8', (e, data) ->
    if (e)
      logger.error "blessc: " + e.message
      next()

    settings = {output, options}

    new bless.Parser(settings).parse data, (err, files, numSelectors) ->
      if (err)
        logger.error "blessc: " + e.message
        next()
      else
        numFiles = files.length
        logger.info "Source CSS file [[ #{input} ]] contained #{numSelectors} selectors"
        if (numFiles > 1 || input != output)
          _.each files, (file) ->
            fd = fs.openSync file.filename, 'w'
            fs.writeSync fd, file.content, 0, 'utf-8'

          logger.success " #{numFiles} CSS files created for #{input}"
        else
          logger.success "No changes made."

cleanBlessed = (mimosaConfig, options, next) ->
  #TODO: clean up any generated bless files
  next()

checkForBless = (mimosaConfig, options, next) ->
  #TODO: support blessing in watch mode if files get added
  next()

gatherFiles = (filesFromOptions) ->
  _ filesFromOptions
    .map (entry) ->
      if fs.statSync(entry).isDirectory()
      then wrench.readdirSyncRecursive(entry).filter (f) ->
        (path.extname f) == ".css"
      .map (f) -> path.join entry, f
      else [entry]
    .flatten()
    .uniq()
    .value()

blessAll = (mimosaConfig, options, next) ->
  settings = mimosaConfig.bless.options
  logger.info "Blessing files"
  files = gatherFiles mimosaConfig.bless.files

  logger.debug "bless files: #{files}"

  #TODO: support output per filename via object entry if desired
  sources = _.map files, (value, key) ->
    input = if _.isString(key) then key else value
    output = value
    {input, output}

  uniqueInputs = _.map sources, ({input, output}) -> input

  finish = trackCompletion "blessSources", uniqueInputs, next

  _.each sources, ({input, output}) ->
    blessFile input, output, settings, () -> finish(input)

module.exports = {blessAll, checkForBless, cleanBlessed}
