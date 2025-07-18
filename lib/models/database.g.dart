// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ScriptModelTable extends ScriptModel
    with TableInfo<$ScriptModelTable, ScriptModelData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScriptModelTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
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
  static const VerificationMeta _scriptTextMeta = const VerificationMeta(
    'scriptText',
  );
  @override
  late final GeneratedColumn<String> scriptText = GeneratedColumn<String>(
    'script_text',
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
  @override
  List<GeneratedColumn> get $columns => [id, title, scriptText, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'script_model';
  @override
  VerificationContext validateIntegrity(
    Insertable<ScriptModelData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('script_text')) {
      context.handle(
        _scriptTextMeta,
        scriptText.isAcceptableOrUnknown(data['script_text']!, _scriptTextMeta),
      );
    } else if (isInserting) {
      context.missing(_scriptTextMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ScriptModelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ScriptModelData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      scriptText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}script_text'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $ScriptModelTable createAlias(String alias) {
    return $ScriptModelTable(attachedDatabase, alias);
  }
}

class ScriptModelData extends DataClass implements Insertable<ScriptModelData> {
  final int id;
  final String title;
  final String scriptText;
  final DateTime createdAt;
  const ScriptModelData({
    required this.id,
    required this.title,
    required this.scriptText,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['script_text'] = Variable<String>(scriptText);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ScriptModelCompanion toCompanion(bool nullToAbsent) {
    return ScriptModelCompanion(
      id: Value(id),
      title: Value(title),
      scriptText: Value(scriptText),
      createdAt: Value(createdAt),
    );
  }

  factory ScriptModelData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ScriptModelData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      scriptText: serializer.fromJson<String>(json['scriptText']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'scriptText': serializer.toJson<String>(scriptText),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ScriptModelData copyWith({
    int? id,
    String? title,
    String? scriptText,
    DateTime? createdAt,
  }) => ScriptModelData(
    id: id ?? this.id,
    title: title ?? this.title,
    scriptText: scriptText ?? this.scriptText,
    createdAt: createdAt ?? this.createdAt,
  );
  ScriptModelData copyWithCompanion(ScriptModelCompanion data) {
    return ScriptModelData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      scriptText: data.scriptText.present
          ? data.scriptText.value
          : this.scriptText,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScriptModelData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('scriptText: $scriptText, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, scriptText, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ScriptModelData &&
          other.id == this.id &&
          other.title == this.title &&
          other.scriptText == this.scriptText &&
          other.createdAt == this.createdAt);
}

class ScriptModelCompanion extends UpdateCompanion<ScriptModelData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> scriptText;
  final Value<DateTime> createdAt;
  const ScriptModelCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.scriptText = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ScriptModelCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String scriptText,
    required DateTime createdAt,
  }) : title = Value(title),
       scriptText = Value(scriptText),
       createdAt = Value(createdAt);
  static Insertable<ScriptModelData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? scriptText,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (scriptText != null) 'script_text': scriptText,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ScriptModelCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String>? scriptText,
    Value<DateTime>? createdAt,
  }) {
    return ScriptModelCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      scriptText: scriptText ?? this.scriptText,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (scriptText.present) {
      map['script_text'] = Variable<String>(scriptText.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScriptModelCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('scriptText: $scriptText, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ScriptModelTable scriptModel = $ScriptModelTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [scriptModel];
}

typedef $$ScriptModelTableCreateCompanionBuilder =
    ScriptModelCompanion Function({
      Value<int> id,
      required String title,
      required String scriptText,
      required DateTime createdAt,
    });
typedef $$ScriptModelTableUpdateCompanionBuilder =
    ScriptModelCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String> scriptText,
      Value<DateTime> createdAt,
    });

class $$ScriptModelTableFilterComposer
    extends Composer<_$AppDatabase, $ScriptModelTable> {
  $$ScriptModelTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scriptText => $composableBuilder(
    column: $table.scriptText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ScriptModelTableOrderingComposer
    extends Composer<_$AppDatabase, $ScriptModelTable> {
  $$ScriptModelTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scriptText => $composableBuilder(
    column: $table.scriptText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ScriptModelTableAnnotationComposer
    extends Composer<_$AppDatabase, $ScriptModelTable> {
  $$ScriptModelTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get scriptText => $composableBuilder(
    column: $table.scriptText,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$ScriptModelTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ScriptModelTable,
          ScriptModelData,
          $$ScriptModelTableFilterComposer,
          $$ScriptModelTableOrderingComposer,
          $$ScriptModelTableAnnotationComposer,
          $$ScriptModelTableCreateCompanionBuilder,
          $$ScriptModelTableUpdateCompanionBuilder,
          (
            ScriptModelData,
            BaseReferences<_$AppDatabase, $ScriptModelTable, ScriptModelData>,
          ),
          ScriptModelData,
          PrefetchHooks Function()
        > {
  $$ScriptModelTableTableManager(_$AppDatabase db, $ScriptModelTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ScriptModelTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ScriptModelTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ScriptModelTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> scriptText = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => ScriptModelCompanion(
                id: id,
                title: title,
                scriptText: scriptText,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required String scriptText,
                required DateTime createdAt,
              }) => ScriptModelCompanion.insert(
                id: id,
                title: title,
                scriptText: scriptText,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ScriptModelTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ScriptModelTable,
      ScriptModelData,
      $$ScriptModelTableFilterComposer,
      $$ScriptModelTableOrderingComposer,
      $$ScriptModelTableAnnotationComposer,
      $$ScriptModelTableCreateCompanionBuilder,
      $$ScriptModelTableUpdateCompanionBuilder,
      (
        ScriptModelData,
        BaseReferences<_$AppDatabase, $ScriptModelTable, ScriptModelData>,
      ),
      ScriptModelData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ScriptModelTableTableManager get scriptModel =>
      $$ScriptModelTableTableManager(_db, _db.scriptModel);
}
