// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $TeachersTable extends Teachers with TableInfo<$TeachersTable, Teacher> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TeachersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _specialtyMeta =
      const VerificationMeta('specialty');
  @override
  late final GeneratedColumn<String> specialty = GeneratedColumn<String>(
      'specialty', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _profileImageMeta =
      const VerificationMeta('profileImage');
  @override
  late final GeneratedColumn<String> profileImage = GeneratedColumn<String>(
      'profile_image', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, specialty, profileImage, email, phone, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'teachers';
  @override
  VerificationContext validateIntegrity(Insertable<Teacher> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('specialty')) {
      context.handle(_specialtyMeta,
          specialty.isAcceptableOrUnknown(data['specialty']!, _specialtyMeta));
    }
    if (data.containsKey('profile_image')) {
      context.handle(
          _profileImageMeta,
          profileImage.isAcceptableOrUnknown(
              data['profile_image']!, _profileImageMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Teacher map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Teacher(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      specialty: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}specialty']),
      profileImage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}profile_image']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $TeachersTable createAlias(String alias) {
    return $TeachersTable(attachedDatabase, alias);
  }
}

class Teacher extends DataClass implements Insertable<Teacher> {
  final String id;
  final String name;
  final String? specialty;
  final String? profileImage;
  final String? email;
  final String? phone;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const Teacher(
      {required this.id,
      required this.name,
      this.specialty,
      this.profileImage,
      this.email,
      this.phone,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || specialty != null) {
      map['specialty'] = Variable<String>(specialty);
    }
    if (!nullToAbsent || profileImage != null) {
      map['profile_image'] = Variable<String>(profileImage);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  TeachersCompanion toCompanion(bool nullToAbsent) {
    return TeachersCompanion(
      id: Value(id),
      name: Value(name),
      specialty: specialty == null && nullToAbsent
          ? const Value.absent()
          : Value(specialty),
      profileImage: profileImage == null && nullToAbsent
          ? const Value.absent()
          : Value(profileImage),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Teacher.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Teacher(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      specialty: serializer.fromJson<String?>(json['specialty']),
      profileImage: serializer.fromJson<String?>(json['profileImage']),
      email: serializer.fromJson<String?>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'specialty': serializer.toJson<String?>(specialty),
      'profileImage': serializer.toJson<String?>(profileImage),
      'email': serializer.toJson<String?>(email),
      'phone': serializer.toJson<String?>(phone),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Teacher copyWith(
          {String? id,
          String? name,
          Value<String?> specialty = const Value.absent(),
          Value<String?> profileImage = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      Teacher(
        id: id ?? this.id,
        name: name ?? this.name,
        specialty: specialty.present ? specialty.value : this.specialty,
        profileImage:
            profileImage.present ? profileImage.value : this.profileImage,
        email: email.present ? email.value : this.email,
        phone: phone.present ? phone.value : this.phone,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  Teacher copyWithCompanion(TeachersCompanion data) {
    return Teacher(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      specialty: data.specialty.present ? data.specialty.value : this.specialty,
      profileImage: data.profileImage.present
          ? data.profileImage.value
          : this.profileImage,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Teacher(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('specialty: $specialty, ')
          ..write('profileImage: $profileImage, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, specialty, profileImage, email, phone, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Teacher &&
          other.id == this.id &&
          other.name == this.name &&
          other.specialty == this.specialty &&
          other.profileImage == this.profileImage &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TeachersCompanion extends UpdateCompanion<Teacher> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> specialty;
  final Value<String?> profileImage;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const TeachersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.specialty = const Value.absent(),
    this.profileImage = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TeachersCompanion.insert({
    required String id,
    required String name,
    this.specialty = const Value.absent(),
    this.profileImage = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<Teacher> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? specialty,
    Expression<String>? profileImage,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (specialty != null) 'specialty': specialty,
      if (profileImage != null) 'profile_image': profileImage,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TeachersCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? specialty,
      Value<String?>? profileImage,
      Value<String?>? email,
      Value<String?>? phone,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return TeachersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      specialty: specialty ?? this.specialty,
      profileImage: profileImage ?? this.profileImage,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (specialty.present) {
      map['specialty'] = Variable<String>(specialty.value);
    }
    if (profileImage.present) {
      map['profile_image'] = Variable<String>(profileImage.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeachersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('specialty: $specialty, ')
          ..write('profileImage: $profileImage, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SchoolsTable extends Schools with TableInfo<$SchoolsTable, School> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SchoolsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _logoMeta = const VerificationMeta('logo');
  @override
  late final GeneratedColumn<String> logo = GeneratedColumn<String>(
      'logo', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _educationAuthorityMeta =
      const VerificationMeta('educationAuthority');
  @override
  late final GeneratedColumn<String> educationAuthority =
      GeneratedColumn<String>('education_authority', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _academicYearMeta =
      const VerificationMeta('academicYear');
  @override
  late final GeneratedColumn<String> academicYear = GeneratedColumn<String>(
      'academic_year', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('2024-2025'));
  static const VerificationMeta _isDefaultMeta =
      const VerificationMeta('isDefault');
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
      'is_default', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_default" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        logo,
        educationAuthority,
        address,
        phone,
        academicYear,
        isDefault,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'schools';
  @override
  VerificationContext validateIntegrity(Insertable<School> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('logo')) {
      context.handle(
          _logoMeta, logo.isAcceptableOrUnknown(data['logo']!, _logoMeta));
    }
    if (data.containsKey('education_authority')) {
      context.handle(
          _educationAuthorityMeta,
          educationAuthority.isAcceptableOrUnknown(
              data['education_authority']!, _educationAuthorityMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('academic_year')) {
      context.handle(
          _academicYearMeta,
          academicYear.isAcceptableOrUnknown(
              data['academic_year']!, _academicYearMeta));
    }
    if (data.containsKey('is_default')) {
      context.handle(_isDefaultMeta,
          isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  School map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return School(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      logo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}logo']),
      educationAuthority: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}education_authority']),
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address']),
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      academicYear: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}academic_year'])!,
      isDefault: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_default'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $SchoolsTable createAlias(String alias) {
    return $SchoolsTable(attachedDatabase, alias);
  }
}

class School extends DataClass implements Insertable<School> {
  final String id;
  final String name;
  final String? logo;
  final String? educationAuthority;
  final String? address;
  final String? phone;
  final String academicYear;
  final bool isDefault;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const School(
      {required this.id,
      required this.name,
      this.logo,
      this.educationAuthority,
      this.address,
      this.phone,
      required this.academicYear,
      required this.isDefault,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || logo != null) {
      map['logo'] = Variable<String>(logo);
    }
    if (!nullToAbsent || educationAuthority != null) {
      map['education_authority'] = Variable<String>(educationAuthority);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    map['academic_year'] = Variable<String>(academicYear);
    map['is_default'] = Variable<bool>(isDefault);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  SchoolsCompanion toCompanion(bool nullToAbsent) {
    return SchoolsCompanion(
      id: Value(id),
      name: Value(name),
      logo: logo == null && nullToAbsent ? const Value.absent() : Value(logo),
      educationAuthority: educationAuthority == null && nullToAbsent
          ? const Value.absent()
          : Value(educationAuthority),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      academicYear: Value(academicYear),
      isDefault: Value(isDefault),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory School.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return School(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      logo: serializer.fromJson<String?>(json['logo']),
      educationAuthority:
          serializer.fromJson<String?>(json['educationAuthority']),
      address: serializer.fromJson<String?>(json['address']),
      phone: serializer.fromJson<String?>(json['phone']),
      academicYear: serializer.fromJson<String>(json['academicYear']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'logo': serializer.toJson<String?>(logo),
      'educationAuthority': serializer.toJson<String?>(educationAuthority),
      'address': serializer.toJson<String?>(address),
      'phone': serializer.toJson<String?>(phone),
      'academicYear': serializer.toJson<String>(academicYear),
      'isDefault': serializer.toJson<bool>(isDefault),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  School copyWith(
          {String? id,
          String? name,
          Value<String?> logo = const Value.absent(),
          Value<String?> educationAuthority = const Value.absent(),
          Value<String?> address = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          String? academicYear,
          bool? isDefault,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      School(
        id: id ?? this.id,
        name: name ?? this.name,
        logo: logo.present ? logo.value : this.logo,
        educationAuthority: educationAuthority.present
            ? educationAuthority.value
            : this.educationAuthority,
        address: address.present ? address.value : this.address,
        phone: phone.present ? phone.value : this.phone,
        academicYear: academicYear ?? this.academicYear,
        isDefault: isDefault ?? this.isDefault,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  School copyWithCompanion(SchoolsCompanion data) {
    return School(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      logo: data.logo.present ? data.logo.value : this.logo,
      educationAuthority: data.educationAuthority.present
          ? data.educationAuthority.value
          : this.educationAuthority,
      address: data.address.present ? data.address.value : this.address,
      phone: data.phone.present ? data.phone.value : this.phone,
      academicYear: data.academicYear.present
          ? data.academicYear.value
          : this.academicYear,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('School(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('logo: $logo, ')
          ..write('educationAuthority: $educationAuthority, ')
          ..write('address: $address, ')
          ..write('phone: $phone, ')
          ..write('academicYear: $academicYear, ')
          ..write('isDefault: $isDefault, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, logo, educationAuthority, address,
      phone, academicYear, isDefault, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is School &&
          other.id == this.id &&
          other.name == this.name &&
          other.logo == this.logo &&
          other.educationAuthority == this.educationAuthority &&
          other.address == this.address &&
          other.phone == this.phone &&
          other.academicYear == this.academicYear &&
          other.isDefault == this.isDefault &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SchoolsCompanion extends UpdateCompanion<School> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> logo;
  final Value<String?> educationAuthority;
  final Value<String?> address;
  final Value<String?> phone;
  final Value<String> academicYear;
  final Value<bool> isDefault;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const SchoolsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.logo = const Value.absent(),
    this.educationAuthority = const Value.absent(),
    this.address = const Value.absent(),
    this.phone = const Value.absent(),
    this.academicYear = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SchoolsCompanion.insert({
    required String id,
    required String name,
    this.logo = const Value.absent(),
    this.educationAuthority = const Value.absent(),
    this.address = const Value.absent(),
    this.phone = const Value.absent(),
    this.academicYear = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<School> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? logo,
    Expression<String>? educationAuthority,
    Expression<String>? address,
    Expression<String>? phone,
    Expression<String>? academicYear,
    Expression<bool>? isDefault,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (logo != null) 'logo': logo,
      if (educationAuthority != null) 'education_authority': educationAuthority,
      if (address != null) 'address': address,
      if (phone != null) 'phone': phone,
      if (academicYear != null) 'academic_year': academicYear,
      if (isDefault != null) 'is_default': isDefault,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SchoolsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? logo,
      Value<String?>? educationAuthority,
      Value<String?>? address,
      Value<String?>? phone,
      Value<String>? academicYear,
      Value<bool>? isDefault,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return SchoolsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      logo: logo ?? this.logo,
      educationAuthority: educationAuthority ?? this.educationAuthority,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      academicYear: academicYear ?? this.academicYear,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (logo.present) {
      map['logo'] = Variable<String>(logo.value);
    }
    if (educationAuthority.present) {
      map['education_authority'] = Variable<String>(educationAuthority.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (academicYear.present) {
      map['academic_year'] = Variable<String>(academicYear.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SchoolsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('logo: $logo, ')
          ..write('educationAuthority: $educationAuthority, ')
          ..write('address: $address, ')
          ..write('phone: $phone, ')
          ..write('academicYear: $academicYear, ')
          ..write('isDefault: $isDefault, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ClassesTable extends Classes with TableInfo<$ClassesTable, ClassesData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClassesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _schoolIdMeta =
      const VerificationMeta('schoolId');
  @override
  late final GeneratedColumn<String> schoolId = GeneratedColumn<String>(
      'school_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES schools (id)'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _gradeLevelMeta =
      const VerificationMeta('gradeLevel');
  @override
  late final GeneratedColumn<String> gradeLevel = GeneratedColumn<String>(
      'grade_level', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, schoolId, name, gradeLevel, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'classes';
  @override
  VerificationContext validateIntegrity(Insertable<ClassesData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('school_id')) {
      context.handle(_schoolIdMeta,
          schoolId.isAcceptableOrUnknown(data['school_id']!, _schoolIdMeta));
    } else if (isInserting) {
      context.missing(_schoolIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('grade_level')) {
      context.handle(
          _gradeLevelMeta,
          gradeLevel.isAcceptableOrUnknown(
              data['grade_level']!, _gradeLevelMeta));
    } else if (isInserting) {
      context.missing(_gradeLevelMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ClassesData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClassesData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      schoolId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}school_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      gradeLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}grade_level'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $ClassesTable createAlias(String alias) {
    return $ClassesTable(attachedDatabase, alias);
  }
}

class ClassesData extends DataClass implements Insertable<ClassesData> {
  final String id;
  final String schoolId;
  final String name;
  final String gradeLevel;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const ClassesData(
      {required this.id,
      required this.schoolId,
      required this.name,
      required this.gradeLevel,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['school_id'] = Variable<String>(schoolId);
    map['name'] = Variable<String>(name);
    map['grade_level'] = Variable<String>(gradeLevel);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  ClassesCompanion toCompanion(bool nullToAbsent) {
    return ClassesCompanion(
      id: Value(id),
      schoolId: Value(schoolId),
      name: Value(name),
      gradeLevel: Value(gradeLevel),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory ClassesData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClassesData(
      id: serializer.fromJson<String>(json['id']),
      schoolId: serializer.fromJson<String>(json['schoolId']),
      name: serializer.fromJson<String>(json['name']),
      gradeLevel: serializer.fromJson<String>(json['gradeLevel']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'schoolId': serializer.toJson<String>(schoolId),
      'name': serializer.toJson<String>(name),
      'gradeLevel': serializer.toJson<String>(gradeLevel),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  ClassesData copyWith(
          {String? id,
          String? schoolId,
          String? name,
          String? gradeLevel,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      ClassesData(
        id: id ?? this.id,
        schoolId: schoolId ?? this.schoolId,
        name: name ?? this.name,
        gradeLevel: gradeLevel ?? this.gradeLevel,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  ClassesData copyWithCompanion(ClassesCompanion data) {
    return ClassesData(
      id: data.id.present ? data.id.value : this.id,
      schoolId: data.schoolId.present ? data.schoolId.value : this.schoolId,
      name: data.name.present ? data.name.value : this.name,
      gradeLevel:
          data.gradeLevel.present ? data.gradeLevel.value : this.gradeLevel,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClassesData(')
          ..write('id: $id, ')
          ..write('schoolId: $schoolId, ')
          ..write('name: $name, ')
          ..write('gradeLevel: $gradeLevel, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, schoolId, name, gradeLevel, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClassesData &&
          other.id == this.id &&
          other.schoolId == this.schoolId &&
          other.name == this.name &&
          other.gradeLevel == this.gradeLevel &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ClassesCompanion extends UpdateCompanion<ClassesData> {
  final Value<String> id;
  final Value<String> schoolId;
  final Value<String> name;
  final Value<String> gradeLevel;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const ClassesCompanion({
    this.id = const Value.absent(),
    this.schoolId = const Value.absent(),
    this.name = const Value.absent(),
    this.gradeLevel = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClassesCompanion.insert({
    required String id,
    required String schoolId,
    required String name,
    required String gradeLevel,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        schoolId = Value(schoolId),
        name = Value(name),
        gradeLevel = Value(gradeLevel);
  static Insertable<ClassesData> custom({
    Expression<String>? id,
    Expression<String>? schoolId,
    Expression<String>? name,
    Expression<String>? gradeLevel,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (schoolId != null) 'school_id': schoolId,
      if (name != null) 'name': name,
      if (gradeLevel != null) 'grade_level': gradeLevel,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClassesCompanion copyWith(
      {Value<String>? id,
      Value<String>? schoolId,
      Value<String>? name,
      Value<String>? gradeLevel,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return ClassesCompanion(
      id: id ?? this.id,
      schoolId: schoolId ?? this.schoolId,
      name: name ?? this.name,
      gradeLevel: gradeLevel ?? this.gradeLevel,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (schoolId.present) {
      map['school_id'] = Variable<String>(schoolId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (gradeLevel.present) {
      map['grade_level'] = Variable<String>(gradeLevel.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClassesCompanion(')
          ..write('id: $id, ')
          ..write('schoolId: $schoolId, ')
          ..write('name: $name, ')
          ..write('gradeLevel: $gradeLevel, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SectionsTable extends Sections with TableInfo<$SectionsTable, Section> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _classIdMeta =
      const VerificationMeta('classId');
  @override
  late final GeneratedColumn<String> classId = GeneratedColumn<String>(
      'class_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES classes (id)'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _academicYearMeta =
      const VerificationMeta('academicYear');
  @override
  late final GeneratedColumn<String> academicYear = GeneratedColumn<String>(
      'academic_year', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('2024-2025'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, classId, name, academicYear, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sections';
  @override
  VerificationContext validateIntegrity(Insertable<Section> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('class_id')) {
      context.handle(_classIdMeta,
          classId.isAcceptableOrUnknown(data['class_id']!, _classIdMeta));
    } else if (isInserting) {
      context.missing(_classIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('academic_year')) {
      context.handle(
          _academicYearMeta,
          academicYear.isAcceptableOrUnknown(
              data['academic_year']!, _academicYearMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Section map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Section(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      classId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}class_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      academicYear: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}academic_year'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $SectionsTable createAlias(String alias) {
    return $SectionsTable(attachedDatabase, alias);
  }
}

class Section extends DataClass implements Insertable<Section> {
  final String id;
  final String classId;
  final String name;
  final String academicYear;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const Section(
      {required this.id,
      required this.classId,
      required this.name,
      required this.academicYear,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['class_id'] = Variable<String>(classId);
    map['name'] = Variable<String>(name);
    map['academic_year'] = Variable<String>(academicYear);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  SectionsCompanion toCompanion(bool nullToAbsent) {
    return SectionsCompanion(
      id: Value(id),
      classId: Value(classId),
      name: Value(name),
      academicYear: Value(academicYear),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Section.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Section(
      id: serializer.fromJson<String>(json['id']),
      classId: serializer.fromJson<String>(json['classId']),
      name: serializer.fromJson<String>(json['name']),
      academicYear: serializer.fromJson<String>(json['academicYear']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'classId': serializer.toJson<String>(classId),
      'name': serializer.toJson<String>(name),
      'academicYear': serializer.toJson<String>(academicYear),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Section copyWith(
          {String? id,
          String? classId,
          String? name,
          String? academicYear,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      Section(
        id: id ?? this.id,
        classId: classId ?? this.classId,
        name: name ?? this.name,
        academicYear: academicYear ?? this.academicYear,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  Section copyWithCompanion(SectionsCompanion data) {
    return Section(
      id: data.id.present ? data.id.value : this.id,
      classId: data.classId.present ? data.classId.value : this.classId,
      name: data.name.present ? data.name.value : this.name,
      academicYear: data.academicYear.present
          ? data.academicYear.value
          : this.academicYear,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Section(')
          ..write('id: $id, ')
          ..write('classId: $classId, ')
          ..write('name: $name, ')
          ..write('academicYear: $academicYear, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, classId, name, academicYear, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Section &&
          other.id == this.id &&
          other.classId == this.classId &&
          other.name == this.name &&
          other.academicYear == this.academicYear &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SectionsCompanion extends UpdateCompanion<Section> {
  final Value<String> id;
  final Value<String> classId;
  final Value<String> name;
  final Value<String> academicYear;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const SectionsCompanion({
    this.id = const Value.absent(),
    this.classId = const Value.absent(),
    this.name = const Value.absent(),
    this.academicYear = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SectionsCompanion.insert({
    required String id,
    required String classId,
    required String name,
    this.academicYear = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        classId = Value(classId),
        name = Value(name);
  static Insertable<Section> custom({
    Expression<String>? id,
    Expression<String>? classId,
    Expression<String>? name,
    Expression<String>? academicYear,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (classId != null) 'class_id': classId,
      if (name != null) 'name': name,
      if (academicYear != null) 'academic_year': academicYear,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SectionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? classId,
      Value<String>? name,
      Value<String>? academicYear,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return SectionsCompanion(
      id: id ?? this.id,
      classId: classId ?? this.classId,
      name: name ?? this.name,
      academicYear: academicYear ?? this.academicYear,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (classId.present) {
      map['class_id'] = Variable<String>(classId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (academicYear.present) {
      map['academic_year'] = Variable<String>(academicYear.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SectionsCompanion(')
          ..write('id: $id, ')
          ..write('classId: $classId, ')
          ..write('name: $name, ')
          ..write('academicYear: $academicYear, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SubjectsTable extends Subjects with TableInfo<$SubjectsTable, Subject> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubjectsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _schoolIdMeta =
      const VerificationMeta('schoolId');
  @override
  late final GeneratedColumn<String> schoolId = GeneratedColumn<String>(
      'school_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES schools (id)'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
      'color', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, schoolId, name, color, icon, description, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subjects';
  @override
  VerificationContext validateIntegrity(Insertable<Subject> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('school_id')) {
      context.handle(_schoolIdMeta,
          schoolId.isAcceptableOrUnknown(data['school_id']!, _schoolIdMeta));
    } else if (isInserting) {
      context.missing(_schoolIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
          _colorMeta, color.isAcceptableOrUnknown(data['color']!, _colorMeta));
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Subject map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Subject(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      schoolId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}school_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      color: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}color']),
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon']),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $SubjectsTable createAlias(String alias) {
    return $SubjectsTable(attachedDatabase, alias);
  }
}

class Subject extends DataClass implements Insertable<Subject> {
  final String id;
  final String schoolId;
  final String name;
  final String? color;
  final String? icon;
  final String? description;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const Subject(
      {required this.id,
      required this.schoolId,
      required this.name,
      this.color,
      this.icon,
      this.description,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['school_id'] = Variable<String>(schoolId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  SubjectsCompanion toCompanion(bool nullToAbsent) {
    return SubjectsCompanion(
      id: Value(id),
      schoolId: Value(schoolId),
      name: Value(name),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Subject.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Subject(
      id: serializer.fromJson<String>(json['id']),
      schoolId: serializer.fromJson<String>(json['schoolId']),
      name: serializer.fromJson<String>(json['name']),
      color: serializer.fromJson<String?>(json['color']),
      icon: serializer.fromJson<String?>(json['icon']),
      description: serializer.fromJson<String?>(json['description']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'schoolId': serializer.toJson<String>(schoolId),
      'name': serializer.toJson<String>(name),
      'color': serializer.toJson<String?>(color),
      'icon': serializer.toJson<String?>(icon),
      'description': serializer.toJson<String?>(description),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Subject copyWith(
          {String? id,
          String? schoolId,
          String? name,
          Value<String?> color = const Value.absent(),
          Value<String?> icon = const Value.absent(),
          Value<String?> description = const Value.absent(),
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      Subject(
        id: id ?? this.id,
        schoolId: schoolId ?? this.schoolId,
        name: name ?? this.name,
        color: color.present ? color.value : this.color,
        icon: icon.present ? icon.value : this.icon,
        description: description.present ? description.value : this.description,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  Subject copyWithCompanion(SubjectsCompanion data) {
    return Subject(
      id: data.id.present ? data.id.value : this.id,
      schoolId: data.schoolId.present ? data.schoolId.value : this.schoolId,
      name: data.name.present ? data.name.value : this.name,
      color: data.color.present ? data.color.value : this.color,
      icon: data.icon.present ? data.icon.value : this.icon,
      description:
          data.description.present ? data.description.value : this.description,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Subject(')
          ..write('id: $id, ')
          ..write('schoolId: $schoolId, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('icon: $icon, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, schoolId, name, color, icon, description, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Subject &&
          other.id == this.id &&
          other.schoolId == this.schoolId &&
          other.name == this.name &&
          other.color == this.color &&
          other.icon == this.icon &&
          other.description == this.description &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SubjectsCompanion extends UpdateCompanion<Subject> {
  final Value<String> id;
  final Value<String> schoolId;
  final Value<String> name;
  final Value<String?> color;
  final Value<String?> icon;
  final Value<String?> description;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const SubjectsCompanion({
    this.id = const Value.absent(),
    this.schoolId = const Value.absent(),
    this.name = const Value.absent(),
    this.color = const Value.absent(),
    this.icon = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SubjectsCompanion.insert({
    required String id,
    required String schoolId,
    required String name,
    this.color = const Value.absent(),
    this.icon = const Value.absent(),
    this.description = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        schoolId = Value(schoolId),
        name = Value(name);
  static Insertable<Subject> custom({
    Expression<String>? id,
    Expression<String>? schoolId,
    Expression<String>? name,
    Expression<String>? color,
    Expression<String>? icon,
    Expression<String>? description,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (schoolId != null) 'school_id': schoolId,
      if (name != null) 'name': name,
      if (color != null) 'color': color,
      if (icon != null) 'icon': icon,
      if (description != null) 'description': description,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SubjectsCompanion copyWith(
      {Value<String>? id,
      Value<String>? schoolId,
      Value<String>? name,
      Value<String?>? color,
      Value<String?>? icon,
      Value<String?>? description,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return SubjectsCompanion(
      id: id ?? this.id,
      schoolId: schoolId ?? this.schoolId,
      name: name ?? this.name,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (schoolId.present) {
      map['school_id'] = Variable<String>(schoolId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubjectsCompanion(')
          ..write('id: $id, ')
          ..write('schoolId: $schoolId, ')
          ..write('name: $name, ')
          ..write('color: $color, ')
          ..write('icon: $icon, ')
          ..write('description: $description, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StudentsTable extends Students with TableInfo<$StudentsTable, Student> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StudentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 2, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _studentNumberMeta =
      const VerificationMeta('studentNumber');
  @override
  late final GeneratedColumn<String> studentNumber = GeneratedColumn<String>(
      'student_number', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _classIdMeta =
      const VerificationMeta('classId');
  @override
  late final GeneratedColumn<String> classId = GeneratedColumn<String>(
      'class_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES classes (id)'));
  static const VerificationMeta _sectionIdMeta =
      const VerificationMeta('sectionId');
  @override
  late final GeneratedColumn<String> sectionId = GeneratedColumn<String>(
      'section_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES sections (id)'));
  static const VerificationMeta _parentPhoneMeta =
      const VerificationMeta('parentPhone');
  @override
  late final GeneratedColumn<String> parentPhone = GeneratedColumn<String>(
      'parent_phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _profileImageMeta =
      const VerificationMeta('profileImage');
  @override
  late final GeneratedColumn<String> profileImage = GeneratedColumn<String>(
      'profile_image', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        studentNumber,
        classId,
        sectionId,
        parentPhone,
        profileImage,
        notes,
        gender,
        email,
        address,
        createdAt,
        updatedAt,
        isDeleted,
        isActive
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'students';
  @override
  VerificationContext validateIntegrity(Insertable<Student> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('student_number')) {
      context.handle(
          _studentNumberMeta,
          studentNumber.isAcceptableOrUnknown(
              data['student_number']!, _studentNumberMeta));
    } else if (isInserting) {
      context.missing(_studentNumberMeta);
    }
    if (data.containsKey('class_id')) {
      context.handle(_classIdMeta,
          classId.isAcceptableOrUnknown(data['class_id']!, _classIdMeta));
    } else if (isInserting) {
      context.missing(_classIdMeta);
    }
    if (data.containsKey('section_id')) {
      context.handle(_sectionIdMeta,
          sectionId.isAcceptableOrUnknown(data['section_id']!, _sectionIdMeta));
    }
    if (data.containsKey('parent_phone')) {
      context.handle(
          _parentPhoneMeta,
          parentPhone.isAcceptableOrUnknown(
              data['parent_phone']!, _parentPhoneMeta));
    }
    if (data.containsKey('profile_image')) {
      context.handle(
          _profileImageMeta,
          profileImage.isAcceptableOrUnknown(
              data['profile_image']!, _profileImageMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Student map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Student(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      studentNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}student_number'])!,
      classId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}class_id'])!,
      sectionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}section_id']),
      parentPhone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}parent_phone']),
      profileImage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}profile_image']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
    );
  }

  @override
  $StudentsTable createAlias(String alias) {
    return $StudentsTable(attachedDatabase, alias);
  }
}

class Student extends DataClass implements Insertable<Student> {
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
  const Student(
      {required this.id,
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
      required this.isDeleted,
      required this.isActive});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['student_number'] = Variable<String>(studentNumber);
    map['class_id'] = Variable<String>(classId);
    if (!nullToAbsent || sectionId != null) {
      map['section_id'] = Variable<String>(sectionId);
    }
    if (!nullToAbsent || parentPhone != null) {
      map['parent_phone'] = Variable<String>(parentPhone);
    }
    if (!nullToAbsent || profileImage != null) {
      map['profile_image'] = Variable<String>(profileImage);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  StudentsCompanion toCompanion(bool nullToAbsent) {
    return StudentsCompanion(
      id: Value(id),
      name: Value(name),
      studentNumber: Value(studentNumber),
      classId: Value(classId),
      sectionId: sectionId == null && nullToAbsent
          ? const Value.absent()
          : Value(sectionId),
      parentPhone: parentPhone == null && nullToAbsent
          ? const Value.absent()
          : Value(parentPhone),
      profileImage: profileImage == null && nullToAbsent
          ? const Value.absent()
          : Value(profileImage),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      gender:
          gender == null && nullToAbsent ? const Value.absent() : Value(gender),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      isDeleted: Value(isDeleted),
      isActive: Value(isActive),
    );
  }

  factory Student.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Student(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      studentNumber: serializer.fromJson<String>(json['studentNumber']),
      classId: serializer.fromJson<String>(json['classId']),
      sectionId: serializer.fromJson<String?>(json['sectionId']),
      parentPhone: serializer.fromJson<String?>(json['parentPhone']),
      profileImage: serializer.fromJson<String?>(json['profileImage']),
      notes: serializer.fromJson<String?>(json['notes']),
      gender: serializer.fromJson<String?>(json['gender']),
      email: serializer.fromJson<String?>(json['email']),
      address: serializer.fromJson<String?>(json['address']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'studentNumber': serializer.toJson<String>(studentNumber),
      'classId': serializer.toJson<String>(classId),
      'sectionId': serializer.toJson<String?>(sectionId),
      'parentPhone': serializer.toJson<String?>(parentPhone),
      'profileImage': serializer.toJson<String?>(profileImage),
      'notes': serializer.toJson<String?>(notes),
      'gender': serializer.toJson<String?>(gender),
      'email': serializer.toJson<String?>(email),
      'address': serializer.toJson<String?>(address),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  Student copyWith(
          {String? id,
          String? name,
          String? studentNumber,
          String? classId,
          Value<String?> sectionId = const Value.absent(),
          Value<String?> parentPhone = const Value.absent(),
          Value<String?> profileImage = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          Value<String?> gender = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<String?> address = const Value.absent(),
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent(),
          bool? isDeleted,
          bool? isActive}) =>
      Student(
        id: id ?? this.id,
        name: name ?? this.name,
        studentNumber: studentNumber ?? this.studentNumber,
        classId: classId ?? this.classId,
        sectionId: sectionId.present ? sectionId.value : this.sectionId,
        parentPhone: parentPhone.present ? parentPhone.value : this.parentPhone,
        profileImage:
            profileImage.present ? profileImage.value : this.profileImage,
        notes: notes.present ? notes.value : this.notes,
        gender: gender.present ? gender.value : this.gender,
        email: email.present ? email.value : this.email,
        address: address.present ? address.value : this.address,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
        isDeleted: isDeleted ?? this.isDeleted,
        isActive: isActive ?? this.isActive,
      );
  Student copyWithCompanion(StudentsCompanion data) {
    return Student(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      studentNumber: data.studentNumber.present
          ? data.studentNumber.value
          : this.studentNumber,
      classId: data.classId.present ? data.classId.value : this.classId,
      sectionId: data.sectionId.present ? data.sectionId.value : this.sectionId,
      parentPhone:
          data.parentPhone.present ? data.parentPhone.value : this.parentPhone,
      profileImage: data.profileImage.present
          ? data.profileImage.value
          : this.profileImage,
      notes: data.notes.present ? data.notes.value : this.notes,
      gender: data.gender.present ? data.gender.value : this.gender,
      email: data.email.present ? data.email.value : this.email,
      address: data.address.present ? data.address.value : this.address,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Student(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('studentNumber: $studentNumber, ')
          ..write('classId: $classId, ')
          ..write('sectionId: $sectionId, ')
          ..write('parentPhone: $parentPhone, ')
          ..write('profileImage: $profileImage, ')
          ..write('notes: $notes, ')
          ..write('gender: $gender, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      studentNumber,
      classId,
      sectionId,
      parentPhone,
      profileImage,
      notes,
      gender,
      email,
      address,
      createdAt,
      updatedAt,
      isDeleted,
      isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Student &&
          other.id == this.id &&
          other.name == this.name &&
          other.studentNumber == this.studentNumber &&
          other.classId == this.classId &&
          other.sectionId == this.sectionId &&
          other.parentPhone == this.parentPhone &&
          other.profileImage == this.profileImage &&
          other.notes == this.notes &&
          other.gender == this.gender &&
          other.email == this.email &&
          other.address == this.address &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.isDeleted == this.isDeleted &&
          other.isActive == this.isActive);
}

class StudentsCompanion extends UpdateCompanion<Student> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> studentNumber;
  final Value<String> classId;
  final Value<String?> sectionId;
  final Value<String?> parentPhone;
  final Value<String?> profileImage;
  final Value<String?> notes;
  final Value<String?> gender;
  final Value<String?> email;
  final Value<String?> address;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<bool> isDeleted;
  final Value<bool> isActive;
  final Value<int> rowid;
  const StudentsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.studentNumber = const Value.absent(),
    this.classId = const Value.absent(),
    this.sectionId = const Value.absent(),
    this.parentPhone = const Value.absent(),
    this.profileImage = const Value.absent(),
    this.notes = const Value.absent(),
    this.gender = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StudentsCompanion.insert({
    required String id,
    required String name,
    required String studentNumber,
    required String classId,
    this.sectionId = const Value.absent(),
    this.parentPhone = const Value.absent(),
    this.profileImage = const Value.absent(),
    this.notes = const Value.absent(),
    this.gender = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        studentNumber = Value(studentNumber),
        classId = Value(classId);
  static Insertable<Student> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? studentNumber,
    Expression<String>? classId,
    Expression<String>? sectionId,
    Expression<String>? parentPhone,
    Expression<String>? profileImage,
    Expression<String>? notes,
    Expression<String>? gender,
    Expression<String>? email,
    Expression<String>? address,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? isDeleted,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (studentNumber != null) 'student_number': studentNumber,
      if (classId != null) 'class_id': classId,
      if (sectionId != null) 'section_id': sectionId,
      if (parentPhone != null) 'parent_phone': parentPhone,
      if (profileImage != null) 'profile_image': profileImage,
      if (notes != null) 'notes': notes,
      if (gender != null) 'gender': gender,
      if (email != null) 'email': email,
      if (address != null) 'address': address,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StudentsCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String>? studentNumber,
      Value<String>? classId,
      Value<String?>? sectionId,
      Value<String?>? parentPhone,
      Value<String?>? profileImage,
      Value<String?>? notes,
      Value<String?>? gender,
      Value<String?>? email,
      Value<String?>? address,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<bool>? isDeleted,
      Value<bool>? isActive,
      Value<int>? rowid}) {
    return StudentsCompanion(
      id: id ?? this.id,
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
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (studentNumber.present) {
      map['student_number'] = Variable<String>(studentNumber.value);
    }
    if (classId.present) {
      map['class_id'] = Variable<String>(classId.value);
    }
    if (sectionId.present) {
      map['section_id'] = Variable<String>(sectionId.value);
    }
    if (parentPhone.present) {
      map['parent_phone'] = Variable<String>(parentPhone.value);
    }
    if (profileImage.present) {
      map['profile_image'] = Variable<String>(profileImage.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StudentsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('studentNumber: $studentNumber, ')
          ..write('classId: $classId, ')
          ..write('sectionId: $sectionId, ')
          ..write('parentPhone: $parentPhone, ')
          ..write('profileImage: $profileImage, ')
          ..write('notes: $notes, ')
          ..write('gender: $gender, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExamsTable extends Exams with TableInfo<$ExamsTable, ExamModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExamsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _schoolIdMeta =
      const VerificationMeta('schoolId');
  @override
  late final GeneratedColumn<String> schoolId = GeneratedColumn<String>(
      'school_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES schools (id)'));
  static const VerificationMeta _classIdMeta =
      const VerificationMeta('classId');
  @override
  late final GeneratedColumn<String> classId = GeneratedColumn<String>(
      'class_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES classes (id)'));
  static const VerificationMeta _sectionIdMeta =
      const VerificationMeta('sectionId');
  @override
  late final GeneratedColumn<String> sectionId = GeneratedColumn<String>(
      'section_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES sections (id)'));
  static const VerificationMeta _subjectIdMeta =
      const VerificationMeta('subjectId');
  @override
  late final GeneratedColumn<String> subjectId = GeneratedColumn<String>(
      'subject_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES subjects (id)'));
  static const VerificationMeta _teacherIdMeta =
      const VerificationMeta('teacherId');
  @override
  late final GeneratedColumn<String> teacherId = GeneratedColumn<String>(
      'teacher_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES teachers (id)'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('custom'));
  static const VerificationMeta _academicYearMeta =
      const VerificationMeta('academicYear');
  @override
  late final GeneratedColumn<String> academicYear = GeneratedColumn<String>(
      'academic_year', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('2024-2025'));
  static const VerificationMeta _semesterMeta =
      const VerificationMeta('semester');
  @override
  late final GeneratedColumn<String> semester = GeneratedColumn<String>(
      'semester', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('first'));
  static const VerificationMeta _examDateMeta =
      const VerificationMeta('examDate');
  @override
  late final GeneratedColumn<DateTime> examDate = GeneratedColumn<DateTime>(
      'exam_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _durationMeta =
      const VerificationMeta('duration');
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
      'duration', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(45));
  static const VerificationMeta _totalMarksMeta =
      const VerificationMeta('totalMarks');
  @override
  late final GeneratedColumn<double> totalMarks = GeneratedColumn<double>(
      'total_marks', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(20));
  static const VerificationMeta _instructionsMeta =
      const VerificationMeta('instructions');
  @override
  late final GeneratedColumn<String> instructions = GeneratedColumn<String>(
      'instructions', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('draft'));
  static const VerificationMeta _isTemplateMeta =
      const VerificationMeta('isTemplate');
  @override
  late final GeneratedColumn<bool> isTemplate = GeneratedColumn<bool>(
      'is_template', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_template" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        schoolId,
        classId,
        sectionId,
        subjectId,
        teacherId,
        type,
        academicYear,
        semester,
        examDate,
        duration,
        totalMarks,
        instructions,
        status,
        isTemplate,
        isDeleted,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exams';
  @override
  VerificationContext validateIntegrity(Insertable<ExamModel> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('school_id')) {
      context.handle(_schoolIdMeta,
          schoolId.isAcceptableOrUnknown(data['school_id']!, _schoolIdMeta));
    } else if (isInserting) {
      context.missing(_schoolIdMeta);
    }
    if (data.containsKey('class_id')) {
      context.handle(_classIdMeta,
          classId.isAcceptableOrUnknown(data['class_id']!, _classIdMeta));
    } else if (isInserting) {
      context.missing(_classIdMeta);
    }
    if (data.containsKey('section_id')) {
      context.handle(_sectionIdMeta,
          sectionId.isAcceptableOrUnknown(data['section_id']!, _sectionIdMeta));
    }
    if (data.containsKey('subject_id')) {
      context.handle(_subjectIdMeta,
          subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta));
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    if (data.containsKey('teacher_id')) {
      context.handle(_teacherIdMeta,
          teacherId.isAcceptableOrUnknown(data['teacher_id']!, _teacherIdMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('academic_year')) {
      context.handle(
          _academicYearMeta,
          academicYear.isAcceptableOrUnknown(
              data['academic_year']!, _academicYearMeta));
    }
    if (data.containsKey('semester')) {
      context.handle(_semesterMeta,
          semester.isAcceptableOrUnknown(data['semester']!, _semesterMeta));
    }
    if (data.containsKey('exam_date')) {
      context.handle(_examDateMeta,
          examDate.isAcceptableOrUnknown(data['exam_date']!, _examDateMeta));
    } else if (isInserting) {
      context.missing(_examDateMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration']!, _durationMeta));
    }
    if (data.containsKey('total_marks')) {
      context.handle(
          _totalMarksMeta,
          totalMarks.isAcceptableOrUnknown(
              data['total_marks']!, _totalMarksMeta));
    }
    if (data.containsKey('instructions')) {
      context.handle(
          _instructionsMeta,
          instructions.isAcceptableOrUnknown(
              data['instructions']!, _instructionsMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('is_template')) {
      context.handle(
          _isTemplateMeta,
          isTemplate.isAcceptableOrUnknown(
              data['is_template']!, _isTemplateMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExamModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExamModel(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      schoolId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}school_id'])!,
      classId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}class_id'])!,
      sectionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}section_id']),
      subjectId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}subject_id'])!,
      teacherId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}teacher_id']),
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      academicYear: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}academic_year'])!,
      semester: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}semester'])!,
      examDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}exam_date'])!,
      duration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration'])!,
      totalMarks: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_marks'])!,
      instructions: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}instructions']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      isTemplate: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_template'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $ExamsTable createAlias(String alias) {
    return $ExamsTable(attachedDatabase, alias);
  }
}

class ExamModel extends DataClass implements Insertable<ExamModel> {
  final String id;
  final String title;
  final String schoolId;
  final String classId;
  final String? sectionId;
  final String subjectId;
  final String? teacherId;
  final String type;
  final String academicYear;
  final String semester;
  final DateTime examDate;
  final int duration;
  final double totalMarks;
  final String? instructions;
  final String status;
  final bool isTemplate;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const ExamModel(
      {required this.id,
      required this.title,
      required this.schoolId,
      required this.classId,
      this.sectionId,
      required this.subjectId,
      this.teacherId,
      required this.type,
      required this.academicYear,
      required this.semester,
      required this.examDate,
      required this.duration,
      required this.totalMarks,
      this.instructions,
      required this.status,
      required this.isTemplate,
      required this.isDeleted,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['school_id'] = Variable<String>(schoolId);
    map['class_id'] = Variable<String>(classId);
    if (!nullToAbsent || sectionId != null) {
      map['section_id'] = Variable<String>(sectionId);
    }
    map['subject_id'] = Variable<String>(subjectId);
    if (!nullToAbsent || teacherId != null) {
      map['teacher_id'] = Variable<String>(teacherId);
    }
    map['type'] = Variable<String>(type);
    map['academic_year'] = Variable<String>(academicYear);
    map['semester'] = Variable<String>(semester);
    map['exam_date'] = Variable<DateTime>(examDate);
    map['duration'] = Variable<int>(duration);
    map['total_marks'] = Variable<double>(totalMarks);
    if (!nullToAbsent || instructions != null) {
      map['instructions'] = Variable<String>(instructions);
    }
    map['status'] = Variable<String>(status);
    map['is_template'] = Variable<bool>(isTemplate);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  ExamsCompanion toCompanion(bool nullToAbsent) {
    return ExamsCompanion(
      id: Value(id),
      title: Value(title),
      schoolId: Value(schoolId),
      classId: Value(classId),
      sectionId: sectionId == null && nullToAbsent
          ? const Value.absent()
          : Value(sectionId),
      subjectId: Value(subjectId),
      teacherId: teacherId == null && nullToAbsent
          ? const Value.absent()
          : Value(teacherId),
      type: Value(type),
      academicYear: Value(academicYear),
      semester: Value(semester),
      examDate: Value(examDate),
      duration: Value(duration),
      totalMarks: Value(totalMarks),
      instructions: instructions == null && nullToAbsent
          ? const Value.absent()
          : Value(instructions),
      status: Value(status),
      isTemplate: Value(isTemplate),
      isDeleted: Value(isDeleted),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory ExamModel.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExamModel(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      schoolId: serializer.fromJson<String>(json['schoolId']),
      classId: serializer.fromJson<String>(json['classId']),
      sectionId: serializer.fromJson<String?>(json['sectionId']),
      subjectId: serializer.fromJson<String>(json['subjectId']),
      teacherId: serializer.fromJson<String?>(json['teacherId']),
      type: serializer.fromJson<String>(json['type']),
      academicYear: serializer.fromJson<String>(json['academicYear']),
      semester: serializer.fromJson<String>(json['semester']),
      examDate: serializer.fromJson<DateTime>(json['examDate']),
      duration: serializer.fromJson<int>(json['duration']),
      totalMarks: serializer.fromJson<double>(json['totalMarks']),
      instructions: serializer.fromJson<String?>(json['instructions']),
      status: serializer.fromJson<String>(json['status']),
      isTemplate: serializer.fromJson<bool>(json['isTemplate']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'schoolId': serializer.toJson<String>(schoolId),
      'classId': serializer.toJson<String>(classId),
      'sectionId': serializer.toJson<String?>(sectionId),
      'subjectId': serializer.toJson<String>(subjectId),
      'teacherId': serializer.toJson<String?>(teacherId),
      'type': serializer.toJson<String>(type),
      'academicYear': serializer.toJson<String>(academicYear),
      'semester': serializer.toJson<String>(semester),
      'examDate': serializer.toJson<DateTime>(examDate),
      'duration': serializer.toJson<int>(duration),
      'totalMarks': serializer.toJson<double>(totalMarks),
      'instructions': serializer.toJson<String?>(instructions),
      'status': serializer.toJson<String>(status),
      'isTemplate': serializer.toJson<bool>(isTemplate),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  ExamModel copyWith(
          {String? id,
          String? title,
          String? schoolId,
          String? classId,
          Value<String?> sectionId = const Value.absent(),
          String? subjectId,
          Value<String?> teacherId = const Value.absent(),
          String? type,
          String? academicYear,
          String? semester,
          DateTime? examDate,
          int? duration,
          double? totalMarks,
          Value<String?> instructions = const Value.absent(),
          String? status,
          bool? isTemplate,
          bool? isDeleted,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      ExamModel(
        id: id ?? this.id,
        title: title ?? this.title,
        schoolId: schoolId ?? this.schoolId,
        classId: classId ?? this.classId,
        sectionId: sectionId.present ? sectionId.value : this.sectionId,
        subjectId: subjectId ?? this.subjectId,
        teacherId: teacherId.present ? teacherId.value : this.teacherId,
        type: type ?? this.type,
        academicYear: academicYear ?? this.academicYear,
        semester: semester ?? this.semester,
        examDate: examDate ?? this.examDate,
        duration: duration ?? this.duration,
        totalMarks: totalMarks ?? this.totalMarks,
        instructions:
            instructions.present ? instructions.value : this.instructions,
        status: status ?? this.status,
        isTemplate: isTemplate ?? this.isTemplate,
        isDeleted: isDeleted ?? this.isDeleted,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  ExamModel copyWithCompanion(ExamsCompanion data) {
    return ExamModel(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      schoolId: data.schoolId.present ? data.schoolId.value : this.schoolId,
      classId: data.classId.present ? data.classId.value : this.classId,
      sectionId: data.sectionId.present ? data.sectionId.value : this.sectionId,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      teacherId: data.teacherId.present ? data.teacherId.value : this.teacherId,
      type: data.type.present ? data.type.value : this.type,
      academicYear: data.academicYear.present
          ? data.academicYear.value
          : this.academicYear,
      semester: data.semester.present ? data.semester.value : this.semester,
      examDate: data.examDate.present ? data.examDate.value : this.examDate,
      duration: data.duration.present ? data.duration.value : this.duration,
      totalMarks:
          data.totalMarks.present ? data.totalMarks.value : this.totalMarks,
      instructions: data.instructions.present
          ? data.instructions.value
          : this.instructions,
      status: data.status.present ? data.status.value : this.status,
      isTemplate:
          data.isTemplate.present ? data.isTemplate.value : this.isTemplate,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExamModel(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('schoolId: $schoolId, ')
          ..write('classId: $classId, ')
          ..write('sectionId: $sectionId, ')
          ..write('subjectId: $subjectId, ')
          ..write('teacherId: $teacherId, ')
          ..write('type: $type, ')
          ..write('academicYear: $academicYear, ')
          ..write('semester: $semester, ')
          ..write('examDate: $examDate, ')
          ..write('duration: $duration, ')
          ..write('totalMarks: $totalMarks, ')
          ..write('instructions: $instructions, ')
          ..write('status: $status, ')
          ..write('isTemplate: $isTemplate, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      title,
      schoolId,
      classId,
      sectionId,
      subjectId,
      teacherId,
      type,
      academicYear,
      semester,
      examDate,
      duration,
      totalMarks,
      instructions,
      status,
      isTemplate,
      isDeleted,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExamModel &&
          other.id == this.id &&
          other.title == this.title &&
          other.schoolId == this.schoolId &&
          other.classId == this.classId &&
          other.sectionId == this.sectionId &&
          other.subjectId == this.subjectId &&
          other.teacherId == this.teacherId &&
          other.type == this.type &&
          other.academicYear == this.academicYear &&
          other.semester == this.semester &&
          other.examDate == this.examDate &&
          other.duration == this.duration &&
          other.totalMarks == this.totalMarks &&
          other.instructions == this.instructions &&
          other.status == this.status &&
          other.isTemplate == this.isTemplate &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ExamsCompanion extends UpdateCompanion<ExamModel> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> schoolId;
  final Value<String> classId;
  final Value<String?> sectionId;
  final Value<String> subjectId;
  final Value<String?> teacherId;
  final Value<String> type;
  final Value<String> academicYear;
  final Value<String> semester;
  final Value<DateTime> examDate;
  final Value<int> duration;
  final Value<double> totalMarks;
  final Value<String?> instructions;
  final Value<String> status;
  final Value<bool> isTemplate;
  final Value<bool> isDeleted;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const ExamsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.schoolId = const Value.absent(),
    this.classId = const Value.absent(),
    this.sectionId = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.teacherId = const Value.absent(),
    this.type = const Value.absent(),
    this.academicYear = const Value.absent(),
    this.semester = const Value.absent(),
    this.examDate = const Value.absent(),
    this.duration = const Value.absent(),
    this.totalMarks = const Value.absent(),
    this.instructions = const Value.absent(),
    this.status = const Value.absent(),
    this.isTemplate = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExamsCompanion.insert({
    required String id,
    required String title,
    required String schoolId,
    required String classId,
    this.sectionId = const Value.absent(),
    required String subjectId,
    this.teacherId = const Value.absent(),
    this.type = const Value.absent(),
    this.academicYear = const Value.absent(),
    this.semester = const Value.absent(),
    required DateTime examDate,
    this.duration = const Value.absent(),
    this.totalMarks = const Value.absent(),
    this.instructions = const Value.absent(),
    this.status = const Value.absent(),
    this.isTemplate = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        schoolId = Value(schoolId),
        classId = Value(classId),
        subjectId = Value(subjectId),
        examDate = Value(examDate);
  static Insertable<ExamModel> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? schoolId,
    Expression<String>? classId,
    Expression<String>? sectionId,
    Expression<String>? subjectId,
    Expression<String>? teacherId,
    Expression<String>? type,
    Expression<String>? academicYear,
    Expression<String>? semester,
    Expression<DateTime>? examDate,
    Expression<int>? duration,
    Expression<double>? totalMarks,
    Expression<String>? instructions,
    Expression<String>? status,
    Expression<bool>? isTemplate,
    Expression<bool>? isDeleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (schoolId != null) 'school_id': schoolId,
      if (classId != null) 'class_id': classId,
      if (sectionId != null) 'section_id': sectionId,
      if (subjectId != null) 'subject_id': subjectId,
      if (teacherId != null) 'teacher_id': teacherId,
      if (type != null) 'type': type,
      if (academicYear != null) 'academic_year': academicYear,
      if (semester != null) 'semester': semester,
      if (examDate != null) 'exam_date': examDate,
      if (duration != null) 'duration': duration,
      if (totalMarks != null) 'total_marks': totalMarks,
      if (instructions != null) 'instructions': instructions,
      if (status != null) 'status': status,
      if (isTemplate != null) 'is_template': isTemplate,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExamsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? schoolId,
      Value<String>? classId,
      Value<String?>? sectionId,
      Value<String>? subjectId,
      Value<String?>? teacherId,
      Value<String>? type,
      Value<String>? academicYear,
      Value<String>? semester,
      Value<DateTime>? examDate,
      Value<int>? duration,
      Value<double>? totalMarks,
      Value<String?>? instructions,
      Value<String>? status,
      Value<bool>? isTemplate,
      Value<bool>? isDeleted,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return ExamsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      schoolId: schoolId ?? this.schoolId,
      classId: classId ?? this.classId,
      sectionId: sectionId ?? this.sectionId,
      subjectId: subjectId ?? this.subjectId,
      teacherId: teacherId ?? this.teacherId,
      type: type ?? this.type,
      academicYear: academicYear ?? this.academicYear,
      semester: semester ?? this.semester,
      examDate: examDate ?? this.examDate,
      duration: duration ?? this.duration,
      totalMarks: totalMarks ?? this.totalMarks,
      instructions: instructions ?? this.instructions,
      status: status ?? this.status,
      isTemplate: isTemplate ?? this.isTemplate,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (schoolId.present) {
      map['school_id'] = Variable<String>(schoolId.value);
    }
    if (classId.present) {
      map['class_id'] = Variable<String>(classId.value);
    }
    if (sectionId.present) {
      map['section_id'] = Variable<String>(sectionId.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<String>(subjectId.value);
    }
    if (teacherId.present) {
      map['teacher_id'] = Variable<String>(teacherId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (academicYear.present) {
      map['academic_year'] = Variable<String>(academicYear.value);
    }
    if (semester.present) {
      map['semester'] = Variable<String>(semester.value);
    }
    if (examDate.present) {
      map['exam_date'] = Variable<DateTime>(examDate.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (totalMarks.present) {
      map['total_marks'] = Variable<double>(totalMarks.value);
    }
    if (instructions.present) {
      map['instructions'] = Variable<String>(instructions.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (isTemplate.present) {
      map['is_template'] = Variable<bool>(isTemplate.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExamsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('schoolId: $schoolId, ')
          ..write('classId: $classId, ')
          ..write('sectionId: $sectionId, ')
          ..write('subjectId: $subjectId, ')
          ..write('teacherId: $teacherId, ')
          ..write('type: $type, ')
          ..write('academicYear: $academicYear, ')
          ..write('semester: $semester, ')
          ..write('examDate: $examDate, ')
          ..write('duration: $duration, ')
          ..write('totalMarks: $totalMarks, ')
          ..write('instructions: $instructions, ')
          ..write('status: $status, ')
          ..write('isTemplate: $isTemplate, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuestionBankItemsTable extends QuestionBankItems
    with TableInfo<$QuestionBankItemsTable, QuestionBankItemModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionBankItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _subjectIdMeta =
      const VerificationMeta('subjectId');
  @override
  late final GeneratedColumn<String> subjectId = GeneratedColumn<String>(
      'subject_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES subjects (id)'));
  static const VerificationMeta _classIdMeta =
      const VerificationMeta('classId');
  @override
  late final GeneratedColumn<String> classId = GeneratedColumn<String>(
      'class_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES classes (id)'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
      'unit', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lessonMeta = const VerificationMeta('lesson');
  @override
  late final GeneratedColumn<String> lesson = GeneratedColumn<String>(
      'lesson', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _difficultyMeta =
      const VerificationMeta('difficulty');
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
      'difficulty', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('medium'));
  static const VerificationMeta _marksMeta = const VerificationMeta('marks');
  @override
  late final GeneratedColumn<double> marks = GeneratedColumn<double>(
      'marks', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _correctAnswerMeta =
      const VerificationMeta('correctAnswer');
  @override
  late final GeneratedColumn<String> correctAnswer = GeneratedColumn<String>(
      'correct_answer', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _explanationMeta =
      const VerificationMeta('explanation');
  @override
  late final GeneratedColumn<String> explanation = GeneratedColumn<String>(
      'explanation', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        subjectId,
        classId,
        type,
        content,
        unit,
        lesson,
        difficulty,
        marks,
        correctAnswer,
        explanation,
        isActive,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'question_bank_items';
  @override
  VerificationContext validateIntegrity(
      Insertable<QuestionBankItemModel> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('subject_id')) {
      context.handle(_subjectIdMeta,
          subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta));
    } else if (isInserting) {
      context.missing(_subjectIdMeta);
    }
    if (data.containsKey('class_id')) {
      context.handle(_classIdMeta,
          classId.isAcceptableOrUnknown(data['class_id']!, _classIdMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
          _unitMeta, unit.isAcceptableOrUnknown(data['unit']!, _unitMeta));
    }
    if (data.containsKey('lesson')) {
      context.handle(_lessonMeta,
          lesson.isAcceptableOrUnknown(data['lesson']!, _lessonMeta));
    }
    if (data.containsKey('difficulty')) {
      context.handle(
          _difficultyMeta,
          difficulty.isAcceptableOrUnknown(
              data['difficulty']!, _difficultyMeta));
    }
    if (data.containsKey('marks')) {
      context.handle(
          _marksMeta, marks.isAcceptableOrUnknown(data['marks']!, _marksMeta));
    }
    if (data.containsKey('correct_answer')) {
      context.handle(
          _correctAnswerMeta,
          correctAnswer.isAcceptableOrUnknown(
              data['correct_answer']!, _correctAnswerMeta));
    }
    if (data.containsKey('explanation')) {
      context.handle(
          _explanationMeta,
          explanation.isAcceptableOrUnknown(
              data['explanation']!, _explanationMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuestionBankItemModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestionBankItemModel(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      subjectId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}subject_id'])!,
      classId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}class_id']),
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      unit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit']),
      lesson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lesson']),
      difficulty: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}difficulty'])!,
      marks: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}marks'])!,
      correctAnswer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}correct_answer']),
      explanation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}explanation']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $QuestionBankItemsTable createAlias(String alias) {
    return $QuestionBankItemsTable(attachedDatabase, alias);
  }
}

class QuestionBankItemModel extends DataClass
    implements Insertable<QuestionBankItemModel> {
  final String id;
  final String subjectId;
  final String? classId;
  final String type;
  final String content;
  final String? unit;
  final String? lesson;
  final String difficulty;
  final double marks;
  final String? correctAnswer;
  final String? explanation;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const QuestionBankItemModel(
      {required this.id,
      required this.subjectId,
      this.classId,
      required this.type,
      required this.content,
      this.unit,
      this.lesson,
      required this.difficulty,
      required this.marks,
      this.correctAnswer,
      this.explanation,
      required this.isActive,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['subject_id'] = Variable<String>(subjectId);
    if (!nullToAbsent || classId != null) {
      map['class_id'] = Variable<String>(classId);
    }
    map['type'] = Variable<String>(type);
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || unit != null) {
      map['unit'] = Variable<String>(unit);
    }
    if (!nullToAbsent || lesson != null) {
      map['lesson'] = Variable<String>(lesson);
    }
    map['difficulty'] = Variable<String>(difficulty);
    map['marks'] = Variable<double>(marks);
    if (!nullToAbsent || correctAnswer != null) {
      map['correct_answer'] = Variable<String>(correctAnswer);
    }
    if (!nullToAbsent || explanation != null) {
      map['explanation'] = Variable<String>(explanation);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  QuestionBankItemsCompanion toCompanion(bool nullToAbsent) {
    return QuestionBankItemsCompanion(
      id: Value(id),
      subjectId: Value(subjectId),
      classId: classId == null && nullToAbsent
          ? const Value.absent()
          : Value(classId),
      type: Value(type),
      content: Value(content),
      unit: unit == null && nullToAbsent ? const Value.absent() : Value(unit),
      lesson:
          lesson == null && nullToAbsent ? const Value.absent() : Value(lesson),
      difficulty: Value(difficulty),
      marks: Value(marks),
      correctAnswer: correctAnswer == null && nullToAbsent
          ? const Value.absent()
          : Value(correctAnswer),
      explanation: explanation == null && nullToAbsent
          ? const Value.absent()
          : Value(explanation),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory QuestionBankItemModel.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuestionBankItemModel(
      id: serializer.fromJson<String>(json['id']),
      subjectId: serializer.fromJson<String>(json['subjectId']),
      classId: serializer.fromJson<String?>(json['classId']),
      type: serializer.fromJson<String>(json['type']),
      content: serializer.fromJson<String>(json['content']),
      unit: serializer.fromJson<String?>(json['unit']),
      lesson: serializer.fromJson<String?>(json['lesson']),
      difficulty: serializer.fromJson<String>(json['difficulty']),
      marks: serializer.fromJson<double>(json['marks']),
      correctAnswer: serializer.fromJson<String?>(json['correctAnswer']),
      explanation: serializer.fromJson<String?>(json['explanation']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'subjectId': serializer.toJson<String>(subjectId),
      'classId': serializer.toJson<String?>(classId),
      'type': serializer.toJson<String>(type),
      'content': serializer.toJson<String>(content),
      'unit': serializer.toJson<String?>(unit),
      'lesson': serializer.toJson<String?>(lesson),
      'difficulty': serializer.toJson<String>(difficulty),
      'marks': serializer.toJson<double>(marks),
      'correctAnswer': serializer.toJson<String?>(correctAnswer),
      'explanation': serializer.toJson<String?>(explanation),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  QuestionBankItemModel copyWith(
          {String? id,
          String? subjectId,
          Value<String?> classId = const Value.absent(),
          String? type,
          String? content,
          Value<String?> unit = const Value.absent(),
          Value<String?> lesson = const Value.absent(),
          String? difficulty,
          double? marks,
          Value<String?> correctAnswer = const Value.absent(),
          Value<String?> explanation = const Value.absent(),
          bool? isActive,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      QuestionBankItemModel(
        id: id ?? this.id,
        subjectId: subjectId ?? this.subjectId,
        classId: classId.present ? classId.value : this.classId,
        type: type ?? this.type,
        content: content ?? this.content,
        unit: unit.present ? unit.value : this.unit,
        lesson: lesson.present ? lesson.value : this.lesson,
        difficulty: difficulty ?? this.difficulty,
        marks: marks ?? this.marks,
        correctAnswer:
            correctAnswer.present ? correctAnswer.value : this.correctAnswer,
        explanation: explanation.present ? explanation.value : this.explanation,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  QuestionBankItemModel copyWithCompanion(QuestionBankItemsCompanion data) {
    return QuestionBankItemModel(
      id: data.id.present ? data.id.value : this.id,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      classId: data.classId.present ? data.classId.value : this.classId,
      type: data.type.present ? data.type.value : this.type,
      content: data.content.present ? data.content.value : this.content,
      unit: data.unit.present ? data.unit.value : this.unit,
      lesson: data.lesson.present ? data.lesson.value : this.lesson,
      difficulty:
          data.difficulty.present ? data.difficulty.value : this.difficulty,
      marks: data.marks.present ? data.marks.value : this.marks,
      correctAnswer: data.correctAnswer.present
          ? data.correctAnswer.value
          : this.correctAnswer,
      explanation:
          data.explanation.present ? data.explanation.value : this.explanation,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuestionBankItemModel(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('classId: $classId, ')
          ..write('type: $type, ')
          ..write('content: $content, ')
          ..write('unit: $unit, ')
          ..write('lesson: $lesson, ')
          ..write('difficulty: $difficulty, ')
          ..write('marks: $marks, ')
          ..write('correctAnswer: $correctAnswer, ')
          ..write('explanation: $explanation, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      subjectId,
      classId,
      type,
      content,
      unit,
      lesson,
      difficulty,
      marks,
      correctAnswer,
      explanation,
      isActive,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuestionBankItemModel &&
          other.id == this.id &&
          other.subjectId == this.subjectId &&
          other.classId == this.classId &&
          other.type == this.type &&
          other.content == this.content &&
          other.unit == this.unit &&
          other.lesson == this.lesson &&
          other.difficulty == this.difficulty &&
          other.marks == this.marks &&
          other.correctAnswer == this.correctAnswer &&
          other.explanation == this.explanation &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class QuestionBankItemsCompanion
    extends UpdateCompanion<QuestionBankItemModel> {
  final Value<String> id;
  final Value<String> subjectId;
  final Value<String?> classId;
  final Value<String> type;
  final Value<String> content;
  final Value<String?> unit;
  final Value<String?> lesson;
  final Value<String> difficulty;
  final Value<double> marks;
  final Value<String?> correctAnswer;
  final Value<String?> explanation;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const QuestionBankItemsCompanion({
    this.id = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.classId = const Value.absent(),
    this.type = const Value.absent(),
    this.content = const Value.absent(),
    this.unit = const Value.absent(),
    this.lesson = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.marks = const Value.absent(),
    this.correctAnswer = const Value.absent(),
    this.explanation = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuestionBankItemsCompanion.insert({
    required String id,
    required String subjectId,
    this.classId = const Value.absent(),
    required String type,
    required String content,
    this.unit = const Value.absent(),
    this.lesson = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.marks = const Value.absent(),
    this.correctAnswer = const Value.absent(),
    this.explanation = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        subjectId = Value(subjectId),
        type = Value(type),
        content = Value(content);
  static Insertable<QuestionBankItemModel> custom({
    Expression<String>? id,
    Expression<String>? subjectId,
    Expression<String>? classId,
    Expression<String>? type,
    Expression<String>? content,
    Expression<String>? unit,
    Expression<String>? lesson,
    Expression<String>? difficulty,
    Expression<double>? marks,
    Expression<String>? correctAnswer,
    Expression<String>? explanation,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (subjectId != null) 'subject_id': subjectId,
      if (classId != null) 'class_id': classId,
      if (type != null) 'type': type,
      if (content != null) 'content': content,
      if (unit != null) 'unit': unit,
      if (lesson != null) 'lesson': lesson,
      if (difficulty != null) 'difficulty': difficulty,
      if (marks != null) 'marks': marks,
      if (correctAnswer != null) 'correct_answer': correctAnswer,
      if (explanation != null) 'explanation': explanation,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuestionBankItemsCompanion copyWith(
      {Value<String>? id,
      Value<String>? subjectId,
      Value<String?>? classId,
      Value<String>? type,
      Value<String>? content,
      Value<String?>? unit,
      Value<String?>? lesson,
      Value<String>? difficulty,
      Value<double>? marks,
      Value<String?>? correctAnswer,
      Value<String?>? explanation,
      Value<bool>? isActive,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return QuestionBankItemsCompanion(
      id: id ?? this.id,
      subjectId: subjectId ?? this.subjectId,
      classId: classId ?? this.classId,
      type: type ?? this.type,
      content: content ?? this.content,
      unit: unit ?? this.unit,
      lesson: lesson ?? this.lesson,
      difficulty: difficulty ?? this.difficulty,
      marks: marks ?? this.marks,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      explanation: explanation ?? this.explanation,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<String>(subjectId.value);
    }
    if (classId.present) {
      map['class_id'] = Variable<String>(classId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (lesson.present) {
      map['lesson'] = Variable<String>(lesson.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (marks.present) {
      map['marks'] = Variable<double>(marks.value);
    }
    if (correctAnswer.present) {
      map['correct_answer'] = Variable<String>(correctAnswer.value);
    }
    if (explanation.present) {
      map['explanation'] = Variable<String>(explanation.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionBankItemsCompanion(')
          ..write('id: $id, ')
          ..write('subjectId: $subjectId, ')
          ..write('classId: $classId, ')
          ..write('type: $type, ')
          ..write('content: $content, ')
          ..write('unit: $unit, ')
          ..write('lesson: $lesson, ')
          ..write('difficulty: $difficulty, ')
          ..write('marks: $marks, ')
          ..write('correctAnswer: $correctAnswer, ')
          ..write('explanation: $explanation, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuestionsTable extends Questions
    with TableInfo<$QuestionsTable, QuestionModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _examIdMeta = const VerificationMeta('examId');
  @override
  late final GeneratedColumn<String> examId = GeneratedColumn<String>(
      'exam_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES exams (id)'));
  static const VerificationMeta _parentIdMeta =
      const VerificationMeta('parentId');
  @override
  late final GeneratedColumn<String> parentId = GeneratedColumn<String>(
      'parent_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES questions (id)'));
  static const VerificationMeta _questionBankIdMeta =
      const VerificationMeta('questionBankId');
  @override
  late final GeneratedColumn<String> questionBankId = GeneratedColumn<String>(
      'question_bank_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES question_bank_items (id)'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _instructionsMeta =
      const VerificationMeta('instructions');
  @override
  late final GeneratedColumn<String> instructions = GeneratedColumn<String>(
      'instructions', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _marksMeta = const VerificationMeta('marks');
  @override
  late final GeneratedColumn<double> marks = GeneratedColumn<double>(
      'marks', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
      'order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _difficultyMeta =
      const VerificationMeta('difficulty');
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
      'difficulty', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('medium'));
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
      'unit', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lessonMeta = const VerificationMeta('lesson');
  @override
  late final GeneratedColumn<String> lesson = GeneratedColumn<String>(
      'lesson', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _correctAnswerMeta =
      const VerificationMeta('correctAnswer');
  @override
  late final GeneratedColumn<String> correctAnswer = GeneratedColumn<String>(
      'correct_answer', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _explanationMeta =
      const VerificationMeta('explanation');
  @override
  late final GeneratedColumn<String> explanation = GeneratedColumn<String>(
      'explanation', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        examId,
        parentId,
        questionBankId,
        type,
        content,
        instructions,
        marks,
        order,
        difficulty,
        unit,
        lesson,
        correctAnswer,
        explanation,
        isActive,
        isDeleted,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'questions';
  @override
  VerificationContext validateIntegrity(Insertable<QuestionModel> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('exam_id')) {
      context.handle(_examIdMeta,
          examId.isAcceptableOrUnknown(data['exam_id']!, _examIdMeta));
    }
    if (data.containsKey('parent_id')) {
      context.handle(_parentIdMeta,
          parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta));
    }
    if (data.containsKey('question_bank_id')) {
      context.handle(
          _questionBankIdMeta,
          questionBankId.isAcceptableOrUnknown(
              data['question_bank_id']!, _questionBankIdMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('instructions')) {
      context.handle(
          _instructionsMeta,
          instructions.isAcceptableOrUnknown(
              data['instructions']!, _instructionsMeta));
    }
    if (data.containsKey('marks')) {
      context.handle(
          _marksMeta, marks.isAcceptableOrUnknown(data['marks']!, _marksMeta));
    }
    if (data.containsKey('order')) {
      context.handle(
          _orderMeta, order.isAcceptableOrUnknown(data['order']!, _orderMeta));
    }
    if (data.containsKey('difficulty')) {
      context.handle(
          _difficultyMeta,
          difficulty.isAcceptableOrUnknown(
              data['difficulty']!, _difficultyMeta));
    }
    if (data.containsKey('unit')) {
      context.handle(
          _unitMeta, unit.isAcceptableOrUnknown(data['unit']!, _unitMeta));
    }
    if (data.containsKey('lesson')) {
      context.handle(_lessonMeta,
          lesson.isAcceptableOrUnknown(data['lesson']!, _lessonMeta));
    }
    if (data.containsKey('correct_answer')) {
      context.handle(
          _correctAnswerMeta,
          correctAnswer.isAcceptableOrUnknown(
              data['correct_answer']!, _correctAnswerMeta));
    }
    if (data.containsKey('explanation')) {
      context.handle(
          _explanationMeta,
          explanation.isAcceptableOrUnknown(
              data['explanation']!, _explanationMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuestionModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestionModel(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      examId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}exam_id']),
      parentId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}parent_id']),
      questionBankId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}question_bank_id']),
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      instructions: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}instructions']),
      marks: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}marks'])!,
      order: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order'])!,
      difficulty: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}difficulty'])!,
      unit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit']),
      lesson: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lesson']),
      correctAnswer: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}correct_answer']),
      explanation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}explanation']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $QuestionsTable createAlias(String alias) {
    return $QuestionsTable(attachedDatabase, alias);
  }
}

class QuestionModel extends DataClass implements Insertable<QuestionModel> {
  final String id;
  final String? examId;
  final String? parentId;
  final String? questionBankId;
  final String type;
  final String content;
  final String? instructions;
  final double marks;
  final int order;
  final String difficulty;
  final String? unit;
  final String? lesson;
  final String? correctAnswer;
  final String? explanation;
  final bool isActive;
  final bool isDeleted;
  final DateTime createdAt;
  final DateTime? updatedAt;
  const QuestionModel(
      {required this.id,
      this.examId,
      this.parentId,
      this.questionBankId,
      required this.type,
      required this.content,
      this.instructions,
      required this.marks,
      required this.order,
      required this.difficulty,
      this.unit,
      this.lesson,
      this.correctAnswer,
      this.explanation,
      required this.isActive,
      required this.isDeleted,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || examId != null) {
      map['exam_id'] = Variable<String>(examId);
    }
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<String>(parentId);
    }
    if (!nullToAbsent || questionBankId != null) {
      map['question_bank_id'] = Variable<String>(questionBankId);
    }
    map['type'] = Variable<String>(type);
    map['content'] = Variable<String>(content);
    if (!nullToAbsent || instructions != null) {
      map['instructions'] = Variable<String>(instructions);
    }
    map['marks'] = Variable<double>(marks);
    map['order'] = Variable<int>(order);
    map['difficulty'] = Variable<String>(difficulty);
    if (!nullToAbsent || unit != null) {
      map['unit'] = Variable<String>(unit);
    }
    if (!nullToAbsent || lesson != null) {
      map['lesson'] = Variable<String>(lesson);
    }
    if (!nullToAbsent || correctAnswer != null) {
      map['correct_answer'] = Variable<String>(correctAnswer);
    }
    if (!nullToAbsent || explanation != null) {
      map['explanation'] = Variable<String>(explanation);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  QuestionsCompanion toCompanion(bool nullToAbsent) {
    return QuestionsCompanion(
      id: Value(id),
      examId:
          examId == null && nullToAbsent ? const Value.absent() : Value(examId),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      questionBankId: questionBankId == null && nullToAbsent
          ? const Value.absent()
          : Value(questionBankId),
      type: Value(type),
      content: Value(content),
      instructions: instructions == null && nullToAbsent
          ? const Value.absent()
          : Value(instructions),
      marks: Value(marks),
      order: Value(order),
      difficulty: Value(difficulty),
      unit: unit == null && nullToAbsent ? const Value.absent() : Value(unit),
      lesson:
          lesson == null && nullToAbsent ? const Value.absent() : Value(lesson),
      correctAnswer: correctAnswer == null && nullToAbsent
          ? const Value.absent()
          : Value(correctAnswer),
      explanation: explanation == null && nullToAbsent
          ? const Value.absent()
          : Value(explanation),
      isActive: Value(isActive),
      isDeleted: Value(isDeleted),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory QuestionModel.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuestionModel(
      id: serializer.fromJson<String>(json['id']),
      examId: serializer.fromJson<String?>(json['examId']),
      parentId: serializer.fromJson<String?>(json['parentId']),
      questionBankId: serializer.fromJson<String?>(json['questionBankId']),
      type: serializer.fromJson<String>(json['type']),
      content: serializer.fromJson<String>(json['content']),
      instructions: serializer.fromJson<String?>(json['instructions']),
      marks: serializer.fromJson<double>(json['marks']),
      order: serializer.fromJson<int>(json['order']),
      difficulty: serializer.fromJson<String>(json['difficulty']),
      unit: serializer.fromJson<String?>(json['unit']),
      lesson: serializer.fromJson<String?>(json['lesson']),
      correctAnswer: serializer.fromJson<String?>(json['correctAnswer']),
      explanation: serializer.fromJson<String?>(json['explanation']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'examId': serializer.toJson<String?>(examId),
      'parentId': serializer.toJson<String?>(parentId),
      'questionBankId': serializer.toJson<String?>(questionBankId),
      'type': serializer.toJson<String>(type),
      'content': serializer.toJson<String>(content),
      'instructions': serializer.toJson<String?>(instructions),
      'marks': serializer.toJson<double>(marks),
      'order': serializer.toJson<int>(order),
      'difficulty': serializer.toJson<String>(difficulty),
      'unit': serializer.toJson<String?>(unit),
      'lesson': serializer.toJson<String?>(lesson),
      'correctAnswer': serializer.toJson<String?>(correctAnswer),
      'explanation': serializer.toJson<String?>(explanation),
      'isActive': serializer.toJson<bool>(isActive),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  QuestionModel copyWith(
          {String? id,
          Value<String?> examId = const Value.absent(),
          Value<String?> parentId = const Value.absent(),
          Value<String?> questionBankId = const Value.absent(),
          String? type,
          String? content,
          Value<String?> instructions = const Value.absent(),
          double? marks,
          int? order,
          String? difficulty,
          Value<String?> unit = const Value.absent(),
          Value<String?> lesson = const Value.absent(),
          Value<String?> correctAnswer = const Value.absent(),
          Value<String?> explanation = const Value.absent(),
          bool? isActive,
          bool? isDeleted,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      QuestionModel(
        id: id ?? this.id,
        examId: examId.present ? examId.value : this.examId,
        parentId: parentId.present ? parentId.value : this.parentId,
        questionBankId:
            questionBankId.present ? questionBankId.value : this.questionBankId,
        type: type ?? this.type,
        content: content ?? this.content,
        instructions:
            instructions.present ? instructions.value : this.instructions,
        marks: marks ?? this.marks,
        order: order ?? this.order,
        difficulty: difficulty ?? this.difficulty,
        unit: unit.present ? unit.value : this.unit,
        lesson: lesson.present ? lesson.value : this.lesson,
        correctAnswer:
            correctAnswer.present ? correctAnswer.value : this.correctAnswer,
        explanation: explanation.present ? explanation.value : this.explanation,
        isActive: isActive ?? this.isActive,
        isDeleted: isDeleted ?? this.isDeleted,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  QuestionModel copyWithCompanion(QuestionsCompanion data) {
    return QuestionModel(
      id: data.id.present ? data.id.value : this.id,
      examId: data.examId.present ? data.examId.value : this.examId,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      questionBankId: data.questionBankId.present
          ? data.questionBankId.value
          : this.questionBankId,
      type: data.type.present ? data.type.value : this.type,
      content: data.content.present ? data.content.value : this.content,
      instructions: data.instructions.present
          ? data.instructions.value
          : this.instructions,
      marks: data.marks.present ? data.marks.value : this.marks,
      order: data.order.present ? data.order.value : this.order,
      difficulty:
          data.difficulty.present ? data.difficulty.value : this.difficulty,
      unit: data.unit.present ? data.unit.value : this.unit,
      lesson: data.lesson.present ? data.lesson.value : this.lesson,
      correctAnswer: data.correctAnswer.present
          ? data.correctAnswer.value
          : this.correctAnswer,
      explanation:
          data.explanation.present ? data.explanation.value : this.explanation,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuestionModel(')
          ..write('id: $id, ')
          ..write('examId: $examId, ')
          ..write('parentId: $parentId, ')
          ..write('questionBankId: $questionBankId, ')
          ..write('type: $type, ')
          ..write('content: $content, ')
          ..write('instructions: $instructions, ')
          ..write('marks: $marks, ')
          ..write('order: $order, ')
          ..write('difficulty: $difficulty, ')
          ..write('unit: $unit, ')
          ..write('lesson: $lesson, ')
          ..write('correctAnswer: $correctAnswer, ')
          ..write('explanation: $explanation, ')
          ..write('isActive: $isActive, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      examId,
      parentId,
      questionBankId,
      type,
      content,
      instructions,
      marks,
      order,
      difficulty,
      unit,
      lesson,
      correctAnswer,
      explanation,
      isActive,
      isDeleted,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuestionModel &&
          other.id == this.id &&
          other.examId == this.examId &&
          other.parentId == this.parentId &&
          other.questionBankId == this.questionBankId &&
          other.type == this.type &&
          other.content == this.content &&
          other.instructions == this.instructions &&
          other.marks == this.marks &&
          other.order == this.order &&
          other.difficulty == this.difficulty &&
          other.unit == this.unit &&
          other.lesson == this.lesson &&
          other.correctAnswer == this.correctAnswer &&
          other.explanation == this.explanation &&
          other.isActive == this.isActive &&
          other.isDeleted == this.isDeleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class QuestionsCompanion extends UpdateCompanion<QuestionModel> {
  final Value<String> id;
  final Value<String?> examId;
  final Value<String?> parentId;
  final Value<String?> questionBankId;
  final Value<String> type;
  final Value<String> content;
  final Value<String?> instructions;
  final Value<double> marks;
  final Value<int> order;
  final Value<String> difficulty;
  final Value<String?> unit;
  final Value<String?> lesson;
  final Value<String?> correctAnswer;
  final Value<String?> explanation;
  final Value<bool> isActive;
  final Value<bool> isDeleted;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const QuestionsCompanion({
    this.id = const Value.absent(),
    this.examId = const Value.absent(),
    this.parentId = const Value.absent(),
    this.questionBankId = const Value.absent(),
    this.type = const Value.absent(),
    this.content = const Value.absent(),
    this.instructions = const Value.absent(),
    this.marks = const Value.absent(),
    this.order = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.unit = const Value.absent(),
    this.lesson = const Value.absent(),
    this.correctAnswer = const Value.absent(),
    this.explanation = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuestionsCompanion.insert({
    required String id,
    this.examId = const Value.absent(),
    this.parentId = const Value.absent(),
    this.questionBankId = const Value.absent(),
    required String type,
    required String content,
    this.instructions = const Value.absent(),
    this.marks = const Value.absent(),
    this.order = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.unit = const Value.absent(),
    this.lesson = const Value.absent(),
    this.correctAnswer = const Value.absent(),
    this.explanation = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        type = Value(type),
        content = Value(content);
  static Insertable<QuestionModel> custom({
    Expression<String>? id,
    Expression<String>? examId,
    Expression<String>? parentId,
    Expression<String>? questionBankId,
    Expression<String>? type,
    Expression<String>? content,
    Expression<String>? instructions,
    Expression<double>? marks,
    Expression<int>? order,
    Expression<String>? difficulty,
    Expression<String>? unit,
    Expression<String>? lesson,
    Expression<String>? correctAnswer,
    Expression<String>? explanation,
    Expression<bool>? isActive,
    Expression<bool>? isDeleted,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (examId != null) 'exam_id': examId,
      if (parentId != null) 'parent_id': parentId,
      if (questionBankId != null) 'question_bank_id': questionBankId,
      if (type != null) 'type': type,
      if (content != null) 'content': content,
      if (instructions != null) 'instructions': instructions,
      if (marks != null) 'marks': marks,
      if (order != null) 'order': order,
      if (difficulty != null) 'difficulty': difficulty,
      if (unit != null) 'unit': unit,
      if (lesson != null) 'lesson': lesson,
      if (correctAnswer != null) 'correct_answer': correctAnswer,
      if (explanation != null) 'explanation': explanation,
      if (isActive != null) 'is_active': isActive,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuestionsCompanion copyWith(
      {Value<String>? id,
      Value<String?>? examId,
      Value<String?>? parentId,
      Value<String?>? questionBankId,
      Value<String>? type,
      Value<String>? content,
      Value<String?>? instructions,
      Value<double>? marks,
      Value<int>? order,
      Value<String>? difficulty,
      Value<String?>? unit,
      Value<String?>? lesson,
      Value<String?>? correctAnswer,
      Value<String?>? explanation,
      Value<bool>? isActive,
      Value<bool>? isDeleted,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return QuestionsCompanion(
      id: id ?? this.id,
      examId: examId ?? this.examId,
      parentId: parentId ?? this.parentId,
      questionBankId: questionBankId ?? this.questionBankId,
      type: type ?? this.type,
      content: content ?? this.content,
      instructions: instructions ?? this.instructions,
      marks: marks ?? this.marks,
      order: order ?? this.order,
      difficulty: difficulty ?? this.difficulty,
      unit: unit ?? this.unit,
      lesson: lesson ?? this.lesson,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      explanation: explanation ?? this.explanation,
      isActive: isActive ?? this.isActive,
      isDeleted: isDeleted ?? this.isDeleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (examId.present) {
      map['exam_id'] = Variable<String>(examId.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<String>(parentId.value);
    }
    if (questionBankId.present) {
      map['question_bank_id'] = Variable<String>(questionBankId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (instructions.present) {
      map['instructions'] = Variable<String>(instructions.value);
    }
    if (marks.present) {
      map['marks'] = Variable<double>(marks.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (lesson.present) {
      map['lesson'] = Variable<String>(lesson.value);
    }
    if (correctAnswer.present) {
      map['correct_answer'] = Variable<String>(correctAnswer.value);
    }
    if (explanation.present) {
      map['explanation'] = Variable<String>(explanation.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionsCompanion(')
          ..write('id: $id, ')
          ..write('examId: $examId, ')
          ..write('parentId: $parentId, ')
          ..write('questionBankId: $questionBankId, ')
          ..write('type: $type, ')
          ..write('content: $content, ')
          ..write('instructions: $instructions, ')
          ..write('marks: $marks, ')
          ..write('order: $order, ')
          ..write('difficulty: $difficulty, ')
          ..write('unit: $unit, ')
          ..write('lesson: $lesson, ')
          ..write('correctAnswer: $correctAnswer, ')
          ..write('explanation: $explanation, ')
          ..write('isActive: $isActive, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuestionBlocksTable extends QuestionBlocks
    with TableInfo<$QuestionBlocksTable, QuestionBlockModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionBlocksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _questionIdMeta =
      const VerificationMeta('questionId');
  @override
  late final GeneratedColumn<String> questionId = GeneratedColumn<String>(
      'question_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES questions (id)'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
      'order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _metadataMeta =
      const VerificationMeta('metadata');
  @override
  late final GeneratedColumn<String> metadata = GeneratedColumn<String>(
      'metadata', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, questionId, type, content, order, metadata];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'question_blocks';
  @override
  VerificationContext validateIntegrity(Insertable<QuestionBlockModel> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('question_id')) {
      context.handle(
          _questionIdMeta,
          questionId.isAcceptableOrUnknown(
              data['question_id']!, _questionIdMeta));
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
          _orderMeta, order.isAcceptableOrUnknown(data['order']!, _orderMeta));
    }
    if (data.containsKey('metadata')) {
      context.handle(_metadataMeta,
          metadata.isAcceptableOrUnknown(data['metadata']!, _metadataMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuestionBlockModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestionBlockModel(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      questionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}question_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      order: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order'])!,
      metadata: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}metadata']),
    );
  }

  @override
  $QuestionBlocksTable createAlias(String alias) {
    return $QuestionBlocksTable(attachedDatabase, alias);
  }
}

class QuestionBlockModel extends DataClass
    implements Insertable<QuestionBlockModel> {
  final String id;
  final String questionId;
  final String type;
  final String content;
  final int order;
  final String? metadata;
  const QuestionBlockModel(
      {required this.id,
      required this.questionId,
      required this.type,
      required this.content,
      required this.order,
      this.metadata});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['question_id'] = Variable<String>(questionId);
    map['type'] = Variable<String>(type);
    map['content'] = Variable<String>(content);
    map['order'] = Variable<int>(order);
    if (!nullToAbsent || metadata != null) {
      map['metadata'] = Variable<String>(metadata);
    }
    return map;
  }

  QuestionBlocksCompanion toCompanion(bool nullToAbsent) {
    return QuestionBlocksCompanion(
      id: Value(id),
      questionId: Value(questionId),
      type: Value(type),
      content: Value(content),
      order: Value(order),
      metadata: metadata == null && nullToAbsent
          ? const Value.absent()
          : Value(metadata),
    );
  }

  factory QuestionBlockModel.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuestionBlockModel(
      id: serializer.fromJson<String>(json['id']),
      questionId: serializer.fromJson<String>(json['questionId']),
      type: serializer.fromJson<String>(json['type']),
      content: serializer.fromJson<String>(json['content']),
      order: serializer.fromJson<int>(json['order']),
      metadata: serializer.fromJson<String?>(json['metadata']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'questionId': serializer.toJson<String>(questionId),
      'type': serializer.toJson<String>(type),
      'content': serializer.toJson<String>(content),
      'order': serializer.toJson<int>(order),
      'metadata': serializer.toJson<String?>(metadata),
    };
  }

  QuestionBlockModel copyWith(
          {String? id,
          String? questionId,
          String? type,
          String? content,
          int? order,
          Value<String?> metadata = const Value.absent()}) =>
      QuestionBlockModel(
        id: id ?? this.id,
        questionId: questionId ?? this.questionId,
        type: type ?? this.type,
        content: content ?? this.content,
        order: order ?? this.order,
        metadata: metadata.present ? metadata.value : this.metadata,
      );
  QuestionBlockModel copyWithCompanion(QuestionBlocksCompanion data) {
    return QuestionBlockModel(
      id: data.id.present ? data.id.value : this.id,
      questionId:
          data.questionId.present ? data.questionId.value : this.questionId,
      type: data.type.present ? data.type.value : this.type,
      content: data.content.present ? data.content.value : this.content,
      order: data.order.present ? data.order.value : this.order,
      metadata: data.metadata.present ? data.metadata.value : this.metadata,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuestionBlockModel(')
          ..write('id: $id, ')
          ..write('questionId: $questionId, ')
          ..write('type: $type, ')
          ..write('content: $content, ')
          ..write('order: $order, ')
          ..write('metadata: $metadata')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, questionId, type, content, order, metadata);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuestionBlockModel &&
          other.id == this.id &&
          other.questionId == this.questionId &&
          other.type == this.type &&
          other.content == this.content &&
          other.order == this.order &&
          other.metadata == this.metadata);
}

class QuestionBlocksCompanion extends UpdateCompanion<QuestionBlockModel> {
  final Value<String> id;
  final Value<String> questionId;
  final Value<String> type;
  final Value<String> content;
  final Value<int> order;
  final Value<String?> metadata;
  final Value<int> rowid;
  const QuestionBlocksCompanion({
    this.id = const Value.absent(),
    this.questionId = const Value.absent(),
    this.type = const Value.absent(),
    this.content = const Value.absent(),
    this.order = const Value.absent(),
    this.metadata = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuestionBlocksCompanion.insert({
    required String id,
    required String questionId,
    required String type,
    required String content,
    this.order = const Value.absent(),
    this.metadata = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        questionId = Value(questionId),
        type = Value(type),
        content = Value(content);
  static Insertable<QuestionBlockModel> custom({
    Expression<String>? id,
    Expression<String>? questionId,
    Expression<String>? type,
    Expression<String>? content,
    Expression<int>? order,
    Expression<String>? metadata,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (questionId != null) 'question_id': questionId,
      if (type != null) 'type': type,
      if (content != null) 'content': content,
      if (order != null) 'order': order,
      if (metadata != null) 'metadata': metadata,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuestionBlocksCompanion copyWith(
      {Value<String>? id,
      Value<String>? questionId,
      Value<String>? type,
      Value<String>? content,
      Value<int>? order,
      Value<String?>? metadata,
      Value<int>? rowid}) {
    return QuestionBlocksCompanion(
      id: id ?? this.id,
      questionId: questionId ?? this.questionId,
      type: type ?? this.type,
      content: content ?? this.content,
      order: order ?? this.order,
      metadata: metadata ?? this.metadata,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (questionId.present) {
      map['question_id'] = Variable<String>(questionId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (metadata.present) {
      map['metadata'] = Variable<String>(metadata.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionBlocksCompanion(')
          ..write('id: $id, ')
          ..write('questionId: $questionId, ')
          ..write('type: $type, ')
          ..write('content: $content, ')
          ..write('order: $order, ')
          ..write('metadata: $metadata, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuestionOptionsTable extends QuestionOptions
    with TableInfo<$QuestionOptionsTable, QuestionOptionModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuestionOptionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _questionIdMeta =
      const VerificationMeta('questionId');
  @override
  late final GeneratedColumn<String> questionId = GeneratedColumn<String>(
      'question_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES questions (id)'));
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
      'order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _isCorrectMeta =
      const VerificationMeta('isCorrect');
  @override
  late final GeneratedColumn<bool> isCorrect = GeneratedColumn<bool>(
      'is_correct', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_correct" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns =>
      [id, questionId, content, order, isCorrect];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'question_options';
  @override
  VerificationContext validateIntegrity(
      Insertable<QuestionOptionModel> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('question_id')) {
      context.handle(
          _questionIdMeta,
          questionId.isAcceptableOrUnknown(
              data['question_id']!, _questionIdMeta));
    } else if (isInserting) {
      context.missing(_questionIdMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
          _orderMeta, order.isAcceptableOrUnknown(data['order']!, _orderMeta));
    }
    if (data.containsKey('is_correct')) {
      context.handle(_isCorrectMeta,
          isCorrect.isAcceptableOrUnknown(data['is_correct']!, _isCorrectMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuestionOptionModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuestionOptionModel(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      questionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}question_id'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content'])!,
      order: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order'])!,
      isCorrect: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_correct'])!,
    );
  }

  @override
  $QuestionOptionsTable createAlias(String alias) {
    return $QuestionOptionsTable(attachedDatabase, alias);
  }
}

class QuestionOptionModel extends DataClass
    implements Insertable<QuestionOptionModel> {
  final String id;
  final String questionId;
  final String content;
  final int order;
  final bool isCorrect;
  const QuestionOptionModel(
      {required this.id,
      required this.questionId,
      required this.content,
      required this.order,
      required this.isCorrect});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['question_id'] = Variable<String>(questionId);
    map['content'] = Variable<String>(content);
    map['order'] = Variable<int>(order);
    map['is_correct'] = Variable<bool>(isCorrect);
    return map;
  }

  QuestionOptionsCompanion toCompanion(bool nullToAbsent) {
    return QuestionOptionsCompanion(
      id: Value(id),
      questionId: Value(questionId),
      content: Value(content),
      order: Value(order),
      isCorrect: Value(isCorrect),
    );
  }

  factory QuestionOptionModel.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuestionOptionModel(
      id: serializer.fromJson<String>(json['id']),
      questionId: serializer.fromJson<String>(json['questionId']),
      content: serializer.fromJson<String>(json['content']),
      order: serializer.fromJson<int>(json['order']),
      isCorrect: serializer.fromJson<bool>(json['isCorrect']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'questionId': serializer.toJson<String>(questionId),
      'content': serializer.toJson<String>(content),
      'order': serializer.toJson<int>(order),
      'isCorrect': serializer.toJson<bool>(isCorrect),
    };
  }

  QuestionOptionModel copyWith(
          {String? id,
          String? questionId,
          String? content,
          int? order,
          bool? isCorrect}) =>
      QuestionOptionModel(
        id: id ?? this.id,
        questionId: questionId ?? this.questionId,
        content: content ?? this.content,
        order: order ?? this.order,
        isCorrect: isCorrect ?? this.isCorrect,
      );
  QuestionOptionModel copyWithCompanion(QuestionOptionsCompanion data) {
    return QuestionOptionModel(
      id: data.id.present ? data.id.value : this.id,
      questionId:
          data.questionId.present ? data.questionId.value : this.questionId,
      content: data.content.present ? data.content.value : this.content,
      order: data.order.present ? data.order.value : this.order,
      isCorrect: data.isCorrect.present ? data.isCorrect.value : this.isCorrect,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuestionOptionModel(')
          ..write('id: $id, ')
          ..write('questionId: $questionId, ')
          ..write('content: $content, ')
          ..write('order: $order, ')
          ..write('isCorrect: $isCorrect')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, questionId, content, order, isCorrect);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuestionOptionModel &&
          other.id == this.id &&
          other.questionId == this.questionId &&
          other.content == this.content &&
          other.order == this.order &&
          other.isCorrect == this.isCorrect);
}

class QuestionOptionsCompanion extends UpdateCompanion<QuestionOptionModel> {
  final Value<String> id;
  final Value<String> questionId;
  final Value<String> content;
  final Value<int> order;
  final Value<bool> isCorrect;
  final Value<int> rowid;
  const QuestionOptionsCompanion({
    this.id = const Value.absent(),
    this.questionId = const Value.absent(),
    this.content = const Value.absent(),
    this.order = const Value.absent(),
    this.isCorrect = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuestionOptionsCompanion.insert({
    required String id,
    required String questionId,
    required String content,
    this.order = const Value.absent(),
    this.isCorrect = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        questionId = Value(questionId),
        content = Value(content);
  static Insertable<QuestionOptionModel> custom({
    Expression<String>? id,
    Expression<String>? questionId,
    Expression<String>? content,
    Expression<int>? order,
    Expression<bool>? isCorrect,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (questionId != null) 'question_id': questionId,
      if (content != null) 'content': content,
      if (order != null) 'order': order,
      if (isCorrect != null) 'is_correct': isCorrect,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuestionOptionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? questionId,
      Value<String>? content,
      Value<int>? order,
      Value<bool>? isCorrect,
      Value<int>? rowid}) {
    return QuestionOptionsCompanion(
      id: id ?? this.id,
      questionId: questionId ?? this.questionId,
      content: content ?? this.content,
      order: order ?? this.order,
      isCorrect: isCorrect ?? this.isCorrect,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (questionId.present) {
      map['question_id'] = Variable<String>(questionId.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (isCorrect.present) {
      map['is_correct'] = Variable<bool>(isCorrect.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuestionOptionsCompanion(')
          ..write('id: $id, ')
          ..write('questionId: $questionId, ')
          ..write('content: $content, ')
          ..write('order: $order, ')
          ..write('isCorrect: $isCorrect, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExamGradesTable extends ExamGrades
    with TableInfo<$ExamGradesTable, ExamGradeModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExamGradesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _examIdMeta = const VerificationMeta('examId');
  @override
  late final GeneratedColumn<String> examId = GeneratedColumn<String>(
      'exam_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES exams (id)'));
  static const VerificationMeta _studentIdMeta =
      const VerificationMeta('studentId');
  @override
  late final GeneratedColumn<String> studentId = GeneratedColumn<String>(
      'student_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES students (id)'));
  static const VerificationMeta _scoreMeta = const VerificationMeta('score');
  @override
  late final GeneratedColumn<double> score = GeneratedColumn<double>(
      'score', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _gradeMeta = const VerificationMeta('grade');
  @override
  late final GeneratedColumn<String> grade = GeneratedColumn<String>(
      'grade', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isAbsentMeta =
      const VerificationMeta('isAbsent');
  @override
  late final GeneratedColumn<bool> isAbsent = GeneratedColumn<bool>(
      'is_absent', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_absent" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _gradedAtMeta =
      const VerificationMeta('gradedAt');
  @override
  late final GeneratedColumn<DateTime> gradedAt = GeneratedColumn<DateTime>(
      'graded_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        examId,
        studentId,
        score,
        grade,
        notes,
        isAbsent,
        gradedAt,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exam_grades';
  @override
  VerificationContext validateIntegrity(Insertable<ExamGradeModel> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('exam_id')) {
      context.handle(_examIdMeta,
          examId.isAcceptableOrUnknown(data['exam_id']!, _examIdMeta));
    } else if (isInserting) {
      context.missing(_examIdMeta);
    }
    if (data.containsKey('student_id')) {
      context.handle(_studentIdMeta,
          studentId.isAcceptableOrUnknown(data['student_id']!, _studentIdMeta));
    } else if (isInserting) {
      context.missing(_studentIdMeta);
    }
    if (data.containsKey('score')) {
      context.handle(
          _scoreMeta, score.isAcceptableOrUnknown(data['score']!, _scoreMeta));
    }
    if (data.containsKey('grade')) {
      context.handle(
          _gradeMeta, grade.isAcceptableOrUnknown(data['grade']!, _gradeMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('is_absent')) {
      context.handle(_isAbsentMeta,
          isAbsent.isAcceptableOrUnknown(data['is_absent']!, _isAbsentMeta));
    }
    if (data.containsKey('graded_at')) {
      context.handle(_gradedAtMeta,
          gradedAt.isAcceptableOrUnknown(data['graded_at']!, _gradedAtMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExamGradeModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExamGradeModel(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      examId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}exam_id'])!,
      studentId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}student_id'])!,
      score: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}score'])!,
      grade: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}grade']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      isAbsent: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_absent'])!,
      gradedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}graded_at']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ExamGradesTable createAlias(String alias) {
    return $ExamGradesTable(attachedDatabase, alias);
  }
}

class ExamGradeModel extends DataClass implements Insertable<ExamGradeModel> {
  final String id;
  final String examId;
  final String studentId;
  final double score;
  final String? grade;
  final String? notes;
  final bool isAbsent;
  final DateTime? gradedAt;
  final DateTime createdAt;
  const ExamGradeModel(
      {required this.id,
      required this.examId,
      required this.studentId,
      required this.score,
      this.grade,
      this.notes,
      required this.isAbsent,
      this.gradedAt,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['exam_id'] = Variable<String>(examId);
    map['student_id'] = Variable<String>(studentId);
    map['score'] = Variable<double>(score);
    if (!nullToAbsent || grade != null) {
      map['grade'] = Variable<String>(grade);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_absent'] = Variable<bool>(isAbsent);
    if (!nullToAbsent || gradedAt != null) {
      map['graded_at'] = Variable<DateTime>(gradedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ExamGradesCompanion toCompanion(bool nullToAbsent) {
    return ExamGradesCompanion(
      id: Value(id),
      examId: Value(examId),
      studentId: Value(studentId),
      score: Value(score),
      grade:
          grade == null && nullToAbsent ? const Value.absent() : Value(grade),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      isAbsent: Value(isAbsent),
      gradedAt: gradedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(gradedAt),
      createdAt: Value(createdAt),
    );
  }

  factory ExamGradeModel.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExamGradeModel(
      id: serializer.fromJson<String>(json['id']),
      examId: serializer.fromJson<String>(json['examId']),
      studentId: serializer.fromJson<String>(json['studentId']),
      score: serializer.fromJson<double>(json['score']),
      grade: serializer.fromJson<String?>(json['grade']),
      notes: serializer.fromJson<String?>(json['notes']),
      isAbsent: serializer.fromJson<bool>(json['isAbsent']),
      gradedAt: serializer.fromJson<DateTime?>(json['gradedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'examId': serializer.toJson<String>(examId),
      'studentId': serializer.toJson<String>(studentId),
      'score': serializer.toJson<double>(score),
      'grade': serializer.toJson<String?>(grade),
      'notes': serializer.toJson<String?>(notes),
      'isAbsent': serializer.toJson<bool>(isAbsent),
      'gradedAt': serializer.toJson<DateTime?>(gradedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ExamGradeModel copyWith(
          {String? id,
          String? examId,
          String? studentId,
          double? score,
          Value<String?> grade = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          bool? isAbsent,
          Value<DateTime?> gradedAt = const Value.absent(),
          DateTime? createdAt}) =>
      ExamGradeModel(
        id: id ?? this.id,
        examId: examId ?? this.examId,
        studentId: studentId ?? this.studentId,
        score: score ?? this.score,
        grade: grade.present ? grade.value : this.grade,
        notes: notes.present ? notes.value : this.notes,
        isAbsent: isAbsent ?? this.isAbsent,
        gradedAt: gradedAt.present ? gradedAt.value : this.gradedAt,
        createdAt: createdAt ?? this.createdAt,
      );
  ExamGradeModel copyWithCompanion(ExamGradesCompanion data) {
    return ExamGradeModel(
      id: data.id.present ? data.id.value : this.id,
      examId: data.examId.present ? data.examId.value : this.examId,
      studentId: data.studentId.present ? data.studentId.value : this.studentId,
      score: data.score.present ? data.score.value : this.score,
      grade: data.grade.present ? data.grade.value : this.grade,
      notes: data.notes.present ? data.notes.value : this.notes,
      isAbsent: data.isAbsent.present ? data.isAbsent.value : this.isAbsent,
      gradedAt: data.gradedAt.present ? data.gradedAt.value : this.gradedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExamGradeModel(')
          ..write('id: $id, ')
          ..write('examId: $examId, ')
          ..write('studentId: $studentId, ')
          ..write('score: $score, ')
          ..write('grade: $grade, ')
          ..write('notes: $notes, ')
          ..write('isAbsent: $isAbsent, ')
          ..write('gradedAt: $gradedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, examId, studentId, score, grade, notes,
      isAbsent, gradedAt, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExamGradeModel &&
          other.id == this.id &&
          other.examId == this.examId &&
          other.studentId == this.studentId &&
          other.score == this.score &&
          other.grade == this.grade &&
          other.notes == this.notes &&
          other.isAbsent == this.isAbsent &&
          other.gradedAt == this.gradedAt &&
          other.createdAt == this.createdAt);
}

class ExamGradesCompanion extends UpdateCompanion<ExamGradeModel> {
  final Value<String> id;
  final Value<String> examId;
  final Value<String> studentId;
  final Value<double> score;
  final Value<String?> grade;
  final Value<String?> notes;
  final Value<bool> isAbsent;
  final Value<DateTime?> gradedAt;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ExamGradesCompanion({
    this.id = const Value.absent(),
    this.examId = const Value.absent(),
    this.studentId = const Value.absent(),
    this.score = const Value.absent(),
    this.grade = const Value.absent(),
    this.notes = const Value.absent(),
    this.isAbsent = const Value.absent(),
    this.gradedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExamGradesCompanion.insert({
    required String id,
    required String examId,
    required String studentId,
    this.score = const Value.absent(),
    this.grade = const Value.absent(),
    this.notes = const Value.absent(),
    this.isAbsent = const Value.absent(),
    this.gradedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        examId = Value(examId),
        studentId = Value(studentId);
  static Insertable<ExamGradeModel> custom({
    Expression<String>? id,
    Expression<String>? examId,
    Expression<String>? studentId,
    Expression<double>? score,
    Expression<String>? grade,
    Expression<String>? notes,
    Expression<bool>? isAbsent,
    Expression<DateTime>? gradedAt,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (examId != null) 'exam_id': examId,
      if (studentId != null) 'student_id': studentId,
      if (score != null) 'score': score,
      if (grade != null) 'grade': grade,
      if (notes != null) 'notes': notes,
      if (isAbsent != null) 'is_absent': isAbsent,
      if (gradedAt != null) 'graded_at': gradedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExamGradesCompanion copyWith(
      {Value<String>? id,
      Value<String>? examId,
      Value<String>? studentId,
      Value<double>? score,
      Value<String?>? grade,
      Value<String?>? notes,
      Value<bool>? isAbsent,
      Value<DateTime?>? gradedAt,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return ExamGradesCompanion(
      id: id ?? this.id,
      examId: examId ?? this.examId,
      studentId: studentId ?? this.studentId,
      score: score ?? this.score,
      grade: grade ?? this.grade,
      notes: notes ?? this.notes,
      isAbsent: isAbsent ?? this.isAbsent,
      gradedAt: gradedAt ?? this.gradedAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (examId.present) {
      map['exam_id'] = Variable<String>(examId.value);
    }
    if (studentId.present) {
      map['student_id'] = Variable<String>(studentId.value);
    }
    if (score.present) {
      map['score'] = Variable<double>(score.value);
    }
    if (grade.present) {
      map['grade'] = Variable<String>(grade.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isAbsent.present) {
      map['is_absent'] = Variable<bool>(isAbsent.value);
    }
    if (gradedAt.present) {
      map['graded_at'] = Variable<DateTime>(gradedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExamGradesCompanion(')
          ..write('id: $id, ')
          ..write('examId: $examId, ')
          ..write('studentId: $studentId, ')
          ..write('score: $score, ')
          ..write('grade: $grade, ')
          ..write('notes: $notes, ')
          ..write('isAbsent: $isAbsent, ')
          ..write('gradedAt: $gradedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExamTemplatesTable extends ExamTemplates
    with TableInfo<$ExamTemplatesTable, ExamTemplateModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExamTemplatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _schoolIdMeta =
      const VerificationMeta('schoolId');
  @override
  late final GeneratedColumn<String> schoolId = GeneratedColumn<String>(
      'school_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES schools (id)'));
  static const VerificationMeta _classIdMeta =
      const VerificationMeta('classId');
  @override
  late final GeneratedColumn<String> classId = GeneratedColumn<String>(
      'class_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES classes (id)'));
  static const VerificationMeta _subjectIdMeta =
      const VerificationMeta('subjectId');
  @override
  late final GeneratedColumn<String> subjectId = GeneratedColumn<String>(
      'subject_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES subjects (id)'));
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _durationMeta =
      const VerificationMeta('duration');
  @override
  late final GeneratedColumn<int> duration = GeneratedColumn<int>(
      'duration', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _totalMarksMeta =
      const VerificationMeta('totalMarks');
  @override
  late final GeneratedColumn<double> totalMarks = GeneratedColumn<double>(
      'total_marks', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _structureMeta =
      const VerificationMeta('structure');
  @override
  late final GeneratedColumn<String> structure = GeneratedColumn<String>(
      'structure', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _settingsMeta =
      const VerificationMeta('settings');
  @override
  late final GeneratedColumn<String> settings = GeneratedColumn<String>(
      'settings', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isDefaultMeta =
      const VerificationMeta('isDefault');
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
      'is_default', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_default" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        schoolId,
        classId,
        subjectId,
        type,
        duration,
        totalMarks,
        structure,
        settings,
        isDefault,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exam_templates';
  @override
  VerificationContext validateIntegrity(Insertable<ExamTemplateModel> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('school_id')) {
      context.handle(_schoolIdMeta,
          schoolId.isAcceptableOrUnknown(data['school_id']!, _schoolIdMeta));
    }
    if (data.containsKey('class_id')) {
      context.handle(_classIdMeta,
          classId.isAcceptableOrUnknown(data['class_id']!, _classIdMeta));
    }
    if (data.containsKey('subject_id')) {
      context.handle(_subjectIdMeta,
          subjectId.isAcceptableOrUnknown(data['subject_id']!, _subjectIdMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('duration')) {
      context.handle(_durationMeta,
          duration.isAcceptableOrUnknown(data['duration']!, _durationMeta));
    }
    if (data.containsKey('total_marks')) {
      context.handle(
          _totalMarksMeta,
          totalMarks.isAcceptableOrUnknown(
              data['total_marks']!, _totalMarksMeta));
    }
    if (data.containsKey('structure')) {
      context.handle(_structureMeta,
          structure.isAcceptableOrUnknown(data['structure']!, _structureMeta));
    }
    if (data.containsKey('settings')) {
      context.handle(_settingsMeta,
          settings.isAcceptableOrUnknown(data['settings']!, _settingsMeta));
    }
    if (data.containsKey('is_default')) {
      context.handle(_isDefaultMeta,
          isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExamTemplateModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExamTemplateModel(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      schoolId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}school_id']),
      classId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}class_id']),
      subjectId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}subject_id']),
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type']),
      duration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration']),
      totalMarks: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_marks']),
      structure: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}structure']),
      settings: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}settings']),
      isDefault: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_default'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ExamTemplatesTable createAlias(String alias) {
    return $ExamTemplatesTable(attachedDatabase, alias);
  }
}

class ExamTemplateModel extends DataClass
    implements Insertable<ExamTemplateModel> {
  final String id;
  final String name;
  final String? schoolId;
  final String? classId;
  final String? subjectId;
  final String? type;
  final int? duration;
  final double? totalMarks;
  final String? structure;
  final String? settings;
  final bool isDefault;
  final DateTime createdAt;
  const ExamTemplateModel(
      {required this.id,
      required this.name,
      this.schoolId,
      this.classId,
      this.subjectId,
      this.type,
      this.duration,
      this.totalMarks,
      this.structure,
      this.settings,
      required this.isDefault,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || schoolId != null) {
      map['school_id'] = Variable<String>(schoolId);
    }
    if (!nullToAbsent || classId != null) {
      map['class_id'] = Variable<String>(classId);
    }
    if (!nullToAbsent || subjectId != null) {
      map['subject_id'] = Variable<String>(subjectId);
    }
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    if (!nullToAbsent || duration != null) {
      map['duration'] = Variable<int>(duration);
    }
    if (!nullToAbsent || totalMarks != null) {
      map['total_marks'] = Variable<double>(totalMarks);
    }
    if (!nullToAbsent || structure != null) {
      map['structure'] = Variable<String>(structure);
    }
    if (!nullToAbsent || settings != null) {
      map['settings'] = Variable<String>(settings);
    }
    map['is_default'] = Variable<bool>(isDefault);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ExamTemplatesCompanion toCompanion(bool nullToAbsent) {
    return ExamTemplatesCompanion(
      id: Value(id),
      name: Value(name),
      schoolId: schoolId == null && nullToAbsent
          ? const Value.absent()
          : Value(schoolId),
      classId: classId == null && nullToAbsent
          ? const Value.absent()
          : Value(classId),
      subjectId: subjectId == null && nullToAbsent
          ? const Value.absent()
          : Value(subjectId),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      duration: duration == null && nullToAbsent
          ? const Value.absent()
          : Value(duration),
      totalMarks: totalMarks == null && nullToAbsent
          ? const Value.absent()
          : Value(totalMarks),
      structure: structure == null && nullToAbsent
          ? const Value.absent()
          : Value(structure),
      settings: settings == null && nullToAbsent
          ? const Value.absent()
          : Value(settings),
      isDefault: Value(isDefault),
      createdAt: Value(createdAt),
    );
  }

  factory ExamTemplateModel.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExamTemplateModel(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      schoolId: serializer.fromJson<String?>(json['schoolId']),
      classId: serializer.fromJson<String?>(json['classId']),
      subjectId: serializer.fromJson<String?>(json['subjectId']),
      type: serializer.fromJson<String?>(json['type']),
      duration: serializer.fromJson<int?>(json['duration']),
      totalMarks: serializer.fromJson<double?>(json['totalMarks']),
      structure: serializer.fromJson<String?>(json['structure']),
      settings: serializer.fromJson<String?>(json['settings']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'schoolId': serializer.toJson<String?>(schoolId),
      'classId': serializer.toJson<String?>(classId),
      'subjectId': serializer.toJson<String?>(subjectId),
      'type': serializer.toJson<String?>(type),
      'duration': serializer.toJson<int?>(duration),
      'totalMarks': serializer.toJson<double?>(totalMarks),
      'structure': serializer.toJson<String?>(structure),
      'settings': serializer.toJson<String?>(settings),
      'isDefault': serializer.toJson<bool>(isDefault),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ExamTemplateModel copyWith(
          {String? id,
          String? name,
          Value<String?> schoolId = const Value.absent(),
          Value<String?> classId = const Value.absent(),
          Value<String?> subjectId = const Value.absent(),
          Value<String?> type = const Value.absent(),
          Value<int?> duration = const Value.absent(),
          Value<double?> totalMarks = const Value.absent(),
          Value<String?> structure = const Value.absent(),
          Value<String?> settings = const Value.absent(),
          bool? isDefault,
          DateTime? createdAt}) =>
      ExamTemplateModel(
        id: id ?? this.id,
        name: name ?? this.name,
        schoolId: schoolId.present ? schoolId.value : this.schoolId,
        classId: classId.present ? classId.value : this.classId,
        subjectId: subjectId.present ? subjectId.value : this.subjectId,
        type: type.present ? type.value : this.type,
        duration: duration.present ? duration.value : this.duration,
        totalMarks: totalMarks.present ? totalMarks.value : this.totalMarks,
        structure: structure.present ? structure.value : this.structure,
        settings: settings.present ? settings.value : this.settings,
        isDefault: isDefault ?? this.isDefault,
        createdAt: createdAt ?? this.createdAt,
      );
  ExamTemplateModel copyWithCompanion(ExamTemplatesCompanion data) {
    return ExamTemplateModel(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      schoolId: data.schoolId.present ? data.schoolId.value : this.schoolId,
      classId: data.classId.present ? data.classId.value : this.classId,
      subjectId: data.subjectId.present ? data.subjectId.value : this.subjectId,
      type: data.type.present ? data.type.value : this.type,
      duration: data.duration.present ? data.duration.value : this.duration,
      totalMarks:
          data.totalMarks.present ? data.totalMarks.value : this.totalMarks,
      structure: data.structure.present ? data.structure.value : this.structure,
      settings: data.settings.present ? data.settings.value : this.settings,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExamTemplateModel(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('schoolId: $schoolId, ')
          ..write('classId: $classId, ')
          ..write('subjectId: $subjectId, ')
          ..write('type: $type, ')
          ..write('duration: $duration, ')
          ..write('totalMarks: $totalMarks, ')
          ..write('structure: $structure, ')
          ..write('settings: $settings, ')
          ..write('isDefault: $isDefault, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, schoolId, classId, subjectId, type,
      duration, totalMarks, structure, settings, isDefault, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExamTemplateModel &&
          other.id == this.id &&
          other.name == this.name &&
          other.schoolId == this.schoolId &&
          other.classId == this.classId &&
          other.subjectId == this.subjectId &&
          other.type == this.type &&
          other.duration == this.duration &&
          other.totalMarks == this.totalMarks &&
          other.structure == this.structure &&
          other.settings == this.settings &&
          other.isDefault == this.isDefault &&
          other.createdAt == this.createdAt);
}

class ExamTemplatesCompanion extends UpdateCompanion<ExamTemplateModel> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> schoolId;
  final Value<String?> classId;
  final Value<String?> subjectId;
  final Value<String?> type;
  final Value<int?> duration;
  final Value<double?> totalMarks;
  final Value<String?> structure;
  final Value<String?> settings;
  final Value<bool> isDefault;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ExamTemplatesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.schoolId = const Value.absent(),
    this.classId = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.type = const Value.absent(),
    this.duration = const Value.absent(),
    this.totalMarks = const Value.absent(),
    this.structure = const Value.absent(),
    this.settings = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExamTemplatesCompanion.insert({
    required String id,
    required String name,
    this.schoolId = const Value.absent(),
    this.classId = const Value.absent(),
    this.subjectId = const Value.absent(),
    this.type = const Value.absent(),
    this.duration = const Value.absent(),
    this.totalMarks = const Value.absent(),
    this.structure = const Value.absent(),
    this.settings = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<ExamTemplateModel> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? schoolId,
    Expression<String>? classId,
    Expression<String>? subjectId,
    Expression<String>? type,
    Expression<int>? duration,
    Expression<double>? totalMarks,
    Expression<String>? structure,
    Expression<String>? settings,
    Expression<bool>? isDefault,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (schoolId != null) 'school_id': schoolId,
      if (classId != null) 'class_id': classId,
      if (subjectId != null) 'subject_id': subjectId,
      if (type != null) 'type': type,
      if (duration != null) 'duration': duration,
      if (totalMarks != null) 'total_marks': totalMarks,
      if (structure != null) 'structure': structure,
      if (settings != null) 'settings': settings,
      if (isDefault != null) 'is_default': isDefault,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExamTemplatesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? schoolId,
      Value<String?>? classId,
      Value<String?>? subjectId,
      Value<String?>? type,
      Value<int?>? duration,
      Value<double?>? totalMarks,
      Value<String?>? structure,
      Value<String?>? settings,
      Value<bool>? isDefault,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return ExamTemplatesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      schoolId: schoolId ?? this.schoolId,
      classId: classId ?? this.classId,
      subjectId: subjectId ?? this.subjectId,
      type: type ?? this.type,
      duration: duration ?? this.duration,
      totalMarks: totalMarks ?? this.totalMarks,
      structure: structure ?? this.structure,
      settings: settings ?? this.settings,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (schoolId.present) {
      map['school_id'] = Variable<String>(schoolId.value);
    }
    if (classId.present) {
      map['class_id'] = Variable<String>(classId.value);
    }
    if (subjectId.present) {
      map['subject_id'] = Variable<String>(subjectId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (duration.present) {
      map['duration'] = Variable<int>(duration.value);
    }
    if (totalMarks.present) {
      map['total_marks'] = Variable<double>(totalMarks.value);
    }
    if (structure.present) {
      map['structure'] = Variable<String>(structure.value);
    }
    if (settings.present) {
      map['settings'] = Variable<String>(settings.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExamTemplatesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('schoolId: $schoolId, ')
          ..write('classId: $classId, ')
          ..write('subjectId: $subjectId, ')
          ..write('type: $type, ')
          ..write('duration: $duration, ')
          ..write('totalMarks: $totalMarks, ')
          ..write('structure: $structure, ')
          ..write('settings: $settings, ')
          ..write('isDefault: $isDefault, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TeachersTable teachers = $TeachersTable(this);
  late final $SchoolsTable schools = $SchoolsTable(this);
  late final $ClassesTable classes = $ClassesTable(this);
  late final $SectionsTable sections = $SectionsTable(this);
  late final $SubjectsTable subjects = $SubjectsTable(this);
  late final $StudentsTable students = $StudentsTable(this);
  late final $ExamsTable exams = $ExamsTable(this);
  late final $QuestionBankItemsTable questionBankItems =
      $QuestionBankItemsTable(this);
  late final $QuestionsTable questions = $QuestionsTable(this);
  late final $QuestionBlocksTable questionBlocks = $QuestionBlocksTable(this);
  late final $QuestionOptionsTable questionOptions =
      $QuestionOptionsTable(this);
  late final $ExamGradesTable examGrades = $ExamGradesTable(this);
  late final $ExamTemplatesTable examTemplates = $ExamTemplatesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        teachers,
        schools,
        classes,
        sections,
        subjects,
        students,
        exams,
        questionBankItems,
        questions,
        questionBlocks,
        questionOptions,
        examGrades,
        examTemplates
      ];
}

typedef $$TeachersTableCreateCompanionBuilder = TeachersCompanion Function({
  required String id,
  required String name,
  Value<String?> specialty,
  Value<String?> profileImage,
  Value<String?> email,
  Value<String?> phone,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});
typedef $$TeachersTableUpdateCompanionBuilder = TeachersCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> specialty,
  Value<String?> profileImage,
  Value<String?> email,
  Value<String?> phone,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});

final class $$TeachersTableReferences
    extends BaseReferences<_$AppDatabase, $TeachersTable, Teacher> {
  $$TeachersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ExamsTable, List<ExamModel>> _examsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.exams,
          aliasName: 'teachers__id__exams__teacher_id');

  $$ExamsTableProcessedTableManager get examsRefs {
    final manager = $$ExamsTableTableManager($_db, $_db.exams)
        .filter((f) => f.teacherId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_examsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TeachersTableFilterComposer
    extends Composer<_$AppDatabase, $TeachersTable> {
  $$TeachersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get specialty => $composableBuilder(
      column: $table.specialty, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get profileImage => $composableBuilder(
      column: $table.profileImage, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> examsRefs(
      Expression<bool> Function($$ExamsTableFilterComposer f) f) {
    final $$ExamsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.exams,
        getReferencedColumn: (t) => t.teacherId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamsTableFilterComposer(
              $db: $db,
              $table: $db.exams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TeachersTableOrderingComposer
    extends Composer<_$AppDatabase, $TeachersTable> {
  $$TeachersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get specialty => $composableBuilder(
      column: $table.specialty, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get profileImage => $composableBuilder(
      column: $table.profileImage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$TeachersTableAnnotationComposer
    extends Composer<_$AppDatabase, $TeachersTable> {
  $$TeachersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get specialty =>
      $composableBuilder(column: $table.specialty, builder: (column) => column);

  GeneratedColumn<String> get profileImage => $composableBuilder(
      column: $table.profileImage, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> examsRefs<T extends Object>(
      Expression<T> Function($$ExamsTableAnnotationComposer a) f) {
    final $$ExamsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.exams,
        getReferencedColumn: (t) => t.teacherId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamsTableAnnotationComposer(
              $db: $db,
              $table: $db.exams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TeachersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TeachersTable,
    Teacher,
    $$TeachersTableFilterComposer,
    $$TeachersTableOrderingComposer,
    $$TeachersTableAnnotationComposer,
    $$TeachersTableCreateCompanionBuilder,
    $$TeachersTableUpdateCompanionBuilder,
    (Teacher, $$TeachersTableReferences),
    Teacher,
    PrefetchHooks Function({bool examsRefs})> {
  $$TeachersTableTableManager(_$AppDatabase db, $TeachersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TeachersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TeachersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TeachersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> specialty = const Value.absent(),
            Value<String?> profileImage = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TeachersCompanion(
            id: id,
            name: name,
            specialty: specialty,
            profileImage: profileImage,
            email: email,
            phone: phone,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> specialty = const Value.absent(),
            Value<String?> profileImage = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TeachersCompanion.insert(
            id: id,
            name: name,
            specialty: specialty,
            profileImage: profileImage,
            email: email,
            phone: phone,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$TeachersTable, Teacher>(table),
                    $$TeachersTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({examsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (examsRefs) db.exams],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (examsRefs)
                    await $_getPrefetchedData<Teacher, $TeachersTable,
                            ExamModel>(
                        currentTable: table,
                        referencedTable:
                            $$TeachersTableReferences._examsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TeachersTableReferences(db, table, p0).examsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.teacherId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TeachersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TeachersTable,
    Teacher,
    $$TeachersTableFilterComposer,
    $$TeachersTableOrderingComposer,
    $$TeachersTableAnnotationComposer,
    $$TeachersTableCreateCompanionBuilder,
    $$TeachersTableUpdateCompanionBuilder,
    (Teacher, $$TeachersTableReferences),
    Teacher,
    PrefetchHooks Function({bool examsRefs})>;
typedef $$SchoolsTableCreateCompanionBuilder = SchoolsCompanion Function({
  required String id,
  required String name,
  Value<String?> logo,
  Value<String?> educationAuthority,
  Value<String?> address,
  Value<String?> phone,
  Value<String> academicYear,
  Value<bool> isDefault,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});
typedef $$SchoolsTableUpdateCompanionBuilder = SchoolsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> logo,
  Value<String?> educationAuthority,
  Value<String?> address,
  Value<String?> phone,
  Value<String> academicYear,
  Value<bool> isDefault,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});

final class $$SchoolsTableReferences
    extends BaseReferences<_$AppDatabase, $SchoolsTable, School> {
  $$SchoolsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ClassesTable, List<ClassesData>>
      _classesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.classes,
              aliasName: 'schools__id__classes__school_id');

  $$ClassesTableProcessedTableManager get classesRefs {
    final manager = $$ClassesTableTableManager($_db, $_db.classes)
        .filter((f) => f.schoolId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_classesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$SubjectsTable, List<Subject>> _subjectsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.subjects,
          aliasName: 'schools__id__subjects__school_id');

  $$SubjectsTableProcessedTableManager get subjectsRefs {
    final manager = $$SubjectsTableTableManager($_db, $_db.subjects)
        .filter((f) => f.schoolId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_subjectsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ExamsTable, List<ExamModel>> _examsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.exams,
          aliasName: 'schools__id__exams__school_id');

  $$ExamsTableProcessedTableManager get examsRefs {
    final manager = $$ExamsTableTableManager($_db, $_db.exams)
        .filter((f) => f.schoolId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_examsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ExamTemplatesTable, List<ExamTemplateModel>>
      _examTemplatesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.examTemplates,
              aliasName: 'schools__id__exam_templates__school_id');

  $$ExamTemplatesTableProcessedTableManager get examTemplatesRefs {
    final manager = $$ExamTemplatesTableTableManager($_db, $_db.examTemplates)
        .filter((f) => f.schoolId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_examTemplatesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$SchoolsTableFilterComposer
    extends Composer<_$AppDatabase, $SchoolsTable> {
  $$SchoolsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get logo => $composableBuilder(
      column: $table.logo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get educationAuthority => $composableBuilder(
      column: $table.educationAuthority,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get academicYear => $composableBuilder(
      column: $table.academicYear, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDefault => $composableBuilder(
      column: $table.isDefault, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> classesRefs(
      Expression<bool> Function($$ClassesTableFilterComposer f) f) {
    final $$ClassesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.classes,
        getReferencedColumn: (t) => t.schoolId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassesTableFilterComposer(
              $db: $db,
              $table: $db.classes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> subjectsRefs(
      Expression<bool> Function($$SubjectsTableFilterComposer f) f) {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.subjects,
        getReferencedColumn: (t) => t.schoolId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SubjectsTableFilterComposer(
              $db: $db,
              $table: $db.subjects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> examsRefs(
      Expression<bool> Function($$ExamsTableFilterComposer f) f) {
    final $$ExamsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.exams,
        getReferencedColumn: (t) => t.schoolId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamsTableFilterComposer(
              $db: $db,
              $table: $db.exams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> examTemplatesRefs(
      Expression<bool> Function($$ExamTemplatesTableFilterComposer f) f) {
    final $$ExamTemplatesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.examTemplates,
        getReferencedColumn: (t) => t.schoolId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamTemplatesTableFilterComposer(
              $db: $db,
              $table: $db.examTemplates,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SchoolsTableOrderingComposer
    extends Composer<_$AppDatabase, $SchoolsTable> {
  $$SchoolsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get logo => $composableBuilder(
      column: $table.logo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get educationAuthority => $composableBuilder(
      column: $table.educationAuthority,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get academicYear => $composableBuilder(
      column: $table.academicYear,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDefault => $composableBuilder(
      column: $table.isDefault, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$SchoolsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SchoolsTable> {
  $$SchoolsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get logo =>
      $composableBuilder(column: $table.logo, builder: (column) => column);

  GeneratedColumn<String> get educationAuthority => $composableBuilder(
      column: $table.educationAuthority, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get academicYear => $composableBuilder(
      column: $table.academicYear, builder: (column) => column);

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> classesRefs<T extends Object>(
      Expression<T> Function($$ClassesTableAnnotationComposer a) f) {
    final $$ClassesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.classes,
        getReferencedColumn: (t) => t.schoolId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassesTableAnnotationComposer(
              $db: $db,
              $table: $db.classes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> subjectsRefs<T extends Object>(
      Expression<T> Function($$SubjectsTableAnnotationComposer a) f) {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.subjects,
        getReferencedColumn: (t) => t.schoolId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SubjectsTableAnnotationComposer(
              $db: $db,
              $table: $db.subjects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> examsRefs<T extends Object>(
      Expression<T> Function($$ExamsTableAnnotationComposer a) f) {
    final $$ExamsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.exams,
        getReferencedColumn: (t) => t.schoolId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamsTableAnnotationComposer(
              $db: $db,
              $table: $db.exams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> examTemplatesRefs<T extends Object>(
      Expression<T> Function($$ExamTemplatesTableAnnotationComposer a) f) {
    final $$ExamTemplatesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.examTemplates,
        getReferencedColumn: (t) => t.schoolId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamTemplatesTableAnnotationComposer(
              $db: $db,
              $table: $db.examTemplates,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SchoolsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SchoolsTable,
    School,
    $$SchoolsTableFilterComposer,
    $$SchoolsTableOrderingComposer,
    $$SchoolsTableAnnotationComposer,
    $$SchoolsTableCreateCompanionBuilder,
    $$SchoolsTableUpdateCompanionBuilder,
    (School, $$SchoolsTableReferences),
    School,
    PrefetchHooks Function(
        {bool classesRefs,
        bool subjectsRefs,
        bool examsRefs,
        bool examTemplatesRefs})> {
  $$SchoolsTableTableManager(_$AppDatabase db, $SchoolsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SchoolsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SchoolsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SchoolsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> logo = const Value.absent(),
            Value<String?> educationAuthority = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String> academicYear = const Value.absent(),
            Value<bool> isDefault = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SchoolsCompanion(
            id: id,
            name: name,
            logo: logo,
            educationAuthority: educationAuthority,
            address: address,
            phone: phone,
            academicYear: academicYear,
            isDefault: isDefault,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> logo = const Value.absent(),
            Value<String?> educationAuthority = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String> academicYear = const Value.absent(),
            Value<bool> isDefault = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SchoolsCompanion.insert(
            id: id,
            name: name,
            logo: logo,
            educationAuthority: educationAuthority,
            address: address,
            phone: phone,
            academicYear: academicYear,
            isDefault: isDefault,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$SchoolsTable, School>(table),
                    $$SchoolsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {classesRefs = false,
              subjectsRefs = false,
              examsRefs = false,
              examTemplatesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (classesRefs) db.classes,
                if (subjectsRefs) db.subjects,
                if (examsRefs) db.exams,
                if (examTemplatesRefs) db.examTemplates
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (classesRefs)
                    await $_getPrefetchedData<School, $SchoolsTable,
                            ClassesData>(
                        currentTable: table,
                        referencedTable:
                            $$SchoolsTableReferences._classesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SchoolsTableReferences(db, table, p0).classesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.schoolId == item.id),
                        typedResults: items),
                  if (subjectsRefs)
                    await $_getPrefetchedData<School, $SchoolsTable, Subject>(
                        currentTable: table,
                        referencedTable:
                            $$SchoolsTableReferences._subjectsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SchoolsTableReferences(db, table, p0)
                                .subjectsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.schoolId == item.id),
                        typedResults: items),
                  if (examsRefs)
                    await $_getPrefetchedData<School, $SchoolsTable, ExamModel>(
                        currentTable: table,
                        referencedTable:
                            $$SchoolsTableReferences._examsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SchoolsTableReferences(db, table, p0).examsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.schoolId == item.id),
                        typedResults: items),
                  if (examTemplatesRefs)
                    await $_getPrefetchedData<School, $SchoolsTable,
                            ExamTemplateModel>(
                        currentTable: table,
                        referencedTable: $$SchoolsTableReferences
                            ._examTemplatesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SchoolsTableReferences(db, table, p0)
                                .examTemplatesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.schoolId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$SchoolsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SchoolsTable,
    School,
    $$SchoolsTableFilterComposer,
    $$SchoolsTableOrderingComposer,
    $$SchoolsTableAnnotationComposer,
    $$SchoolsTableCreateCompanionBuilder,
    $$SchoolsTableUpdateCompanionBuilder,
    (School, $$SchoolsTableReferences),
    School,
    PrefetchHooks Function(
        {bool classesRefs,
        bool subjectsRefs,
        bool examsRefs,
        bool examTemplatesRefs})>;
typedef $$ClassesTableCreateCompanionBuilder = ClassesCompanion Function({
  required String id,
  required String schoolId,
  required String name,
  required String gradeLevel,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});
typedef $$ClassesTableUpdateCompanionBuilder = ClassesCompanion Function({
  Value<String> id,
  Value<String> schoolId,
  Value<String> name,
  Value<String> gradeLevel,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});

final class $$ClassesTableReferences
    extends BaseReferences<_$AppDatabase, $ClassesTable, ClassesData> {
  $$ClassesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SchoolsTable _schoolIdTable(_$AppDatabase db) =>
      db.schools.createAlias('classes__school_id__schools__id');

  $$SchoolsTableProcessedTableManager get schoolId {
    final $_column = $_itemColumn<String>('school_id')!;

    final manager = $$SchoolsTableTableManager($_db, $_db.schools)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_schoolIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$SectionsTable, List<Section>> _sectionsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.sections,
          aliasName: 'classes__id__sections__class_id');

  $$SectionsTableProcessedTableManager get sectionsRefs {
    final manager = $$SectionsTableTableManager($_db, $_db.sections)
        .filter((f) => f.classId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_sectionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$StudentsTable, List<Student>> _studentsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.students,
          aliasName: 'classes__id__students__class_id');

  $$StudentsTableProcessedTableManager get studentsRefs {
    final manager = $$StudentsTableTableManager($_db, $_db.students)
        .filter((f) => f.classId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_studentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ExamsTable, List<ExamModel>> _examsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.exams,
          aliasName: 'classes__id__exams__class_id');

  $$ExamsTableProcessedTableManager get examsRefs {
    final manager = $$ExamsTableTableManager($_db, $_db.exams)
        .filter((f) => f.classId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_examsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$QuestionBankItemsTable,
      List<QuestionBankItemModel>> _questionBankItemsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.questionBankItems,
          aliasName: 'classes__id__question_bank_items__class_id');

  $$QuestionBankItemsTableProcessedTableManager get questionBankItemsRefs {
    final manager =
        $$QuestionBankItemsTableTableManager($_db, $_db.questionBankItems)
            .filter((f) => f.classId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_questionBankItemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ExamTemplatesTable, List<ExamTemplateModel>>
      _examTemplatesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.examTemplates,
              aliasName: 'classes__id__exam_templates__class_id');

  $$ExamTemplatesTableProcessedTableManager get examTemplatesRefs {
    final manager = $$ExamTemplatesTableTableManager($_db, $_db.examTemplates)
        .filter((f) => f.classId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_examTemplatesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ClassesTableFilterComposer
    extends Composer<_$AppDatabase, $ClassesTable> {
  $$ClassesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gradeLevel => $composableBuilder(
      column: $table.gradeLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$SchoolsTableFilterComposer get schoolId {
    final $$SchoolsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.schoolId,
        referencedTable: $db.schools,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SchoolsTableFilterComposer(
              $db: $db,
              $table: $db.schools,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> sectionsRefs(
      Expression<bool> Function($$SectionsTableFilterComposer f) f) {
    final $$SectionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.sections,
        getReferencedColumn: (t) => t.classId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SectionsTableFilterComposer(
              $db: $db,
              $table: $db.sections,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> studentsRefs(
      Expression<bool> Function($$StudentsTableFilterComposer f) f) {
    final $$StudentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.students,
        getReferencedColumn: (t) => t.classId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentsTableFilterComposer(
              $db: $db,
              $table: $db.students,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> examsRefs(
      Expression<bool> Function($$ExamsTableFilterComposer f) f) {
    final $$ExamsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.exams,
        getReferencedColumn: (t) => t.classId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamsTableFilterComposer(
              $db: $db,
              $table: $db.exams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> questionBankItemsRefs(
      Expression<bool> Function($$QuestionBankItemsTableFilterComposer f) f) {
    final $$QuestionBankItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.questionBankItems,
        getReferencedColumn: (t) => t.classId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionBankItemsTableFilterComposer(
              $db: $db,
              $table: $db.questionBankItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> examTemplatesRefs(
      Expression<bool> Function($$ExamTemplatesTableFilterComposer f) f) {
    final $$ExamTemplatesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.examTemplates,
        getReferencedColumn: (t) => t.classId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamTemplatesTableFilterComposer(
              $db: $db,
              $table: $db.examTemplates,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ClassesTableOrderingComposer
    extends Composer<_$AppDatabase, $ClassesTable> {
  $$ClassesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gradeLevel => $composableBuilder(
      column: $table.gradeLevel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$SchoolsTableOrderingComposer get schoolId {
    final $$SchoolsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.schoolId,
        referencedTable: $db.schools,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SchoolsTableOrderingComposer(
              $db: $db,
              $table: $db.schools,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ClassesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClassesTable> {
  $$ClassesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get gradeLevel => $composableBuilder(
      column: $table.gradeLevel, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$SchoolsTableAnnotationComposer get schoolId {
    final $$SchoolsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.schoolId,
        referencedTable: $db.schools,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SchoolsTableAnnotationComposer(
              $db: $db,
              $table: $db.schools,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> sectionsRefs<T extends Object>(
      Expression<T> Function($$SectionsTableAnnotationComposer a) f) {
    final $$SectionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.sections,
        getReferencedColumn: (t) => t.classId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SectionsTableAnnotationComposer(
              $db: $db,
              $table: $db.sections,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> studentsRefs<T extends Object>(
      Expression<T> Function($$StudentsTableAnnotationComposer a) f) {
    final $$StudentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.students,
        getReferencedColumn: (t) => t.classId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentsTableAnnotationComposer(
              $db: $db,
              $table: $db.students,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> examsRefs<T extends Object>(
      Expression<T> Function($$ExamsTableAnnotationComposer a) f) {
    final $$ExamsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.exams,
        getReferencedColumn: (t) => t.classId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamsTableAnnotationComposer(
              $db: $db,
              $table: $db.exams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> questionBankItemsRefs<T extends Object>(
      Expression<T> Function($$QuestionBankItemsTableAnnotationComposer a) f) {
    final $$QuestionBankItemsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.questionBankItems,
            getReferencedColumn: (t) => t.classId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$QuestionBankItemsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.questionBankItems,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> examTemplatesRefs<T extends Object>(
      Expression<T> Function($$ExamTemplatesTableAnnotationComposer a) f) {
    final $$ExamTemplatesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.examTemplates,
        getReferencedColumn: (t) => t.classId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamTemplatesTableAnnotationComposer(
              $db: $db,
              $table: $db.examTemplates,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ClassesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ClassesTable,
    ClassesData,
    $$ClassesTableFilterComposer,
    $$ClassesTableOrderingComposer,
    $$ClassesTableAnnotationComposer,
    $$ClassesTableCreateCompanionBuilder,
    $$ClassesTableUpdateCompanionBuilder,
    (ClassesData, $$ClassesTableReferences),
    ClassesData,
    PrefetchHooks Function(
        {bool schoolId,
        bool sectionsRefs,
        bool studentsRefs,
        bool examsRefs,
        bool questionBankItemsRefs,
        bool examTemplatesRefs})> {
  $$ClassesTableTableManager(_$AppDatabase db, $ClassesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClassesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClassesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClassesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> schoolId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> gradeLevel = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ClassesCompanion(
            id: id,
            schoolId: schoolId,
            name: name,
            gradeLevel: gradeLevel,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String schoolId,
            required String name,
            required String gradeLevel,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ClassesCompanion.insert(
            id: id,
            schoolId: schoolId,
            name: name,
            gradeLevel: gradeLevel,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$ClassesTable, ClassesData>(table),
                    $$ClassesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {schoolId = false,
              sectionsRefs = false,
              studentsRefs = false,
              examsRefs = false,
              questionBankItemsRefs = false,
              examTemplatesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (sectionsRefs) db.sections,
                if (studentsRefs) db.students,
                if (examsRefs) db.exams,
                if (questionBankItemsRefs) db.questionBankItems,
                if (examTemplatesRefs) db.examTemplates
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (schoolId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.schoolId,
                    referencedTable:
                        $$ClassesTableReferences._schoolIdTable(db),
                    referencedColumn:
                        $$ClassesTableReferences._schoolIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (sectionsRefs)
                    await $_getPrefetchedData<ClassesData, $ClassesTable,
                            Section>(
                        currentTable: table,
                        referencedTable:
                            $$ClassesTableReferences._sectionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ClassesTableReferences(db, table, p0)
                                .sectionsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.classId == item.id),
                        typedResults: items),
                  if (studentsRefs)
                    await $_getPrefetchedData<ClassesData, $ClassesTable,
                            Student>(
                        currentTable: table,
                        referencedTable:
                            $$ClassesTableReferences._studentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ClassesTableReferences(db, table, p0)
                                .studentsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.classId == item.id),
                        typedResults: items),
                  if (examsRefs)
                    await $_getPrefetchedData<ClassesData, $ClassesTable,
                            ExamModel>(
                        currentTable: table,
                        referencedTable:
                            $$ClassesTableReferences._examsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ClassesTableReferences(db, table, p0).examsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.classId == item.id),
                        typedResults: items),
                  if (questionBankItemsRefs)
                    await $_getPrefetchedData<ClassesData, $ClassesTable, QuestionBankItemModel>(
                        currentTable: table,
                        referencedTable: $$ClassesTableReferences
                            ._questionBankItemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ClassesTableReferences(db, table, p0)
                                .questionBankItemsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.classId == item.id),
                        typedResults: items),
                  if (examTemplatesRefs)
                    await $_getPrefetchedData<ClassesData, $ClassesTable,
                            ExamTemplateModel>(
                        currentTable: table,
                        referencedTable: $$ClassesTableReferences
                            ._examTemplatesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ClassesTableReferences(db, table, p0)
                                .examTemplatesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.classId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ClassesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ClassesTable,
    ClassesData,
    $$ClassesTableFilterComposer,
    $$ClassesTableOrderingComposer,
    $$ClassesTableAnnotationComposer,
    $$ClassesTableCreateCompanionBuilder,
    $$ClassesTableUpdateCompanionBuilder,
    (ClassesData, $$ClassesTableReferences),
    ClassesData,
    PrefetchHooks Function(
        {bool schoolId,
        bool sectionsRefs,
        bool studentsRefs,
        bool examsRefs,
        bool questionBankItemsRefs,
        bool examTemplatesRefs})>;
typedef $$SectionsTableCreateCompanionBuilder = SectionsCompanion Function({
  required String id,
  required String classId,
  required String name,
  Value<String> academicYear,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});
typedef $$SectionsTableUpdateCompanionBuilder = SectionsCompanion Function({
  Value<String> id,
  Value<String> classId,
  Value<String> name,
  Value<String> academicYear,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});

final class $$SectionsTableReferences
    extends BaseReferences<_$AppDatabase, $SectionsTable, Section> {
  $$SectionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClassesTable _classIdTable(_$AppDatabase db) =>
      db.classes.createAlias('sections__class_id__classes__id');

  $$ClassesTableProcessedTableManager get classId {
    final $_column = $_itemColumn<String>('class_id')!;

    final manager = $$ClassesTableTableManager($_db, $_db.classes)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_classIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$StudentsTable, List<Student>> _studentsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.students,
          aliasName: 'sections__id__students__section_id');

  $$StudentsTableProcessedTableManager get studentsRefs {
    final manager = $$StudentsTableTableManager($_db, $_db.students)
        .filter((f) => f.sectionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_studentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ExamsTable, List<ExamModel>> _examsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.exams,
          aliasName: 'sections__id__exams__section_id');

  $$ExamsTableProcessedTableManager get examsRefs {
    final manager = $$ExamsTableTableManager($_db, $_db.exams)
        .filter((f) => f.sectionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_examsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$SectionsTableFilterComposer
    extends Composer<_$AppDatabase, $SectionsTable> {
  $$SectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get academicYear => $composableBuilder(
      column: $table.academicYear, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$ClassesTableFilterComposer get classId {
    final $$ClassesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.classId,
        referencedTable: $db.classes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassesTableFilterComposer(
              $db: $db,
              $table: $db.classes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> studentsRefs(
      Expression<bool> Function($$StudentsTableFilterComposer f) f) {
    final $$StudentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.students,
        getReferencedColumn: (t) => t.sectionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentsTableFilterComposer(
              $db: $db,
              $table: $db.students,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> examsRefs(
      Expression<bool> Function($$ExamsTableFilterComposer f) f) {
    final $$ExamsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.exams,
        getReferencedColumn: (t) => t.sectionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamsTableFilterComposer(
              $db: $db,
              $table: $db.exams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SectionsTable> {
  $$SectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get academicYear => $composableBuilder(
      column: $table.academicYear,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$ClassesTableOrderingComposer get classId {
    final $$ClassesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.classId,
        referencedTable: $db.classes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassesTableOrderingComposer(
              $db: $db,
              $table: $db.classes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SectionsTable> {
  $$SectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get academicYear => $composableBuilder(
      column: $table.academicYear, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ClassesTableAnnotationComposer get classId {
    final $$ClassesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.classId,
        referencedTable: $db.classes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassesTableAnnotationComposer(
              $db: $db,
              $table: $db.classes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> studentsRefs<T extends Object>(
      Expression<T> Function($$StudentsTableAnnotationComposer a) f) {
    final $$StudentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.students,
        getReferencedColumn: (t) => t.sectionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentsTableAnnotationComposer(
              $db: $db,
              $table: $db.students,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> examsRefs<T extends Object>(
      Expression<T> Function($$ExamsTableAnnotationComposer a) f) {
    final $$ExamsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.exams,
        getReferencedColumn: (t) => t.sectionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamsTableAnnotationComposer(
              $db: $db,
              $table: $db.exams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SectionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SectionsTable,
    Section,
    $$SectionsTableFilterComposer,
    $$SectionsTableOrderingComposer,
    $$SectionsTableAnnotationComposer,
    $$SectionsTableCreateCompanionBuilder,
    $$SectionsTableUpdateCompanionBuilder,
    (Section, $$SectionsTableReferences),
    Section,
    PrefetchHooks Function({bool classId, bool studentsRefs, bool examsRefs})> {
  $$SectionsTableTableManager(_$AppDatabase db, $SectionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SectionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> classId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> academicYear = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SectionsCompanion(
            id: id,
            classId: classId,
            name: name,
            academicYear: academicYear,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String classId,
            required String name,
            Value<String> academicYear = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SectionsCompanion.insert(
            id: id,
            classId: classId,
            name: name,
            academicYear: academicYear,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$SectionsTable, Section>(table),
                    $$SectionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {classId = false, studentsRefs = false, examsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (studentsRefs) db.students,
                if (examsRefs) db.exams
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (classId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.classId,
                    referencedTable:
                        $$SectionsTableReferences._classIdTable(db),
                    referencedColumn:
                        $$SectionsTableReferences._classIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (studentsRefs)
                    await $_getPrefetchedData<Section, $SectionsTable, Student>(
                        currentTable: table,
                        referencedTable:
                            $$SectionsTableReferences._studentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SectionsTableReferences(db, table, p0)
                                .studentsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.sectionId == item.id),
                        typedResults: items),
                  if (examsRefs)
                    await $_getPrefetchedData<Section, $SectionsTable,
                            ExamModel>(
                        currentTable: table,
                        referencedTable:
                            $$SectionsTableReferences._examsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SectionsTableReferences(db, table, p0).examsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.sectionId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$SectionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SectionsTable,
    Section,
    $$SectionsTableFilterComposer,
    $$SectionsTableOrderingComposer,
    $$SectionsTableAnnotationComposer,
    $$SectionsTableCreateCompanionBuilder,
    $$SectionsTableUpdateCompanionBuilder,
    (Section, $$SectionsTableReferences),
    Section,
    PrefetchHooks Function({bool classId, bool studentsRefs, bool examsRefs})>;
typedef $$SubjectsTableCreateCompanionBuilder = SubjectsCompanion Function({
  required String id,
  required String schoolId,
  required String name,
  Value<String?> color,
  Value<String?> icon,
  Value<String?> description,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});
typedef $$SubjectsTableUpdateCompanionBuilder = SubjectsCompanion Function({
  Value<String> id,
  Value<String> schoolId,
  Value<String> name,
  Value<String?> color,
  Value<String?> icon,
  Value<String?> description,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});

final class $$SubjectsTableReferences
    extends BaseReferences<_$AppDatabase, $SubjectsTable, Subject> {
  $$SubjectsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SchoolsTable _schoolIdTable(_$AppDatabase db) =>
      db.schools.createAlias('subjects__school_id__schools__id');

  $$SchoolsTableProcessedTableManager get schoolId {
    final $_column = $_itemColumn<String>('school_id')!;

    final manager = $$SchoolsTableTableManager($_db, $_db.schools)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_schoolIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ExamsTable, List<ExamModel>> _examsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.exams,
          aliasName: 'subjects__id__exams__subject_id');

  $$ExamsTableProcessedTableManager get examsRefs {
    final manager = $$ExamsTableTableManager($_db, $_db.exams)
        .filter((f) => f.subjectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_examsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$QuestionBankItemsTable,
      List<QuestionBankItemModel>> _questionBankItemsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.questionBankItems,
          aliasName: 'subjects__id__question_bank_items__subject_id');

  $$QuestionBankItemsTableProcessedTableManager get questionBankItemsRefs {
    final manager = $$QuestionBankItemsTableTableManager(
            $_db, $_db.questionBankItems)
        .filter((f) => f.subjectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_questionBankItemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ExamTemplatesTable, List<ExamTemplateModel>>
      _examTemplatesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.examTemplates,
              aliasName: 'subjects__id__exam_templates__subject_id');

  $$ExamTemplatesTableProcessedTableManager get examTemplatesRefs {
    final manager = $$ExamTemplatesTableTableManager($_db, $_db.examTemplates)
        .filter((f) => f.subjectId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_examTemplatesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$SubjectsTableFilterComposer
    extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$SchoolsTableFilterComposer get schoolId {
    final $$SchoolsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.schoolId,
        referencedTable: $db.schools,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SchoolsTableFilterComposer(
              $db: $db,
              $table: $db.schools,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> examsRefs(
      Expression<bool> Function($$ExamsTableFilterComposer f) f) {
    final $$ExamsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.exams,
        getReferencedColumn: (t) => t.subjectId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamsTableFilterComposer(
              $db: $db,
              $table: $db.exams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> questionBankItemsRefs(
      Expression<bool> Function($$QuestionBankItemsTableFilterComposer f) f) {
    final $$QuestionBankItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.questionBankItems,
        getReferencedColumn: (t) => t.subjectId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionBankItemsTableFilterComposer(
              $db: $db,
              $table: $db.questionBankItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> examTemplatesRefs(
      Expression<bool> Function($$ExamTemplatesTableFilterComposer f) f) {
    final $$ExamTemplatesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.examTemplates,
        getReferencedColumn: (t) => t.subjectId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamTemplatesTableFilterComposer(
              $db: $db,
              $table: $db.examTemplates,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SubjectsTableOrderingComposer
    extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get color => $composableBuilder(
      column: $table.color, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$SchoolsTableOrderingComposer get schoolId {
    final $$SchoolsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.schoolId,
        referencedTable: $db.schools,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SchoolsTableOrderingComposer(
              $db: $db,
              $table: $db.schools,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$SubjectsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SubjectsTable> {
  $$SubjectsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$SchoolsTableAnnotationComposer get schoolId {
    final $$SchoolsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.schoolId,
        referencedTable: $db.schools,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SchoolsTableAnnotationComposer(
              $db: $db,
              $table: $db.schools,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> examsRefs<T extends Object>(
      Expression<T> Function($$ExamsTableAnnotationComposer a) f) {
    final $$ExamsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.exams,
        getReferencedColumn: (t) => t.subjectId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamsTableAnnotationComposer(
              $db: $db,
              $table: $db.exams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> questionBankItemsRefs<T extends Object>(
      Expression<T> Function($$QuestionBankItemsTableAnnotationComposer a) f) {
    final $$QuestionBankItemsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.questionBankItems,
            getReferencedColumn: (t) => t.subjectId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$QuestionBankItemsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.questionBankItems,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> examTemplatesRefs<T extends Object>(
      Expression<T> Function($$ExamTemplatesTableAnnotationComposer a) f) {
    final $$ExamTemplatesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.examTemplates,
        getReferencedColumn: (t) => t.subjectId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamTemplatesTableAnnotationComposer(
              $db: $db,
              $table: $db.examTemplates,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$SubjectsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SubjectsTable,
    Subject,
    $$SubjectsTableFilterComposer,
    $$SubjectsTableOrderingComposer,
    $$SubjectsTableAnnotationComposer,
    $$SubjectsTableCreateCompanionBuilder,
    $$SubjectsTableUpdateCompanionBuilder,
    (Subject, $$SubjectsTableReferences),
    Subject,
    PrefetchHooks Function(
        {bool schoolId,
        bool examsRefs,
        bool questionBankItemsRefs,
        bool examTemplatesRefs})> {
  $$SubjectsTableTableManager(_$AppDatabase db, $SubjectsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubjectsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SubjectsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SubjectsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> schoolId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> color = const Value.absent(),
            Value<String?> icon = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SubjectsCompanion(
            id: id,
            schoolId: schoolId,
            name: name,
            color: color,
            icon: icon,
            description: description,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String schoolId,
            required String name,
            Value<String?> color = const Value.absent(),
            Value<String?> icon = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SubjectsCompanion.insert(
            id: id,
            schoolId: schoolId,
            name: name,
            color: color,
            icon: icon,
            description: description,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$SubjectsTable, Subject>(table),
                    $$SubjectsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {schoolId = false,
              examsRefs = false,
              questionBankItemsRefs = false,
              examTemplatesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (examsRefs) db.exams,
                if (questionBankItemsRefs) db.questionBankItems,
                if (examTemplatesRefs) db.examTemplates
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (schoolId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.schoolId,
                    referencedTable:
                        $$SubjectsTableReferences._schoolIdTable(db),
                    referencedColumn:
                        $$SubjectsTableReferences._schoolIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (examsRefs)
                    await $_getPrefetchedData<Subject, $SubjectsTable,
                            ExamModel>(
                        currentTable: table,
                        referencedTable:
                            $$SubjectsTableReferences._examsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SubjectsTableReferences(db, table, p0).examsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.subjectId == item.id),
                        typedResults: items),
                  if (questionBankItemsRefs)
                    await $_getPrefetchedData<Subject, $SubjectsTable,
                            QuestionBankItemModel>(
                        currentTable: table,
                        referencedTable: $$SubjectsTableReferences
                            ._questionBankItemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SubjectsTableReferences(db, table, p0)
                                .questionBankItemsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.subjectId == item.id),
                        typedResults: items),
                  if (examTemplatesRefs)
                    await $_getPrefetchedData<Subject, $SubjectsTable,
                            ExamTemplateModel>(
                        currentTable: table,
                        referencedTable: $$SubjectsTableReferences
                            ._examTemplatesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$SubjectsTableReferences(db, table, p0)
                                .examTemplatesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.subjectId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$SubjectsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SubjectsTable,
    Subject,
    $$SubjectsTableFilterComposer,
    $$SubjectsTableOrderingComposer,
    $$SubjectsTableAnnotationComposer,
    $$SubjectsTableCreateCompanionBuilder,
    $$SubjectsTableUpdateCompanionBuilder,
    (Subject, $$SubjectsTableReferences),
    Subject,
    PrefetchHooks Function(
        {bool schoolId,
        bool examsRefs,
        bool questionBankItemsRefs,
        bool examTemplatesRefs})>;
typedef $$StudentsTableCreateCompanionBuilder = StudentsCompanion Function({
  required String id,
  required String name,
  required String studentNumber,
  required String classId,
  Value<String?> sectionId,
  Value<String?> parentPhone,
  Value<String?> profileImage,
  Value<String?> notes,
  Value<String?> gender,
  Value<String?> email,
  Value<String?> address,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<bool> isDeleted,
  Value<bool> isActive,
  Value<int> rowid,
});
typedef $$StudentsTableUpdateCompanionBuilder = StudentsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String> studentNumber,
  Value<String> classId,
  Value<String?> sectionId,
  Value<String?> parentPhone,
  Value<String?> profileImage,
  Value<String?> notes,
  Value<String?> gender,
  Value<String?> email,
  Value<String?> address,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<bool> isDeleted,
  Value<bool> isActive,
  Value<int> rowid,
});

final class $$StudentsTableReferences
    extends BaseReferences<_$AppDatabase, $StudentsTable, Student> {
  $$StudentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClassesTable _classIdTable(_$AppDatabase db) =>
      db.classes.createAlias('students__class_id__classes__id');

  $$ClassesTableProcessedTableManager get classId {
    final $_column = $_itemColumn<String>('class_id')!;

    final manager = $$ClassesTableTableManager($_db, $_db.classes)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_classIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $SectionsTable _sectionIdTable(_$AppDatabase db) =>
      db.sections.createAlias('students__section_id__sections__id');

  $$SectionsTableProcessedTableManager? get sectionId {
    final $_column = $_itemColumn<String>('section_id');
    if ($_column == null) return null;
    final manager = $$SectionsTableTableManager($_db, $_db.sections)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sectionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$ExamGradesTable, List<ExamGradeModel>>
      _examGradesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.examGrades,
              aliasName: 'students__id__exam_grades__student_id');

  $$ExamGradesTableProcessedTableManager get examGradesRefs {
    final manager = $$ExamGradesTableTableManager($_db, $_db.examGrades)
        .filter((f) => f.studentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_examGradesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$StudentsTableFilterComposer
    extends Composer<_$AppDatabase, $StudentsTable> {
  $$StudentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get studentNumber => $composableBuilder(
      column: $table.studentNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get parentPhone => $composableBuilder(
      column: $table.parentPhone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get profileImage => $composableBuilder(
      column: $table.profileImage, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  $$ClassesTableFilterComposer get classId {
    final $$ClassesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.classId,
        referencedTable: $db.classes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassesTableFilterComposer(
              $db: $db,
              $table: $db.classes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SectionsTableFilterComposer get sectionId {
    final $$SectionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sectionId,
        referencedTable: $db.sections,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SectionsTableFilterComposer(
              $db: $db,
              $table: $db.sections,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> examGradesRefs(
      Expression<bool> Function($$ExamGradesTableFilterComposer f) f) {
    final $$ExamGradesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.examGrades,
        getReferencedColumn: (t) => t.studentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamGradesTableFilterComposer(
              $db: $db,
              $table: $db.examGrades,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$StudentsTableOrderingComposer
    extends Composer<_$AppDatabase, $StudentsTable> {
  $$StudentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get studentNumber => $composableBuilder(
      column: $table.studentNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get parentPhone => $composableBuilder(
      column: $table.parentPhone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get profileImage => $composableBuilder(
      column: $table.profileImage,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  $$ClassesTableOrderingComposer get classId {
    final $$ClassesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.classId,
        referencedTable: $db.classes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassesTableOrderingComposer(
              $db: $db,
              $table: $db.classes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SectionsTableOrderingComposer get sectionId {
    final $$SectionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sectionId,
        referencedTable: $db.sections,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SectionsTableOrderingComposer(
              $db: $db,
              $table: $db.sections,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$StudentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StudentsTable> {
  $$StudentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get studentNumber => $composableBuilder(
      column: $table.studentNumber, builder: (column) => column);

  GeneratedColumn<String> get parentPhone => $composableBuilder(
      column: $table.parentPhone, builder: (column) => column);

  GeneratedColumn<String> get profileImage => $composableBuilder(
      column: $table.profileImage, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  $$ClassesTableAnnotationComposer get classId {
    final $$ClassesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.classId,
        referencedTable: $db.classes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassesTableAnnotationComposer(
              $db: $db,
              $table: $db.classes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SectionsTableAnnotationComposer get sectionId {
    final $$SectionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sectionId,
        referencedTable: $db.sections,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SectionsTableAnnotationComposer(
              $db: $db,
              $table: $db.sections,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> examGradesRefs<T extends Object>(
      Expression<T> Function($$ExamGradesTableAnnotationComposer a) f) {
    final $$ExamGradesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.examGrades,
        getReferencedColumn: (t) => t.studentId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamGradesTableAnnotationComposer(
              $db: $db,
              $table: $db.examGrades,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$StudentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $StudentsTable,
    Student,
    $$StudentsTableFilterComposer,
    $$StudentsTableOrderingComposer,
    $$StudentsTableAnnotationComposer,
    $$StudentsTableCreateCompanionBuilder,
    $$StudentsTableUpdateCompanionBuilder,
    (Student, $$StudentsTableReferences),
    Student,
    PrefetchHooks Function(
        {bool classId, bool sectionId, bool examGradesRefs})> {
  $$StudentsTableTableManager(_$AppDatabase db, $StudentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StudentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StudentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StudentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> studentNumber = const Value.absent(),
            Value<String> classId = const Value.absent(),
            Value<String?> sectionId = const Value.absent(),
            Value<String?> parentPhone = const Value.absent(),
            Value<String?> profileImage = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              StudentsCompanion(
            id: id,
            name: name,
            studentNumber: studentNumber,
            classId: classId,
            sectionId: sectionId,
            parentPhone: parentPhone,
            profileImage: profileImage,
            notes: notes,
            gender: gender,
            email: email,
            address: address,
            createdAt: createdAt,
            updatedAt: updatedAt,
            isDeleted: isDeleted,
            isActive: isActive,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required String studentNumber,
            required String classId,
            Value<String?> sectionId = const Value.absent(),
            Value<String?> parentPhone = const Value.absent(),
            Value<String?> profileImage = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              StudentsCompanion.insert(
            id: id,
            name: name,
            studentNumber: studentNumber,
            classId: classId,
            sectionId: sectionId,
            parentPhone: parentPhone,
            profileImage: profileImage,
            notes: notes,
            gender: gender,
            email: email,
            address: address,
            createdAt: createdAt,
            updatedAt: updatedAt,
            isDeleted: isDeleted,
            isActive: isActive,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$StudentsTable, Student>(table),
                    $$StudentsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {classId = false, sectionId = false, examGradesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (examGradesRefs) db.examGrades],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (classId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.classId,
                    referencedTable:
                        $$StudentsTableReferences._classIdTable(db),
                    referencedColumn:
                        $$StudentsTableReferences._classIdTable(db).id,
                  ) as T;
                }
                if (sectionId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.sectionId,
                    referencedTable:
                        $$StudentsTableReferences._sectionIdTable(db),
                    referencedColumn:
                        $$StudentsTableReferences._sectionIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (examGradesRefs)
                    await $_getPrefetchedData<Student, $StudentsTable,
                            ExamGradeModel>(
                        currentTable: table,
                        referencedTable:
                            $$StudentsTableReferences._examGradesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$StudentsTableReferences(db, table, p0)
                                .examGradesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.studentId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$StudentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $StudentsTable,
    Student,
    $$StudentsTableFilterComposer,
    $$StudentsTableOrderingComposer,
    $$StudentsTableAnnotationComposer,
    $$StudentsTableCreateCompanionBuilder,
    $$StudentsTableUpdateCompanionBuilder,
    (Student, $$StudentsTableReferences),
    Student,
    PrefetchHooks Function(
        {bool classId, bool sectionId, bool examGradesRefs})>;
typedef $$ExamsTableCreateCompanionBuilder = ExamsCompanion Function({
  required String id,
  required String title,
  required String schoolId,
  required String classId,
  Value<String?> sectionId,
  required String subjectId,
  Value<String?> teacherId,
  Value<String> type,
  Value<String> academicYear,
  Value<String> semester,
  required DateTime examDate,
  Value<int> duration,
  Value<double> totalMarks,
  Value<String?> instructions,
  Value<String> status,
  Value<bool> isTemplate,
  Value<bool> isDeleted,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});
typedef $$ExamsTableUpdateCompanionBuilder = ExamsCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String> schoolId,
  Value<String> classId,
  Value<String?> sectionId,
  Value<String> subjectId,
  Value<String?> teacherId,
  Value<String> type,
  Value<String> academicYear,
  Value<String> semester,
  Value<DateTime> examDate,
  Value<int> duration,
  Value<double> totalMarks,
  Value<String?> instructions,
  Value<String> status,
  Value<bool> isTemplate,
  Value<bool> isDeleted,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});

final class $$ExamsTableReferences
    extends BaseReferences<_$AppDatabase, $ExamsTable, ExamModel> {
  $$ExamsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $SchoolsTable _schoolIdTable(_$AppDatabase db) =>
      db.schools.createAlias('exams__school_id__schools__id');

  $$SchoolsTableProcessedTableManager get schoolId {
    final $_column = $_itemColumn<String>('school_id')!;

    final manager = $$SchoolsTableTableManager($_db, $_db.schools)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_schoolIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ClassesTable _classIdTable(_$AppDatabase db) =>
      db.classes.createAlias('exams__class_id__classes__id');

  $$ClassesTableProcessedTableManager get classId {
    final $_column = $_itemColumn<String>('class_id')!;

    final manager = $$ClassesTableTableManager($_db, $_db.classes)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_classIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $SectionsTable _sectionIdTable(_$AppDatabase db) =>
      db.sections.createAlias('exams__section_id__sections__id');

  $$SectionsTableProcessedTableManager? get sectionId {
    final $_column = $_itemColumn<String>('section_id');
    if ($_column == null) return null;
    final manager = $$SectionsTableTableManager($_db, $_db.sections)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_sectionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $SubjectsTable _subjectIdTable(_$AppDatabase db) =>
      db.subjects.createAlias('exams__subject_id__subjects__id');

  $$SubjectsTableProcessedTableManager get subjectId {
    final $_column = $_itemColumn<String>('subject_id')!;

    final manager = $$SubjectsTableTableManager($_db, $_db.subjects)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $TeachersTable _teacherIdTable(_$AppDatabase db) =>
      db.teachers.createAlias('exams__teacher_id__teachers__id');

  $$TeachersTableProcessedTableManager? get teacherId {
    final $_column = $_itemColumn<String>('teacher_id');
    if ($_column == null) return null;
    final manager = $$TeachersTableTableManager($_db, $_db.teachers)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_teacherIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$QuestionsTable, List<QuestionModel>>
      _questionsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.questions,
              aliasName: 'exams__id__questions__exam_id');

  $$QuestionsTableProcessedTableManager get questionsRefs {
    final manager = $$QuestionsTableTableManager($_db, $_db.questions)
        .filter((f) => f.examId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_questionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ExamGradesTable, List<ExamGradeModel>>
      _examGradesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.examGrades,
              aliasName: 'exams__id__exam_grades__exam_id');

  $$ExamGradesTableProcessedTableManager get examGradesRefs {
    final manager = $$ExamGradesTableTableManager($_db, $_db.examGrades)
        .filter((f) => f.examId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_examGradesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ExamsTableFilterComposer extends Composer<_$AppDatabase, $ExamsTable> {
  $$ExamsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get academicYear => $composableBuilder(
      column: $table.academicYear, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get semester => $composableBuilder(
      column: $table.semester, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get examDate => $composableBuilder(
      column: $table.examDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalMarks => $composableBuilder(
      column: $table.totalMarks, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get instructions => $composableBuilder(
      column: $table.instructions, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isTemplate => $composableBuilder(
      column: $table.isTemplate, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$SchoolsTableFilterComposer get schoolId {
    final $$SchoolsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.schoolId,
        referencedTable: $db.schools,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SchoolsTableFilterComposer(
              $db: $db,
              $table: $db.schools,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ClassesTableFilterComposer get classId {
    final $$ClassesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.classId,
        referencedTable: $db.classes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassesTableFilterComposer(
              $db: $db,
              $table: $db.classes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SectionsTableFilterComposer get sectionId {
    final $$SectionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sectionId,
        referencedTable: $db.sections,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SectionsTableFilterComposer(
              $db: $db,
              $table: $db.sections,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SubjectsTableFilterComposer get subjectId {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.subjectId,
        referencedTable: $db.subjects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SubjectsTableFilterComposer(
              $db: $db,
              $table: $db.subjects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TeachersTableFilterComposer get teacherId {
    final $$TeachersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.teacherId,
        referencedTable: $db.teachers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeachersTableFilterComposer(
              $db: $db,
              $table: $db.teachers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> questionsRefs(
      Expression<bool> Function($$QuestionsTableFilterComposer f) f) {
    final $$QuestionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.questions,
        getReferencedColumn: (t) => t.examId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionsTableFilterComposer(
              $db: $db,
              $table: $db.questions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> examGradesRefs(
      Expression<bool> Function($$ExamGradesTableFilterComposer f) f) {
    final $$ExamGradesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.examGrades,
        getReferencedColumn: (t) => t.examId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamGradesTableFilterComposer(
              $db: $db,
              $table: $db.examGrades,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ExamsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExamsTable> {
  $$ExamsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get academicYear => $composableBuilder(
      column: $table.academicYear,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get semester => $composableBuilder(
      column: $table.semester, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get examDate => $composableBuilder(
      column: $table.examDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalMarks => $composableBuilder(
      column: $table.totalMarks, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get instructions => $composableBuilder(
      column: $table.instructions,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isTemplate => $composableBuilder(
      column: $table.isTemplate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$SchoolsTableOrderingComposer get schoolId {
    final $$SchoolsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.schoolId,
        referencedTable: $db.schools,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SchoolsTableOrderingComposer(
              $db: $db,
              $table: $db.schools,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ClassesTableOrderingComposer get classId {
    final $$ClassesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.classId,
        referencedTable: $db.classes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassesTableOrderingComposer(
              $db: $db,
              $table: $db.classes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SectionsTableOrderingComposer get sectionId {
    final $$SectionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sectionId,
        referencedTable: $db.sections,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SectionsTableOrderingComposer(
              $db: $db,
              $table: $db.sections,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SubjectsTableOrderingComposer get subjectId {
    final $$SubjectsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.subjectId,
        referencedTable: $db.subjects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SubjectsTableOrderingComposer(
              $db: $db,
              $table: $db.subjects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TeachersTableOrderingComposer get teacherId {
    final $$TeachersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.teacherId,
        referencedTable: $db.teachers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeachersTableOrderingComposer(
              $db: $db,
              $table: $db.teachers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExamsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExamsTable> {
  $$ExamsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get academicYear => $composableBuilder(
      column: $table.academicYear, builder: (column) => column);

  GeneratedColumn<String> get semester =>
      $composableBuilder(column: $table.semester, builder: (column) => column);

  GeneratedColumn<DateTime> get examDate =>
      $composableBuilder(column: $table.examDate, builder: (column) => column);

  GeneratedColumn<int> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<double> get totalMarks => $composableBuilder(
      column: $table.totalMarks, builder: (column) => column);

  GeneratedColumn<String> get instructions => $composableBuilder(
      column: $table.instructions, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<bool> get isTemplate => $composableBuilder(
      column: $table.isTemplate, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$SchoolsTableAnnotationComposer get schoolId {
    final $$SchoolsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.schoolId,
        referencedTable: $db.schools,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SchoolsTableAnnotationComposer(
              $db: $db,
              $table: $db.schools,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ClassesTableAnnotationComposer get classId {
    final $$ClassesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.classId,
        referencedTable: $db.classes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassesTableAnnotationComposer(
              $db: $db,
              $table: $db.classes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SectionsTableAnnotationComposer get sectionId {
    final $$SectionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.sectionId,
        referencedTable: $db.sections,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SectionsTableAnnotationComposer(
              $db: $db,
              $table: $db.sections,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SubjectsTableAnnotationComposer get subjectId {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.subjectId,
        referencedTable: $db.subjects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SubjectsTableAnnotationComposer(
              $db: $db,
              $table: $db.subjects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TeachersTableAnnotationComposer get teacherId {
    final $$TeachersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.teacherId,
        referencedTable: $db.teachers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TeachersTableAnnotationComposer(
              $db: $db,
              $table: $db.teachers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> questionsRefs<T extends Object>(
      Expression<T> Function($$QuestionsTableAnnotationComposer a) f) {
    final $$QuestionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.questions,
        getReferencedColumn: (t) => t.examId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionsTableAnnotationComposer(
              $db: $db,
              $table: $db.questions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> examGradesRefs<T extends Object>(
      Expression<T> Function($$ExamGradesTableAnnotationComposer a) f) {
    final $$ExamGradesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.examGrades,
        getReferencedColumn: (t) => t.examId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamGradesTableAnnotationComposer(
              $db: $db,
              $table: $db.examGrades,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ExamsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExamsTable,
    ExamModel,
    $$ExamsTableFilterComposer,
    $$ExamsTableOrderingComposer,
    $$ExamsTableAnnotationComposer,
    $$ExamsTableCreateCompanionBuilder,
    $$ExamsTableUpdateCompanionBuilder,
    (ExamModel, $$ExamsTableReferences),
    ExamModel,
    PrefetchHooks Function(
        {bool schoolId,
        bool classId,
        bool sectionId,
        bool subjectId,
        bool teacherId,
        bool questionsRefs,
        bool examGradesRefs})> {
  $$ExamsTableTableManager(_$AppDatabase db, $ExamsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExamsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExamsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExamsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> schoolId = const Value.absent(),
            Value<String> classId = const Value.absent(),
            Value<String?> sectionId = const Value.absent(),
            Value<String> subjectId = const Value.absent(),
            Value<String?> teacherId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> academicYear = const Value.absent(),
            Value<String> semester = const Value.absent(),
            Value<DateTime> examDate = const Value.absent(),
            Value<int> duration = const Value.absent(),
            Value<double> totalMarks = const Value.absent(),
            Value<String?> instructions = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<bool> isTemplate = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExamsCompanion(
            id: id,
            title: title,
            schoolId: schoolId,
            classId: classId,
            sectionId: sectionId,
            subjectId: subjectId,
            teacherId: teacherId,
            type: type,
            academicYear: academicYear,
            semester: semester,
            examDate: examDate,
            duration: duration,
            totalMarks: totalMarks,
            instructions: instructions,
            status: status,
            isTemplate: isTemplate,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required String schoolId,
            required String classId,
            Value<String?> sectionId = const Value.absent(),
            required String subjectId,
            Value<String?> teacherId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> academicYear = const Value.absent(),
            Value<String> semester = const Value.absent(),
            required DateTime examDate,
            Value<int> duration = const Value.absent(),
            Value<double> totalMarks = const Value.absent(),
            Value<String?> instructions = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<bool> isTemplate = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExamsCompanion.insert(
            id: id,
            title: title,
            schoolId: schoolId,
            classId: classId,
            sectionId: sectionId,
            subjectId: subjectId,
            teacherId: teacherId,
            type: type,
            academicYear: academicYear,
            semester: semester,
            examDate: examDate,
            duration: duration,
            totalMarks: totalMarks,
            instructions: instructions,
            status: status,
            isTemplate: isTemplate,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$ExamsTable, ExamModel>(table),
                    $$ExamsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {schoolId = false,
              classId = false,
              sectionId = false,
              subjectId = false,
              teacherId = false,
              questionsRefs = false,
              examGradesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (questionsRefs) db.questions,
                if (examGradesRefs) db.examGrades
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (schoolId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.schoolId,
                    referencedTable: $$ExamsTableReferences._schoolIdTable(db),
                    referencedColumn:
                        $$ExamsTableReferences._schoolIdTable(db).id,
                  ) as T;
                }
                if (classId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.classId,
                    referencedTable: $$ExamsTableReferences._classIdTable(db),
                    referencedColumn:
                        $$ExamsTableReferences._classIdTable(db).id,
                  ) as T;
                }
                if (sectionId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.sectionId,
                    referencedTable: $$ExamsTableReferences._sectionIdTable(db),
                    referencedColumn:
                        $$ExamsTableReferences._sectionIdTable(db).id,
                  ) as T;
                }
                if (subjectId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.subjectId,
                    referencedTable: $$ExamsTableReferences._subjectIdTable(db),
                    referencedColumn:
                        $$ExamsTableReferences._subjectIdTable(db).id,
                  ) as T;
                }
                if (teacherId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.teacherId,
                    referencedTable: $$ExamsTableReferences._teacherIdTable(db),
                    referencedColumn:
                        $$ExamsTableReferences._teacherIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (questionsRefs)
                    await $_getPrefetchedData<ExamModel, $ExamsTable,
                            QuestionModel>(
                        currentTable: table,
                        referencedTable:
                            $$ExamsTableReferences._questionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ExamsTableReferences(db, table, p0).questionsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.examId == item.id),
                        typedResults: items),
                  if (examGradesRefs)
                    await $_getPrefetchedData<ExamModel, $ExamsTable,
                            ExamGradeModel>(
                        currentTable: table,
                        referencedTable:
                            $$ExamsTableReferences._examGradesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ExamsTableReferences(db, table, p0)
                                .examGradesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.examId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ExamsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExamsTable,
    ExamModel,
    $$ExamsTableFilterComposer,
    $$ExamsTableOrderingComposer,
    $$ExamsTableAnnotationComposer,
    $$ExamsTableCreateCompanionBuilder,
    $$ExamsTableUpdateCompanionBuilder,
    (ExamModel, $$ExamsTableReferences),
    ExamModel,
    PrefetchHooks Function(
        {bool schoolId,
        bool classId,
        bool sectionId,
        bool subjectId,
        bool teacherId,
        bool questionsRefs,
        bool examGradesRefs})>;
typedef $$QuestionBankItemsTableCreateCompanionBuilder
    = QuestionBankItemsCompanion Function({
  required String id,
  required String subjectId,
  Value<String?> classId,
  required String type,
  required String content,
  Value<String?> unit,
  Value<String?> lesson,
  Value<String> difficulty,
  Value<double> marks,
  Value<String?> correctAnswer,
  Value<String?> explanation,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});
typedef $$QuestionBankItemsTableUpdateCompanionBuilder
    = QuestionBankItemsCompanion Function({
  Value<String> id,
  Value<String> subjectId,
  Value<String?> classId,
  Value<String> type,
  Value<String> content,
  Value<String?> unit,
  Value<String?> lesson,
  Value<String> difficulty,
  Value<double> marks,
  Value<String?> correctAnswer,
  Value<String?> explanation,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});

final class $$QuestionBankItemsTableReferences extends BaseReferences<
    _$AppDatabase, $QuestionBankItemsTable, QuestionBankItemModel> {
  $$QuestionBankItemsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $SubjectsTable _subjectIdTable(_$AppDatabase db) =>
      db.subjects.createAlias('question_bank_items__subject_id__subjects__id');

  $$SubjectsTableProcessedTableManager get subjectId {
    final $_column = $_itemColumn<String>('subject_id')!;

    final manager = $$SubjectsTableTableManager($_db, $_db.subjects)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ClassesTable _classIdTable(_$AppDatabase db) =>
      db.classes.createAlias('question_bank_items__class_id__classes__id');

  $$ClassesTableProcessedTableManager? get classId {
    final $_column = $_itemColumn<String>('class_id');
    if ($_column == null) return null;
    final manager = $$ClassesTableTableManager($_db, $_db.classes)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_classIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$QuestionsTable, List<QuestionModel>>
      _questionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.questions,
          aliasName: 'question_bank_items__id__questions__question_bank_id');

  $$QuestionsTableProcessedTableManager get questionsRefs {
    final manager = $$QuestionsTableTableManager($_db, $_db.questions).filter(
        (f) => f.questionBankId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_questionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$QuestionBankItemsTableFilterComposer
    extends Composer<_$AppDatabase, $QuestionBankItemsTable> {
  $$QuestionBankItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lesson => $composableBuilder(
      column: $table.lesson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get marks => $composableBuilder(
      column: $table.marks, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get correctAnswer => $composableBuilder(
      column: $table.correctAnswer, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get explanation => $composableBuilder(
      column: $table.explanation, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$SubjectsTableFilterComposer get subjectId {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.subjectId,
        referencedTable: $db.subjects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SubjectsTableFilterComposer(
              $db: $db,
              $table: $db.subjects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ClassesTableFilterComposer get classId {
    final $$ClassesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.classId,
        referencedTable: $db.classes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassesTableFilterComposer(
              $db: $db,
              $table: $db.classes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> questionsRefs(
      Expression<bool> Function($$QuestionsTableFilterComposer f) f) {
    final $$QuestionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.questions,
        getReferencedColumn: (t) => t.questionBankId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionsTableFilterComposer(
              $db: $db,
              $table: $db.questions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$QuestionBankItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $QuestionBankItemsTable> {
  $$QuestionBankItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lesson => $composableBuilder(
      column: $table.lesson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get marks => $composableBuilder(
      column: $table.marks, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get correctAnswer => $composableBuilder(
      column: $table.correctAnswer,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get explanation => $composableBuilder(
      column: $table.explanation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$SubjectsTableOrderingComposer get subjectId {
    final $$SubjectsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.subjectId,
        referencedTable: $db.subjects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SubjectsTableOrderingComposer(
              $db: $db,
              $table: $db.subjects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ClassesTableOrderingComposer get classId {
    final $$ClassesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.classId,
        referencedTable: $db.classes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassesTableOrderingComposer(
              $db: $db,
              $table: $db.classes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$QuestionBankItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuestionBankItemsTable> {
  $$QuestionBankItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get lesson =>
      $composableBuilder(column: $table.lesson, builder: (column) => column);

  GeneratedColumn<String> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => column);

  GeneratedColumn<double> get marks =>
      $composableBuilder(column: $table.marks, builder: (column) => column);

  GeneratedColumn<String> get correctAnswer => $composableBuilder(
      column: $table.correctAnswer, builder: (column) => column);

  GeneratedColumn<String> get explanation => $composableBuilder(
      column: $table.explanation, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$SubjectsTableAnnotationComposer get subjectId {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.subjectId,
        referencedTable: $db.subjects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SubjectsTableAnnotationComposer(
              $db: $db,
              $table: $db.subjects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ClassesTableAnnotationComposer get classId {
    final $$ClassesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.classId,
        referencedTable: $db.classes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassesTableAnnotationComposer(
              $db: $db,
              $table: $db.classes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> questionsRefs<T extends Object>(
      Expression<T> Function($$QuestionsTableAnnotationComposer a) f) {
    final $$QuestionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.questions,
        getReferencedColumn: (t) => t.questionBankId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionsTableAnnotationComposer(
              $db: $db,
              $table: $db.questions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$QuestionBankItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $QuestionBankItemsTable,
    QuestionBankItemModel,
    $$QuestionBankItemsTableFilterComposer,
    $$QuestionBankItemsTableOrderingComposer,
    $$QuestionBankItemsTableAnnotationComposer,
    $$QuestionBankItemsTableCreateCompanionBuilder,
    $$QuestionBankItemsTableUpdateCompanionBuilder,
    (QuestionBankItemModel, $$QuestionBankItemsTableReferences),
    QuestionBankItemModel,
    PrefetchHooks Function(
        {bool subjectId, bool classId, bool questionsRefs})> {
  $$QuestionBankItemsTableTableManager(
      _$AppDatabase db, $QuestionBankItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuestionBankItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuestionBankItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuestionBankItemsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> subjectId = const Value.absent(),
            Value<String?> classId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String?> unit = const Value.absent(),
            Value<String?> lesson = const Value.absent(),
            Value<String> difficulty = const Value.absent(),
            Value<double> marks = const Value.absent(),
            Value<String?> correctAnswer = const Value.absent(),
            Value<String?> explanation = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              QuestionBankItemsCompanion(
            id: id,
            subjectId: subjectId,
            classId: classId,
            type: type,
            content: content,
            unit: unit,
            lesson: lesson,
            difficulty: difficulty,
            marks: marks,
            correctAnswer: correctAnswer,
            explanation: explanation,
            isActive: isActive,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String subjectId,
            Value<String?> classId = const Value.absent(),
            required String type,
            required String content,
            Value<String?> unit = const Value.absent(),
            Value<String?> lesson = const Value.absent(),
            Value<String> difficulty = const Value.absent(),
            Value<double> marks = const Value.absent(),
            Value<String?> correctAnswer = const Value.absent(),
            Value<String?> explanation = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              QuestionBankItemsCompanion.insert(
            id: id,
            subjectId: subjectId,
            classId: classId,
            type: type,
            content: content,
            unit: unit,
            lesson: lesson,
            difficulty: difficulty,
            marks: marks,
            correctAnswer: correctAnswer,
            explanation: explanation,
            isActive: isActive,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$QuestionBankItemsTable, QuestionBankItemModel>(
                        table),
                    $$QuestionBankItemsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {subjectId = false, classId = false, questionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (questionsRefs) db.questions],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (subjectId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.subjectId,
                    referencedTable:
                        $$QuestionBankItemsTableReferences._subjectIdTable(db),
                    referencedColumn: $$QuestionBankItemsTableReferences
                        ._subjectIdTable(db)
                        .id,
                  ) as T;
                }
                if (classId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.classId,
                    referencedTable:
                        $$QuestionBankItemsTableReferences._classIdTable(db),
                    referencedColumn:
                        $$QuestionBankItemsTableReferences._classIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (questionsRefs)
                    await $_getPrefetchedData<QuestionBankItemModel,
                            $QuestionBankItemsTable, QuestionModel>(
                        currentTable: table,
                        referencedTable: $$QuestionBankItemsTableReferences
                            ._questionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$QuestionBankItemsTableReferences(db, table, p0)
                                .questionsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.questionBankId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$QuestionBankItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $QuestionBankItemsTable,
    QuestionBankItemModel,
    $$QuestionBankItemsTableFilterComposer,
    $$QuestionBankItemsTableOrderingComposer,
    $$QuestionBankItemsTableAnnotationComposer,
    $$QuestionBankItemsTableCreateCompanionBuilder,
    $$QuestionBankItemsTableUpdateCompanionBuilder,
    (QuestionBankItemModel, $$QuestionBankItemsTableReferences),
    QuestionBankItemModel,
    PrefetchHooks Function({bool subjectId, bool classId, bool questionsRefs})>;
typedef $$QuestionsTableCreateCompanionBuilder = QuestionsCompanion Function({
  required String id,
  Value<String?> examId,
  Value<String?> parentId,
  Value<String?> questionBankId,
  required String type,
  required String content,
  Value<String?> instructions,
  Value<double> marks,
  Value<int> order,
  Value<String> difficulty,
  Value<String?> unit,
  Value<String?> lesson,
  Value<String?> correctAnswer,
  Value<String?> explanation,
  Value<bool> isActive,
  Value<bool> isDeleted,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});
typedef $$QuestionsTableUpdateCompanionBuilder = QuestionsCompanion Function({
  Value<String> id,
  Value<String?> examId,
  Value<String?> parentId,
  Value<String?> questionBankId,
  Value<String> type,
  Value<String> content,
  Value<String?> instructions,
  Value<double> marks,
  Value<int> order,
  Value<String> difficulty,
  Value<String?> unit,
  Value<String?> lesson,
  Value<String?> correctAnswer,
  Value<String?> explanation,
  Value<bool> isActive,
  Value<bool> isDeleted,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});

final class $$QuestionsTableReferences
    extends BaseReferences<_$AppDatabase, $QuestionsTable, QuestionModel> {
  $$QuestionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ExamsTable _examIdTable(_$AppDatabase db) =>
      db.exams.createAlias('questions__exam_id__exams__id');

  $$ExamsTableProcessedTableManager? get examId {
    final $_column = $_itemColumn<String>('exam_id');
    if ($_column == null) return null;
    final manager = $$ExamsTableTableManager($_db, $_db.exams)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_examIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $QuestionsTable _parentIdTable(_$AppDatabase db) =>
      db.questions.createAlias('questions__parent_id__questions__id');

  $$QuestionsTableProcessedTableManager? get parentId {
    final $_column = $_itemColumn<String>('parent_id');
    if ($_column == null) return null;
    final manager = $$QuestionsTableTableManager($_db, $_db.questions)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_parentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $QuestionBankItemsTable _questionBankIdTable(_$AppDatabase db) =>
      db.questionBankItems
          .createAlias('questions__question_bank_id__question_bank_items__id');

  $$QuestionBankItemsTableProcessedTableManager? get questionBankId {
    final $_column = $_itemColumn<String>('question_bank_id');
    if ($_column == null) return null;
    final manager =
        $$QuestionBankItemsTableTableManager($_db, $_db.questionBankItems)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_questionBankIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$QuestionBlocksTable, List<QuestionBlockModel>>
      _questionBlocksRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.questionBlocks,
              aliasName: 'questions__id__question_blocks__question_id');

  $$QuestionBlocksTableProcessedTableManager get questionBlocksRefs {
    final manager = $$QuestionBlocksTableTableManager($_db, $_db.questionBlocks)
        .filter((f) => f.questionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_questionBlocksRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$QuestionOptionsTable, List<QuestionOptionModel>>
      _questionOptionsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.questionOptions,
              aliasName: 'questions__id__question_options__question_id');

  $$QuestionOptionsTableProcessedTableManager get questionOptionsRefs {
    final manager = $$QuestionOptionsTableTableManager(
            $_db, $_db.questionOptions)
        .filter((f) => f.questionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_questionOptionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$QuestionsTableFilterComposer
    extends Composer<_$AppDatabase, $QuestionsTable> {
  $$QuestionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get instructions => $composableBuilder(
      column: $table.instructions, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get marks => $composableBuilder(
      column: $table.marks, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get order => $composableBuilder(
      column: $table.order, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lesson => $composableBuilder(
      column: $table.lesson, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get correctAnswer => $composableBuilder(
      column: $table.correctAnswer, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get explanation => $composableBuilder(
      column: $table.explanation, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$ExamsTableFilterComposer get examId {
    final $$ExamsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.examId,
        referencedTable: $db.exams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamsTableFilterComposer(
              $db: $db,
              $table: $db.exams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$QuestionsTableFilterComposer get parentId {
    final $$QuestionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parentId,
        referencedTable: $db.questions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionsTableFilterComposer(
              $db: $db,
              $table: $db.questions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$QuestionBankItemsTableFilterComposer get questionBankId {
    final $$QuestionBankItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.questionBankId,
        referencedTable: $db.questionBankItems,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionBankItemsTableFilterComposer(
              $db: $db,
              $table: $db.questionBankItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> questionBlocksRefs(
      Expression<bool> Function($$QuestionBlocksTableFilterComposer f) f) {
    final $$QuestionBlocksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.questionBlocks,
        getReferencedColumn: (t) => t.questionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionBlocksTableFilterComposer(
              $db: $db,
              $table: $db.questionBlocks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> questionOptionsRefs(
      Expression<bool> Function($$QuestionOptionsTableFilterComposer f) f) {
    final $$QuestionOptionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.questionOptions,
        getReferencedColumn: (t) => t.questionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionOptionsTableFilterComposer(
              $db: $db,
              $table: $db.questionOptions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$QuestionsTableOrderingComposer
    extends Composer<_$AppDatabase, $QuestionsTable> {
  $$QuestionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get instructions => $composableBuilder(
      column: $table.instructions,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get marks => $composableBuilder(
      column: $table.marks, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get order => $composableBuilder(
      column: $table.order, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lesson => $composableBuilder(
      column: $table.lesson, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get correctAnswer => $composableBuilder(
      column: $table.correctAnswer,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get explanation => $composableBuilder(
      column: $table.explanation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$ExamsTableOrderingComposer get examId {
    final $$ExamsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.examId,
        referencedTable: $db.exams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamsTableOrderingComposer(
              $db: $db,
              $table: $db.exams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$QuestionsTableOrderingComposer get parentId {
    final $$QuestionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parentId,
        referencedTable: $db.questions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionsTableOrderingComposer(
              $db: $db,
              $table: $db.questions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$QuestionBankItemsTableOrderingComposer get questionBankId {
    final $$QuestionBankItemsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.questionBankId,
        referencedTable: $db.questionBankItems,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionBankItemsTableOrderingComposer(
              $db: $db,
              $table: $db.questionBankItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$QuestionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuestionsTable> {
  $$QuestionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<String> get instructions => $composableBuilder(
      column: $table.instructions, builder: (column) => column);

  GeneratedColumn<double> get marks =>
      $composableBuilder(column: $table.marks, builder: (column) => column);

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumn<String> get difficulty => $composableBuilder(
      column: $table.difficulty, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get lesson =>
      $composableBuilder(column: $table.lesson, builder: (column) => column);

  GeneratedColumn<String> get correctAnswer => $composableBuilder(
      column: $table.correctAnswer, builder: (column) => column);

  GeneratedColumn<String> get explanation => $composableBuilder(
      column: $table.explanation, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ExamsTableAnnotationComposer get examId {
    final $$ExamsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.examId,
        referencedTable: $db.exams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamsTableAnnotationComposer(
              $db: $db,
              $table: $db.exams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$QuestionsTableAnnotationComposer get parentId {
    final $$QuestionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.parentId,
        referencedTable: $db.questions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionsTableAnnotationComposer(
              $db: $db,
              $table: $db.questions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$QuestionBankItemsTableAnnotationComposer get questionBankId {
    final $$QuestionBankItemsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.questionBankId,
            referencedTable: $db.questionBankItems,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$QuestionBankItemsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.questionBankItems,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  Expression<T> questionBlocksRefs<T extends Object>(
      Expression<T> Function($$QuestionBlocksTableAnnotationComposer a) f) {
    final $$QuestionBlocksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.questionBlocks,
        getReferencedColumn: (t) => t.questionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionBlocksTableAnnotationComposer(
              $db: $db,
              $table: $db.questionBlocks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> questionOptionsRefs<T extends Object>(
      Expression<T> Function($$QuestionOptionsTableAnnotationComposer a) f) {
    final $$QuestionOptionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.questionOptions,
        getReferencedColumn: (t) => t.questionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionOptionsTableAnnotationComposer(
              $db: $db,
              $table: $db.questionOptions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$QuestionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $QuestionsTable,
    QuestionModel,
    $$QuestionsTableFilterComposer,
    $$QuestionsTableOrderingComposer,
    $$QuestionsTableAnnotationComposer,
    $$QuestionsTableCreateCompanionBuilder,
    $$QuestionsTableUpdateCompanionBuilder,
    (QuestionModel, $$QuestionsTableReferences),
    QuestionModel,
    PrefetchHooks Function(
        {bool examId,
        bool parentId,
        bool questionBankId,
        bool questionBlocksRefs,
        bool questionOptionsRefs})> {
  $$QuestionsTableTableManager(_$AppDatabase db, $QuestionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuestionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuestionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuestionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> examId = const Value.absent(),
            Value<String?> parentId = const Value.absent(),
            Value<String?> questionBankId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<String?> instructions = const Value.absent(),
            Value<double> marks = const Value.absent(),
            Value<int> order = const Value.absent(),
            Value<String> difficulty = const Value.absent(),
            Value<String?> unit = const Value.absent(),
            Value<String?> lesson = const Value.absent(),
            Value<String?> correctAnswer = const Value.absent(),
            Value<String?> explanation = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              QuestionsCompanion(
            id: id,
            examId: examId,
            parentId: parentId,
            questionBankId: questionBankId,
            type: type,
            content: content,
            instructions: instructions,
            marks: marks,
            order: order,
            difficulty: difficulty,
            unit: unit,
            lesson: lesson,
            correctAnswer: correctAnswer,
            explanation: explanation,
            isActive: isActive,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> examId = const Value.absent(),
            Value<String?> parentId = const Value.absent(),
            Value<String?> questionBankId = const Value.absent(),
            required String type,
            required String content,
            Value<String?> instructions = const Value.absent(),
            Value<double> marks = const Value.absent(),
            Value<int> order = const Value.absent(),
            Value<String> difficulty = const Value.absent(),
            Value<String?> unit = const Value.absent(),
            Value<String?> lesson = const Value.absent(),
            Value<String?> correctAnswer = const Value.absent(),
            Value<String?> explanation = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              QuestionsCompanion.insert(
            id: id,
            examId: examId,
            parentId: parentId,
            questionBankId: questionBankId,
            type: type,
            content: content,
            instructions: instructions,
            marks: marks,
            order: order,
            difficulty: difficulty,
            unit: unit,
            lesson: lesson,
            correctAnswer: correctAnswer,
            explanation: explanation,
            isActive: isActive,
            isDeleted: isDeleted,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$QuestionsTable, QuestionModel>(table),
                    $$QuestionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {examId = false,
              parentId = false,
              questionBankId = false,
              questionBlocksRefs = false,
              questionOptionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (questionBlocksRefs) db.questionBlocks,
                if (questionOptionsRefs) db.questionOptions
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (examId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.examId,
                    referencedTable:
                        $$QuestionsTableReferences._examIdTable(db),
                    referencedColumn:
                        $$QuestionsTableReferences._examIdTable(db).id,
                  ) as T;
                }
                if (parentId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.parentId,
                    referencedTable:
                        $$QuestionsTableReferences._parentIdTable(db),
                    referencedColumn:
                        $$QuestionsTableReferences._parentIdTable(db).id,
                  ) as T;
                }
                if (questionBankId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.questionBankId,
                    referencedTable:
                        $$QuestionsTableReferences._questionBankIdTable(db),
                    referencedColumn:
                        $$QuestionsTableReferences._questionBankIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (questionBlocksRefs)
                    await $_getPrefetchedData<QuestionModel, $QuestionsTable,
                            QuestionBlockModel>(
                        currentTable: table,
                        referencedTable: $$QuestionsTableReferences
                            ._questionBlocksRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$QuestionsTableReferences(db, table, p0)
                                .questionBlocksRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.questionId == item.id),
                        typedResults: items),
                  if (questionOptionsRefs)
                    await $_getPrefetchedData<QuestionModel, $QuestionsTable,
                            QuestionOptionModel>(
                        currentTable: table,
                        referencedTable: $$QuestionsTableReferences
                            ._questionOptionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$QuestionsTableReferences(db, table, p0)
                                .questionOptionsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.questionId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$QuestionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $QuestionsTable,
    QuestionModel,
    $$QuestionsTableFilterComposer,
    $$QuestionsTableOrderingComposer,
    $$QuestionsTableAnnotationComposer,
    $$QuestionsTableCreateCompanionBuilder,
    $$QuestionsTableUpdateCompanionBuilder,
    (QuestionModel, $$QuestionsTableReferences),
    QuestionModel,
    PrefetchHooks Function(
        {bool examId,
        bool parentId,
        bool questionBankId,
        bool questionBlocksRefs,
        bool questionOptionsRefs})>;
typedef $$QuestionBlocksTableCreateCompanionBuilder = QuestionBlocksCompanion
    Function({
  required String id,
  required String questionId,
  required String type,
  required String content,
  Value<int> order,
  Value<String?> metadata,
  Value<int> rowid,
});
typedef $$QuestionBlocksTableUpdateCompanionBuilder = QuestionBlocksCompanion
    Function({
  Value<String> id,
  Value<String> questionId,
  Value<String> type,
  Value<String> content,
  Value<int> order,
  Value<String?> metadata,
  Value<int> rowid,
});

final class $$QuestionBlocksTableReferences extends BaseReferences<
    _$AppDatabase, $QuestionBlocksTable, QuestionBlockModel> {
  $$QuestionBlocksTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $QuestionsTable _questionIdTable(_$AppDatabase db) =>
      db.questions.createAlias('question_blocks__question_id__questions__id');

  $$QuestionsTableProcessedTableManager get questionId {
    final $_column = $_itemColumn<String>('question_id')!;

    final manager = $$QuestionsTableTableManager($_db, $_db.questions)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_questionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$QuestionBlocksTableFilterComposer
    extends Composer<_$AppDatabase, $QuestionBlocksTable> {
  $$QuestionBlocksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get order => $composableBuilder(
      column: $table.order, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get metadata => $composableBuilder(
      column: $table.metadata, builder: (column) => ColumnFilters(column));

  $$QuestionsTableFilterComposer get questionId {
    final $$QuestionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.questionId,
        referencedTable: $db.questions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionsTableFilterComposer(
              $db: $db,
              $table: $db.questions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$QuestionBlocksTableOrderingComposer
    extends Composer<_$AppDatabase, $QuestionBlocksTable> {
  $$QuestionBlocksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get order => $composableBuilder(
      column: $table.order, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get metadata => $composableBuilder(
      column: $table.metadata, builder: (column) => ColumnOrderings(column));

  $$QuestionsTableOrderingComposer get questionId {
    final $$QuestionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.questionId,
        referencedTable: $db.questions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionsTableOrderingComposer(
              $db: $db,
              $table: $db.questions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$QuestionBlocksTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuestionBlocksTable> {
  $$QuestionBlocksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumn<String> get metadata =>
      $composableBuilder(column: $table.metadata, builder: (column) => column);

  $$QuestionsTableAnnotationComposer get questionId {
    final $$QuestionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.questionId,
        referencedTable: $db.questions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionsTableAnnotationComposer(
              $db: $db,
              $table: $db.questions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$QuestionBlocksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $QuestionBlocksTable,
    QuestionBlockModel,
    $$QuestionBlocksTableFilterComposer,
    $$QuestionBlocksTableOrderingComposer,
    $$QuestionBlocksTableAnnotationComposer,
    $$QuestionBlocksTableCreateCompanionBuilder,
    $$QuestionBlocksTableUpdateCompanionBuilder,
    (QuestionBlockModel, $$QuestionBlocksTableReferences),
    QuestionBlockModel,
    PrefetchHooks Function({bool questionId})> {
  $$QuestionBlocksTableTableManager(
      _$AppDatabase db, $QuestionBlocksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuestionBlocksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuestionBlocksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuestionBlocksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> questionId = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<int> order = const Value.absent(),
            Value<String?> metadata = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              QuestionBlocksCompanion(
            id: id,
            questionId: questionId,
            type: type,
            content: content,
            order: order,
            metadata: metadata,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String questionId,
            required String type,
            required String content,
            Value<int> order = const Value.absent(),
            Value<String?> metadata = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              QuestionBlocksCompanion.insert(
            id: id,
            questionId: questionId,
            type: type,
            content: content,
            order: order,
            metadata: metadata,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$QuestionBlocksTable, QuestionBlockModel>(
                        table),
                    $$QuestionBlocksTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({questionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (questionId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.questionId,
                    referencedTable:
                        $$QuestionBlocksTableReferences._questionIdTable(db),
                    referencedColumn:
                        $$QuestionBlocksTableReferences._questionIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$QuestionBlocksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $QuestionBlocksTable,
    QuestionBlockModel,
    $$QuestionBlocksTableFilterComposer,
    $$QuestionBlocksTableOrderingComposer,
    $$QuestionBlocksTableAnnotationComposer,
    $$QuestionBlocksTableCreateCompanionBuilder,
    $$QuestionBlocksTableUpdateCompanionBuilder,
    (QuestionBlockModel, $$QuestionBlocksTableReferences),
    QuestionBlockModel,
    PrefetchHooks Function({bool questionId})>;
typedef $$QuestionOptionsTableCreateCompanionBuilder = QuestionOptionsCompanion
    Function({
  required String id,
  required String questionId,
  required String content,
  Value<int> order,
  Value<bool> isCorrect,
  Value<int> rowid,
});
typedef $$QuestionOptionsTableUpdateCompanionBuilder = QuestionOptionsCompanion
    Function({
  Value<String> id,
  Value<String> questionId,
  Value<String> content,
  Value<int> order,
  Value<bool> isCorrect,
  Value<int> rowid,
});

final class $$QuestionOptionsTableReferences extends BaseReferences<
    _$AppDatabase, $QuestionOptionsTable, QuestionOptionModel> {
  $$QuestionOptionsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $QuestionsTable _questionIdTable(_$AppDatabase db) =>
      db.questions.createAlias('question_options__question_id__questions__id');

  $$QuestionsTableProcessedTableManager get questionId {
    final $_column = $_itemColumn<String>('question_id')!;

    final manager = $$QuestionsTableTableManager($_db, $_db.questions)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_questionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$QuestionOptionsTableFilterComposer
    extends Composer<_$AppDatabase, $QuestionOptionsTable> {
  $$QuestionOptionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get order => $composableBuilder(
      column: $table.order, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isCorrect => $composableBuilder(
      column: $table.isCorrect, builder: (column) => ColumnFilters(column));

  $$QuestionsTableFilterComposer get questionId {
    final $$QuestionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.questionId,
        referencedTable: $db.questions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionsTableFilterComposer(
              $db: $db,
              $table: $db.questions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$QuestionOptionsTableOrderingComposer
    extends Composer<_$AppDatabase, $QuestionOptionsTable> {
  $$QuestionOptionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get content => $composableBuilder(
      column: $table.content, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get order => $composableBuilder(
      column: $table.order, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isCorrect => $composableBuilder(
      column: $table.isCorrect, builder: (column) => ColumnOrderings(column));

  $$QuestionsTableOrderingComposer get questionId {
    final $$QuestionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.questionId,
        referencedTable: $db.questions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionsTableOrderingComposer(
              $db: $db,
              $table: $db.questions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$QuestionOptionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuestionOptionsTable> {
  $$QuestionOptionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  GeneratedColumn<bool> get isCorrect =>
      $composableBuilder(column: $table.isCorrect, builder: (column) => column);

  $$QuestionsTableAnnotationComposer get questionId {
    final $$QuestionsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.questionId,
        referencedTable: $db.questions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$QuestionsTableAnnotationComposer(
              $db: $db,
              $table: $db.questions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$QuestionOptionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $QuestionOptionsTable,
    QuestionOptionModel,
    $$QuestionOptionsTableFilterComposer,
    $$QuestionOptionsTableOrderingComposer,
    $$QuestionOptionsTableAnnotationComposer,
    $$QuestionOptionsTableCreateCompanionBuilder,
    $$QuestionOptionsTableUpdateCompanionBuilder,
    (QuestionOptionModel, $$QuestionOptionsTableReferences),
    QuestionOptionModel,
    PrefetchHooks Function({bool questionId})> {
  $$QuestionOptionsTableTableManager(
      _$AppDatabase db, $QuestionOptionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuestionOptionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuestionOptionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuestionOptionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> questionId = const Value.absent(),
            Value<String> content = const Value.absent(),
            Value<int> order = const Value.absent(),
            Value<bool> isCorrect = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              QuestionOptionsCompanion(
            id: id,
            questionId: questionId,
            content: content,
            order: order,
            isCorrect: isCorrect,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String questionId,
            required String content,
            Value<int> order = const Value.absent(),
            Value<bool> isCorrect = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              QuestionOptionsCompanion.insert(
            id: id,
            questionId: questionId,
            content: content,
            order: order,
            isCorrect: isCorrect,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$QuestionOptionsTable, QuestionOptionModel>(
                        table),
                    $$QuestionOptionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({questionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (questionId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.questionId,
                    referencedTable:
                        $$QuestionOptionsTableReferences._questionIdTable(db),
                    referencedColumn: $$QuestionOptionsTableReferences
                        ._questionIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$QuestionOptionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $QuestionOptionsTable,
    QuestionOptionModel,
    $$QuestionOptionsTableFilterComposer,
    $$QuestionOptionsTableOrderingComposer,
    $$QuestionOptionsTableAnnotationComposer,
    $$QuestionOptionsTableCreateCompanionBuilder,
    $$QuestionOptionsTableUpdateCompanionBuilder,
    (QuestionOptionModel, $$QuestionOptionsTableReferences),
    QuestionOptionModel,
    PrefetchHooks Function({bool questionId})>;
typedef $$ExamGradesTableCreateCompanionBuilder = ExamGradesCompanion Function({
  required String id,
  required String examId,
  required String studentId,
  Value<double> score,
  Value<String?> grade,
  Value<String?> notes,
  Value<bool> isAbsent,
  Value<DateTime?> gradedAt,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$ExamGradesTableUpdateCompanionBuilder = ExamGradesCompanion Function({
  Value<String> id,
  Value<String> examId,
  Value<String> studentId,
  Value<double> score,
  Value<String?> grade,
  Value<String?> notes,
  Value<bool> isAbsent,
  Value<DateTime?> gradedAt,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$ExamGradesTableReferences
    extends BaseReferences<_$AppDatabase, $ExamGradesTable, ExamGradeModel> {
  $$ExamGradesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ExamsTable _examIdTable(_$AppDatabase db) =>
      db.exams.createAlias('exam_grades__exam_id__exams__id');

  $$ExamsTableProcessedTableManager get examId {
    final $_column = $_itemColumn<String>('exam_id')!;

    final manager = $$ExamsTableTableManager($_db, $_db.exams)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_examIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $StudentsTable _studentIdTable(_$AppDatabase db) =>
      db.students.createAlias('exam_grades__student_id__students__id');

  $$StudentsTableProcessedTableManager get studentId {
    final $_column = $_itemColumn<String>('student_id')!;

    final manager = $$StudentsTableTableManager($_db, $_db.students)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_studentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ExamGradesTableFilterComposer
    extends Composer<_$AppDatabase, $ExamGradesTable> {
  $$ExamGradesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get score => $composableBuilder(
      column: $table.score, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get grade => $composableBuilder(
      column: $table.grade, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isAbsent => $composableBuilder(
      column: $table.isAbsent, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get gradedAt => $composableBuilder(
      column: $table.gradedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$ExamsTableFilterComposer get examId {
    final $$ExamsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.examId,
        referencedTable: $db.exams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamsTableFilterComposer(
              $db: $db,
              $table: $db.exams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$StudentsTableFilterComposer get studentId {
    final $$StudentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.studentId,
        referencedTable: $db.students,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentsTableFilterComposer(
              $db: $db,
              $table: $db.students,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExamGradesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExamGradesTable> {
  $$ExamGradesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get score => $composableBuilder(
      column: $table.score, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get grade => $composableBuilder(
      column: $table.grade, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isAbsent => $composableBuilder(
      column: $table.isAbsent, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get gradedAt => $composableBuilder(
      column: $table.gradedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$ExamsTableOrderingComposer get examId {
    final $$ExamsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.examId,
        referencedTable: $db.exams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamsTableOrderingComposer(
              $db: $db,
              $table: $db.exams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$StudentsTableOrderingComposer get studentId {
    final $$StudentsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.studentId,
        referencedTable: $db.students,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentsTableOrderingComposer(
              $db: $db,
              $table: $db.students,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExamGradesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExamGradesTable> {
  $$ExamGradesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get score =>
      $composableBuilder(column: $table.score, builder: (column) => column);

  GeneratedColumn<String> get grade =>
      $composableBuilder(column: $table.grade, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isAbsent =>
      $composableBuilder(column: $table.isAbsent, builder: (column) => column);

  GeneratedColumn<DateTime> get gradedAt =>
      $composableBuilder(column: $table.gradedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ExamsTableAnnotationComposer get examId {
    final $$ExamsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.examId,
        referencedTable: $db.exams,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ExamsTableAnnotationComposer(
              $db: $db,
              $table: $db.exams,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$StudentsTableAnnotationComposer get studentId {
    final $$StudentsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.studentId,
        referencedTable: $db.students,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$StudentsTableAnnotationComposer(
              $db: $db,
              $table: $db.students,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExamGradesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExamGradesTable,
    ExamGradeModel,
    $$ExamGradesTableFilterComposer,
    $$ExamGradesTableOrderingComposer,
    $$ExamGradesTableAnnotationComposer,
    $$ExamGradesTableCreateCompanionBuilder,
    $$ExamGradesTableUpdateCompanionBuilder,
    (ExamGradeModel, $$ExamGradesTableReferences),
    ExamGradeModel,
    PrefetchHooks Function({bool examId, bool studentId})> {
  $$ExamGradesTableTableManager(_$AppDatabase db, $ExamGradesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExamGradesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExamGradesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExamGradesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> examId = const Value.absent(),
            Value<String> studentId = const Value.absent(),
            Value<double> score = const Value.absent(),
            Value<String?> grade = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<bool> isAbsent = const Value.absent(),
            Value<DateTime?> gradedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExamGradesCompanion(
            id: id,
            examId: examId,
            studentId: studentId,
            score: score,
            grade: grade,
            notes: notes,
            isAbsent: isAbsent,
            gradedAt: gradedAt,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String examId,
            required String studentId,
            Value<double> score = const Value.absent(),
            Value<String?> grade = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<bool> isAbsent = const Value.absent(),
            Value<DateTime?> gradedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExamGradesCompanion.insert(
            id: id,
            examId: examId,
            studentId: studentId,
            score: score,
            grade: grade,
            notes: notes,
            isAbsent: isAbsent,
            gradedAt: gradedAt,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$ExamGradesTable, ExamGradeModel>(table),
                    $$ExamGradesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({examId = false, studentId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (examId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.examId,
                    referencedTable:
                        $$ExamGradesTableReferences._examIdTable(db),
                    referencedColumn:
                        $$ExamGradesTableReferences._examIdTable(db).id,
                  ) as T;
                }
                if (studentId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.studentId,
                    referencedTable:
                        $$ExamGradesTableReferences._studentIdTable(db),
                    referencedColumn:
                        $$ExamGradesTableReferences._studentIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ExamGradesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExamGradesTable,
    ExamGradeModel,
    $$ExamGradesTableFilterComposer,
    $$ExamGradesTableOrderingComposer,
    $$ExamGradesTableAnnotationComposer,
    $$ExamGradesTableCreateCompanionBuilder,
    $$ExamGradesTableUpdateCompanionBuilder,
    (ExamGradeModel, $$ExamGradesTableReferences),
    ExamGradeModel,
    PrefetchHooks Function({bool examId, bool studentId})>;
typedef $$ExamTemplatesTableCreateCompanionBuilder = ExamTemplatesCompanion
    Function({
  required String id,
  required String name,
  Value<String?> schoolId,
  Value<String?> classId,
  Value<String?> subjectId,
  Value<String?> type,
  Value<int?> duration,
  Value<double?> totalMarks,
  Value<String?> structure,
  Value<String?> settings,
  Value<bool> isDefault,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$ExamTemplatesTableUpdateCompanionBuilder = ExamTemplatesCompanion
    Function({
  Value<String> id,
  Value<String> name,
  Value<String?> schoolId,
  Value<String?> classId,
  Value<String?> subjectId,
  Value<String?> type,
  Value<int?> duration,
  Value<double?> totalMarks,
  Value<String?> structure,
  Value<String?> settings,
  Value<bool> isDefault,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$ExamTemplatesTableReferences extends BaseReferences<_$AppDatabase,
    $ExamTemplatesTable, ExamTemplateModel> {
  $$ExamTemplatesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $SchoolsTable _schoolIdTable(_$AppDatabase db) =>
      db.schools.createAlias('exam_templates__school_id__schools__id');

  $$SchoolsTableProcessedTableManager? get schoolId {
    final $_column = $_itemColumn<String>('school_id');
    if ($_column == null) return null;
    final manager = $$SchoolsTableTableManager($_db, $_db.schools)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_schoolIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ClassesTable _classIdTable(_$AppDatabase db) =>
      db.classes.createAlias('exam_templates__class_id__classes__id');

  $$ClassesTableProcessedTableManager? get classId {
    final $_column = $_itemColumn<String>('class_id');
    if ($_column == null) return null;
    final manager = $$ClassesTableTableManager($_db, $_db.classes)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_classIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $SubjectsTable _subjectIdTable(_$AppDatabase db) =>
      db.subjects.createAlias('exam_templates__subject_id__subjects__id');

  $$SubjectsTableProcessedTableManager? get subjectId {
    final $_column = $_itemColumn<String>('subject_id');
    if ($_column == null) return null;
    final manager = $$SubjectsTableTableManager($_db, $_db.subjects)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subjectIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ExamTemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $ExamTemplatesTable> {
  $$ExamTemplatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalMarks => $composableBuilder(
      column: $table.totalMarks, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get structure => $composableBuilder(
      column: $table.structure, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get settings => $composableBuilder(
      column: $table.settings, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDefault => $composableBuilder(
      column: $table.isDefault, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$SchoolsTableFilterComposer get schoolId {
    final $$SchoolsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.schoolId,
        referencedTable: $db.schools,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SchoolsTableFilterComposer(
              $db: $db,
              $table: $db.schools,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ClassesTableFilterComposer get classId {
    final $$ClassesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.classId,
        referencedTable: $db.classes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassesTableFilterComposer(
              $db: $db,
              $table: $db.classes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SubjectsTableFilterComposer get subjectId {
    final $$SubjectsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.subjectId,
        referencedTable: $db.subjects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SubjectsTableFilterComposer(
              $db: $db,
              $table: $db.subjects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExamTemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExamTemplatesTable> {
  $$ExamTemplatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get duration => $composableBuilder(
      column: $table.duration, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalMarks => $composableBuilder(
      column: $table.totalMarks, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get structure => $composableBuilder(
      column: $table.structure, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get settings => $composableBuilder(
      column: $table.settings, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDefault => $composableBuilder(
      column: $table.isDefault, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$SchoolsTableOrderingComposer get schoolId {
    final $$SchoolsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.schoolId,
        referencedTable: $db.schools,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SchoolsTableOrderingComposer(
              $db: $db,
              $table: $db.schools,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ClassesTableOrderingComposer get classId {
    final $$ClassesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.classId,
        referencedTable: $db.classes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassesTableOrderingComposer(
              $db: $db,
              $table: $db.classes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SubjectsTableOrderingComposer get subjectId {
    final $$SubjectsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.subjectId,
        referencedTable: $db.subjects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SubjectsTableOrderingComposer(
              $db: $db,
              $table: $db.subjects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExamTemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExamTemplatesTable> {
  $$ExamTemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<double> get totalMarks => $composableBuilder(
      column: $table.totalMarks, builder: (column) => column);

  GeneratedColumn<String> get structure =>
      $composableBuilder(column: $table.structure, builder: (column) => column);

  GeneratedColumn<String> get settings =>
      $composableBuilder(column: $table.settings, builder: (column) => column);

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$SchoolsTableAnnotationComposer get schoolId {
    final $$SchoolsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.schoolId,
        referencedTable: $db.schools,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SchoolsTableAnnotationComposer(
              $db: $db,
              $table: $db.schools,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ClassesTableAnnotationComposer get classId {
    final $$ClassesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.classId,
        referencedTable: $db.classes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClassesTableAnnotationComposer(
              $db: $db,
              $table: $db.classes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$SubjectsTableAnnotationComposer get subjectId {
    final $$SubjectsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.subjectId,
        referencedTable: $db.subjects,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$SubjectsTableAnnotationComposer(
              $db: $db,
              $table: $db.subjects,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ExamTemplatesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExamTemplatesTable,
    ExamTemplateModel,
    $$ExamTemplatesTableFilterComposer,
    $$ExamTemplatesTableOrderingComposer,
    $$ExamTemplatesTableAnnotationComposer,
    $$ExamTemplatesTableCreateCompanionBuilder,
    $$ExamTemplatesTableUpdateCompanionBuilder,
    (ExamTemplateModel, $$ExamTemplatesTableReferences),
    ExamTemplateModel,
    PrefetchHooks Function({bool schoolId, bool classId, bool subjectId})> {
  $$ExamTemplatesTableTableManager(_$AppDatabase db, $ExamTemplatesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExamTemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExamTemplatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExamTemplatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> schoolId = const Value.absent(),
            Value<String?> classId = const Value.absent(),
            Value<String?> subjectId = const Value.absent(),
            Value<String?> type = const Value.absent(),
            Value<int?> duration = const Value.absent(),
            Value<double?> totalMarks = const Value.absent(),
            Value<String?> structure = const Value.absent(),
            Value<String?> settings = const Value.absent(),
            Value<bool> isDefault = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExamTemplatesCompanion(
            id: id,
            name: name,
            schoolId: schoolId,
            classId: classId,
            subjectId: subjectId,
            type: type,
            duration: duration,
            totalMarks: totalMarks,
            structure: structure,
            settings: settings,
            isDefault: isDefault,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> schoolId = const Value.absent(),
            Value<String?> classId = const Value.absent(),
            Value<String?> subjectId = const Value.absent(),
            Value<String?> type = const Value.absent(),
            Value<int?> duration = const Value.absent(),
            Value<double?> totalMarks = const Value.absent(),
            Value<String?> structure = const Value.absent(),
            Value<String?> settings = const Value.absent(),
            Value<bool> isDefault = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExamTemplatesCompanion.insert(
            id: id,
            name: name,
            schoolId: schoolId,
            classId: classId,
            subjectId: subjectId,
            type: type,
            duration: duration,
            totalMarks: totalMarks,
            structure: structure,
            settings: settings,
            isDefault: isDefault,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$ExamTemplatesTable, ExamTemplateModel>(table),
                    $$ExamTemplatesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {schoolId = false, classId = false, subjectId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (schoolId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.schoolId,
                    referencedTable:
                        $$ExamTemplatesTableReferences._schoolIdTable(db),
                    referencedColumn:
                        $$ExamTemplatesTableReferences._schoolIdTable(db).id,
                  ) as T;
                }
                if (classId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.classId,
                    referencedTable:
                        $$ExamTemplatesTableReferences._classIdTable(db),
                    referencedColumn:
                        $$ExamTemplatesTableReferences._classIdTable(db).id,
                  ) as T;
                }
                if (subjectId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.subjectId,
                    referencedTable:
                        $$ExamTemplatesTableReferences._subjectIdTable(db),
                    referencedColumn:
                        $$ExamTemplatesTableReferences._subjectIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ExamTemplatesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ExamTemplatesTable,
    ExamTemplateModel,
    $$ExamTemplatesTableFilterComposer,
    $$ExamTemplatesTableOrderingComposer,
    $$ExamTemplatesTableAnnotationComposer,
    $$ExamTemplatesTableCreateCompanionBuilder,
    $$ExamTemplatesTableUpdateCompanionBuilder,
    (ExamTemplateModel, $$ExamTemplatesTableReferences),
    ExamTemplateModel,
    PrefetchHooks Function({bool schoolId, bool classId, bool subjectId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TeachersTableTableManager get teachers =>
      $$TeachersTableTableManager(_db, _db.teachers);
  $$SchoolsTableTableManager get schools =>
      $$SchoolsTableTableManager(_db, _db.schools);
  $$ClassesTableTableManager get classes =>
      $$ClassesTableTableManager(_db, _db.classes);
  $$SectionsTableTableManager get sections =>
      $$SectionsTableTableManager(_db, _db.sections);
  $$SubjectsTableTableManager get subjects =>
      $$SubjectsTableTableManager(_db, _db.subjects);
  $$StudentsTableTableManager get students =>
      $$StudentsTableTableManager(_db, _db.students);
  $$ExamsTableTableManager get exams =>
      $$ExamsTableTableManager(_db, _db.exams);
  $$QuestionBankItemsTableTableManager get questionBankItems =>
      $$QuestionBankItemsTableTableManager(_db, _db.questionBankItems);
  $$QuestionsTableTableManager get questions =>
      $$QuestionsTableTableManager(_db, _db.questions);
  $$QuestionBlocksTableTableManager get questionBlocks =>
      $$QuestionBlocksTableTableManager(_db, _db.questionBlocks);
  $$QuestionOptionsTableTableManager get questionOptions =>
      $$QuestionOptionsTableTableManager(_db, _db.questionOptions);
  $$ExamGradesTableTableManager get examGrades =>
      $$ExamGradesTableTableManager(_db, _db.examGrades);
  $$ExamTemplatesTableTableManager get examTemplates =>
      $$ExamTemplatesTableTableManager(_db, _db.examTemplates);
}
