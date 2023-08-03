
import 'package:deltamin/deltamin.dart';

void main() {

  final delta = {
    "insert": 'Gandalf',
    "attributes": {"bold": true}
  };


  // Minify the delta object
  var minifiedDelta = minify(delta);

  // Unminify the minified object.
  // Should be the same as the original delta object
  var unminifiedDelta = unminify(minifiedDelta);

  print(unminifiedDelta);
  // { "insert": 'Gandalf', "attributes": {"bold": true} }
}
