import 'package:flutter_test/flutter_test.dart';
import 'package:time_tracking_app_for_tasks/models/task_model.dart';

void main() {
  group('Task', () {
    test('fromJson should correctly parse JSON into Task object', () {
      final json = {
        'id': '1',
        'content': 'Task content',
        'is_completed': false,
        'project_id': 'proj_123',
        'section_id': 'sec_456',
        'order': 1,
        'time_spent': '2h',
        'completed_on': '2023-08-23T10:00:00Z',
      };

      final task = Task.fromJson(json);

      expect(task.id, '1');
      expect(task.content, 'Task content');
      expect(task.isCompleted, false);
      expect(task.projectId, 'proj_123');
      expect(task.sectionId, 'sec_456');
      expect(task.order, 1);
      expect(task.timeSpent, '2h');
      expect(task.completedOn, '2023-08-23T10:00:00Z');
    });

    test('fromJson should handle missing optional fields gracefully', () {
      final json = {
        'id': '1',
        'content': 'Task content',
        'is_completed': false,
        'project_id': 'proj_123',
        'section_id': 'sec_456',
        'order': 1,
        // 'time_spent': '2h', // Missing optional field
        // 'completed_on': '2023-08-23T10:00:00Z', // Missing optional field
      };

      final task = Task.fromJson(json);

      expect(task.id, '1');
      expect(task.content, 'Task content');
      expect(task.isCompleted, false);
      expect(task.projectId, 'proj_123');
      expect(task.sectionId, 'sec_456');
      expect(task.order, 1);
      expect(task.timeSpent, null); // Optional field should be null
      expect(task.completedOn, null); // Optional field should be null
    });

    test('fromJson should throw an ArgumentError if a required field is missing', () {
      final json = {
        'id': '1',
        // 'content': 'Task content', // Missing required field
        'is_completed': false,
        'project_id': 'proj_123',
        'section_id': 'sec_456',
        'order': 1,
      };

      expect(() => Task.fromJson(json), throwsA(isA<ArgumentError>()));
    });

    test('toJson should correctly convert Task object to JSON', () {
      final task = Task(
        id: '1',
        content: 'Task content',
        isCompleted: false,
        projectId: 'proj_123',
        sectionId: 'sec_456',
        order: 1,
        timeSpent: '2h',
        completedOn: '2023-08-23T10:00:00Z',
      );

      final json = task.toJson();

      expect(json['id'], '1');
      expect(json['content'], 'Task content');
      expect(json['is_completed'], false);
      expect(json['project_id'], 'proj_123');
      expect(json['section_id'], 'sec_456');
      expect(json['order'], 1);
      expect(json['time_spent'], '2h');
      expect(json['completed_on'], '2023-08-23T10:00:00Z');
    });

    test('toJson should handle null optional fields correctly', () {
      final task = Task(
        id: '1',
        content: 'Task content',
        isCompleted: false,
        projectId: 'proj_123',
        sectionId: 'sec_456',
        order: 1,
        timeSpent: null,
        completedOn: null,
      );

      final json = task.toJson();

      expect(json['id'], '1');
      expect(json['content'], 'Task content');
      expect(json['is_completed'], false);
      expect(json['project_id'], 'proj_123');
      expect(json['section_id'], 'sec_456');
      expect(json['order'], 1);
      expect(json['time_spent'], null); // Optional field should be null
      expect(json['completed_on'], null); // Optional field should be null
    });

    test('toString should return a properly formatted string', () {
      final task = Task(
        id: '1',
        content: 'Task content',
        isCompleted: false,
        projectId: 'proj_123',
        sectionId: 'sec_456',
        order: 1,
        timeSpent: '2h',
        completedOn: '2023-08-23T10:00:00Z',
      );

      expect(
        task.toString(),
        'Task(id: 1, content: Task content, isCompleted: false, projectId: proj_123, sectionId: sec_456, order: 1, timeSpent: 2h, completedOn: 2023-08-23T10:00:00Z)',
      );
    });
  });
}
