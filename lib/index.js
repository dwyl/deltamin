// TODO: accumulate data we can use as fixtures

// Alphabetic map of Delta keywords to abbreviated versions:
const map = {
  "attributes": "a",
  "bold": "b",
  "color": "c",
  "delete": "d",
  "image": "ig",
  "import": "im",
  "insert": "i",
  "italic": "it",
  "link": "l",
  "retain": "r",
  "underline": "u"
}

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



module.exports = {
  minify: minify
}
