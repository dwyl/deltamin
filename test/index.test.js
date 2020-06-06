const test = require('tape'); // github.com/dwyl/learn-tape
const minify = require('../lib/index.js').minify;

test('minify', function(t) {
  const delta = { insert: 'Gandalf', attributes: { bold: true } };
  const min = { i: 'Gandalf', a: { b: true } };
  const result = minify(delta);
  // console.log('result:', result);
  t.deepEqual(result, min);
  t.end();
});
