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
  var ret = <String, String>{};
  jsonMap.forEach((key, value) => ret[key] = value.toString());

  return ret;
}

/// Map of Delta keywords to abbreviated versions.
final _map = _getMap();

/// Reversed map of abbreviated versions to Delta keywords.
final _mapReversed = _map.map((k, v) => MapEntry(v, k));

/// Accepts a Delta object [obj]
/// and returns the minified version with abbreviated keys.
Map<String, dynamic> minify(Map<String, dynamic> obj) {
  final min = <String, dynamic>{};
  final keys = obj.keys.toList();
  var n = keys.length, key = "insert";

  while (n-- > 0) {
    key = keys[n];
    var mappedAttribute = _map[key];

    // Check if mapped attribute exists in the map.
    if (mappedAttribute != null) {
      // Check if the value of the key is an array
      if (obj[key] is List) {
        min[mappedAttribute] = obj[key].map((j) => minify(j));
      }

      // Check if it's another Map<String, dynamic>
      else if (obj[key] is Map) {
        min[mappedAttribute] = minify(obj[key]);
      }

      // Else, we minify normally.
      else {
        min[mappedAttribute] = obj[key];
      }
    }

    // If mapped attribute doesn't exist, we just add it to the minified object as it was originally.
    else {
      min[key] = obj[key];
    }
  }

  return min;
}

/// Accepts a minified Delta object [obj]
/// and returns the unminified version with abbreviated keys.
Map<String, dynamic> unminify(Map<String, dynamic> obj) {
  final expanded = <String, dynamic>{};
  final keys = obj.keys.toList();
  var n = keys.length, key = "insert";

  while (n-- > 0) {
    key = keys[n];
    var mappedAttribute = _mapReversed[key];

    // Check if mapped attribute exists in the map.
    if (mappedAttribute != null) {
      // Check if the value of the key is an array
      if (obj[key] is List) {
        expanded[mappedAttribute] = obj[key].map((j) => unminify(j));
      }

      // Check if it's another Map<String, dynamic>
      else if (obj[key] is Map) {
        expanded[mappedAttribute] = unminify(obj[key]);
      } else {
        expanded[mappedAttribute] = obj[key];
      }
    }

    // If mapped attribute doesn't exist, we just add it to the minified object as it was originally.
    else {
      expanded[key] = obj[key];
    }
  }

  return expanded;
}
