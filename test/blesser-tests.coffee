chai = require "chai"
_ = require "lodash"
sinon = require "sinon"
expect = chai.expect
rewirez = require "./rewirez"
blesser = rewirez "../lib/blesser.js"
path = require "path"

describe "gatherFiles", ->
  gatherFiles = blesser.__get__ "gatherFiles"

  it "expands folder names into all .css files recursively under that folder", ->
    files = ['test']
    result = gatherFiles files
    expect(result).to.eql ["test#{path.sep}test.css"]

describe "blessFile", ->
  blessFile = blesser.__get__ "blessFile"

  it "breaks down the test file into three files", (done) ->
    files = ['test']

    blessFile "test/test.css", "test/test.css", {}, (blessData) ->
      expect(blessData.data.length).to.eql 3
      done()

describe "blessAll", ->
  parserSpy = parserRewire  = blessAll = writeFilesSpy = writeFilesRewire = fsRewire = {}

  testConfig =
    isBuild: true
    bless:
      files: ['test']
      options: {}

  # rewire test stubs and spies
  beforeEach ->
    blessAll = blesser.__get__ "blessAll"
    parser = blesser.__get__ "parser"

    writeFilesSpy = sinon.spy()
    parserSpy = sinon.spy parser

    writeFilesRewire = blesser.__set__ 'writeFiles', writeFilesSpy
    parserRewire = blesser.__set__ 'parser', parserSpy
    fsRewire = blesser.__set__ 'fs',
      existsSync: (input) -> true
      readFile: (input, encode, cb) ->
        cb {message:"Mocking read file fail"}, null
      statSync: (input) ->
        isDirectory: -> input is 'test'

  # revert rewired content
  afterEach ->
    writeFilesRewire()
    fsRewire()
    parserRewire()

  it "writes the blessData out to multiple files", (done) ->
    fsRewire()
    blessAll testConfig, {}, ->
      expect(writeFilesSpy.called).to.be.true
      done()

  it "does not write blessData out if readFile fails", (done) ->
    blessAll testConfig, {}, ->
      expect(parserSpy.called).to.be.false
      expect(writeFilesSpy.called).to.be.false
      done()

  #TODO: more test coverage
