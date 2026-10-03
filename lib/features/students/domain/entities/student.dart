class Student {
  final String id;
  final String name;
  final String studentNumber;
  final String classId;
  final String? sectionId;
  final String? parentPhone;
  final String? profileImage;
  final String? notes;
  final String? gender;
  final String? email;
  final String? address;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final bool isDeleted;
  final bool isActive;
  
  const Student({
    required this.id,
    required this.name,
    required this.studentNumber,
    required this.classId,
    this.sectionId,
    this.parentPhone,
    this.profileImage,
    this.notes,
    this.gender,
    this.email,
    this.address,
    required this.createdAt,
    this.updatedAt,
    this.isDeleted = false,
    this.isActive = true,
  });
  
  // نسخ مع تعديل
  Student copyWith({
    String? name,
    String? studentNumber,
    String? classId,
    String? sectionId,
    String? parentPhone,
    String? profileImage,
    String? notes,
    String? gender,
    String? email,
    String? address,
    DateTime? updatedAt,
    bool? isDeleted,
    bool? isActive,
  }) {
    return Student(
      id: id,
      name: name ?? this.name,
      studentNumber: studentNumber ?? this.studentNumber,
      classId: classId ?? this.classId,
      sectionId: sectionId ?? this.sectionId,
      parentPhone: parentPhone ?? this.parentPhone,
      profileImage: profileImage ?? this.profileImage,
      notes: notes ?? this.notes,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      address: address ?? this.address,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      isActive: isActive ?? this.isActive,
    );
  }
  
  // تحويل إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'studentNumber': studentNumber,
      'classId': classId,
      'sectionId': sectionId,
      'parentPhone': parentPhone,
      'profileImage': profileImage,
      'notes': notes,
      'gender': gender,
      'email': email,
      'address': address,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'isDeleted': isDeleted,
      'isActive': isActive,
    };
  }
  
  // إنشاء من JSON
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      studentNumber: json['studentNumber'],
      classId: json['classId'],
      sectionId: json['sectionId'],
      parentPhone: json['parentPhone'],
      profileImage: json['profileImage'],
      notes: json['notes'],
      gender: json['gender'],
      email: json['email'],
      address: json['address'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      isDeleted: json['isDeleted'] ?? false,
      isActive: json['isActive'] ?? true,
    );
  }
}

// نموذج الطالب مع معلومات إضافية
class StudentWithDetails {
  final Student student;
  final String className;
  final String? sectionName;
  final double? averageGrade;
  final int? attendanceRate;
  
  const StudentWithDetails({
    required this.student,
    required this.className,
    this.sectionName,
    this.averageGrade,
    this.attendanceRate,
  });
}