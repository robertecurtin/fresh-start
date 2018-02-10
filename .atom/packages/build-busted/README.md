# build-busted

Adds [busted][] targets for [atom-build][].

![](https://raw.githubusercontent.com/xpol/atom-build-busted/master/busted.png)

## How It Works

This package add [busted][] targets for [atom-build][] if `.busted`
(see [busted: Predefined Busted Tasks](http://olivinelabs.com/busted/#usage))
exists in project root directory.

Here is minimal `.busted` file if you just want to run `busted`:

```lua
return {}
```

**Limitation**: Currently this package can only parse `.busted` which return a
table constructor expression. That is the follow `.busted` will parsed:
```lua
return {
  ...
}
```

and this will not parsed (you only got default busted target):

```lua
local t =  {
  mytask = {...}
}
return t
```


## Setup
1. Install [busted][] and add a `.busted` file for your project.
2. Install [atom-build][] and this [atom-build-busted][] package `apm install build build-busted`.
3. Preferences... -> Packages -> build-busted -> Settings -> Set executable Path to your busted executable.

## Contribute

Ideas, bugs and pull requests please go to GitHub [xpol/atom-build-busted][repo].

[atom-build]: https://atom.io/packages/build
[atom-build-busted]: https://atom.io/packages/build-busted
[busted]: http://olivinelabs.com/busted/
[repo]: https://github.com/xpol/atom-build-busted
