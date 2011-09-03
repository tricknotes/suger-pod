# Suger Pod
Suger Pod is a simple template engin that extends CoffeeScript.

## Installation

```
$ npm install suger-pod
node> require('suger-pod');
```

## Quick Example

```coffee-script
suger = require 'suger-pod'
suger.render "console.log @@name", name: 'Jhon'
# => "console.log('Jhon');"
```

Bind agrs to variables that start with '@@'.
(for example: @@name)

Types of Embeded variable are supprted with String, Number, Boolean and Object.

## Express
To use with [Express](http://expressjs.com/) and the .coffee extension, simply register the engine:
```coffee-script
app.register('.coffee', require('suger-pod'))
```

## License
Licensed under MIT.
