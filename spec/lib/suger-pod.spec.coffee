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

        it 'should be rendered with Date', ->
          date = new Date(2011, 8, 4, 11, 15, 30) # want to consider timezone
          expect(@suger.render('@@now', now: date))
            .toEqual(helper.enclose("  new Date('#{date.toString()}');"))

        it 'should be rendered with RegExp', ->
          expect(@suger.render('@@escape', escape: /(?:\n')+[a-z]/))
            .toEqual(helper.enclose('  /(?:\\n\')+[a-z]/;'))

        it 'should not be rendered with Function', ->
          expect(=> @suger.render('@@sum', sum: (a, b) -> a + b))
            .toThrow('Function should not be embeded: @@sum')

    describe 'when variables are setted twice', ->
      it 'should set each variables', ->
        expect(@suger.render('"#{@@firstName} #{@@lastName}"', firstName: 'Nia',lastName: 'Teppelin'))
          .toEqual(helper.enclose('  "" + \'Nia\' + " " + \'Teppelin\';'))

  describe '.compile()', ->
    it 'should be compiled', ->
      expect(@suger.compile('location.href = @@url')(url: 'http://example.com/'))
        .toEqual(helper.enclose("  location.href = 'http://example.com/';"))
