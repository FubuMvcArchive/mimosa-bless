chai = require "chai"
_ = require "lodash"
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

describe "blessAll", ->
  blessFile = blesser.__get__ "blessFile"

  it "breaks down the test file into three files", (done) ->
    files = ['test']

    blessFile "test/test.css", "test/test.css", {}, (blessData) ->
      expect(blessData.data.length).to.eql 3
      done()
  #TODO: more test coverage
