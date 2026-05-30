// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $TreatmentEntriesTable extends TreatmentEntries
    with TableInfo<$TreatmentEntriesTable, TreatmentEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TreatmentEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userNameMeta = const VerificationMeta(
    'userName',
  );
  @override
  late final GeneratedColumn<String> userName = GeneratedColumn<String>(
    'user_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _medicationIdMeta = const VerificationMeta(
    'medicationId',
  );
  @override
  late final GeneratedColumn<String> medicationId = GeneratedColumn<String>(
    'medication_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _medicationNameMeta = const VerificationMeta(
    'medicationName',
  );
  @override
  late final GeneratedColumn<String> medicationName = GeneratedColumn<String>(
    'medication_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _selectedApplicationPointIdMeta =
      const VerificationMeta('selectedApplicationPointId');
  @override
  late final GeneratedColumn<String> selectedApplicationPointId =
      GeneratedColumn<String>(
        'selected_application_point_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _selectedApplicationPointLabelMeta =
      const VerificationMeta('selectedApplicationPointLabel');
  @override
  late final GeneratedColumn<String> selectedApplicationPointLabel =
      GeneratedColumn<String>(
        'selected_application_point_label',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _applicationTimeMeta = const VerificationMeta(
    'applicationTime',
  );
  @override
  late final GeneratedColumn<String> applicationTime = GeneratedColumn<String>(
    'application_time',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _treatmentStartDateMeta =
      const VerificationMeta('treatmentStartDate');
  @override
  late final GeneratedColumn<DateTime> treatmentStartDate =
      GeneratedColumn<DateTime>(
        'treatment_start_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _remindersEnabledMeta = const VerificationMeta(
    'remindersEnabled',
  );
  @override
  late final GeneratedColumn<bool> remindersEnabled = GeneratedColumn<bool>(
    'reminders_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("reminders_enabled" IN (0, 1))',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userName,
    medicationId,
    medicationName,
    selectedApplicationPointId,
    selectedApplicationPointLabel,
    applicationTime,
    treatmentStartDate,
    remindersEnabled,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'treatment_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<TreatmentEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_name')) {
      context.handle(
        _userNameMeta,
        userName.isAcceptableOrUnknown(data['user_name']!, _userNameMeta),
      );
    } else if (isInserting) {
      context.missing(_userNameMeta);
    }
    if (data.containsKey('medication_id')) {
      context.handle(
        _medicationIdMeta,
        medicationId.isAcceptableOrUnknown(
          data['medication_id']!,
          _medicationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_medicationIdMeta);
    }
    if (data.containsKey('medication_name')) {
      context.handle(
        _medicationNameMeta,
        medicationName.isAcceptableOrUnknown(
          data['medication_name']!,
          _medicationNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_medicationNameMeta);
    }
    if (data.containsKey('selected_application_point_id')) {
      context.handle(
        _selectedApplicationPointIdMeta,
        selectedApplicationPointId.isAcceptableOrUnknown(
          data['selected_application_point_id']!,
          _selectedApplicationPointIdMeta,
        ),
      );
    }
    if (data.containsKey('selected_application_point_label')) {
      context.handle(
        _selectedApplicationPointLabelMeta,
        selectedApplicationPointLabel.isAcceptableOrUnknown(
          data['selected_application_point_label']!,
          _selectedApplicationPointLabelMeta,
        ),
      );
    }
    if (data.containsKey('application_time')) {
      context.handle(
        _applicationTimeMeta,
        applicationTime.isAcceptableOrUnknown(
          data['application_time']!,
          _applicationTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_applicationTimeMeta);
    }
    if (data.containsKey('treatment_start_date')) {
      context.handle(
        _treatmentStartDateMeta,
        treatmentStartDate.isAcceptableOrUnknown(
          data['treatment_start_date']!,
          _treatmentStartDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_treatmentStartDateMeta);
    }
    if (data.containsKey('reminders_enabled')) {
      context.handle(
        _remindersEnabledMeta,
        remindersEnabled.isAcceptableOrUnknown(
          data['reminders_enabled']!,
          _remindersEnabledMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_remindersEnabledMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TreatmentEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TreatmentEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_name'],
      )!,
      medicationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}medication_id'],
      )!,
      medicationName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}medication_name'],
      )!,
      selectedApplicationPointId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}selected_application_point_id'],
      ),
      selectedApplicationPointLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}selected_application_point_label'],
      ),
      applicationTime: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}application_time'],
      )!,
      treatmentStartDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}treatment_start_date'],
      )!,
      remindersEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}reminders_enabled'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TreatmentEntriesTable createAlias(String alias) {
    return $TreatmentEntriesTable(attachedDatabase, alias);
  }
}

