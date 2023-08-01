/// Minimize your Delta format data before sending it down the wire or saving it to a datastore.
///
/// You can `minify` and `unminify` your Delta format data.
library;

import 'dart:convert';
import 'dart:io';

/// Loads the map from `map.json`.
Map<String, String> _getMap() {
  // Get map object from `map.json`.
  // It is an alphabetic map of Delta keywords to abbreviated versions:
  final file = File('map.json');
  final jsonString = file.readAsStringSync();
  final jsonMap = jsonDecode(jsonString);

  // Converting `Map<String, dynamic>` to `Map<String, String>`.
  Map<String, String> ret = Map<String, String>();
  jsonMap.forEach((key, value) => ret[key] = value.toString());

  return ret;
}

/// Map of Delta keywords to abbreviated versions.
final map = _getMap();

/// Reversed map of abbreviated versions to Delta keywords.
final mapReversed = map.map((k, v) => MapEntry(v, k));

/// Accepts a Delta object [obj]
/// and returns the minified version with abbreviated keys.
Map<dynamic, dynamic> minify(Map<String, dynamic> obj) {
  final min = {};
  final keys = obj.keys.toList();
  var n = keys.length, key = "insert", k = "i";

  while (n-- > 0) {
    key = keys[n];
    k = map[key].toString();

    // Check if the value of the key is an array
    if (obj[key] is List) {
      min[map[key]] = obj[key].map((j) => {minify(j)});
    }

    // Check if it's another Map<String, dynamic>
    else if (obj[key] is Map) {
      min[map[key]] = minify(obj[key]);
    }

    // Else, we minify normally.
    else {
      min[map[key]] = obj[key];
    }
  }

  return min;
}

/// Accepts a minified Delta object [obj]
/// and returns the unminified version with abbreviated keys.
Map<dynamic, dynamic> unminify(Map<String, dynamic> obj) {
  final expanded = {};
  final keys = obj.keys.toList();
  var n = keys.length, key = "insert", k = "i";

  while (n-- > 0) {
    key = keys[n];
    k = mapReversed[key].toString();

    // Check if the value of the key is an array
    if (obj[key] is List) {
      expanded[mapReversed[key]] = obj[key].map((j) => {unminify(j)});
    }

    // Check if it's another Map<String, dynamic>
    else if (obj[key] is Map) {
      expanded[mapReversed[key]] = unminify(obj[key]);
    } else {
      expanded[mapReversed[key]] = obj[key];
    }
  }

  return expanded;
}