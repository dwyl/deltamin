// TODO: accumulate data we can use as fixtures in our tests!

// Alphabetic map of Delta keywords to abbreviated versions:
const map = require('./map.json')

// https://stackoverflow.com/questions/23013573/swap-key-with-value
function reverse_map (obj) {
  return Object.entries(obj).reduce((ret, entry) => {
    const [ key, value ] = entry;
    ret[ value ] = key;
    return ret;
  }, {});
}

const mapr = reverse_map(map);

/**
 * `minify/1` accepts a Delta object and
 * returns the minified version with abbreviated keys.
 */
function minify (obj) {
  const min = {}
  const keys = Object.keys(obj)
  let n = keys.length, key = "insert", k = "i";

  while (n--) {
    key = keys[n];
    k = map[key];
    if (Object.prototype.toString.call(obj[key]) === '[object Array]') {
      min[map[key]] = obj[key].map((j) => {
        return minify(j)
      })
    }
    else if (typeof obj[key] === "object") {
      min[map[key]] = minify(obj[key]);
    }
    else {
      min[map[key]] = obj[key];
    }
  }

  return min;
}

/**
 * `unminify/1` accepts a minified Delta object and
 * returns the expanded version with full length keys.
 */
function unminify (obj) {
  const expanded = {}
  const keys = Object.keys(obj)
  let n = keys.length, key = "insert", k = "i";

  while (n--) {
    key = keys[n];
    k = mapr[key];

    if (Object.prototype.toString.call(obj[key]) === '[object Array]') {
      expanded[mapr[key]] = obj[key].map((j) => {
        return unminify(j)
      })
    }
    else if (typeof obj[key] === "object") {
      expanded[mapr[key]] = unminify(obj[key]);
    }
    else {
      expanded[mapr[key]] = obj[key];
    }
  }

  return expanded;
}

module.exports = {
  minify: minify,
  unminify: unminify
}
