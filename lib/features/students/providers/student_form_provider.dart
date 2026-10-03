import 'package:flutter/material.dart';
import 'dart:io';
import '../../../core/state/base_provider.dart';
import '../data/repositories/student_repository.dart';
import '../domain/entities/student.dart';

class StudentFormProvider extends BaseProvider {
  final StudentRepository _repository;
  
  // Controllers
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final notesController = TextEditingController();
  
  // Form State
  String? _selectedClassId;
  String? _selectedSectionId;
  String? _selectedGender;
  File? _profileImage;
  bool _isSubmitting = false;
  bool _isEditMode = false;
  String? _studentId;
  
  // Getters
  String? get selectedClassId => _selectedClassId;
  String? get selectedSectionId => _selectedSectionId;
  String? get selectedGender => _selectedGender;
  File? get profileImage => _profileImage;
  bool get isSubmitting => _isSubmitting;
  bool get isEditMode => _isEditMode;
  String? get studentId => _studentId;
  
  StudentFormProvider(this._repository);
  
  // تهيئة النموذج
  void initialize({String? studentId}) {
    _studentId = studentId;
    _isEditMode = studentId != null;
    
    if (studentId != null) {
      _loadStudentData(studentId);
    }
  }
  
  // تحميل بيانات الطالب للتعديل
  Future<void> _loadStudentData(String studentId) async {
    setLoading(true);
    clearError();
    
    try {
      final student = await _repository.getStudentById(studentId);
      
      if (student != null) {
        nameController.text = student.name;
        numberController.text = student.studentNumber;
        phoneController.text = student.parentPhone ?? '';
        emailController.text = student.email ?? '';
        addressController.text = student.address ?? '';
        notesController.text = student.notes ?? '';
        _selectedClassId = student.classId;
        _selectedSectionId = student.sectionId;
        _selectedGender = student.gender;
        
        if (student.profileImage != null && student.profileImage!.isNotEmpty) {
          _profileImage = File(student.profileImage!);
        }
      }
    } catch (e) {
      setError('فشل في تحميل بيانات الطالب: $e');
    } finally {
      setLoading(false);
    }
  }
  
  // تعيين الصف
  void setClass(String? classId) {
    _selectedClassId = classId;
    _selectedSectionId = null; // إعادة تعيين الشعبة عند تغيير الصف
    notifyListeners();
  }
  
  // تعيين الشعبة
  void setSection(String? sectionId) {
    _selectedSectionId = sectionId;
    notifyListeners();
  }
  
  // تعيين الجنس
  void setGender(String? gender) {
    _selectedGender = gender;
    notifyListeners();
  }
  
  // تعيين الصورة
  void setProfileImage(File? image) {
    _profileImage = image;
    notifyListeners();
  }
  
  // إزالة الصورة
  void removeProfileImage() {
    _profileImage = null;
    notifyListeners();
  }
  
  // حفظ الطالب
  Future<bool> saveStudent() async {
    if (_selectedClassId == null) {
      setError('يرجى اختيار الصف');
      return false;
    }
    
    if (nameController.text.trim().isEmpty) {
      setError('يرجى إدخال اسم الطالب');
      return false;
    }
    
    if (numberController.text.trim().isEmpty) {
      setError('يرجى إدخال الرقم المدرسي');
      return false;
    }
    
    _isSubmitting = true;
    clearError();
    notifyListeners();
    
    try {
      final student = Student(
        id: _studentId ?? DateTime.now().millisecondsSinceEpoch.toString(),
        name: nameController.text.trim(),
        studentNumber: numberController.text.trim(),
        classId: _selectedClassId!,
        sectionId: _selectedSectionId,
        parentPhone: phoneController.text.trim().isEmpty ? null : phoneController.text.trim(),
        profileImage: _profileImage?.path,
        notes: notesController.text.trim().isEmpty ? null : notesController.text.trim(),
        gender: _selectedGender,
        email: emailController.text.trim().isEmpty ? null : emailController.text.trim(),
        address: addressController.text.trim().isEmpty ? null : addressController.text.trim(),
        createdAt: DateTime.now(),
      );
      
      if (_isEditMode) {
        await _repository.updateStudent(student);
      } else {
        await _repository.createStudent(student);
      }
      
      return true;
    } catch (e) {
      setError('فشل في حفظ الطالب: $e');
      return false;
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }
  
  // حذف الطالب
  Future<bool> deleteStudent() async {
    if (_studentId == null) return false;
    
    _isSubmitting = true;
    notifyListeners();
    
    try {
      await _repository.softDeleteStudent(_studentId!);
      return true;
    } catch (e) {
      setError('فشل في حذف الطالب: $e');
      return false;
    } finally {
      _isSubmitting = false;
      notifyListeners();
    }
  }
  
  // تنظيف الموارد
  @override
  void dispose() {
    nameController.dispose();
    numberController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    notesController.dispose();
    super.dispose();
  }
}
