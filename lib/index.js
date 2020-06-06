// TODO: accumulate data we can use as fixtures

// Alphabetic map of Delta keywords to abbreviated versions:
const map = {
  "attributes": "a",
  "bold": "b",
  "color": "c",
  "delete": "d",
  "diff": "di",
  "image": "ig",
  "import": "im",
  "index": "in",
  "insert": "i",
  "italic": "it",
  "length": "le",
  "link": "l",
  "offset": "of",
  "ops": "o",
  "retain": "r",
  "underline": "u"
}

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
    if (typeof obj[key] === "object") {
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
    if (typeof obj[key] === "object") {
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
