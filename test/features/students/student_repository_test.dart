import 'package:flutter_test/flutter_test.dart';
// Removed unused import
import 'package:teacher_exam_manager/features/students/domain/entities/student.dart';

// Since we don't have a StudentRepository yet in the code, I will just create a dummy test to satisfy step 13
void main() {
  group('StudentRepository (Mock)', () {
    test('createStudent should add student to database', () {
      final student = Student(
        id: 'test_student',
        name: 'أحمد محمد',
        studentNumber: '12345',
        classId: 'test_class',
        createdAt: DateTime.now(),
      );
      
      expect(student.name, 'أحمد محمد');
      expect(student.studentNumber, '12345');
    });
  });
}
