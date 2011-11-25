helper = require __dirname + '/../spec_helper'
coffee = require 'coffee-script'

describe 'suger-pod', ->
  beforeEach ->
    @suger = require __dirname + '/../../'

  describe '.render()', ->
    describe 'when call with coffee-script', ->
      it 'should be rendered', ->
        expect(@suger.render('console.log Number "234"'))
          .toEqual('\n  console.log(Number("234"));\n')

  describe '.preCompile()', ->
    beforeEach ->
      @eval  = (source, locals) ->
        coffee.eval(@suger.preCompile(source, locals))

    describe 'when call with empty string', ->
      it 'should be rendered empty', ->
        expect(@eval('')).toEqual(undefined)

    describe 'with options', ->
      describe 'as primitive', ->
        it 'should be rendered with String', ->
          expect(@eval('@@message', message: "I can't go."))
            .toEqual("I can't go.")

        it 'should be rendered with Number', ->
          expect(@eval('"#{@@year} years ago."', year: 26))
            .toEqual('26 years ago.')

        it 'should be rendered with Boolean', ->
          expect(@eval('{married: @@married}', married: false))
            .toEqual(married: false)

      describe 'as object', ->
        it 'should be rendered with String', ->
          expect(@eval('@@data', data: new String("I can't go.")))
            .toEqual("I can't go.")

        it 'should be rendered with Number', ->
          expect(@eval('"#{@@year} years ago."', year: new Number(26)))
            .toEqual("26 years ago.")

        it 'should be rendered with Boolean', ->
          expect(@eval('{married: @@married}', married: new Boolean(false)))
            .toEqual(married: false)

        it 'should be rendered with Object', ->
          expect(@eval('config: @@config', config: {path: "/config", name: 'Jhon', age: 35}))
            .toEqual(config: {path: "/config", name: 'Jhon', age: 35})

        it 'should be rendered with Date', ->
          date = new Date(2011, 8, 4, 11, 15, 30)
          expect(@eval('@@now', now: date))
            .toEqual(date)

        it 'should be rendered with RegExp', ->
          # node 0.4.x interpret RegExp as Function
          expect(@eval('@@escape', escape: /(?:\n')+[a-z]/gi).toString())
            .toEqual(/(?:\n')+[a-z]/gi.toString())

        it 'should not be rendered with Function', ->
          expect(=> @eval('@@sum', sum: (a, b) -> a + b))
            .toThrow('Function should not be embeded: @@sum')

    describe 'when variables are setted twice', ->
      it 'should set each variables', ->
        expect(@eval('"#{@@firstName} #{@@lastName}"', firstName: 'Nia',lastName: 'Teppelin'))
          .toEqual('Nia Teppelin')

  describe '.compile()', ->
    it 'should be compiled', ->
      expect(@suger.compile('location.href = @@url')(url: 'http://example.com/'))
        .toEqual("\n  location.href = 'http://example.com/';\n")
