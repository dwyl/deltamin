<div align="center">

# `deltamin`

Minify your Delta format data
before sending it down the wire
or saving it to a datastore.

[![Build Status](https://img.shields.io/travis/com/dwyl/deltamin/master.svg?style=flat-square)](https://travis-ci.com/dwyl/deltamin)
[![codecov.io](https://img.shields.io/codecov/c/github/dwyl/deltamin/master.svg?style=flat-square)](http://codecov.io/github/dwyl/deltamin?branch=master)
[![Code Climate](https://img.shields.io/codeclimate/maintainability/dwyl/learn-tape.svg?style=flat-square)](https://codeclimate.com/github/dwyl/deltamin)
[![devDependencies Status](https://david-dm.org/dwyl/deltamin/status.svg?style=flat-square)](https://david-dm.org/dwyl/deltamin)
[![devDependencies Status](https://david-dm.org/dwyl/deltamin/dev-status.svg?style=flat-square)](https://david-dm.org/dwyl/deltamin?type=dev)
[![contributions welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg?style=flat-square)](https://github.com/dwyl/deltamin/issues)
[![HitCount](http://hits.dwyl.io/dwyl/deltamin.svg)](http://hits.dwyl.io/dwyl/deltamin)

</div>


> **Note**: this project is still very much a "work-in-progress".
If you would like to help us with building it,
please leave a comment on: https://github.com/dwyl/deltamin/issues/1


# Why

The Delta format https://quilljs.com/docs/delta is quite _verbose_:

```js
const delta = new Delta([
  { insert: 'Gandalf', attributes: { bold: true } },
  { insert: ' the ' },
  { insert: 'Grey', attributes: { color: '#ccc' } }
]);
```
![delta-full-fat](https://user-images.githubusercontent.com/194400/83935475-d0104a80-a7b1-11ea-887c-dd43a415816f.png)

From the Developer perspective,
having a verbose format makes perfect sense
because it's easy to understand at a glance what is going on.
Given that computers are more than fast enough
to process this verbose format,
it won't affect the performance
of any app using the Delta format.

Where we feel there is scope for improvement is in:
a) **data transmission**
i.e. **saving bandwidth** for people who don't have a lot of it
b) **saving complete history** of changes so that they can be replayed

We can minify this to:

```js
const delta = new Delta([
  { i: 'Gandalf', a: { b: true } },
  { i: ' the ' },
  { i: 'Grey', a: { c: '#ccc' } }
]);
```

![delta-minified](https://user-images.githubusercontent.com/194400/83935485-dc94a300-a7b1-11ea-9f89-e9760f56e093.png)

(157 - 117 / 157) = **25% bandwidth saving**.
It might not _feel_ like much of a saving in this trivial example,
but if you scale it up to entire documents
and thousands (millions?) of concurrent people using a collaborative editor,
a 25% saving on a $10k/month bandwidth bill is $30k/year!
Saving bandwidth is the _right_ thing to do for the _World_!
Why should anyone _needlessly_ waste any scarce resource?
_Obviously_ this is micro-bandwidth saving is _meaningless_
in a world where
[Google Stadia](https://en.wikipedia.org/wiki/Google_Stadia)
is server-rendering and _streaming_ 4K games in realtime ... 🤦  
But we can only try to set a good example to follow.


# Todo

+ [ ] List all the keywords in the Delta format
  e.g: `insert`, `retain`, `text`, `attributes`, etc.
+ [ ] Define short versions for all the keywords
  e.g: `i`, `r`, `t`, `a`
  + [x] Make the _minified_ keywords as short as possible
  (_that's the whole point of this project!_)
  + [x] wherever there is a keyword that starts with the same character,
  give priority to the keyword that appears most frequently in the format.
  e.g: `insert` is used more often than `import`
  so `insert` > `i` and `import` > `im`

+ [x] Create `unminify/1` function for converting the minified version
  _back_ to the "full fat" version of Delta
  before passing it to a consuming library.
+ [x] Publish NPM Package: https://www.npmjs.com/package/deltamin
so we can use it!