class TreatmentEntry extends DataClass implements Insertable<TreatmentEntry> {
  final String id;
  final String userName;
  final String medicationId;
  final String medicationName;
  final String? selectedApplicationPointId;
  final String? selectedApplicationPointLabel;
  final String applicationTime;
  final DateTime treatmentStartDate;
  final bool remindersEnabled;
  final DateTime createdAt;
  final DateTime updatedAt;
  const TreatmentEntry({
    required this.id,
    required this.userName,
    required this.medicationId,
    required this.medicationName,
    this.selectedApplicationPointId,
    this.selectedApplicationPointLabel,
    required this.applicationTime,
    required this.treatmentStartDate,
    required this.remindersEnabled,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_name'] = Variable<String>(userName);
    map['medication_id'] = Variable<String>(medicationId);
    map['medication_name'] = Variable<String>(medicationName);
    if (!nullToAbsent || selectedApplicationPointId != null) {
      map['selected_application_point_id'] = Variable<String>(
        selectedApplicationPointId,
      );
    }
    if (!nullToAbsent || selectedApplicationPointLabel != null) {
      map['selected_application_point_label'] = Variable<String>(
        selectedApplicationPointLabel,
      );
    }
    map['application_time'] = Variable<String>(applicationTime);
    map['treatment_start_date'] = Variable<DateTime>(treatmentStartDate);
    map['reminders_enabled'] = Variable<bool>(remindersEnabled);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TreatmentEntriesCompanion toCompanion(bool nullToAbsent) {
    return TreatmentEntriesCompanion(
      id: Value(id),
      userName: Value(userName),
      medicationId: Value(medicationId),
      medicationName: Value(medicationName),
      selectedApplicationPointId:
          selectedApplicationPointId == null && nullToAbsent
          ? const Value.absent()
          : Value(selectedApplicationPointId),
      selectedApplicationPointLabel:
          selectedApplicationPointLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(selectedApplicationPointLabel),
      applicationTime: Value(applicationTime),
      treatmentStartDate: Value(treatmentStartDate),
      remindersEnabled: Value(remindersEnabled),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory TreatmentEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TreatmentEntry(
      id: serializer.fromJson<String>(json['id']),
      userName: serializer.fromJson<String>(json['userName']),
      medicationId: serializer.fromJson<String>(json['medicationId']),
      medicationName: serializer.fromJson<String>(json['medicationName']),
      selectedApplicationPointId: serializer.fromJson<String?>(
        json['selectedApplicationPointId'],
      ),
      selectedApplicationPointLabel: serializer.fromJson<String?>(
        json['selectedApplicationPointLabel'],
      ),
      applicationTime: serializer.fromJson<String>(json['applicationTime']),
      treatmentStartDate: serializer.fromJson<DateTime>(
        json['treatmentStartDate'],
      ),
      remindersEnabled: serializer.fromJson<bool>(json['remindersEnabled']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userName': serializer.toJson<String>(userName),
      'medicationId': serializer.toJson<String>(medicationId),
      'medicationName': serializer.toJson<String>(medicationName),
      'selectedApplicationPointId': serializer.toJson<String?>(
        selectedApplicationPointId,
      ),
      'selectedApplicationPointLabel': serializer.toJson<String?>(
        selectedApplicationPointLabel,
      ),
      'applicationTime': serializer.toJson<String>(applicationTime),
      'treatmentStartDate': serializer.toJson<DateTime>(treatmentStartDate),
      'remindersEnabled': serializer.toJson<bool>(remindersEnabled),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TreatmentEntry copyWith({
    String? id,
    String? userName,
    String? medicationId,
    String? medicationName,
    Value<String?> selectedApplicationPointId = const Value.absent(),
    Value<String?> selectedApplicationPointLabel = const Value.absent(),
    String? applicationTime,
    DateTime? treatmentStartDate,
    bool? remindersEnabled,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => TreatmentEntry(
    id: id ?? this.id,
    userName: userName ?? this.userName,
    medicationId: medicationId ?? this.medicationId,
    medicationName: medicationName ?? this.medicationName,
    selectedApplicationPointId: selectedApplicationPointId.present
        ? selectedApplicationPointId.value
        : this.selectedApplicationPointId,
    selectedApplicationPointLabel: selectedApplicationPointLabel.present
        ? selectedApplicationPointLabel.value
        : this.selectedApplicationPointLabel,
    applicationTime: applicationTime ?? this.applicationTime,
    treatmentStartDate: treatmentStartDate ?? this.treatmentStartDate,
    remindersEnabled: remindersEnabled ?? this.remindersEnabled,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  TreatmentEntry copyWithCompanion(TreatmentEntriesCompanion data) {
    return TreatmentEntry(
      id: data.id.present ? data.id.value : this.id,
      userName: data.userName.present ? data.userName.value : this.userName,
      medicationId: data.medicationId.present
          ? data.medicationId.value
          : this.medicationId,
      medicationName: data.medicationName.present
          ? data.medicationName.value
          : this.medicationName,
      selectedApplicationPointId: data.selectedApplicationPointId.present
          ? data.selectedApplicationPointId.value
          : this.selectedApplicationPointId,
      selectedApplicationPointLabel: data.selectedApplicationPointLabel.present
          ? data.selectedApplicationPointLabel.value
          : this.selectedApplicationPointLabel,
      applicationTime: data.applicationTime.present
          ? data.applicationTime.value
          : this.applicationTime,
      treatmentStartDate: data.treatmentStartDate.present
          ? data.treatmentStartDate.value
          : this.treatmentStartDate,
      remindersEnabled: data.remindersEnabled.present
          ? data.remindersEnabled.value
          : this.remindersEnabled,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TreatmentEntry(')
          ..write('id: $id, ')
          ..write('userName: $userName, ')
          ..write('medicationId: $medicationId, ')
          ..write('medicationName: $medicationName, ')
          ..write('selectedApplicationPointId: $selectedApplicationPointId, ')
          ..write(
            'selectedApplicationPointLabel: $selectedApplicationPointLabel, ',
          )
          ..write('applicationTime: $applicationTime, ')
          ..write('treatmentStartDate: $treatmentStartDate, ')
          ..write('remindersEnabled: $remindersEnabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userName,
    medicationId,
    medicationName,
    selectedApplicationPointId,
    selectedApplicationPointLabel,
    applicationTime,
    treatmentStartDate,
    remindersEnabled,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TreatmentEntry &&
          other.id == this.id &&
          other.userName == this.userName &&
          other.medicationId == this.medicationId &&
          other.medicationName == this.medicationName &&
          other.selectedApplicationPointId == this.selectedApplicationPointId &&
          other.selectedApplicationPointLabel ==
              this.selectedApplicationPointLabel &&
          other.applicationTime == this.applicationTime &&
          other.treatmentStartDate == this.treatmentStartDate &&
          other.remindersEnabled == this.remindersEnabled &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TreatmentEntriesCompanion extends UpdateCompanion<TreatmentEntry> {
  final Value<String> id;
  final Value<String> userName;
  final Value<String> medicationId;
  final Value<String> medicationName;
  final Value<String?> selectedApplicationPointId;
  final Value<String?> selectedApplicationPointLabel;
  final Value<String> applicationTime;
  final Value<DateTime> treatmentStartDate;
  final Value<bool> remindersEnabled;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const TreatmentEntriesCompanion({
    this.id = const Value.absent(),
    this.userName = const Value.absent(),
    this.medicationId = const Value.absent(),
    this.medicationName = const Value.absent(),
    this.selectedApplicationPointId = const Value.absent(),
    this.selectedApplicationPointLabel = const Value.absent(),
    this.applicationTime = const Value.absent(),
    this.treatmentStartDate = const Value.absent(),
    this.remindersEnabled = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TreatmentEntriesCompanion.insert({
    required String id,
    required String userName,
    required String medicationId,
    required String medicationName,
    this.selectedApplicationPointId = const Value.absent(),
    this.selectedApplicationPointLabel = const Value.absent(),
    required String applicationTime,
    required DateTime treatmentStartDate,
    required bool remindersEnabled,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userName = Value(userName),
       medicationId = Value(medicationId),
       medicationName = Value(medicationName),
       applicationTime = Value(applicationTime),
       treatmentStartDate = Value(treatmentStartDate),
       remindersEnabled = Value(remindersEnabled),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<TreatmentEntry> custom({
    Expression<String>? id,
    Expression<String>? userName,
    Expression<String>? medicationId,
    Expression<String>? medicationName,
    Expression<String>? selectedApplicationPointId,
    Expression<String>? selectedApplicationPointLabel,
    Expression<String>? applicationTime,
    Expression<DateTime>? treatmentStartDate,
    Expression<bool>? remindersEnabled,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userName != null) 'user_name': userName,
      if (medicationId != null) 'medication_id': medicationId,
      if (medicationName != null) 'medication_name': medicationName,
      if (selectedApplicationPointId != null)
        'selected_application_point_id': selectedApplicationPointId,
      if (selectedApplicationPointLabel != null)
        'selected_application_point_label': selectedApplicationPointLabel,
      if (applicationTime != null) 'application_time': applicationTime,
      if (treatmentStartDate != null)
        'treatment_start_date': treatmentStartDate,
      if (remindersEnabled != null) 'reminders_enabled': remindersEnabled,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TreatmentEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? userName,
    Value<String>? medicationId,
    Value<String>? medicationName,
    Value<String?>? selectedApplicationPointId,
    Value<String?>? selectedApplicationPointLabel,
    Value<String>? applicationTime,
    Value<DateTime>? treatmentStartDate,
    Value<bool>? remindersEnabled,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return TreatmentEntriesCompanion(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      medicationId: medicationId ?? this.medicationId,
      medicationName: medicationName ?? this.medicationName,
      selectedApplicationPointId:
          selectedApplicationPointId ?? this.selectedApplicationPointId,
      selectedApplicationPointLabel:
          selectedApplicationPointLabel ?? this.selectedApplicationPointLabel,
      applicationTime: applicationTime ?? this.applicationTime,
      treatmentStartDate: treatmentStartDate ?? this.treatmentStartDate,
      remindersEnabled: remindersEnabled ?? this.remindersEnabled,
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
    if (userName.present) {
      map['user_name'] = Variable<String>(userName.value);
    }
    if (medicationId.present) {
      map['medication_id'] = Variable<String>(medicationId.value);
    }
    if (medicationName.present) {
      map['medication_name'] = Variable<String>(medicationName.value);
    }
    if (selectedApplicationPointId.present) {
      map['selected_application_point_id'] = Variable<String>(
        selectedApplicationPointId.value,
      );
    }
    if (selectedApplicationPointLabel.present) {
      map['selected_application_point_label'] = Variable<String>(
        selectedApplicationPointLabel.value,
      );
    }
    if (applicationTime.present) {
      map['application_time'] = Variable<String>(applicationTime.value);
    }
    if (treatmentStartDate.present) {
      map['treatment_start_date'] = Variable<DateTime>(
        treatmentStartDate.value,
      );
    }
    if (remindersEnabled.present) {
      map['reminders_enabled'] = Variable<bool>(remindersEnabled.value);
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
    return (StringBuffer('TreatmentEntriesCompanion(')
          ..write('id: $id, ')
          ..write('userName: $userName, ')
          ..write('medicationId: $medicationId, ')
          ..write('medicationName: $medicationName, ')
          ..write('selectedApplicationPointId: $selectedApplicationPointId, ')
          ..write(
            'selectedApplicationPointLabel: $selectedApplicationPointLabel, ',
          )
          ..write('applicationTime: $applicationTime, ')
          ..write('treatmentStartDate: $treatmentStartDate, ')
          ..write('remindersEnabled: $remindersEnabled, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ApplicationRecordEntriesTable extends ApplicationRecordEntries
    with TableInfo<$ApplicationRecordEntriesTable, ApplicationRecordEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ApplicationRecordEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _treatmentIdMeta = const VerificationMeta(
    'treatmentId',
  );
  @override
  late final GeneratedColumn<String> treatmentId = GeneratedColumn<String>(
    'treatment_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _medicationIdMeta = const VerificationMeta(
    'medicationId',
  );
  @override
  late final GeneratedColumn<String> medicationId = GeneratedColumn<String>(
    'medication_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _medicationNameMeta = const VerificationMeta(
    'medicationName',
  );
  @override
  late final GeneratedColumn<String> medicationName = GeneratedColumn<String>(
    'medication_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _applicationPointIdMeta =
      const VerificationMeta('applicationPointId');
  @override
  late final GeneratedColumn<String> applicationPointId =
      GeneratedColumn<String>(
        'application_point_id',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _applicationPointLabelMeta =
      const VerificationMeta('applicationPointLabel');
  @override
  late final GeneratedColumn<String> applicationPointLabel =
      GeneratedColumn<String>(
        'application_point_label',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _scheduledAtMeta = const VerificationMeta(
    'scheduledAt',
  );
  @override
  late final GeneratedColumn<DateTime> scheduledAt = GeneratedColumn<DateTime>(
    'scheduled_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _registeredAtMeta = const VerificationMeta(
    'registeredAt',
  );
  @override
  late final GeneratedColumn<DateTime> registeredAt = GeneratedColumn<DateTime>(
    'registered_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _registrationStatusMeta =
      const VerificationMeta('registrationStatus');
  @override
  late final GeneratedColumn<String> registrationStatus =
      GeneratedColumn<String>(
        'registration_status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _adjustedScheduleMeta = const VerificationMeta(
    'adjustedSchedule',
  );
  @override
  late final GeneratedColumn<bool> adjustedSchedule = GeneratedColumn<bool>(
    'adjusted_schedule',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("adjusted_schedule" IN (0, 1))',
    ),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    treatmentId,
    medicationId,
    medicationName,
    applicationPointId,
    applicationPointLabel,
    scheduledAt,
    registeredAt,
    registrationStatus,
    adjustedSchedule,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'application_record_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<ApplicationRecordEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('treatment_id')) {
      context.handle(
        _treatmentIdMeta,
        treatmentId.isAcceptableOrUnknown(
          data['treatment_id']!,
          _treatmentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_treatmentIdMeta);
    }
    if (data.containsKey('medication_id')) {
      context.handle(
        _medicationIdMeta,
        medicationId.isAcceptableOrUnknown(
          data['medication_id']!,
          _medicationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_medicationIdMeta);
    }
    if (data.containsKey('medication_name')) {
      context.handle(
        _medicationNameMeta,
        medicationName.isAcceptableOrUnknown(
          data['medication_name']!,
          _medicationNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_medicationNameMeta);
    }
    if (data.containsKey('application_point_id')) {
      context.handle(
        _applicationPointIdMeta,
        applicationPointId.isAcceptableOrUnknown(
          data['application_point_id']!,
          _applicationPointIdMeta,
        ),
      );
    }
    if (data.containsKey('application_point_label')) {
      context.handle(
        _applicationPointLabelMeta,
        applicationPointLabel.isAcceptableOrUnknown(
          data['application_point_label']!,
          _applicationPointLabelMeta,
        ),
      );
    }
    if (data.containsKey('scheduled_at')) {
      context.handle(
        _scheduledAtMeta,
        scheduledAt.isAcceptableOrUnknown(
          data['scheduled_at']!,
          _scheduledAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduledAtMeta);
    }
    if (data.containsKey('registered_at')) {
      context.handle(
        _registeredAtMeta,
        registeredAt.isAcceptableOrUnknown(
          data['registered_at']!,
          _registeredAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_registeredAtMeta);
    }
    if (data.containsKey('registration_status')) {
      context.handle(
        _registrationStatusMeta,
        registrationStatus.isAcceptableOrUnknown(
          data['registration_status']!,
          _registrationStatusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_registrationStatusMeta);
    }
    if (data.containsKey('adjusted_schedule')) {
      context.handle(
        _adjustedScheduleMeta,
        adjustedSchedule.isAcceptableOrUnknown(
          data['adjusted_schedule']!,
          _adjustedScheduleMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_adjustedScheduleMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ApplicationRecordEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ApplicationRecordEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      treatmentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}treatment_id'],
      )!,
      medicationId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}medication_id'],
      )!,
      medicationName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}medication_name'],
      )!,
      applicationPointId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}application_point_id'],
      ),
      applicationPointLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}application_point_label'],
      ),
      scheduledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scheduled_at'],
      )!,
      registeredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}registered_at'],
      )!,
      registrationStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}registration_status'],
      )!,
      adjustedSchedule: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}adjusted_schedule'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $ApplicationRecordEntriesTable createAlias(String alias) {
    return $ApplicationRecordEntriesTable(attachedDatabase, alias);
  }
}

class ApplicationRecordEntry extends DataClass
    implements Insertable<ApplicationRecordEntry> {
  final String id;
  final String treatmentId;
  final String medicationId;
  final String medicationName;
  final String? applicationPointId;
  final String? applicationPointLabel;
  final DateTime scheduledAt;
  final DateTime registeredAt;
  final String registrationStatus;
  final bool adjustedSchedule;
  final String? notes;
  const ApplicationRecordEntry({
    required this.id,
    required this.treatmentId,
    required this.medicationId,
    required this.medicationName,
    this.applicationPointId,
    this.applicationPointLabel,
    required this.scheduledAt,
    required this.registeredAt,
    required this.registrationStatus,
    required this.adjustedSchedule,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['treatment_id'] = Variable<String>(treatmentId);
    map['medication_id'] = Variable<String>(medicationId);
    map['medication_name'] = Variable<String>(medicationName);
    if (!nullToAbsent || applicationPointId != null) {
      map['application_point_id'] = Variable<String>(applicationPointId);
    }
    if (!nullToAbsent || applicationPointLabel != null) {
      map['application_point_label'] = Variable<String>(applicationPointLabel);
    }
    map['scheduled_at'] = Variable<DateTime>(scheduledAt);
    map['registered_at'] = Variable<DateTime>(registeredAt);
    map['registration_status'] = Variable<String>(registrationStatus);
    map['adjusted_schedule'] = Variable<bool>(adjustedSchedule);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  ApplicationRecordEntriesCompanion toCompanion(bool nullToAbsent) {
    return ApplicationRecordEntriesCompanion(
      id: Value(id),
      treatmentId: Value(treatmentId),
      medicationId: Value(medicationId),
      medicationName: Value(medicationName),
      applicationPointId: applicationPointId == null && nullToAbsent
          ? const Value.absent()
          : Value(applicationPointId),
      applicationPointLabel: applicationPointLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(applicationPointLabel),
      scheduledAt: Value(scheduledAt),
      registeredAt: Value(registeredAt),
      registrationStatus: Value(registrationStatus),
      adjustedSchedule: Value(adjustedSchedule),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory ApplicationRecordEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ApplicationRecordEntry(
      id: serializer.fromJson<String>(json['id']),
      treatmentId: serializer.fromJson<String>(json['treatmentId']),
      medicationId: serializer.fromJson<String>(json['medicationId']),
      medicationName: serializer.fromJson<String>(json['medicationName']),
      applicationPointId: serializer.fromJson<String?>(
        json['applicationPointId'],
      ),
      applicationPointLabel: serializer.fromJson<String?>(
        json['applicationPointLabel'],
      ),
      scheduledAt: serializer.fromJson<DateTime>(json['scheduledAt']),
      registeredAt: serializer.fromJson<DateTime>(json['registeredAt']),
      registrationStatus: serializer.fromJson<String>(
        json['registrationStatus'],
      ),
      adjustedSchedule: serializer.fromJson<bool>(json['adjustedSchedule']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'treatmentId': serializer.toJson<String>(treatmentId),
      'medicationId': serializer.toJson<String>(medicationId),
      'medicationName': serializer.toJson<String>(medicationName),
      'applicationPointId': serializer.toJson<String?>(applicationPointId),
      'applicationPointLabel': serializer.toJson<String?>(
        applicationPointLabel,
      ),
      'scheduledAt': serializer.toJson<DateTime>(scheduledAt),
      'registeredAt': serializer.toJson<DateTime>(registeredAt),
      'registrationStatus': serializer.toJson<String>(registrationStatus),
      'adjustedSchedule': serializer.toJson<bool>(adjustedSchedule),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  ApplicationRecordEntry copyWith({
    String? id,
    String? treatmentId,
    String? medicationId,
    String? medicationName,
    Value<String?> applicationPointId = const Value.absent(),
    Value<String?> applicationPointLabel = const Value.absent(),
    DateTime? scheduledAt,
    DateTime? registeredAt,
    String? registrationStatus,
    bool? adjustedSchedule,
    Value<String?> notes = const Value.absent(),
  }) => ApplicationRecordEntry(
    id: id ?? this.id,
    treatmentId: treatmentId ?? this.treatmentId,
    medicationId: medicationId ?? this.medicationId,
    medicationName: medicationName ?? this.medicationName,
    applicationPointId: applicationPointId.present
        ? applicationPointId.value
        : this.applicationPointId,
    applicationPointLabel: applicationPointLabel.present
        ? applicationPointLabel.value
        : this.applicationPointLabel,
    scheduledAt: scheduledAt ?? this.scheduledAt,
    registeredAt: registeredAt ?? this.registeredAt,
    registrationStatus: registrationStatus ?? this.registrationStatus,
    adjustedSchedule: adjustedSchedule ?? this.adjustedSchedule,
    notes: notes.present ? notes.value : this.notes,
  );
  ApplicationRecordEntry copyWithCompanion(
    ApplicationRecordEntriesCompanion data,
  ) {
    return ApplicationRecordEntry(
      id: data.id.present ? data.id.value : this.id,
      treatmentId: data.treatmentId.present
          ? data.treatmentId.value
          : this.treatmentId,
      medicationId: data.medicationId.present
          ? data.medicationId.value
          : this.medicationId,
      medicationName: data.medicationName.present
          ? data.medicationName.value
          : this.medicationName,
      applicationPointId: data.applicationPointId.present
          ? data.applicationPointId.value
          : this.applicationPointId,
      applicationPointLabel: data.applicationPointLabel.present
          ? data.applicationPointLabel.value
          : this.applicationPointLabel,
      scheduledAt: data.scheduledAt.present
          ? data.scheduledAt.value
          : this.scheduledAt,
      registeredAt: data.registeredAt.present
          ? data.registeredAt.value
          : this.registeredAt,
      registrationStatus: data.registrationStatus.present
          ? data.registrationStatus.value
          : this.registrationStatus,
      adjustedSchedule: data.adjustedSchedule.present
          ? data.adjustedSchedule.value
          : this.adjustedSchedule,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ApplicationRecordEntry(')
          ..write('id: $id, ')
          ..write('treatmentId: $treatmentId, ')
          ..write('medicationId: $medicationId, ')
          ..write('medicationName: $medicationName, ')
          ..write('applicationPointId: $applicationPointId, ')
          ..write('applicationPointLabel: $applicationPointLabel, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('registeredAt: $registeredAt, ')
          ..write('registrationStatus: $registrationStatus, ')
          ..write('adjustedSchedule: $adjustedSchedule, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    treatmentId,
    medicationId,
    medicationName,
    applicationPointId,
    applicationPointLabel,
    scheduledAt,
    registeredAt,
    registrationStatus,
    adjustedSchedule,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ApplicationRecordEntry &&
          other.id == this.id &&
          other.treatmentId == this.treatmentId &&
          other.medicationId == this.medicationId &&
          other.medicationName == this.medicationName &&
          other.applicationPointId == this.applicationPointId &&
          other.applicationPointLabel == this.applicationPointLabel &&
          other.scheduledAt == this.scheduledAt &&
          other.registeredAt == this.registeredAt &&
          other.registrationStatus == this.registrationStatus &&
          other.adjustedSchedule == this.adjustedSchedule &&
          other.notes == this.notes);
}

class ApplicationRecordEntriesCompanion
    extends UpdateCompanion<ApplicationRecordEntry> {
  final Value<String> id;
  final Value<String> treatmentId;
  final Value<String> medicationId;
  final Value<String> medicationName;
  final Value<String?> applicationPointId;
  final Value<String?> applicationPointLabel;
  final Value<DateTime> scheduledAt;
  final Value<DateTime> registeredAt;
  final Value<String> registrationStatus;
  final Value<bool> adjustedSchedule;
  final Value<String?> notes;
  final Value<int> rowid;
  const ApplicationRecordEntriesCompanion({
    this.id = const Value.absent(),
    this.treatmentId = const Value.absent(),
    this.medicationId = const Value.absent(),
    this.medicationName = const Value.absent(),
    this.applicationPointId = const Value.absent(),
    this.applicationPointLabel = const Value.absent(),
    this.scheduledAt = const Value.absent(),
    this.registeredAt = const Value.absent(),
    this.registrationStatus = const Value.absent(),
    this.adjustedSchedule = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ApplicationRecordEntriesCompanion.insert({
    required String id,
    required String treatmentId,
    required String medicationId,
    required String medicationName,
    this.applicationPointId = const Value.absent(),
    this.applicationPointLabel = const Value.absent(),
    required DateTime scheduledAt,
    required DateTime registeredAt,
    required String registrationStatus,
    required bool adjustedSchedule,
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       treatmentId = Value(treatmentId),
       medicationId = Value(medicationId),
       medicationName = Value(medicationName),
       scheduledAt = Value(scheduledAt),
       registeredAt = Value(registeredAt),
       registrationStatus = Value(registrationStatus),
       adjustedSchedule = Value(adjustedSchedule);
  static Insertable<ApplicationRecordEntry> custom({
    Expression<String>? id,
    Expression<String>? treatmentId,
    Expression<String>? medicationId,
    Expression<String>? medicationName,
    Expression<String>? applicationPointId,
    Expression<String>? applicationPointLabel,
    Expression<DateTime>? scheduledAt,
    Expression<DateTime>? registeredAt,
    Expression<String>? registrationStatus,
    Expression<bool>? adjustedSchedule,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (treatmentId != null) 'treatment_id': treatmentId,
      if (medicationId != null) 'medication_id': medicationId,
      if (medicationName != null) 'medication_name': medicationName,
      if (applicationPointId != null)
        'application_point_id': applicationPointId,
      if (applicationPointLabel != null)
        'application_point_label': applicationPointLabel,
      if (scheduledAt != null) 'scheduled_at': scheduledAt,
      if (registeredAt != null) 'registered_at': registeredAt,
      if (registrationStatus != null) 'registration_status': registrationStatus,
      if (adjustedSchedule != null) 'adjusted_schedule': adjustedSchedule,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ApplicationRecordEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? treatmentId,
    Value<String>? medicationId,
    Value<String>? medicationName,
    Value<String?>? applicationPointId,
    Value<String?>? applicationPointLabel,
    Value<DateTime>? scheduledAt,
    Value<DateTime>? registeredAt,
    Value<String>? registrationStatus,
    Value<bool>? adjustedSchedule,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return ApplicationRecordEntriesCompanion(
      id: id ?? this.id,
      treatmentId: treatmentId ?? this.treatmentId,
      medicationId: medicationId ?? this.medicationId,
      medicationName: medicationName ?? this.medicationName,
      applicationPointId: applicationPointId ?? this.applicationPointId,
      applicationPointLabel:
          applicationPointLabel ?? this.applicationPointLabel,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      registeredAt: registeredAt ?? this.registeredAt,
      registrationStatus: registrationStatus ?? this.registrationStatus,
      adjustedSchedule: adjustedSchedule ?? this.adjustedSchedule,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (treatmentId.present) {
      map['treatment_id'] = Variable<String>(treatmentId.value);
    }
    if (medicationId.present) {
      map['medication_id'] = Variable<String>(medicationId.value);
    }
    if (medicationName.present) {
      map['medication_name'] = Variable<String>(medicationName.value);
    }
    if (applicationPointId.present) {
      map['application_point_id'] = Variable<String>(applicationPointId.value);
    }
    if (applicationPointLabel.present) {
      map['application_point_label'] = Variable<String>(
        applicationPointLabel.value,
      );
    }
    if (scheduledAt.present) {
      map['scheduled_at'] = Variable<DateTime>(scheduledAt.value);
    }
    if (registeredAt.present) {
      map['registered_at'] = Variable<DateTime>(registeredAt.value);
    }
    if (registrationStatus.present) {
      map['registration_status'] = Variable<String>(registrationStatus.value);
    }
    if (adjustedSchedule.present) {
      map['adjusted_schedule'] = Variable<bool>(adjustedSchedule.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ApplicationRecordEntriesCompanion(')
          ..write('id: $id, ')
          ..write('treatmentId: $treatmentId, ')
          ..write('medicationId: $medicationId, ')
          ..write('medicationName: $medicationName, ')
          ..write('applicationPointId: $applicationPointId, ')
          ..write('applicationPointLabel: $applicationPointLabel, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('registeredAt: $registeredAt, ')
          ..write('registrationStatus: $registrationStatus, ')
          ..write('adjustedSchedule: $adjustedSchedule, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DiaryEntriesTable extends DiaryEntries
    with TableInfo<$DiaryEntriesTable, DiaryEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DiaryEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fatigueLevelMeta = const VerificationMeta(
    'fatigueLevel',
  );
  @override
  late final GeneratedColumn<int> fatigueLevel = GeneratedColumn<int>(
    'fatigue_level',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _painLevelMeta = const VerificationMeta(
    'painLevel',
  );
  @override
  late final GeneratedColumn<int> painLevel = GeneratedColumn<int>(
    'pain_level',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _moodLevelMeta = const VerificationMeta(
    'moodLevel',
  );
  @override
  late final GeneratedColumn<int> moodLevel = GeneratedColumn<int>(
    'mood_level',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sleepQualityLevelMeta = const VerificationMeta(
    'sleepQualityLevel',
  );
  @override
  late final GeneratedColumn<int> sleepQualityLevel = GeneratedColumn<int>(
    'sleep_quality_level',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    title,
    notes,
    fatigueLevel,
    painLevel,
    moodLevel,
    sleepQualityLevel,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'diary_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<DiaryEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    } else if (isInserting) {
      context.missing(_notesMeta);
    }
    if (data.containsKey('fatigue_level')) {
      context.handle(
        _fatigueLevelMeta,
        fatigueLevel.isAcceptableOrUnknown(
          data['fatigue_level']!,
          _fatigueLevelMeta,
        ),
      );
    }
    if (data.containsKey('pain_level')) {
      context.handle(
        _painLevelMeta,
        painLevel.isAcceptableOrUnknown(data['pain_level']!, _painLevelMeta),
      );
    }
    if (data.containsKey('mood_level')) {
      context.handle(
        _moodLevelMeta,
        moodLevel.isAcceptableOrUnknown(data['mood_level']!, _moodLevelMeta),
      );
    }
    if (data.containsKey('sleep_quality_level')) {
      context.handle(
        _sleepQualityLevelMeta,
        sleepQualityLevel.isAcceptableOrUnknown(
          data['sleep_quality_level']!,
          _sleepQualityLevelMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DiaryEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DiaryEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      fatigueLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fatigue_level'],
      ),
      painLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pain_level'],
      ),
      moodLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mood_level'],
      ),
      sleepQualityLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sleep_quality_level'],
      ),
    );
  }

  @override
  $DiaryEntriesTable createAlias(String alias) {
    return $DiaryEntriesTable(attachedDatabase, alias);
  }
}

class DiaryEntry extends DataClass implements Insertable<DiaryEntry> {
  final String id;
  final DateTime createdAt;
  final String title;
  final String notes;
  final int? fatigueLevel;
  final int? painLevel;
  final int? moodLevel;
  final int? sleepQualityLevel;
  const DiaryEntry({
    required this.id,
    required this.createdAt,
    required this.title,
    required this.notes,
    this.fatigueLevel,
    this.painLevel,
    this.moodLevel,
    this.sleepQualityLevel,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['title'] = Variable<String>(title);
    map['notes'] = Variable<String>(notes);
    if (!nullToAbsent || fatigueLevel != null) {
      map['fatigue_level'] = Variable<int>(fatigueLevel);
    }
    if (!nullToAbsent || painLevel != null) {
      map['pain_level'] = Variable<int>(painLevel);
    }
    if (!nullToAbsent || moodLevel != null) {
      map['mood_level'] = Variable<int>(moodLevel);
    }
    if (!nullToAbsent || sleepQualityLevel != null) {
      map['sleep_quality_level'] = Variable<int>(sleepQualityLevel);
    }
    return map;
  }

  DiaryEntriesCompanion toCompanion(bool nullToAbsent) {
    return DiaryEntriesCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      title: Value(title),
      notes: Value(notes),
      fatigueLevel: fatigueLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(fatigueLevel),
      painLevel: painLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(painLevel),
      moodLevel: moodLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(moodLevel),
      sleepQualityLevel: sleepQualityLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(sleepQualityLevel),
    );
  }

  factory DiaryEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DiaryEntry(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      title: serializer.fromJson<String>(json['title']),
      notes: serializer.fromJson<String>(json['notes']),
      fatigueLevel: serializer.fromJson<int?>(json['fatigueLevel']),
      painLevel: serializer.fromJson<int?>(json['painLevel']),
      moodLevel: serializer.fromJson<int?>(json['moodLevel']),
      sleepQualityLevel: serializer.fromJson<int?>(json['sleepQualityLevel']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'title': serializer.toJson<String>(title),
      'notes': serializer.toJson<String>(notes),
      'fatigueLevel': serializer.toJson<int?>(fatigueLevel),
      'painLevel': serializer.toJson<int?>(painLevel),
      'moodLevel': serializer.toJson<int?>(moodLevel),
      'sleepQualityLevel': serializer.toJson<int?>(sleepQualityLevel),
    };
  }

  DiaryEntry copyWith({
    String? id,
    DateTime? createdAt,
    String? title,
    String? notes,
    Value<int?> fatigueLevel = const Value.absent(),
    Value<int?> painLevel = const Value.absent(),
    Value<int?> moodLevel = const Value.absent(),
    Value<int?> sleepQualityLevel = const Value.absent(),
  }) => DiaryEntry(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    title: title ?? this.title,
    notes: notes ?? this.notes,
    fatigueLevel: fatigueLevel.present ? fatigueLevel.value : this.fatigueLevel,
    painLevel: painLevel.present ? painLevel.value : this.painLevel,
    moodLevel: moodLevel.present ? moodLevel.value : this.moodLevel,
    sleepQualityLevel: sleepQualityLevel.present
        ? sleepQualityLevel.value
        : this.sleepQualityLevel,
  );
  DiaryEntry copyWithCompanion(DiaryEntriesCompanion data) {
    return DiaryEntry(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      title: data.title.present ? data.title.value : this.title,
      notes: data.notes.present ? data.notes.value : this.notes,
      fatigueLevel: data.fatigueLevel.present
          ? data.fatigueLevel.value
          : this.fatigueLevel,
      painLevel: data.painLevel.present ? data.painLevel.value : this.painLevel,
      moodLevel: data.moodLevel.present ? data.moodLevel.value : this.moodLevel,
      sleepQualityLevel: data.sleepQualityLevel.present
          ? data.sleepQualityLevel.value
          : this.sleepQualityLevel,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DiaryEntry(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('title: $title, ')
          ..write('notes: $notes, ')
          ..write('fatigueLevel: $fatigueLevel, ')
          ..write('painLevel: $painLevel, ')
          ..write('moodLevel: $moodLevel, ')
          ..write('sleepQualityLevel: $sleepQualityLevel')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    title,
    notes,
    fatigueLevel,
    painLevel,
    moodLevel,
    sleepQualityLevel,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DiaryEntry &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.title == this.title &&
          other.notes == this.notes &&
          other.fatigueLevel == this.fatigueLevel &&
          other.painLevel == this.painLevel &&
          other.moodLevel == this.moodLevel &&
          other.sleepQualityLevel == this.sleepQualityLevel);
}

class DiaryEntriesCompanion extends UpdateCompanion<DiaryEntry> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<String> title;
  final Value<String> notes;
  final Value<int?> fatigueLevel;
  final Value<int?> painLevel;
  final Value<int?> moodLevel;
  final Value<int?> sleepQualityLevel;
  final Value<int> rowid;
  const DiaryEntriesCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.title = const Value.absent(),
    this.notes = const Value.absent(),
    this.fatigueLevel = const Value.absent(),
    this.painLevel = const Value.absent(),
    this.moodLevel = const Value.absent(),
    this.sleepQualityLevel = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DiaryEntriesCompanion.insert({
    required String id,
    required DateTime createdAt,
    required String title,
    required String notes,
    this.fatigueLevel = const Value.absent(),
    this.painLevel = const Value.absent(),
    this.moodLevel = const Value.absent(),
    this.sleepQualityLevel = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       title = Value(title),
       notes = Value(notes);
  static Insertable<DiaryEntry> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<String>? title,
    Expression<String>? notes,
    Expression<int>? fatigueLevel,
    Expression<int>? painLevel,
    Expression<int>? moodLevel,
    Expression<int>? sleepQualityLevel,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (title != null) 'title': title,
      if (notes != null) 'notes': notes,
      if (fatigueLevel != null) 'fatigue_level': fatigueLevel,
      if (painLevel != null) 'pain_level': painLevel,
      if (moodLevel != null) 'mood_level': moodLevel,
      if (sleepQualityLevel != null) 'sleep_quality_level': sleepQualityLevel,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DiaryEntriesCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<String>? title,
    Value<String>? notes,
    Value<int?>? fatigueLevel,
    Value<int?>? painLevel,
    Value<int?>? moodLevel,
    Value<int?>? sleepQualityLevel,
    Value<int>? rowid,
  }) {
    return DiaryEntriesCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
      notes: notes ?? this.notes,
      fatigueLevel: fatigueLevel ?? this.fatigueLevel,
      painLevel: painLevel ?? this.painLevel,
      moodLevel: moodLevel ?? this.moodLevel,
      sleepQualityLevel: sleepQualityLevel ?? this.sleepQualityLevel,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (fatigueLevel.present) {
      map['fatigue_level'] = Variable<int>(fatigueLevel.value);
    }
    if (painLevel.present) {
      map['pain_level'] = Variable<int>(painLevel.value);
    }
    if (moodLevel.present) {
      map['mood_level'] = Variable<int>(moodLevel.value);
    }
    if (sleepQualityLevel.present) {
      map['sleep_quality_level'] = Variable<int>(sleepQualityLevel.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DiaryEntriesCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('title: $title, ')
          ..write('notes: $notes, ')
          ..write('fatigueLevel: $fatigueLevel, ')
          ..write('painLevel: $painLevel, ')
          ..write('moodLevel: $moodLevel, ')
          ..write('sleepQualityLevel: $sleepQualityLevel, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TreatmentEntriesTable treatmentEntries = $TreatmentEntriesTable(
    this,
  );
  late final $ApplicationRecordEntriesTable applicationRecordEntries =
      $ApplicationRecordEntriesTable(this);
  late final $DiaryEntriesTable diaryEntries = $DiaryEntriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    treatmentEntries,
    applicationRecordEntries,
    diaryEntries,
  ];
}

typedef $$TreatmentEntriesTableCreateCompanionBuilder =
    TreatmentEntriesCompanion Function({
      required String id,
      required String userName,
      required String medicationId,
      required String medicationName,
      Value<String?> selectedApplicationPointId,
      Value<String?> selectedApplicationPointLabel,
      required String applicationTime,
      required DateTime treatmentStartDate,
      required bool remindersEnabled,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$TreatmentEntriesTableUpdateCompanionBuilder =
    TreatmentEntriesCompanion Function({
      Value<String> id,
      Value<String> userName,
      Value<String> medicationId,
      Value<String> medicationName,
      Value<String?> selectedApplicationPointId,
      Value<String?> selectedApplicationPointLabel,
      Value<String> applicationTime,
      Value<DateTime> treatmentStartDate,
      Value<bool> remindersEnabled,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$TreatmentEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $TreatmentEntriesTable> {
  $$TreatmentEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userName => $composableBuilder(
    column: $table.userName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get medicationId => $composableBuilder(
    column: $table.medicationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get medicationName => $composableBuilder(
    column: $table.medicationName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get selectedApplicationPointId => $composableBuilder(
    column: $table.selectedApplicationPointId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get selectedApplicationPointLabel => $composableBuilder(
    column: $table.selectedApplicationPointLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get applicationTime => $composableBuilder(
    column: $table.applicationTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get treatmentStartDate => $composableBuilder(
    column: $table.treatmentStartDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get remindersEnabled => $composableBuilder(
    column: $table.remindersEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TreatmentEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $TreatmentEntriesTable> {
  $$TreatmentEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userName => $composableBuilder(
    column: $table.userName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get medicationId => $composableBuilder(
    column: $table.medicationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get medicationName => $composableBuilder(
    column: $table.medicationName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get selectedApplicationPointId => $composableBuilder(
    column: $table.selectedApplicationPointId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get selectedApplicationPointLabel =>
      $composableBuilder(
        column: $table.selectedApplicationPointLabel,
        builder: (column) => ColumnOrderings(column),
      );

  ColumnOrderings<String> get applicationTime => $composableBuilder(
    column: $table.applicationTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get treatmentStartDate => $composableBuilder(
    column: $table.treatmentStartDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get remindersEnabled => $composableBuilder(
    column: $table.remindersEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TreatmentEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TreatmentEntriesTable> {
  $$TreatmentEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userName =>
      $composableBuilder(column: $table.userName, builder: (column) => column);

  GeneratedColumn<String> get medicationId => $composableBuilder(
    column: $table.medicationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get medicationName => $composableBuilder(
    column: $table.medicationName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get selectedApplicationPointId => $composableBuilder(
    column: $table.selectedApplicationPointId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get selectedApplicationPointLabel =>
      $composableBuilder(
        column: $table.selectedApplicationPointLabel,
        builder: (column) => column,
      );

  GeneratedColumn<String> get applicationTime => $composableBuilder(
    column: $table.applicationTime,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get treatmentStartDate => $composableBuilder(
    column: $table.treatmentStartDate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get remindersEnabled => $composableBuilder(
    column: $table.remindersEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$TreatmentEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TreatmentEntriesTable,
          TreatmentEntry,
          $$TreatmentEntriesTableFilterComposer,
          $$TreatmentEntriesTableOrderingComposer,
          $$TreatmentEntriesTableAnnotationComposer,
          $$TreatmentEntriesTableCreateCompanionBuilder,
          $$TreatmentEntriesTableUpdateCompanionBuilder,
          (
            TreatmentEntry,
            BaseReferences<
              _$AppDatabase,
              $TreatmentEntriesTable,
              TreatmentEntry
            >,
          ),
          TreatmentEntry,
          PrefetchHooks Function()
        > {
  $$TreatmentEntriesTableTableManager(
    _$AppDatabase db,
    $TreatmentEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TreatmentEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TreatmentEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TreatmentEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userName = const Value.absent(),
                Value<String> medicationId = const Value.absent(),
                Value<String> medicationName = const Value.absent(),
                Value<String?> selectedApplicationPointId =
                    const Value.absent(),
                Value<String?> selectedApplicationPointLabel =
                    const Value.absent(),
                Value<String> applicationTime = const Value.absent(),
                Value<DateTime> treatmentStartDate = const Value.absent(),
                Value<bool> remindersEnabled = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TreatmentEntriesCompanion(
                id: id,
                userName: userName,
                medicationId: medicationId,
                medicationName: medicationName,
                selectedApplicationPointId: selectedApplicationPointId,
                selectedApplicationPointLabel: selectedApplicationPointLabel,
                applicationTime: applicationTime,
                treatmentStartDate: treatmentStartDate,
                remindersEnabled: remindersEnabled,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userName,
                required String medicationId,
                required String medicationName,
                Value<String?> selectedApplicationPointId =
                    const Value.absent(),
                Value<String?> selectedApplicationPointLabel =
                    const Value.absent(),
                required String applicationTime,
                required DateTime treatmentStartDate,
                required bool remindersEnabled,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => TreatmentEntriesCompanion.insert(
                id: id,
                userName: userName,
                medicationId: medicationId,
                medicationName: medicationName,
                selectedApplicationPointId: selectedApplicationPointId,
                selectedApplicationPointLabel: selectedApplicationPointLabel,
                applicationTime: applicationTime,
                treatmentStartDate: treatmentStartDate,
                remindersEnabled: remindersEnabled,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TreatmentEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TreatmentEntriesTable,
      TreatmentEntry,
      $$TreatmentEntriesTableFilterComposer,
      $$TreatmentEntriesTableOrderingComposer,
      $$TreatmentEntriesTableAnnotationComposer,
      $$TreatmentEntriesTableCreateCompanionBuilder,
      $$TreatmentEntriesTableUpdateCompanionBuilder,
      (
        TreatmentEntry,
        BaseReferences<_$AppDatabase, $TreatmentEntriesTable, TreatmentEntry>,
      ),
      TreatmentEntry,
      PrefetchHooks Function()
    >;
typedef $$ApplicationRecordEntriesTableCreateCompanionBuilder =
    ApplicationRecordEntriesCompanion Function({
      required String id,
      required String treatmentId,
      required String medicationId,
      required String medicationName,
      Value<String?> applicationPointId,
      Value<String?> applicationPointLabel,
      required DateTime scheduledAt,
      required DateTime registeredAt,
      required String registrationStatus,
      required bool adjustedSchedule,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$ApplicationRecordEntriesTableUpdateCompanionBuilder =
    ApplicationRecordEntriesCompanion Function({
      Value<String> id,
      Value<String> treatmentId,
      Value<String> medicationId,
      Value<String> medicationName,
      Value<String?> applicationPointId,
      Value<String?> applicationPointLabel,
      Value<DateTime> scheduledAt,
      Value<DateTime> registeredAt,
      Value<String> registrationStatus,
      Value<bool> adjustedSchedule,
      Value<String?> notes,
      Value<int> rowid,
    });

class $$ApplicationRecordEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $ApplicationRecordEntriesTable> {
  $$ApplicationRecordEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get treatmentId => $composableBuilder(
    column: $table.treatmentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get medicationId => $composableBuilder(
    column: $table.medicationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get medicationName => $composableBuilder(
    column: $table.medicationName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get applicationPointId => $composableBuilder(
    column: $table.applicationPointId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get applicationPointLabel => $composableBuilder(
    column: $table.applicationPointLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get registeredAt => $composableBuilder(
    column: $table.registeredAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get registrationStatus => $composableBuilder(
    column: $table.registrationStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get adjustedSchedule => $composableBuilder(
    column: $table.adjustedSchedule,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ApplicationRecordEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $ApplicationRecordEntriesTable> {
  $$ApplicationRecordEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get treatmentId => $composableBuilder(
    column: $table.treatmentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get medicationId => $composableBuilder(
    column: $table.medicationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get medicationName => $composableBuilder(
    column: $table.medicationName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get applicationPointId => $composableBuilder(
    column: $table.applicationPointId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get applicationPointLabel => $composableBuilder(
    column: $table.applicationPointLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get registeredAt => $composableBuilder(
    column: $table.registeredAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get registrationStatus => $composableBuilder(
    column: $table.registrationStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get adjustedSchedule => $composableBuilder(
    column: $table.adjustedSchedule,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ApplicationRecordEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ApplicationRecordEntriesTable> {
  $$ApplicationRecordEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get treatmentId => $composableBuilder(
    column: $table.treatmentId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get medicationId => $composableBuilder(
    column: $table.medicationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get medicationName => $composableBuilder(
    column: $table.medicationName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get applicationPointId => $composableBuilder(
    column: $table.applicationPointId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get applicationPointLabel => $composableBuilder(
    column: $table.applicationPointLabel,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get registeredAt => $composableBuilder(
    column: $table.registeredAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get registrationStatus => $composableBuilder(
    column: $table.registrationStatus,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get adjustedSchedule => $composableBuilder(
    column: $table.adjustedSchedule,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$ApplicationRecordEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ApplicationRecordEntriesTable,
          ApplicationRecordEntry,
          $$ApplicationRecordEntriesTableFilterComposer,
          $$ApplicationRecordEntriesTableOrderingComposer,
          $$ApplicationRecordEntriesTableAnnotationComposer,
          $$ApplicationRecordEntriesTableCreateCompanionBuilder,
          $$ApplicationRecordEntriesTableUpdateCompanionBuilder,
          (
            ApplicationRecordEntry,
            BaseReferences<
              _$AppDatabase,
              $ApplicationRecordEntriesTable,
              ApplicationRecordEntry
            >,
          ),
          ApplicationRecordEntry,
          PrefetchHooks Function()
        > {
  $$ApplicationRecordEntriesTableTableManager(
    _$AppDatabase db,
    $ApplicationRecordEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ApplicationRecordEntriesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ApplicationRecordEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ApplicationRecordEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> treatmentId = const Value.absent(),
                Value<String> medicationId = const Value.absent(),
                Value<String> medicationName = const Value.absent(),
                Value<String?> applicationPointId = const Value.absent(),
                Value<String?> applicationPointLabel = const Value.absent(),
                Value<DateTime> scheduledAt = const Value.absent(),
                Value<DateTime> registeredAt = const Value.absent(),
                Value<String> registrationStatus = const Value.absent(),
                Value<bool> adjustedSchedule = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ApplicationRecordEntriesCompanion(
                id: id,
                treatmentId: treatmentId,
                medicationId: medicationId,
                medicationName: medicationName,
                applicationPointId: applicationPointId,
                applicationPointLabel: applicationPointLabel,
                scheduledAt: scheduledAt,
                registeredAt: registeredAt,
                registrationStatus: registrationStatus,
                adjustedSchedule: adjustedSchedule,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String treatmentId,
                required String medicationId,
                required String medicationName,
                Value<String?> applicationPointId = const Value.absent(),
                Value<String?> applicationPointLabel = const Value.absent(),
                required DateTime scheduledAt,
                required DateTime registeredAt,
                required String registrationStatus,
                required bool adjustedSchedule,
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ApplicationRecordEntriesCompanion.insert(
                id: id,
                treatmentId: treatmentId,
                medicationId: medicationId,
                medicationName: medicationName,
                applicationPointId: applicationPointId,
                applicationPointLabel: applicationPointLabel,
                scheduledAt: scheduledAt,
                registeredAt: registeredAt,
                registrationStatus: registrationStatus,
                adjustedSchedule: adjustedSchedule,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ApplicationRecordEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ApplicationRecordEntriesTable,
      ApplicationRecordEntry,
      $$ApplicationRecordEntriesTableFilterComposer,
      $$ApplicationRecordEntriesTableOrderingComposer,
      $$ApplicationRecordEntriesTableAnnotationComposer,
      $$ApplicationRecordEntriesTableCreateCompanionBuilder,
      $$ApplicationRecordEntriesTableUpdateCompanionBuilder,
      (
        ApplicationRecordEntry,
        BaseReferences<
          _$AppDatabase,
          $ApplicationRecordEntriesTable,
          ApplicationRecordEntry
        >,
      ),
      ApplicationRecordEntry,
      PrefetchHooks Function()
    >;
typedef $$DiaryEntriesTableCreateCompanionBuilder =
    DiaryEntriesCompanion Function({
      required String id,
      required DateTime createdAt,
      required String title,
      required String notes,
      Value<int?> fatigueLevel,
      Value<int?> painLevel,
      Value<int?> moodLevel,
      Value<int?> sleepQualityLevel,
      Value<int> rowid,
    });
typedef $$DiaryEntriesTableUpdateCompanionBuilder =
    DiaryEntriesCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<String> title,
      Value<String> notes,
      Value<int?> fatigueLevel,
      Value<int?> painLevel,
      Value<int?> moodLevel,
      Value<int?> sleepQualityLevel,
      Value<int> rowid,
    });

class $$DiaryEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $DiaryEntriesTable> {
  $$DiaryEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fatigueLevel => $composableBuilder(
    column: $table.fatigueLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get painLevel => $composableBuilder(
    column: $table.painLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get moodLevel => $composableBuilder(
    column: $table.moodLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sleepQualityLevel => $composableBuilder(
    column: $table.sleepQualityLevel,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DiaryEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $DiaryEntriesTable> {
  $$DiaryEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fatigueLevel => $composableBuilder(
    column: $table.fatigueLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get painLevel => $composableBuilder(
    column: $table.painLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get moodLevel => $composableBuilder(
    column: $table.moodLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sleepQualityLevel => $composableBuilder(
    column: $table.sleepQualityLevel,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DiaryEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DiaryEntriesTable> {
  $$DiaryEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get fatigueLevel => $composableBuilder(
    column: $table.fatigueLevel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get painLevel =>
      $composableBuilder(column: $table.painLevel, builder: (column) => column);

  GeneratedColumn<int> get moodLevel =>
      $composableBuilder(column: $table.moodLevel, builder: (column) => column);

  GeneratedColumn<int> get sleepQualityLevel => $composableBuilder(
    column: $table.sleepQualityLevel,
    builder: (column) => column,
  );
}

class $$DiaryEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DiaryEntriesTable,
          DiaryEntry,
          $$DiaryEntriesTableFilterComposer,
          $$DiaryEntriesTableOrderingComposer,
          $$DiaryEntriesTableAnnotationComposer,
          $$DiaryEntriesTableCreateCompanionBuilder,
          $$DiaryEntriesTableUpdateCompanionBuilder,
          (
            DiaryEntry,
            BaseReferences<_$AppDatabase, $DiaryEntriesTable, DiaryEntry>,
          ),
          DiaryEntry,
          PrefetchHooks Function()
        > {
  $$DiaryEntriesTableTableManager(_$AppDatabase db, $DiaryEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DiaryEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DiaryEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DiaryEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<int?> fatigueLevel = const Value.absent(),
                Value<int?> painLevel = const Value.absent(),
                Value<int?> moodLevel = const Value.absent(),
                Value<int?> sleepQualityLevel = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DiaryEntriesCompanion(
                id: id,
                createdAt: createdAt,
                title: title,
                notes: notes,
                fatigueLevel: fatigueLevel,
                painLevel: painLevel,
                moodLevel: moodLevel,
                sleepQualityLevel: sleepQualityLevel,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime createdAt,
                required String title,
                required String notes,
                Value<int?> fatigueLevel = const Value.absent(),
                Value<int?> painLevel = const Value.absent(),
                Value<int?> moodLevel = const Value.absent(),
                Value<int?> sleepQualityLevel = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DiaryEntriesCompanion.insert(
                id: id,
                createdAt: createdAt,
                title: title,
                notes: notes,
                fatigueLevel: fatigueLevel,
                painLevel: painLevel,
                moodLevel: moodLevel,
                sleepQualityLevel: sleepQualityLevel,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DiaryEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DiaryEntriesTable,
      DiaryEntry,
      $$DiaryEntriesTableFilterComposer,
      $$DiaryEntriesTableOrderingComposer,
      $$DiaryEntriesTableAnnotationComposer,
      $$DiaryEntriesTableCreateCompanionBuilder,
      $$DiaryEntriesTableUpdateCompanionBuilder,
      (
        DiaryEntry,
        BaseReferences<_$AppDatabase, $DiaryEntriesTable, DiaryEntry>,
      ),
      DiaryEntry,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TreatmentEntriesTableTableManager get treatmentEntries =>
      $$TreatmentEntriesTableTableManager(_db, _db.treatmentEntries);
  $$ApplicationRecordEntriesTableTableManager get applicationRecordEntries =>
      $$ApplicationRecordEntriesTableTableManager(
        _db,
        _db.applicationRecordEntries,
      );
  $$DiaryEntriesTableTableManager get diaryEntries =>
      $$DiaryEntriesTableTableManager(_db, _db.diaryEntries);
}
