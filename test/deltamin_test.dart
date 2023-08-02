import 'package:deltamin/deltamin.dart';
import 'package:test/test.dart';
import 'package:collection/collection.dart';

void main() {
  group('testing', () {
    final equality = DeepCollectionEquality();

    test('minify', () {
      final delta = {
        "insert": 'Gandalf',
        "attributes": {"bold": true}
      };
      final min = {
        "i": 'Gandalf',
        "a": {"b": true}
      };
      final result = minify(delta);

      expect(equality.equals(min, result), isTrue);
    });

    test('unminify', () {
      final delta = {
        "insert": 'Gandalf',
        "attributes": {"bold": true}
      };
      final min = {
        "i": 'Gandalf',
        "a": {"b": true}
      };
      final result = unminify(min);

      expect(equality.equals(delta, result), isTrue);
    });

    test('minify list of ops', () {
      final delta = {
        "ops": [
          {"insert": "Hello Simon!"},
          {
            "attributes": {"list": "ordered"},
            "insert": "\n"
          },
          {"insert": "Checklist item"},
          {
            "attributes": {"list": "checked"},
            "insert": "\n"
          },
          {"insert": "Bullet point"},
          {
            "attributes": {"list": "bullet"},
            "insert": "\n"
          }
        ]
      };
      final min = {
        "o": [
          {"i": "Hello Simon!"},
          {
            "a": {"li": "ordered"},
            "i": "\n"
          },
          {"i": "Checklist item"},
          {
            "a": {"li": "checked"},
            "i": "\n"
          },
          {"i": "Bullet point"},
          {
            "a": {"li": "bullet"},
            "i": "\n"
          }
        ]
      };
      final result = minify(delta);

      expect(equality.equals(result, min), isTrue);
    });

    test('unminify list of ops', () {
      final delta = {
        "ops": [
          {"insert": "Hello Simon!"},
          {
            "attributes": {"list": "ordered"},
            "insert": "\n"
          },
          {"insert": "Checklist item"},
          {
            "attributes": {"list": "checked"},
            "insert": "\n"
          },
          {"insert": "Bullet point"},
          {
            "attributes": {"list": "bullet"},
            "insert": "\n"
          }
        ]
      };
      final min = {
        "o": [
          {"i": "Hello Simon!"},
          {
            "a": {"li": "ordered"},
            "i": "\n"
          },
          {"i": "Checklist item"},
          {
            "a": {"li": "checked"},
            "i": "\n"
          },
          {"i": "Bullet point"},
          {
            "a": {"li": "bullet"},
            "i": "\n"
          }
        ]
      };
      final result = unminify(min);

      expect(equality.equals(result, delta), isTrue);
    });
  });
}
