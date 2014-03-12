Coffeelint - Minimum Colon Spacing
=================================

> Validate a minimum spacing left and right of a colon assignment

## Description

This [CoffeeLint](http://www.coffeelint.org) plugin verifies whether or not a minimum amount of spacing is to the left and/or right of a colon assignment. It is based on the 'colon_assignment_spacing' rule but is less strict by only enforcing a minimum spacing and not an excat amount. This can come in handy when you have files with object assignments where the colon are vertically aligned. See the Router class in the examples part.
## Installation

```sh
[sudo] npm install -g coffeelint-newline-after-function
```
> ***Note:*** *Right now a Coffeelint plugin cannot be installed as a project dependency and must be installed globally. Perhaps this will be improved in a future version of Coffeelint. If you would like to track progress on this enhancement head [over here](https://github.com/clutchski/coffeelint/issues/210).*

## Usage

Insert the below configuration into *coffeelint.json* that you use for linting your scripts:

```js
"min_colon_spacing": {
    "module": "coffeelint-min-colon-spacing"
    "spacing": {
      "left" : 1,
      "right" : 1
    },
    "level": "error",
}
```
## Example

This code will lint without errors:

```
class TestClass

  foo : ->
    bar()

class Router
  routes :
    "/main"            : "main"
    "/dashboard/users" : "dashboard
    "/settings"        : settings

```

But this will fail:

```
class TestClass

  foo:->
    console.log("Oh no! I have linting errors.")
```

## Configuration

The only configuration option specific to this plugin is the **spacing** property. Change the "left" or "right" property to the number of spaces that you like to be inforced.

By default, Coffeelint will report errors if this rule is not satisfied. You may want to relax this by setting the **level** to **warn** in your configuration.

## Credits
Credits go to [Ian McNally](https://github.com/imcnally) whose 'colon_assignment_spacing' rule serves as the basis for this fork.


## License

[MIT](http://en.wikipedia.org/wiki/MIT_License) © [scalable minds](http://scm.io)
