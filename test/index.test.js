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


test('minify list of ops', function(t) {
  const delta = {"ops":[
    {"insert":"Hello Simon!"},{"attributes":{"list":"ordered"},"insert":"\n"},
    {"insert":"Checklist item"},{"attributes":{"list":"checked"},"insert":"\n"},
    {"insert":"Bullet point"},{"attributes":{"list":"bullet"},"insert":"\n"}
  ]}
  const min = {"o":[
    {"i":"Hello Simon!"},{"a":{"li":"ordered"},"i":"\n"},
    {"i":"Checklist item"},{"a":{"li":"checked"},"i":"\n"},
    {"i":"Bullet point"},{"a":{"li":"bullet"},"i":"\n"}
  ]}
  const result = minify(delta);
  t.deepEqual(result, min);
  t.end();
});

test('unminify list of ops', function(t) {
  const delta = {"ops":[
    {"insert":"Hello Simon!"},{"attributes":{"list":"ordered"},"insert":"\n"},
    {"insert":"Checklist item"},{"attributes":{"list":"checked"},"insert":"\n"},
    {"insert":"Bullet point"},{"attributes":{"list":"bullet"},"insert":"\n"}
  ]}
  const min = {"o":[
    {"i":"Hello Simon!"},{"a":{"li":"ordered"},"i":"\n"},
    {"i":"Checklist item"},{"a":{"li":"checked"},"i":"\n"},
    {"i":"Bullet point"},{"a":{"li":"bullet"},"i":"\n"}
  ]}
  const result = unminify(min);
  t.deepEqual(result, delta);
  // console.log(JSON.stringify(result, null, 2));
  t.end();
});
