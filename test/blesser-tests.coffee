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

  #TODO: more test coverage
