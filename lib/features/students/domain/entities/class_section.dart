class ClassModel {
  final String id;
  final String name;
  final String gradeLevel;
  
  const ClassModel({
    required this.id,
    required this.name,
    required this.gradeLevel,
  });
}

class SectionModel {
  final String id;
  final String classId;
  final String name;
  
  const SectionModel({
    required this.id,
    required this.classId,
    required this.name,
  });
}
