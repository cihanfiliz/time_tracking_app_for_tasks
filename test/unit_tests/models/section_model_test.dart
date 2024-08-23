import 'package:flutter_test/flutter_test.dart';
import 'package:time_tracking_app_for_tasks/models/section_model.dart';

void main() {
  group('Section', () {
    test('fromJson should correctly parse JSON into Section object', () {
      final json = {
        'id': '1',
        'project_id': 'proj_123',
        'name': 'To Do',
        'order': 1,
      };

      final section = Section.fromJson(json);

      expect(section.id, '1');
      expect(section.projectId, 'proj_123');
      expect(section.name, 'To Do');
      expect(section.order, 1);
    });

    test('fromJson should handle unexpected JSON structure gracefully', () {
      final json = {
        'id': '1',
        'project_id': 'proj_123',
        'name': 'To Do',
        'order': 1,
        'extra_field': 'extra_value', // Extra field
      };

      final section = Section.fromJson(json);

      expect(section.id, '1');
      expect(section.projectId, 'proj_123');
      expect(section.name, 'To Do');
      expect(section.order, 1);
    });

    test('fromJson should throw an ArgumentError if a field is null', () {
      final json = {
        'id': '1',
        'project_id': 'proj_123',
        'name': null, // Null field
        'order': 1,
      };

      expect(() => Section.fromJson(json), throwsA(isA<ArgumentError>()));
    });

    test('toString should return a properly formatted string', () {
      final section = Section(
        id: '1',
        projectId: 'proj_123',
        name: 'To Do',
        order: 1,
      );

      expect(
        section.toString(),
        'Section(id: 1, projectId: proj_123, name: To Do, order: 1)',
      );
    });
  });
}
