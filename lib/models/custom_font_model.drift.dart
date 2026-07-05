// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:tiefprompt/models/custom_font_model.drift.dart' as i1;
import 'dart:typed_data' as i2;
import 'package:tiefprompt/models/custom_font_model.dart' as i3;
import 'package:drift/src/runtime/query_builder/query_builder.dart' as i4;

typedef $$CustomFontModelTableCreateCompanionBuilder =
    i1.CustomFontModelCompanion Function({
      i0.Value<int> id,
      required String originalFileName,
      required String familyName,
      required int weight,
      i0.Value<bool> isItalic,
      i0.Value<bool> isVariableWeight,
      i0.Value<int?> weightMin,
      i0.Value<int?> weightMax,
      required i2.Uint8List data,
    });
typedef $$CustomFontModelTableUpdateCompanionBuilder =
    i1.CustomFontModelCompanion Function({
      i0.Value<int> id,
      i0.Value<String> originalFileName,
      i0.Value<String> familyName,
      i0.Value<int> weight,
      i0.Value<bool> isItalic,
      i0.Value<bool> isVariableWeight,
      i0.Value<int?> weightMin,
      i0.Value<int?> weightMax,
      i0.Value<i2.Uint8List> data,
    });

class $$CustomFontModelTableFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$CustomFontModelTable> {
  $$CustomFontModelTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get originalFileName => $composableBuilder(
    column: $table.originalFileName,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get familyName => $composableBuilder(
    column: $table.familyName,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<bool> get isItalic => $composableBuilder(
    column: $table.isItalic,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<bool> get isVariableWeight => $composableBuilder(
    column: $table.isVariableWeight,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get weightMin => $composableBuilder(
    column: $table.weightMin,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<int> get weightMax => $composableBuilder(
    column: $table.weightMax,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<i2.Uint8List> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $$CustomFontModelTableOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$CustomFontModelTable> {
  $$CustomFontModelTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get originalFileName => $composableBuilder(
    column: $table.originalFileName,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get familyName => $composableBuilder(
    column: $table.familyName,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<bool> get isItalic => $composableBuilder(
    column: $table.isItalic,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<bool> get isVariableWeight => $composableBuilder(
    column: $table.isVariableWeight,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get weightMin => $composableBuilder(
    column: $table.weightMin,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<int> get weightMax => $composableBuilder(
    column: $table.weightMax,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<i2.Uint8List> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $$CustomFontModelTableAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$CustomFontModelTable> {
  $$CustomFontModelTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  i0.GeneratedColumn<String> get originalFileName => $composableBuilder(
    column: $table.originalFileName,
    builder: (column) => column,
  );

  i0.GeneratedColumn<String> get familyName => $composableBuilder(
    column: $table.familyName,
    builder: (column) => column,
  );

  i0.GeneratedColumn<int> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  i0.GeneratedColumn<bool> get isItalic =>
      $composableBuilder(column: $table.isItalic, builder: (column) => column);

  i0.GeneratedColumn<bool> get isVariableWeight => $composableBuilder(
    column: $table.isVariableWeight,
    builder: (column) => column,
  );

  i0.GeneratedColumn<int> get weightMin =>
      $composableBuilder(column: $table.weightMin, builder: (column) => column);

  i0.GeneratedColumn<int> get weightMax =>
      $composableBuilder(column: $table.weightMax, builder: (column) => column);

  i0.GeneratedColumn<i2.Uint8List> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);
}

class $$CustomFontModelTableTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.$CustomFontModelTable,
          i1.CustomFontModelData,
          i1.$$CustomFontModelTableFilterComposer,
          i1.$$CustomFontModelTableOrderingComposer,
          i1.$$CustomFontModelTableAnnotationComposer,
          $$CustomFontModelTableCreateCompanionBuilder,
          $$CustomFontModelTableUpdateCompanionBuilder,
          (
            i1.CustomFontModelData,
            i0.BaseReferences<
              i0.GeneratedDatabase,
              i1.$CustomFontModelTable,
              i1.CustomFontModelData
            >,
          ),
          i1.CustomFontModelData,
          i0.PrefetchHooks Function()
        > {
  $$CustomFontModelTableTableManager(
    i0.GeneratedDatabase db,
    i1.$CustomFontModelTable table,
  ) : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$$CustomFontModelTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$$CustomFontModelTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => i1
              .$$CustomFontModelTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                i0.Value<int> id = const i0.Value.absent(),
                i0.Value<String> originalFileName = const i0.Value.absent(),
                i0.Value<String> familyName = const i0.Value.absent(),
                i0.Value<int> weight = const i0.Value.absent(),
                i0.Value<bool> isItalic = const i0.Value.absent(),
                i0.Value<bool> isVariableWeight = const i0.Value.absent(),
                i0.Value<int?> weightMin = const i0.Value.absent(),
                i0.Value<int?> weightMax = const i0.Value.absent(),
                i0.Value<i2.Uint8List> data = const i0.Value.absent(),
              }) => i1.CustomFontModelCompanion(
                id: id,
                originalFileName: originalFileName,
                familyName: familyName,
                weight: weight,
                isItalic: isItalic,
                isVariableWeight: isVariableWeight,
                weightMin: weightMin,
                weightMax: weightMax,
                data: data,
              ),
          createCompanionCallback:
              ({
                i0.Value<int> id = const i0.Value.absent(),
                required String originalFileName,
                required String familyName,
                required int weight,
                i0.Value<bool> isItalic = const i0.Value.absent(),
                i0.Value<bool> isVariableWeight = const i0.Value.absent(),
                i0.Value<int?> weightMin = const i0.Value.absent(),
                i0.Value<int?> weightMax = const i0.Value.absent(),
                required i2.Uint8List data,
              }) => i1.CustomFontModelCompanion.insert(
                id: id,
                originalFileName: originalFileName,
                familyName: familyName,
                weight: weight,
                isItalic: isItalic,
                isVariableWeight: isVariableWeight,
                weightMin: weightMin,
                weightMax: weightMax,
                data: data,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CustomFontModelTableProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.$CustomFontModelTable,
      i1.CustomFontModelData,
      i1.$$CustomFontModelTableFilterComposer,
      i1.$$CustomFontModelTableOrderingComposer,
      i1.$$CustomFontModelTableAnnotationComposer,
      $$CustomFontModelTableCreateCompanionBuilder,
      $$CustomFontModelTableUpdateCompanionBuilder,
      (
        i1.CustomFontModelData,
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.$CustomFontModelTable,
          i1.CustomFontModelData
        >,
      ),
      i1.CustomFontModelData,
      i0.PrefetchHooks Function()
    >;

class $CustomFontModelTable extends i3.CustomFontModel
    with i0.TableInfo<$CustomFontModelTable, i1.CustomFontModelData> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomFontModelTable(this.attachedDatabase, [this._alias]);
  static const i0.VerificationMeta _idMeta = const i0.VerificationMeta('id');
  @override
  late final i0.GeneratedColumn<int> id = i0.GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: i0.GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const i0.VerificationMeta _originalFileNameMeta =
      const i0.VerificationMeta('originalFileName');
  @override
  late final i0.GeneratedColumn<String> originalFileName =
      i0.GeneratedColumn<String>(
        'original_file_name',
        aliasedName,
        false,
        type: i0.DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const i0.VerificationMeta _familyNameMeta = const i0.VerificationMeta(
    'familyName',
  );
  @override
  late final i0.GeneratedColumn<String> familyName = i0.GeneratedColumn<String>(
    'family_name',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const i0.VerificationMeta _weightMeta = const i0.VerificationMeta(
    'weight',
  );
  @override
  late final i0.GeneratedColumn<int> weight = i0.GeneratedColumn<int>(
    'weight',
    aliasedName,
    false,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const i0.VerificationMeta _isItalicMeta = const i0.VerificationMeta(
    'isItalic',
  );
  @override
  late final i0.GeneratedColumn<bool> isItalic = i0.GeneratedColumn<bool>(
    'is_italic',
    aliasedName,
    false,
    type: i0.DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: i0.GeneratedColumn.constraintIsAlways(
      'CHECK ("is_italic" IN (0, 1))',
    ),
    defaultValue: const i4.Constant(false),
  );
  static const i0.VerificationMeta _isVariableWeightMeta =
      const i0.VerificationMeta('isVariableWeight');
  @override
  late final i0.GeneratedColumn<bool> isVariableWeight =
      i0.GeneratedColumn<bool>(
        'is_variable_weight',
        aliasedName,
        false,
        type: i0.DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: i0.GeneratedColumn.constraintIsAlways(
          'CHECK ("is_variable_weight" IN (0, 1))',
        ),
        defaultValue: const i4.Constant(false),
      );
  static const i0.VerificationMeta _weightMinMeta = const i0.VerificationMeta(
    'weightMin',
  );
  @override
  late final i0.GeneratedColumn<int> weightMin = i0.GeneratedColumn<int>(
    'weight_min',
    aliasedName,
    true,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const i0.VerificationMeta _weightMaxMeta = const i0.VerificationMeta(
    'weightMax',
  );
  @override
  late final i0.GeneratedColumn<int> weightMax = i0.GeneratedColumn<int>(
    'weight_max',
    aliasedName,
    true,
    type: i0.DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const i0.VerificationMeta _dataMeta = const i0.VerificationMeta(
    'data',
  );
  @override
  late final i0.GeneratedColumn<i2.Uint8List> data =
      i0.GeneratedColumn<i2.Uint8List>(
        'data',
        aliasedName,
        false,
        type: i0.DriftSqlType.blob,
        requiredDuringInsert: true,
      );
  @override
  List<i0.GeneratedColumn> get $columns => [
    id,
    originalFileName,
    familyName,
    weight,
    isItalic,
    isVariableWeight,
    weightMin,
    weightMax,
    data,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'custom_font_model';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.CustomFontModelData> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('original_file_name')) {
      context.handle(
        _originalFileNameMeta,
        originalFileName.isAcceptableOrUnknown(
          data['original_file_name']!,
          _originalFileNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_originalFileNameMeta);
    }
    if (data.containsKey('family_name')) {
      context.handle(
        _familyNameMeta,
        familyName.isAcceptableOrUnknown(data['family_name']!, _familyNameMeta),
      );
    } else if (isInserting) {
      context.missing(_familyNameMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('is_italic')) {
      context.handle(
        _isItalicMeta,
        isItalic.isAcceptableOrUnknown(data['is_italic']!, _isItalicMeta),
      );
    }
    if (data.containsKey('is_variable_weight')) {
      context.handle(
        _isVariableWeightMeta,
        isVariableWeight.isAcceptableOrUnknown(
          data['is_variable_weight']!,
          _isVariableWeightMeta,
        ),
      );
    }
    if (data.containsKey('weight_min')) {
      context.handle(
        _weightMinMeta,
        weightMin.isAcceptableOrUnknown(data['weight_min']!, _weightMinMeta),
      );
    }
    if (data.containsKey('weight_max')) {
      context.handle(
        _weightMaxMeta,
        weightMax.isAcceptableOrUnknown(data['weight_max']!, _weightMaxMeta),
      );
    }
    if (data.containsKey('data')) {
      context.handle(
        _dataMeta,
        this.data.isAcceptableOrUnknown(data['data']!, _dataMeta),
      );
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {id};
  @override
  i1.CustomFontModelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.CustomFontModelData(
      id: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      originalFileName: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}original_file_name'],
      )!,
      familyName: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}family_name'],
      )!,
      weight: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}weight'],
      )!,
      isItalic: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.bool,
        data['${effectivePrefix}is_italic'],
      )!,
      isVariableWeight: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.bool,
        data['${effectivePrefix}is_variable_weight'],
      )!,
      weightMin: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}weight_min'],
      ),
      weightMax: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}weight_max'],
      ),
      data: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.blob,
        data['${effectivePrefix}data'],
      )!,
    );
  }

  @override
  $CustomFontModelTable createAlias(String alias) {
    return $CustomFontModelTable(attachedDatabase, alias);
  }
}

class CustomFontModelData extends i0.DataClass
    implements i0.Insertable<i1.CustomFontModelData> {
  final int id;
  final String originalFileName;
  final String familyName;
  final int weight;
  final bool isItalic;
  final bool isVariableWeight;
  final int? weightMin;
  final int? weightMax;
  final i2.Uint8List data;
  const CustomFontModelData({
    required this.id,
    required this.originalFileName,
    required this.familyName,
    required this.weight,
    required this.isItalic,
    required this.isVariableWeight,
    this.weightMin,
    this.weightMax,
    required this.data,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<int>(id);
    map['original_file_name'] = i0.Variable<String>(originalFileName);
    map['family_name'] = i0.Variable<String>(familyName);
    map['weight'] = i0.Variable<int>(weight);
    map['is_italic'] = i0.Variable<bool>(isItalic);
    map['is_variable_weight'] = i0.Variable<bool>(isVariableWeight);
    if (!nullToAbsent || weightMin != null) {
      map['weight_min'] = i0.Variable<int>(weightMin);
    }
    if (!nullToAbsent || weightMax != null) {
      map['weight_max'] = i0.Variable<int>(weightMax);
    }
    map['data'] = i0.Variable<i2.Uint8List>(data);
    return map;
  }

  i1.CustomFontModelCompanion toCompanion(bool nullToAbsent) {
    return i1.CustomFontModelCompanion(
      id: i0.Value(id),
      originalFileName: i0.Value(originalFileName),
      familyName: i0.Value(familyName),
      weight: i0.Value(weight),
      isItalic: i0.Value(isItalic),
      isVariableWeight: i0.Value(isVariableWeight),
      weightMin: weightMin == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(weightMin),
      weightMax: weightMax == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(weightMax),
      data: i0.Value(data),
    );
  }

  factory CustomFontModelData.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return CustomFontModelData(
      id: serializer.fromJson<int>(json['id']),
      originalFileName: serializer.fromJson<String>(json['originalFileName']),
      familyName: serializer.fromJson<String>(json['familyName']),
      weight: serializer.fromJson<int>(json['weight']),
      isItalic: serializer.fromJson<bool>(json['isItalic']),
      isVariableWeight: serializer.fromJson<bool>(json['isVariableWeight']),
      weightMin: serializer.fromJson<int?>(json['weightMin']),
      weightMax: serializer.fromJson<int?>(json['weightMax']),
      data: serializer.fromJson<i2.Uint8List>(json['data']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'originalFileName': serializer.toJson<String>(originalFileName),
      'familyName': serializer.toJson<String>(familyName),
      'weight': serializer.toJson<int>(weight),
      'isItalic': serializer.toJson<bool>(isItalic),
      'isVariableWeight': serializer.toJson<bool>(isVariableWeight),
      'weightMin': serializer.toJson<int?>(weightMin),
      'weightMax': serializer.toJson<int?>(weightMax),
      'data': serializer.toJson<i2.Uint8List>(data),
    };
  }

  i1.CustomFontModelData copyWith({
    int? id,
    String? originalFileName,
    String? familyName,
    int? weight,
    bool? isItalic,
    bool? isVariableWeight,
    i0.Value<int?> weightMin = const i0.Value.absent(),
    i0.Value<int?> weightMax = const i0.Value.absent(),
    i2.Uint8List? data,
  }) => i1.CustomFontModelData(
    id: id ?? this.id,
    originalFileName: originalFileName ?? this.originalFileName,
    familyName: familyName ?? this.familyName,
    weight: weight ?? this.weight,
    isItalic: isItalic ?? this.isItalic,
    isVariableWeight: isVariableWeight ?? this.isVariableWeight,
    weightMin: weightMin.present ? weightMin.value : this.weightMin,
    weightMax: weightMax.present ? weightMax.value : this.weightMax,
    data: data ?? this.data,
  );
  CustomFontModelData copyWithCompanion(i1.CustomFontModelCompanion data) {
    return CustomFontModelData(
      id: data.id.present ? data.id.value : this.id,
      originalFileName: data.originalFileName.present
          ? data.originalFileName.value
          : this.originalFileName,
      familyName: data.familyName.present
          ? data.familyName.value
          : this.familyName,
      weight: data.weight.present ? data.weight.value : this.weight,
      isItalic: data.isItalic.present ? data.isItalic.value : this.isItalic,
      isVariableWeight: data.isVariableWeight.present
          ? data.isVariableWeight.value
          : this.isVariableWeight,
      weightMin: data.weightMin.present ? data.weightMin.value : this.weightMin,
      weightMax: data.weightMax.present ? data.weightMax.value : this.weightMax,
      data: data.data.present ? data.data.value : this.data,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomFontModelData(')
          ..write('id: $id, ')
          ..write('originalFileName: $originalFileName, ')
          ..write('familyName: $familyName, ')
          ..write('weight: $weight, ')
          ..write('isItalic: $isItalic, ')
          ..write('isVariableWeight: $isVariableWeight, ')
          ..write('weightMin: $weightMin, ')
          ..write('weightMax: $weightMax, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    originalFileName,
    familyName,
    weight,
    isItalic,
    isVariableWeight,
    weightMin,
    weightMax,
    i0.$driftBlobEquality.hash(data),
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.CustomFontModelData &&
          other.id == this.id &&
          other.originalFileName == this.originalFileName &&
          other.familyName == this.familyName &&
          other.weight == this.weight &&
          other.isItalic == this.isItalic &&
          other.isVariableWeight == this.isVariableWeight &&
          other.weightMin == this.weightMin &&
          other.weightMax == this.weightMax &&
          i0.$driftBlobEquality.equals(other.data, this.data));
}

class CustomFontModelCompanion
    extends i0.UpdateCompanion<i1.CustomFontModelData> {
  final i0.Value<int> id;
  final i0.Value<String> originalFileName;
  final i0.Value<String> familyName;
  final i0.Value<int> weight;
  final i0.Value<bool> isItalic;
  final i0.Value<bool> isVariableWeight;
  final i0.Value<int?> weightMin;
  final i0.Value<int?> weightMax;
  final i0.Value<i2.Uint8List> data;
  const CustomFontModelCompanion({
    this.id = const i0.Value.absent(),
    this.originalFileName = const i0.Value.absent(),
    this.familyName = const i0.Value.absent(),
    this.weight = const i0.Value.absent(),
    this.isItalic = const i0.Value.absent(),
    this.isVariableWeight = const i0.Value.absent(),
    this.weightMin = const i0.Value.absent(),
    this.weightMax = const i0.Value.absent(),
    this.data = const i0.Value.absent(),
  });
  CustomFontModelCompanion.insert({
    this.id = const i0.Value.absent(),
    required String originalFileName,
    required String familyName,
    required int weight,
    this.isItalic = const i0.Value.absent(),
    this.isVariableWeight = const i0.Value.absent(),
    this.weightMin = const i0.Value.absent(),
    this.weightMax = const i0.Value.absent(),
    required i2.Uint8List data,
  }) : originalFileName = i0.Value(originalFileName),
       familyName = i0.Value(familyName),
       weight = i0.Value(weight),
       data = i0.Value(data);
  static i0.Insertable<i1.CustomFontModelData> custom({
    i0.Expression<int>? id,
    i0.Expression<String>? originalFileName,
    i0.Expression<String>? familyName,
    i0.Expression<int>? weight,
    i0.Expression<bool>? isItalic,
    i0.Expression<bool>? isVariableWeight,
    i0.Expression<int>? weightMin,
    i0.Expression<int>? weightMax,
    i0.Expression<i2.Uint8List>? data,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (originalFileName != null) 'original_file_name': originalFileName,
      if (familyName != null) 'family_name': familyName,
      if (weight != null) 'weight': weight,
      if (isItalic != null) 'is_italic': isItalic,
      if (isVariableWeight != null) 'is_variable_weight': isVariableWeight,
      if (weightMin != null) 'weight_min': weightMin,
      if (weightMax != null) 'weight_max': weightMax,
      if (data != null) 'data': data,
    });
  }

  i1.CustomFontModelCompanion copyWith({
    i0.Value<int>? id,
    i0.Value<String>? originalFileName,
    i0.Value<String>? familyName,
    i0.Value<int>? weight,
    i0.Value<bool>? isItalic,
    i0.Value<bool>? isVariableWeight,
    i0.Value<int?>? weightMin,
    i0.Value<int?>? weightMax,
    i0.Value<i2.Uint8List>? data,
  }) {
    return i1.CustomFontModelCompanion(
      id: id ?? this.id,
      originalFileName: originalFileName ?? this.originalFileName,
      familyName: familyName ?? this.familyName,
      weight: weight ?? this.weight,
      isItalic: isItalic ?? this.isItalic,
      isVariableWeight: isVariableWeight ?? this.isVariableWeight,
      weightMin: weightMin ?? this.weightMin,
      weightMax: weightMax ?? this.weightMax,
      data: data ?? this.data,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (id.present) {
      map['id'] = i0.Variable<int>(id.value);
    }
    if (originalFileName.present) {
      map['original_file_name'] = i0.Variable<String>(originalFileName.value);
    }
    if (familyName.present) {
      map['family_name'] = i0.Variable<String>(familyName.value);
    }
    if (weight.present) {
      map['weight'] = i0.Variable<int>(weight.value);
    }
    if (isItalic.present) {
      map['is_italic'] = i0.Variable<bool>(isItalic.value);
    }
    if (isVariableWeight.present) {
      map['is_variable_weight'] = i0.Variable<bool>(isVariableWeight.value);
    }
    if (weightMin.present) {
      map['weight_min'] = i0.Variable<int>(weightMin.value);
    }
    if (weightMax.present) {
      map['weight_max'] = i0.Variable<int>(weightMax.value);
    }
    if (data.present) {
      map['data'] = i0.Variable<i2.Uint8List>(data.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomFontModelCompanion(')
          ..write('id: $id, ')
          ..write('originalFileName: $originalFileName, ')
          ..write('familyName: $familyName, ')
          ..write('weight: $weight, ')
          ..write('isItalic: $isItalic, ')
          ..write('isVariableWeight: $isVariableWeight, ')
          ..write('weightMin: $weightMin, ')
          ..write('weightMax: $weightMax, ')
          ..write('data: $data')
          ..write(')'))
        .toString();
  }
}
