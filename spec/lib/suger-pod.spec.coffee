helper = require __dirname + '/../spec_helper'

describe 'suger-pod', ->
  beforeEach ->
    @suger = require 'suger-pod'

  describe '.render()', ->
    describe 'when call with coffee-script', ->
      it 'should be rendered', ->
        expect(@suger.render('console.log Number "234"'))
          .toEqual(helper.enclose('  console.log(Number("234"));'))
