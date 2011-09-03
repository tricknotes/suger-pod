helper = require __dirname + '/../spec_helper'

describe 'suger-pod', ->
  beforeEach ->
    @suger = require 'suger-pod'

  describe '.render()', ->
    describe 'when call with coffee-script', ->
      it 'should be rendered', ->
        expect(@suger.render('console.log Number "234"'))
          .toEqual(helper.enclose('  console.log(Number("234"));'))

    describe 'when call with empty string', ->
      it 'should be rendered empty', ->
        expect(@suger.render(''))
          .toEqual(helper.enclose(''))

    describe 'with options', ->
      describe 'as primitive', ->
        it 'should be rendered with String', ->
          expect(@suger.render('alert @@message', message: "I can't go."))
            .toEqual(helper.enclose("  alert('I can\\'t go.');"))

        it 'should be rendered with Number', ->
          expect(@suger.render('"#{@@year} years ago."', year: 26))
            .toEqual(helper.enclose('  "" + 26 + " years ago.";'))

        it 'should be rendered with Boolean', ->
          expect(@suger.render('{married: @@married}', married: false))
            .toEqual(helper.enclose("  ({\n    married: false\n  });"))

      describe 'as object', ->
        it 'should be rendered with String', ->
          expect(@suger.render('alert @@data', data: new String("I can't go.")))
            .toEqual(helper.enclose("  alert(\"I can't go.\");"))

        it 'should be rendered with Number', ->
          expect(@suger.render('"#{@@year} years ago."', year: new Number(26)))
            .toEqual(helper.enclose('  "" + 26 + " years ago.";'))

        it 'should be rendered with Boolean', ->
          expect(@suger.render('{married: @@married}', married: new Boolean(false)))
            .toEqual(helper.enclose("  ({\n    married: false\n  });"))

        it 'should be rendered with Object', ->
          expect(@suger.render('config = @@config', config: {path: "/config", name: 'Jhon', age: 35}))
            .toEqual(helper.enclose('  var config;\n  config = {"path":"/config","name":\"Jhon\","age":35};'))

        it 'should not be rendered with Function', ->
          expect(=> @suger.render('@@sum', sum: (a, b) -> a + b))
            .toThrow('Function should not be embeded: @@sum')

  describe '.compile()', ->
    it 'should be compiled', ->
      expect(@suger.compile('location.href = @@url')(url: 'http://example.com/'))
        .toEqual(helper.enclose("  location.href = 'http://example.com/';"))
