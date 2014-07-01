mimosa-bless [![Build Status][travis-image]][travis-url]
===========
## Overview

Runs Bless on your css

## Usage

Add `mimosa-bless` to your list of modules.  That's all!  Mimosa will install the module for you when you start up.

## Default Config

  bless: {
    options: {
      cacheBuster: true,
      cleanup: true,
      compress: false,
      force: false,
      imports: true
    },
    files: []
  }

`files` is an array of strings with each entry being either the name of a folder or an exact file name
if its a folder, it will recursively find any files ending in a .css extension within that folder

[travis-url]: https://travis-ci.org/DarthFubuMVC/mimosa-bless
[travis-image]: https://travis-ci.org/DarthFubuMVC/mimosa-bless.svg
