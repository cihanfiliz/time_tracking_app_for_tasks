import 'package:test/test.dart';
import 'package:time_tracking_app_for_tasks/models/comment_model.dart';

void main() {
  group('Comment', () {
    test('fromJson works correctly', () {
      final json = {
        'id': '123',
        'task_id': '456',
        'content': 'Hello, world!',
        'posted_at': '2022-01-01T12:00:00Z',
      };

      final comment = Comment.fromJson(json);

      expect(comment.id, '123');
      expect(comment.taskId, '456');
      expect(comment.content, 'Hello, world!');
      expect(comment.postedAt, '2022-01-01T12:00:00Z');
    });

    test('fromJson should throw a TypeError if a required field is null', () {
      final json = {
        'id': '123',
        'task_id': '456',
        // 'content': null, // Explicitly setting content to null to simulate the error
        'posted_at': '2023-08-23T10:00:00Z',
      };

      // Expect a TypeError when trying to create a Comment with a null content
      expect(() => Comment.fromJson(json), throwsA(isA<ArgumentError>()));
    });

    test('fromJson should handle unexpected JSON structure gracefully', () {
      final json = {
        'id': '123',
        'task_id': '456',
        'content': 'This is a comment',
        'posted_at': '2023-08-23T10:00:00Z',
        'unexpected_field': 'unexpected_value',
      };

      final comment = Comment.fromJson(json);

      expect(comment.id, '123');
      expect(comment.taskId, '456');
      expect(comment.content, 'This is a comment');
      expect(comment.postedAt, '2023-08-23T10:00:00Z');
    });
  });
}