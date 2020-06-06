const test = require('tape'); // github.com/dwyl/learn-tape
const minify = require('../lib/index.js').minify;
const unminify = require('../lib/index.js').unminify;

test('minify', function(t) {
  const delta = { insert: 'Gandalf', attributes: { bold: true } };
  const min = { i: 'Gandalf', a: { b: true } };
  const result = minify(delta);
  // console.log('result:', result);
  t.deepEqual(result, min);
  t.end();
});

test('unminify', function(t) {
  const delta = { insert: 'Gandalf', attributes: { bold: true } };
  const min = { i: 'Gandalf', a: { b: true } };
  const result = unminify(min);
  // console.log('result:', result);
  t.deepEqual(result, delta);
  t.end();
});
