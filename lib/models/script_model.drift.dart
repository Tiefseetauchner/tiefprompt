// dart format width=80
// ignore_for_file: type=lint
import 'package:drift/drift.dart' as i0;
import 'package:tiefprompt/models/script_model.drift.dart' as i1;
import 'package:tiefprompt/models/script_model.dart' as i2;
import 'package:drift/src/runtime/query_builder/query_builder.dart' as i3;

typedef $$ScriptModelTableCreateCompanionBuilder =
    i1.ScriptModelCompanion Function({
      i0.Value<int> id,
      required String title,
      required String scriptText,
      required DateTime createdAt,
      i0.Value<bool> ephemeral,
      i0.Value<double?> scrollPosition,
    });
typedef $$ScriptModelTableUpdateCompanionBuilder =
    i1.ScriptModelCompanion Function({
      i0.Value<int> id,
      i0.Value<String> title,
      i0.Value<String> scriptText,
      i0.Value<DateTime> createdAt,
      i0.Value<bool> ephemeral,
      i0.Value<double?> scrollPosition,
    });

class $$ScriptModelTableFilterComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$ScriptModelTable> {
  $$ScriptModelTableFilterComposer({
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

  i0.ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<String> get scriptText => $composableBuilder(
    column: $table.scriptText,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<bool> get ephemeral => $composableBuilder(
    column: $table.ephemeral,
    builder: (column) => i0.ColumnFilters(column),
  );

  i0.ColumnFilters<double> get scrollPosition => $composableBuilder(
    column: $table.scrollPosition,
    builder: (column) => i0.ColumnFilters(column),
  );
}

class $$ScriptModelTableOrderingComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$ScriptModelTable> {
  $$ScriptModelTableOrderingComposer({
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

  i0.ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<String> get scriptText => $composableBuilder(
    column: $table.scriptText,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<bool> get ephemeral => $composableBuilder(
    column: $table.ephemeral,
    builder: (column) => i0.ColumnOrderings(column),
  );

  i0.ColumnOrderings<double> get scrollPosition => $composableBuilder(
    column: $table.scrollPosition,
    builder: (column) => i0.ColumnOrderings(column),
  );
}

class $$ScriptModelTableAnnotationComposer
    extends i0.Composer<i0.GeneratedDatabase, i1.$ScriptModelTable> {
  $$ScriptModelTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  i0.GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  i0.GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  i0.GeneratedColumn<String> get scriptText => $composableBuilder(
    column: $table.scriptText,
    builder: (column) => column,
  );

  i0.GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  i0.GeneratedColumn<bool> get ephemeral =>
      $composableBuilder(column: $table.ephemeral, builder: (column) => column);

  i0.GeneratedColumn<double> get scrollPosition => $composableBuilder(
    column: $table.scrollPosition,
    builder: (column) => column,
  );
}

class $$ScriptModelTableTableManager
    extends
        i0.RootTableManager<
          i0.GeneratedDatabase,
          i1.$ScriptModelTable,
          i1.ScriptModelData,
          i1.$$ScriptModelTableFilterComposer,
          i1.$$ScriptModelTableOrderingComposer,
          i1.$$ScriptModelTableAnnotationComposer,
          $$ScriptModelTableCreateCompanionBuilder,
          $$ScriptModelTableUpdateCompanionBuilder,
          (
            i1.ScriptModelData,
            i0.BaseReferences<
              i0.GeneratedDatabase,
              i1.$ScriptModelTable,
              i1.ScriptModelData
            >,
          ),
          i1.ScriptModelData,
          i0.PrefetchHooks Function()
        > {
  $$ScriptModelTableTableManager(
    i0.GeneratedDatabase db,
    i1.$ScriptModelTable table,
  ) : super(
        i0.TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              i1.$$ScriptModelTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              i1.$$ScriptModelTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              i1.$$ScriptModelTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                i0.Value<int> id = const i0.Value.absent(),
                i0.Value<String> title = const i0.Value.absent(),
                i0.Value<String> scriptText = const i0.Value.absent(),
                i0.Value<DateTime> createdAt = const i0.Value.absent(),
                i0.Value<bool> ephemeral = const i0.Value.absent(),
                i0.Value<double?> scrollPosition = const i0.Value.absent(),
              }) => i1.ScriptModelCompanion(
                id: id,
                title: title,
                scriptText: scriptText,
                createdAt: createdAt,
                ephemeral: ephemeral,
                scrollPosition: scrollPosition,
              ),
          createCompanionCallback:
              ({
                i0.Value<int> id = const i0.Value.absent(),
                required String title,
                required String scriptText,
                required DateTime createdAt,
                i0.Value<bool> ephemeral = const i0.Value.absent(),
                i0.Value<double?> scrollPosition = const i0.Value.absent(),
              }) => i1.ScriptModelCompanion.insert(
                id: id,
                title: title,
                scriptText: scriptText,
                createdAt: createdAt,
                ephemeral: ephemeral,
                scrollPosition: scrollPosition,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), i0.BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ScriptModelTableProcessedTableManager =
    i0.ProcessedTableManager<
      i0.GeneratedDatabase,
      i1.$ScriptModelTable,
      i1.ScriptModelData,
      i1.$$ScriptModelTableFilterComposer,
      i1.$$ScriptModelTableOrderingComposer,
      i1.$$ScriptModelTableAnnotationComposer,
      $$ScriptModelTableCreateCompanionBuilder,
      $$ScriptModelTableUpdateCompanionBuilder,
      (
        i1.ScriptModelData,
        i0.BaseReferences<
          i0.GeneratedDatabase,
          i1.$ScriptModelTable,
          i1.ScriptModelData
        >,
      ),
      i1.ScriptModelData,
      i0.PrefetchHooks Function()
    >;

class $ScriptModelTable extends i2.ScriptModel
    with i0.TableInfo<$ScriptModelTable, i1.ScriptModelData> {
  @override
  final i0.GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ScriptModelTable(this.attachedDatabase, [this._alias]);
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
  static const i0.VerificationMeta _titleMeta = const i0.VerificationMeta(
    'title',
  );
  @override
  late final i0.GeneratedColumn<String> title = i0.GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const i0.VerificationMeta _scriptTextMeta = const i0.VerificationMeta(
    'scriptText',
  );
  @override
  late final i0.GeneratedColumn<String> scriptText = i0.GeneratedColumn<String>(
    'script_text',
    aliasedName,
    false,
    type: i0.DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const i0.VerificationMeta _createdAtMeta = const i0.VerificationMeta(
    'createdAt',
  );
  @override
  late final i0.GeneratedColumn<DateTime> createdAt =
      i0.GeneratedColumn<DateTime>(
        'created_at',
        aliasedName,
        false,
        type: i0.DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const i0.VerificationMeta _ephemeralMeta = const i0.VerificationMeta(
    'ephemeral',
  );
  @override
  late final i0.GeneratedColumn<bool> ephemeral = i0.GeneratedColumn<bool>(
    'ephemeral',
    aliasedName,
    false,
    type: i0.DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: i0.GeneratedColumn.constraintIsAlways(
      'CHECK ("ephemeral" IN (0, 1))',
    ),
    defaultValue: i3.Constant(false),
  );
  static const i0.VerificationMeta _scrollPositionMeta =
      const i0.VerificationMeta('scrollPosition');
  @override
  late final i0.GeneratedColumn<double> scrollPosition =
      i0.GeneratedColumn<double>(
        'scroll_position',
        aliasedName,
        true,
        type: i0.DriftSqlType.double,
        requiredDuringInsert: false,
      );
  @override
  List<i0.GeneratedColumn> get $columns => [
    id,
    title,
    scriptText,
    createdAt,
    ephemeral,
    scrollPosition,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'script_model';
  @override
  i0.VerificationContext validateIntegrity(
    i0.Insertable<i1.ScriptModelData> instance, {
    bool isInserting = false,
  }) {
    final context = i0.VerificationContext();
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
    if (data.containsKey('ephemeral')) {
      context.handle(
        _ephemeralMeta,
        ephemeral.isAcceptableOrUnknown(data['ephemeral']!, _ephemeralMeta),
      );
    }
    if (data.containsKey('scroll_position')) {
      context.handle(
        _scrollPositionMeta,
        scrollPosition.isAcceptableOrUnknown(
          data['scroll_position']!,
          _scrollPositionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<i0.GeneratedColumn> get $primaryKey => {id};
  @override
  i1.ScriptModelData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return i1.ScriptModelData(
      id: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      scriptText: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.string,
        data['${effectivePrefix}script_text'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      ephemeral: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.bool,
        data['${effectivePrefix}ephemeral'],
      )!,
      scrollPosition: attachedDatabase.typeMapping.read(
        i0.DriftSqlType.double,
        data['${effectivePrefix}scroll_position'],
      ),
    );
  }

  @override
  $ScriptModelTable createAlias(String alias) {
    return $ScriptModelTable(attachedDatabase, alias);
  }
}

class ScriptModelData extends i0.DataClass
    implements i0.Insertable<i1.ScriptModelData> {
  final int id;
  final String title;
  final String scriptText;
  final DateTime createdAt;
  final bool ephemeral;
  final double? scrollPosition;
  const ScriptModelData({
    required this.id,
    required this.title,
    required this.scriptText,
    required this.createdAt,
    required this.ephemeral,
    this.scrollPosition,
  });
  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    map['id'] = i0.Variable<int>(id);
    map['title'] = i0.Variable<String>(title);
    map['script_text'] = i0.Variable<String>(scriptText);
    map['created_at'] = i0.Variable<DateTime>(createdAt);
    map['ephemeral'] = i0.Variable<bool>(ephemeral);
    if (!nullToAbsent || scrollPosition != null) {
      map['scroll_position'] = i0.Variable<double>(scrollPosition);
    }
    return map;
  }

  i1.ScriptModelCompanion toCompanion(bool nullToAbsent) {
    return i1.ScriptModelCompanion(
      id: i0.Value(id),
      title: i0.Value(title),
      scriptText: i0.Value(scriptText),
      createdAt: i0.Value(createdAt),
      ephemeral: i0.Value(ephemeral),
      scrollPosition: scrollPosition == null && nullToAbsent
          ? const i0.Value.absent()
          : i0.Value(scrollPosition),
    );
  }

  factory ScriptModelData.fromJson(
    Map<String, dynamic> json, {
    i0.ValueSerializer? serializer,
  }) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return ScriptModelData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      scriptText: serializer.fromJson<String>(json['scriptText']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      ephemeral: serializer.fromJson<bool>(json['ephemeral']),
      scrollPosition: serializer.fromJson<double?>(json['scrollPosition']),
    );
  }
  @override
  Map<String, dynamic> toJson({i0.ValueSerializer? serializer}) {
    serializer ??= i0.driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'scriptText': serializer.toJson<String>(scriptText),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'ephemeral': serializer.toJson<bool>(ephemeral),
      'scrollPosition': serializer.toJson<double?>(scrollPosition),
    };
  }

  i1.ScriptModelData copyWith({
    int? id,
    String? title,
    String? scriptText,
    DateTime? createdAt,
    bool? ephemeral,
    i0.Value<double?> scrollPosition = const i0.Value.absent(),
  }) => i1.ScriptModelData(
    id: id ?? this.id,
    title: title ?? this.title,
    scriptText: scriptText ?? this.scriptText,
    createdAt: createdAt ?? this.createdAt,
    ephemeral: ephemeral ?? this.ephemeral,
    scrollPosition: scrollPosition.present
        ? scrollPosition.value
        : this.scrollPosition,
  );
  ScriptModelData copyWithCompanion(i1.ScriptModelCompanion data) {
    return ScriptModelData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      scriptText: data.scriptText.present
          ? data.scriptText.value
          : this.scriptText,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      ephemeral: data.ephemeral.present ? data.ephemeral.value : this.ephemeral,
      scrollPosition: data.scrollPosition.present
          ? data.scrollPosition.value
          : this.scrollPosition,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ScriptModelData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('scriptText: $scriptText, ')
          ..write('createdAt: $createdAt, ')
          ..write('ephemeral: $ephemeral, ')
          ..write('scrollPosition: $scrollPosition')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, scriptText, createdAt, ephemeral, scrollPosition);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is i1.ScriptModelData &&
          other.id == this.id &&
          other.title == this.title &&
          other.scriptText == this.scriptText &&
          other.createdAt == this.createdAt &&
          other.ephemeral == this.ephemeral &&
          other.scrollPosition == this.scrollPosition);
}

class ScriptModelCompanion extends i0.UpdateCompanion<i1.ScriptModelData> {
  final i0.Value<int> id;
  final i0.Value<String> title;
  final i0.Value<String> scriptText;
  final i0.Value<DateTime> createdAt;
  final i0.Value<bool> ephemeral;
  final i0.Value<double?> scrollPosition;
  const ScriptModelCompanion({
    this.id = const i0.Value.absent(),
    this.title = const i0.Value.absent(),
    this.scriptText = const i0.Value.absent(),
    this.createdAt = const i0.Value.absent(),
    this.ephemeral = const i0.Value.absent(),
    this.scrollPosition = const i0.Value.absent(),
  });
  ScriptModelCompanion.insert({
    this.id = const i0.Value.absent(),
    required String title,
    required String scriptText,
    required DateTime createdAt,
    this.ephemeral = const i0.Value.absent(),
    this.scrollPosition = const i0.Value.absent(),
  }) : title = i0.Value(title),
       scriptText = i0.Value(scriptText),
       createdAt = i0.Value(createdAt);
  static i0.Insertable<i1.ScriptModelData> custom({
    i0.Expression<int>? id,
    i0.Expression<String>? title,
    i0.Expression<String>? scriptText,
    i0.Expression<DateTime>? createdAt,
    i0.Expression<bool>? ephemeral,
    i0.Expression<double>? scrollPosition,
  }) {
    return i0.RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (scriptText != null) 'script_text': scriptText,
      if (createdAt != null) 'created_at': createdAt,
      if (ephemeral != null) 'ephemeral': ephemeral,
      if (scrollPosition != null) 'scroll_position': scrollPosition,
    });
  }

  i1.ScriptModelCompanion copyWith({
    i0.Value<int>? id,
    i0.Value<String>? title,
    i0.Value<String>? scriptText,
    i0.Value<DateTime>? createdAt,
    i0.Value<bool>? ephemeral,
    i0.Value<double?>? scrollPosition,
  }) {
    return i1.ScriptModelCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      scriptText: scriptText ?? this.scriptText,
      createdAt: createdAt ?? this.createdAt,
      ephemeral: ephemeral ?? this.ephemeral,
      scrollPosition: scrollPosition ?? this.scrollPosition,
    );
  }

  @override
  Map<String, i0.Expression> toColumns(bool nullToAbsent) {
    final map = <String, i0.Expression>{};
    if (id.present) {
      map['id'] = i0.Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = i0.Variable<String>(title.value);
    }
    if (scriptText.present) {
      map['script_text'] = i0.Variable<String>(scriptText.value);
    }
    if (createdAt.present) {
      map['created_at'] = i0.Variable<DateTime>(createdAt.value);
    }
    if (ephemeral.present) {
      map['ephemeral'] = i0.Variable<bool>(ephemeral.value);
    }
    if (scrollPosition.present) {
      map['scroll_position'] = i0.Variable<double>(scrollPosition.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ScriptModelCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('scriptText: $scriptText, ')
          ..write('createdAt: $createdAt, ')
          ..write('ephemeral: $ephemeral, ')
          ..write('scrollPosition: $scrollPosition')
          ..write(')'))
        .toString();
  }
}
