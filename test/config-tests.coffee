chai = require "chai"
_ = require "lodash"
expect = chai.expect
config = require("../lib/config.js")

describe "the config", ->
  it "errors if no bless config section is provided", ->
    fakeConfig = {}
    result = config.validate fakeConfig
    expect(result).to.eql ["bless config"]

  it "errors if bless config section is not an object", ->
    fakeConfig =
      bless: []
    result = config.validate fakeConfig
    expect(result).to.eql ["bless config"]

  it "errors if options is not an object", ->
    fakeConfig =
      bless:
        options: []
        files: []
    result = config.validate fakeConfig
    expect(result).to.eql ["bless.options"]

  it "errors if files is not an array", ->
    fakeConfig =
      bless:
        options: {}
        files: {}
    result = config.validate fakeConfig
    expect(result).to.eql ["bless.files"]

  it "succeeds if all sections are all there and of the right type", ->
    fakeConfig =
      bless:
        options: {}
        files: []
    result = config.validate fakeConfig
    expect(result).to.eql []
